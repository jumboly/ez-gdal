#!/usr/bin/env bash
# gdal --json-usage を data/usage-en.json に保存する。
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$here/../../.." && pwd)"
out="$root/scripts/completions/data/usage-en.json"

resolve_gdal() {
    # Why: ezgdal の RunMainEntry は root algorithm の --json-usage を解釈する経路がないため
    #      system gdal を優先する。EZGDAL_BIN を override 用エスケープハッチとして残す。
    if [[ -n "${EZGDAL_BIN:-}" && -x "$EZGDAL_BIN" ]]; then
        echo "$EZGDAL_BIN"
        return
    fi
    if command -v gdal >/dev/null 2>&1; then
        command -v gdal
        return
    fi
    for c in "$root/tool-test/gdal"; do
        if [[ -x "$c" ]]; then
            echo "$c"
            return
        fi
    done
    return 1
}

bin="$(resolve_gdal)" || {
    echo "extract.sh: gdal バイナリが見つからない (EZGDAL_BIN / tool-test/gdal / PATH)" >&2
    exit 1
}

echo "extract.sh: using $bin" >&2
"$bin" --json-usage | jq -S . > "$out"
echo "extract.sh: wrote $out ($(wc -c < "$out") bytes)" >&2
