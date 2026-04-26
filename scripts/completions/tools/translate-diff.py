#!/usr/bin/env python3
"""data/usage-en.json と data/usage-en.snapshot.json を比較し、新規/変更ノードのみ Claude API で翻訳する。

使い方:
    export ANTHROPIC_API_KEY=sk-ant-...
    uv run --project scripts/completions/tools translate-diff.py

副作用:
- data/usage-ja.json を更新 (新規/変更分を上書き、既存の人手修正は維持)
- data/usage-en.snapshot.json を usage-en.json と同期 (次回 diff の起点)

Why: 翻訳と抽出を分離する。GDAL バンプで構造ごと変わる en は丸ごと再抽出 (extract.sh)。ja は変わらない部分
     を温存し、新規・変更分だけ LLM へ送る。これで翻訳コストと品質ブレを抑える。
"""
from __future__ import annotations

import json
import os
import sys
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).parent))
from common import walk_tree

ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "scripts" / "completions" / "data"
USAGE_EN = DATA / "usage-en.json"
USAGE_JA = DATA / "usage-ja.json"
SNAPSHOT = DATA / "usage-en.snapshot.json"

# Why: Claude にバッチで投げて JSON を返してもらう。1 リクエストでまとめると入力 caching が効きやすく、
#      かつ entry 同士の文脈 (関連 subcommand) を考慮した訳が出やすい。
MODEL = "claude-opus-4-7"
SYSTEM_PROMPT = """\
あなたは GDAL 3.12+ 統一 CLI の subcommand / argument の説明テキストを英語から日本語へ翻訳するアシスタントです。

ルール:
- 1 行で簡潔に。技術ドキュメント風 (敬体ではなく体言止め寄り)。
- 技術用語はカタカナ優先 (Raster→ラスタ、Vector→ベクタ、CRS→CRS、 Coordinate Reference System→CRS、Tile→タイル、Mosaic→モザイク)
- subcommand description は名詞句または動詞の連用形で 30 文字以内目安
- argument description は 50 文字以内目安、何を指定する値か分かるように
- 句点・読点は不要 (補完候補に並ぶため短く)
- 訳に迷う固有名詞 (GeoTIFF, COG, sozip, etc) はそのまま保持
- 出力は必ず指定された JSON 形式

入力は { "key": "english text", ... } の dict、出力も同じキー集合の { "key": "日本語訳", ... } を返す。
"""


def collect_keys_from_en(en_root: dict[str, Any], root_path: str = "gdal") -> dict[str, str]:
    """JSON ツリーから path / path@argname の英語 description を flat dict に集める."""
    out: dict[str, str] = {}
    for path, node in walk_tree(en_root, root_path):
        desc = (node.get("description") or "").strip()
        if desc:
            out[path] = desc
        for src_key in ("input_arguments", "input_output_arguments"):
            for a in node.get(src_key, []) or []:
                name = a.get("name")
                adesc = (a.get("description") or "").strip()
                if name and adesc:
                    out[f"{path}@{name}"] = adesc
    return out


def diff_keys(current: dict[str, str], snapshot: dict[str, str]) -> dict[str, str]:
    """新規 (snapshot に無い) または英文が変わったエントリのみ返す。"""
    diff: dict[str, str] = {}
    for k, v in current.items():
        if snapshot.get(k) != v:
            diff[k] = v
    return diff


def chunk(d: dict[str, str], size: int) -> list[dict[str, str]]:
    items = list(d.items())
    return [dict(items[i : i + size]) for i in range(0, len(items), size)]


def translate_batch(client: Any, batch: dict[str, str]) -> dict[str, str]:
    user_msg = json.dumps(batch, ensure_ascii=False, indent=2)
    resp = client.messages.create(
        model=MODEL,
        max_tokens=8192,
        system=SYSTEM_PROMPT,
        messages=[
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": (
                            "次の dict を翻訳してください。出力は同じキー集合の JSON だけを返し、"
                            "前置きや説明は不要です。\n\n"
                            f"```json\n{user_msg}\n```"
                        ),
                    }
                ],
            }
        ],
    )
    text = "".join(block.text for block in resp.content if block.type == "text").strip()
    # Why: モデルが ```json``` フェンスで返す可能性があるので剥がす
    if text.startswith("```"):
        first_nl = text.find("\n")
        text = text[first_nl + 1 :]
        if text.endswith("```"):
            text = text[: -3]
        text = text.strip()
    parsed = json.loads(text)
    if not isinstance(parsed, dict):
        raise RuntimeError(f"Claude returned non-dict: {type(parsed)}")
    return parsed


def main() -> int:
    if not USAGE_EN.exists():
        print("translate-diff.py: data/usage-en.json が無い。先に extract.sh を実行", file=sys.stderr)
        return 1
    if "ANTHROPIC_API_KEY" not in os.environ:
        print("translate-diff.py: ANTHROPIC_API_KEY が環境変数にない", file=sys.stderr)
        return 1

    en_root = json.loads(USAGE_EN.read_text())
    snapshot_root = json.loads(SNAPSHOT.read_text()) if SNAPSHOT.exists() else None
    ja = json.loads(USAGE_JA.read_text()) if USAGE_JA.exists() else {}

    en_flat = collect_keys_from_en(en_root)
    snapshot_flat = collect_keys_from_en(snapshot_root) if snapshot_root is not None else {}

    diff = diff_keys(en_flat, snapshot_flat)
    print(f"translate-diff.py: en_total={len(en_flat)} ja_existing={len(ja)} to_translate={len(diff)}")

    if not diff:
        print("translate-diff.py: no changes, skip API call")
        return 0

    # Why: anthropic SDK は uv の依存にあり。API キーが要るので最後の段階で import する。
    from anthropic import Anthropic

    client = Anthropic()
    # Why: 1 リクエストあたりのトークン上限 (出力 8192 tokens 想定) を超えない粒度に分割。
    #      日本語 1 行 ~30 字 ≒ 60 tokens、入力英語と合算して 1 entry 約 200 tokens 見積もり。
    #      80 entry / batch ≒ 16k tokens で 8k 出力に収まる。
    batch_size = 80
    batches = chunk(diff, batch_size)
    print(f"translate-diff.py: dispatching {len(batches)} batch(es)")

    for idx, batch in enumerate(batches, 1):
        print(f"  batch {idx}/{len(batches)} ({len(batch)} entries)... ", end="", flush=True)
        translated = translate_batch(client, batch)
        # Why: モデルがキー集合を変える / 訳が空のものは無視 (元の英語 fallback を維持)。
        merged = 0
        for k in batch:
            v = translated.get(k)
            if isinstance(v, str) and v.strip():
                ja[k] = v.strip()
                merged += 1
        print(f"merged {merged}")

    USAGE_JA.write_text(json.dumps(ja, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    print(f"translate-diff.py: wrote {USAGE_JA.relative_to(ROOT)} ({len(ja)} entries)")

    SNAPSHOT.write_text(USAGE_EN.read_text())
    print(f"translate-diff.py: refreshed {SNAPSHOT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
