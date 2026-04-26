#!/usr/bin/env python3
"""data/usage-en.json と data/usage-ja.json から bash/zsh/fish/PowerShell の補完スクリプトを生成する。

使い方:
    uv run --project scripts/completions/tools compile.py

生成先: scripts/completions/{ezgdal.bash,ezgdal.zsh,ezgdal.fish,ezgdal.ps1}
"""
from __future__ import annotations

import json
import shlex
import subprocess
import sys
from pathlib import Path
from typing import Any

sys.path.insert(0, str(Path(__file__).parent))
from common import normalize_oneline, walk_tree

ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "scripts" / "completions" / "data"
OUT = ROOT / "scripts" / "completions"
USAGE_EN = DATA / "usage-en.json"
USAGE_JA = DATA / "usage-ja.json"

# Why: ezgdal はハイフン始まり引数を root algorithm に渡す経路を持たないので、補完は root 直下の
#      subcommand から walk する。テーブル上は "gdal" を root key として扱い、ezgdal / gdal の
#      どちらで呼ばれても同じツリーを参照する。
ROOT_KEY = "gdal"


def collect(en_root: dict[str, Any]) -> dict[str, dict[str, Any]]:
    table: dict[str, dict[str, Any]] = {}
    for path, node in walk_tree(en_root, ROOT_KEY):
        args: list[dict[str, Any]] = []
        for src_key in ("input_arguments", "input_output_arguments"):
            for a in node.get(src_key, []) or []:
                name = a.get("name")
                if not name:
                    continue
                args.append(
                    {
                        "name": name,
                        "desc_en": (a.get("description") or "").strip(),
                        "choices": a.get("choices") or [],
                    }
                )
        table[path] = {
            "desc_en": (node.get("description") or "").strip(),
            "sub_commands": [
                {"name": s.get("name", ""), "desc_en": (s.get("description") or "").strip()}
                for s in node.get("sub_algorithms", []) or []
                if s.get("name")
            ],
            "options": args,
        }
    return table


def attach_ja(table: dict[str, dict[str, Any]], ja: dict[str, str]) -> tuple[int, int]:
    translated = 0
    missing = 0

    def tally(node_or_opt: dict[str, Any]) -> None:
        nonlocal translated, missing
        if not node_or_opt["desc_en"]:
            return
        if node_or_opt["desc_ja"]:
            translated += 1
        else:
            missing += 1

    for path, node in table.items():
        node["desc_ja"] = ja.get(path, "")
        tally(node)
        for opt in node["options"]:
            opt["desc_ja"] = ja.get(f"{path}@{opt['name']}", "")
            tally(opt)
    return translated, missing


def child_descs(parent_path: str, sub_meta: dict[str, Any], table: dict[str, dict[str, Any]]) -> tuple[str, str]:
    """子コマンドの (en, ja) description を返す。ja が空なら en にフォールバック後の値で返す."""
    child = table.get(f"{parent_path}/{sub_meta['name']}", {})
    en = normalize_oneline(child.get("desc_en") or sub_meta.get("desc_en", ""))
    ja = normalize_oneline(child.get("desc_ja") or "") or en
    return en, ja


def opt_descs(opt: dict[str, Any]) -> tuple[str, str]:
    en = normalize_oneline(opt.get("desc_en", ""))
    ja = normalize_oneline(opt.get("desc_ja") or "") or en
    return en, ja


def fmt_zsh_pairs(pairs: list[tuple[str, str]]) -> str:
    # Why: zsh の _describe には `name:description` 配列が必要。説明にコロンが含まれると分離点として
    #      解釈されるのでバックスラッシュエスケープする。
    return " ".join(
        shlex.quote(f"{n}:{d.replace(':', '\\:')}") if d else shlex.quote(n)
        for n, d in pairs
    )


# ---------- bash ----------
def gen_bash(table: dict[str, dict[str, Any]]) -> str:
    lines: list[str] = [
        "# ezgdal / gdal シェル補完 (bash 4+)。再生成は scripts/completions/tools/compile.py",
        "",
        # Why: 連想配列 (declare -A) は bash 4 から。macOS の system bash 3.2 では何もしない。
        'if [ -z "$BASH_VERSION" ] || [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then',
        "    return 0 2>/dev/null || exit 0",
        "fi",
        "",
        "declare -A __EZGDAL_SUBS",
        "declare -A __EZGDAL_OPTS",
        "",
    ]

    for path in sorted(table.keys()):
        node = table[path]
        sub_names = " ".join(s["name"] for s in node["sub_commands"])
        opt_names = " ".join(f"--{o['name']}" for o in node["options"])
        if sub_names:
            lines.append(f"__EZGDAL_SUBS[{shlex.quote(path)}]={shlex.quote(sub_names)}")
        if opt_names:
            lines.append(f"__EZGDAL_OPTS[{shlex.quote(path)}]={shlex.quote(opt_names)}")

    lines.append("")
    lines.append(r"""
_ezgdal_complete() {
    local cur prev words cword
    if declare -f _init_completion >/dev/null 2>&1; then
        _init_completion -n : || return
    else
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        words=("${COMP_WORDS[@]}")
        cword=$COMP_CWORD
    fi

    local path="gdal"
    local i=1
    while (( i < cword )); do
        local w="${words[i]}"
        if [[ "$w" == -* ]]; then break; fi
        local trial="${path}/${w}"
        if [[ -n "${__EZGDAL_SUBS[$trial]:-}" || -n "${__EZGDAL_OPTS[$trial]:-}" ]]; then
            path="$trial"
            ((i++))
        else
            break
        fi
    done

    local cands
    if [[ "$cur" == -* ]]; then
        cands="${__EZGDAL_OPTS[$path]:-}"
    else
        cands="${__EZGDAL_SUBS[$path]:-}"
    fi
    COMPREPLY=( $(compgen -W "$cands" -- "$cur") )
    return 0
}
complete -F _ezgdal_complete ezgdal
complete -F _ezgdal_complete gdal
""")
    return "\n".join(lines) + "\n"


# ---------- zsh ----------
def gen_zsh(table: dict[str, dict[str, Any]]) -> str:
    lines: list[str] = [
        "#compdef ezgdal gdal",
        "# ezgdal / gdal シェル補完 (zsh)。LANG / LC_ALL / LC_MESSAGES が ja* なら日本語、",
        "# それ以外は英語。再生成は scripts/completions/tools/compile.py",
        "",
        "typeset -gA __ezgdal_subs_en __ezgdal_subs_ja __ezgdal_opts_en __ezgdal_opts_ja",
        "",
    ]

    for path in sorted(table.keys()):
        node = table[path]
        if node["sub_commands"]:
            pairs_en: list[tuple[str, str]] = []
            pairs_ja: list[tuple[str, str]] = []
            for s in node["sub_commands"]:
                en, ja = child_descs(path, s, table)
                pairs_en.append((s["name"], en))
                pairs_ja.append((s["name"], ja))
            lines.append(f"__ezgdal_subs_en[{shlex.quote(path)}]={shlex.quote(fmt_zsh_pairs(pairs_en))}")
            lines.append(f"__ezgdal_subs_ja[{shlex.quote(path)}]={shlex.quote(fmt_zsh_pairs(pairs_ja))}")
        if node["options"]:
            pairs_en = []
            pairs_ja = []
            for o in node["options"]:
                en, ja = opt_descs(o)
                pairs_en.append((f"--{o['name']}", en))
                pairs_ja.append((f"--{o['name']}", ja))
            lines.append(f"__ezgdal_opts_en[{shlex.quote(path)}]={shlex.quote(fmt_zsh_pairs(pairs_en))}")
            lines.append(f"__ezgdal_opts_ja[{shlex.quote(path)}]={shlex.quote(fmt_zsh_pairs(pairs_ja))}")

    lines.append("")
    lines.append(r"""
_ezgdal() {
    local lang="${LC_ALL:-${LC_MESSAGES:-${LANG:-}}}"
    local use_ja=0
    [[ "$lang" == ja* ]] && use_ja=1

    local path="gdal"
    integer i=2
    while (( i < CURRENT )); do
        local w="${words[i]}"
        if [[ "$w" == -* ]]; then break; fi
        local trial="${path}/${w}"
        if (( ${+__ezgdal_subs_en[$trial]} )) || (( ${+__ezgdal_opts_en[$trial]} )); then
            path="$trial"
            (( i++ ))
        else
            break
        fi
    done

    local entry
    local -a items
    if [[ "${words[CURRENT]}" == -* ]]; then
        if (( use_ja )); then
            entry="${__ezgdal_opts_ja[$path]:-}"
        else
            entry="${__ezgdal_opts_en[$path]:-}"
        fi
        items=( ${(z)entry} )
        _describe -t options 'option' items
    else
        if (( use_ja )); then
            entry="${__ezgdal_subs_ja[$path]:-}"
        else
            entry="${__ezgdal_subs_en[$path]:-}"
        fi
        items=( ${(z)entry} )
        _describe -t commands 'subcommand' items
    fi
}
# Why: source 経由で読まれた場合に補完を bind する。fpath 経由 (autoload _ezgdal) なら #compdef
#      ヘッダで既に bind 済みで重複登録は無害。source / autoload 両対応のためこの 1 行だけ末尾に置く。
compdef _ezgdal ezgdal gdal 2>/dev/null || true
""")
    return "\n".join(lines) + "\n"


# ---------- fish ----------
def emit_fish_complete(
    lines: list[str], path_q: str, flag: str, value: str, desc_en: str, desc_ja: str
) -> None:
    """ezgdal / gdal × en / ja の 4 行 complete 定義を発行する.

    flag は '-a' (subcommand) / '-l' (long option)。"""
    val_q = shlex.quote(value)
    en_q = shlex.quote(desc_en)
    ja_q = shlex.quote(desc_ja)
    for cmd in ("ezgdal", "gdal"):
        lines.append(
            f"complete -c {cmd} -f -n '__ezgdal_path_eq {path_q}; and not __ezgdal_use_ja' "
            f"{flag} {val_q} -d {en_q}"
        )
        lines.append(
            f"complete -c {cmd} -f -n '__ezgdal_path_eq {path_q}; and __ezgdal_use_ja' "
            f"{flag} {val_q} -d {ja_q}"
        )


def gen_fish(table: dict[str, dict[str, Any]]) -> str:
    lines: list[str] = [
        "# ezgdal / gdal シェル補完 (fish)。LANG が ja* なら日本語、それ以外は英語。",
        "# 再生成は scripts/completions/tools/compile.py",
        "",
    ]
    # Why: fish には連想配列がないので、全 path をリスト変数に並べて contains で存在判定する。
    paths_lit = " ".join(shlex.quote(p) for p in sorted(table.keys()))
    lines.append(f"set -g __ezgdal_paths {paths_lit}")
    lines.append(r"""
function __ezgdal_path
    set -l tokens (commandline -opc)
    set -l path "gdal"
    set -l i 2
    while test $i -le (count $tokens)
        set -l w $tokens[$i]
        if string match -q -- '-*' $w
            break
        end
        set -l trial "$path/$w"
        if contains -- $trial $__ezgdal_paths
            set path $trial
            set i (math $i + 1)
        else
            break
        end
    end
    echo $path
end

function __ezgdal_path_eq -a expected
    test (__ezgdal_path) = "$expected"
end

function __ezgdal_use_ja
    string match -q -- 'ja*' "$LC_ALL$LC_MESSAGES$LANG"
end
""")

    for path in sorted(table.keys()):
        node = table[path]
        path_q = shlex.quote(path)
        for s in node["sub_commands"]:
            en, ja = child_descs(path, s, table)
            emit_fish_complete(lines, path_q, "-a", s["name"], en, ja)
        for o in node["options"]:
            en, ja = opt_descs(o)
            emit_fish_complete(lines, path_q, "-l", o["name"], en, ja)

    return "\n".join(lines) + "\n"


# ---------- PowerShell ----------
def ps1_escape(s: str) -> str:
    return s.replace("'", "''")


def gen_ps1(table: dict[str, dict[str, Any]]) -> str:
    lines: list[str] = [
        "# ezgdal / gdal シェル補完 (PowerShell 5.1+ / 7+)。CurrentCulture が ja なら日本語、",
        "# それ以外は英語。再生成は scripts/completions/tools/compile.py",
        "",
        "$script:EzGdalTree = @{}",
        "",
    ]

    for path in sorted(table.keys()):
        node = table[path]
        lines.append(f"$script:EzGdalTree['{ps1_escape(path)}'] = @{{")
        lines.append("    Subs = @(")
        for s in node["sub_commands"]:
            en, ja = child_descs(path, s, table)
            lines.append(
                f"        @{{ Name = '{ps1_escape(s['name'])}';"
                f" DescEn = '{ps1_escape(en)}'; DescJa = '{ps1_escape(ja)}' }}"
            )
        lines.append("    )")
        lines.append("    Opts = @(")
        for o in node["options"]:
            en, ja = opt_descs(o)
            lines.append(
                f"        @{{ Name = '--{ps1_escape(o['name'])}';"
                f" DescEn = '{ps1_escape(en)}'; DescJa = '{ps1_escape(ja)}' }}"
            )
        lines.append("    )")
        lines.append("}")

    lines.append("")
    lines.append(r"""
$script:EzGdalCompleter = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $useJa = ([System.Globalization.CultureInfo]::CurrentCulture.TwoLetterISOLanguageName -eq 'ja')
    $tokens = @()
    foreach ($e in $commandAst.CommandElements) {
        $tokens += $e.Extent.Text
    }
    $path = 'gdal'
    for ($i = 1; $i -lt $tokens.Count; $i++) {
        $t = $tokens[$i]
        if ($t.StartsWith('-')) { break }
        # Why: 末尾要素は補完対象 (まだ確定していない単語) なので path に組み込まない
        if (-not [string]::IsNullOrEmpty($wordToComplete) -and $i -eq $tokens.Count - 1) { break }
        $trial = "$path/$t"
        if ($script:EzGdalTree.ContainsKey($trial)) {
            $path = $trial
        } else {
            break
        }
    }
    $node = $script:EzGdalTree[$path]
    if ($null -eq $node) { return }
    if ($wordToComplete.StartsWith('-')) {
        foreach ($o in $node.Opts) {
            if ($o.Name -like "$wordToComplete*") {
                $desc = if ($useJa) { $o.DescJa } else { $o.DescEn }
                [System.Management.Automation.CompletionResult]::new(
                    $o.Name, $o.Name, 'ParameterName', $desc)
            }
        }
    } else {
        foreach ($s in $node.Subs) {
            if ($s.Name -like "$wordToComplete*") {
                $desc = if ($useJa) { $s.DescJa } else { $s.DescEn }
                [System.Management.Automation.CompletionResult]::new(
                    $s.Name, $s.Name, 'Command', $desc)
            }
        }
    }
}

Register-ArgumentCompleter -CommandName 'ezgdal','gdal' -Native -ScriptBlock $script:EzGdalCompleter
""")
    return "\n".join(lines) + "\n"


def syntax_check(path: Path, cmd: list[str]) -> bool:
    try:
        subprocess.run(cmd + [str(path)], check=True, capture_output=True)
        return True
    except FileNotFoundError:
        print(f"  skip: {cmd[0]} not found", file=sys.stderr)
        return True
    except subprocess.CalledProcessError as e:
        print(f"  syntax error in {path.name}:", file=sys.stderr)
        print(e.stderr.decode(errors="replace"), file=sys.stderr)
        return False


def main() -> int:
    en_data = json.loads(USAGE_EN.read_text())
    ja_data = json.loads(USAGE_JA.read_text()) if USAGE_JA.exists() else {}

    table = collect(en_data)
    translated, missing = attach_ja(table, ja_data)
    print(f"compile.py: nodes={len(table)} ja_translated={translated} ja_missing={missing}")

    outputs = {
        OUT / "ezgdal.bash": gen_bash(table),
        OUT / "ezgdal.zsh": gen_zsh(table),
        OUT / "ezgdal.fish": gen_fish(table),
        OUT / "ezgdal.ps1": gen_ps1(table),
    }
    for p, content in outputs.items():
        p.write_text(content)
        print(f"compile.py: wrote {p.relative_to(ROOT)} ({len(content):,} bytes)")

    ok = True
    for p, cmd in [
        (OUT / "ezgdal.bash", ["bash", "-n"]),
        (OUT / "ezgdal.zsh", ["zsh", "-n"]),
        (OUT / "ezgdal.fish", ["fish", "-n"]),
    ]:
        ok &= syntax_check(p, cmd)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
