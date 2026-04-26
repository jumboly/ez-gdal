#!/usr/bin/env bash
# 全対象 RID 向けに ezgdal を self-contained single-file として publish する。
# 第 1 引数で対象 RID を 1 つに絞れる。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$ROOT/src/EzGdal/EzGdal.csproj"

RIDS=(win-x64 linux-x64 osx-arm64)
ONLY="${1:-}"

for rid in "${RIDS[@]}"; do
  if [[ -n "$ONLY" && "$ONLY" != "$rid" ]]; then continue; fi
  echo "=== Publishing $rid ==="
  out="$ROOT/publish/$rid"
  rm -rf "$out"
  dotnet publish "$PROJECT" \
    -c Release \
    -r "$rid" \
    -o "$out"
  echo "  -> $out/ezgdal$( [[ $rid == win-* ]] && echo .exe )"
  echo
done

echo "$ROOT/publish/ 配下に各 RID 向けバイナリを出力しました。"
