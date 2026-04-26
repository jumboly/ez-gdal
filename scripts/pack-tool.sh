#!/usr/bin/env bash
# RID 別の EzGdal .NET global tool nupkg を ./nupkg/ に生成する。
# 1 つの nupkg = 1 RID（osx-arm64 / linux-x64 / linux-arm64 / win-x64）。
# 第 1 引数で対象 RID を 1 つに絞れる（省略時は全部）。
#   pack-tool.sh                     # 4 RID すべて
#   pack-tool.sh osx-arm64           # 指定 RID のみ
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$ROOT/src/EzGdal/EzGdal.csproj"

RIDS=(osx-arm64 linux-x64 linux-arm64 win-x64)
ONLY="${1:-}"

mkdir -p "$ROOT/nupkg"

SDK_LIB="$ROOT/scripts/win-sdk/build/sdk/lib/gdal.lib"

for rid in "${RIDS[@]}"; do
    if [[ -n "$ONLY" && "$ONLY" != "$rid" ]]; then continue; fi
    echo "=== Packing $rid ==="

    # win-x64 は Windows プラグイン作者向け SDK (gdal.lib + headers + cmake) を
    # nupkg の sdk/ に同梱する。CI の pack-windows ジョブと Windows ローカルでは
    # generate-sdk.ps1 が事前に走る前提。mac/linux の dev-loop でも pack 自体は
    # 通すために、SDK 未生成は warn のみ (csproj の Exists() condition で空同梱)。
    if [[ "$rid" == "win-x64" && ! -f "$SDK_LIB" ]]; then
        echo "⚠️  Windows SDK 未生成 (sdk/ 同梱なし)。プラグイン作者向け配布なら" >&2
        echo "    Windows + MSVC 環境で先に scripts/win-sdk/generate-sdk.ps1 を実行してください。" >&2
    fi

    # PackageReference が RID ごとに切り替わるので、毎回 obj/bin を削除して restore する。
    rm -rf "$ROOT/src/EzGdal/obj" "$ROOT/src/EzGdal/bin"
    dotnet pack "$PROJECT" -c Release -p:PackTargetRid="$rid"
    echo
done

echo "生成された nupkg:"
ls -lh "$ROOT"/nupkg/Jumboly.EzGdal*.nupkg
echo
echo "インストール例:"
echo "  dotnet tool install -g Jumboly.EzGdal.<your-rid>      # NuGet.org に publish 後"
echo "  dotnet tool install -g --add-source $ROOT/nupkg Jumboly.EzGdal.<your-rid>  # ローカル nupkg"
echo
echo "インストール後: 'ezgdal install-applets' を 1 度実行してください。"
