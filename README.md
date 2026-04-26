# ez-gdal

GDAL を内包したワンバイナリ・ポータブル CLI ツール。
GDAL の公式 EXE (`gdalinfo` / `gdal_translate` / `gdalwarp` / `ogr2ogr` / `ogrinfo` 等) と argv 互換で動作し、
追加インストールや環境変数設定なしで使えます。

- **対象 OS**:
  - Global tool (.NET nupkg): Windows x64 / Linux x64 / Linux arm64 / macOS arm64
  - Portable single-file: Windows x64 / Linux x64 / macOS x64 / macOS arm64
- **GDAL バージョン**: 3.12.x（MaxRev.Gdal NuGet 経由、RID 別 patch 番号は [`docs/plugin-authoring.md §1`](docs/plugin-authoring.md#1-対象-abi-内蔵-gdal-バージョン) 参照、実機では `ezgdal gdalinfo --version`）
- **配布形式**: Self-contained single-file（.NET ランタイム同梱、約 84MB）
- **PMTiles**: 読み書き両対応

## インストール方法

### A. Global tool（.NET 10 ランタイム必須、最も手軽）

PackageId は **RID 別**に分かれています。自分のプラットフォームに対応する 1 つを選んでください：

| プラットフォーム | PackageId | nupkg サイズ |
|---|---|---|
| Apple Silicon Mac | `Jumboly.EzGdal.osx-arm64` | ~51MB |
| Linux x64 | `Jumboly.EzGdal.linux-x64` | ~97MB |
| Linux arm64 | `Jumboly.EzGdal.linux-arm64` | ~97MB |
| Windows x64 | `Jumboly.EzGdal.win-x64` | ~39MB |

```bash
# Apple Silicon Mac
dotnet tool install -g Jumboly.EzGdal.osx-arm64

# Linux x64
dotnet tool install -g Jumboly.EzGdal.linux-x64

# Linux arm64
dotnet tool install -g Jumboly.EzGdal.linux-arm64

# Windows x64
dotnet tool install -g Jumboly.EzGdal.win-x64

# どれを入れても、共通で
ezgdal install-applets
gdalinfo /path/to/sample.tif
```

**RID 自動判定（Linux/macOS bash）:**

```bash
RID=$(dotnet --info | awk -F: '/RID:/ { gsub(/^[ \t]+/, "", $2); print $2; exit }')
dotnet tool install -g Jumboly.EzGdal.$RID
```

**RID 自動判定（Windows PowerShell）:**

```powershell
$rid = (dotnet --info | Select-String '\bRID:\s*(.+)').Matches.Groups[1].Value.Trim()
dotnet tool install -g "Jumboly.EzGdal.$rid"
```

`~/.dotnet/tools` (Unix) / `%USERPROFILE%\.dotnet\tools` (Windows) が PATH に通っている必要あり。
`dotnet tool update -g Jumboly.EzGdal.<rid>` 後は再度 `ezgdal install-applets` を実行すること（symlink が tool ディレクトリ内に作成されているため、update で消えます）。

ローカル nupkg からインストール:

```bash
./scripts/pack-tool.sh             # 4 RID すべて pack
./scripts/pack-tool.sh osx-arm64   # 自分の RID だけでも可
dotnet tool install -g --add-source ./nupkg Jumboly.EzGdal.osx-arm64
```

アンインストール:

```bash
ezgdal uninstall-applets
dotnet tool uninstall -g Jumboly.EzGdal.osx-arm64   # install したのと同じ ID
```

### NuGet.org への公開（メンテナ向け）

1. [NuGet.org](https://www.nuget.org/) でアカウント作成
2. [API Keys](https://www.nuget.org/account/apikeys) で Push スコープの key を作成（Glob: `Jumboly.*`）
3. 4 つの nupkg をまとめて pack & push:

   ```bash
   ./scripts/pack-tool.sh
   for f in ./nupkg/Jumboly.EzGdal.*.0.1.0.nupkg; do
     dotnet nuget push "$f" \
       --source https://api.nuget.org/v3/index.json \
       --api-key <YOUR_KEY>
   done
   ```

4. インデックスされるまで数分待つと、誰でも `dotnet tool install -g Jumboly.EzGdal.<rid>` で入る。

注意:

- **4 つの PackageId** が NuGet.org に予約されます（一覧と nupkg サイズは上の「インストール方法 A」のテーブル参照）。
- すべて NuGet.org 上限 250MB に収まります。合計 push 量 ~284MB。
- 展開サイズは各 RID で ~250MB（`~/.dotnet/tools/.store/jumboly.ezgdal.<rid>/` 配下）。
- **初回は v0.1.0 ではなく v1.0.0 から始めることを推奨**（pre-release 用には v0.1.0-alpha 等を使う）。csproj の `<Version>` を変更するか、pack 時に `-p:Version=1.0.0` で上書きしてください。
- 4 つの ID すべてが NuGet.org で空いていることを事前確認してください。

### B. ポータブル単一バイナリ（.NET ランタイム不要）

ビルド済み `ezgdal` (Windows なら `ezgdal.exe`) を任意のディレクトリに 1 ファイル置き、`ezgdal install-applets` を実行：

```bash
# Linux/macOS
mv ezgdal /usr/local/bin/   # PATH の通った場所へ
ezgdal install-applets       # gdalinfo / gdal_translate / ... の symlink を /usr/local/bin/ に作成

# Windows (PowerShell)
Move-Item ezgdal.exe C:\Tools\ezgdal\
C:\Tools\ezgdal\ezgdal.exe install-applets   # 同ディレクトリに hardlink (or copy) を作成
```

`PATH` に通せば、既存の GDAL スクリプトをそのまま実行できます。

```bash
gdalinfo input.tif
gdal_translate -of PNG input.tif output.png
ogr2ogr -f PMTiles tiles.pmtiles features.geojson
gdalwarp -t_srs EPSG:3857 in.tif out.tif
```

新しい統一 CLI（GDAL 3.12+）も使えます：

```bash
ezgdal raster info input.tif
ezgdal vector convert in.shp out.gpkg
ezgdal raster create --size 1024,1024 --datatype Byte blank.tif
```

## サポートする applet（argv[0] 互換）

| applet | 対応状況 |
|---|---|
| `gdalinfo` / `gdal_translate` / `gdalwarp` / `ogr2ogr` / `ogrinfo` | C# から Util API 経由で直接実行 |
| `gdaladdo` / `gdalbuildvrt` / `gdal_rasterize` / `gdal_grid` / `gdaldem` | Util API 経由 |
| `nearblack` / `gdalmdimtranslate` / `gdal_contour` / `gdal_footprint` | Util API 経由 |
| `gdaltindex` / `gdal_create` / `sozip` / `gdal_viewshed` | 統一 CLI (`ezgdal raster create` 等) にフォールバック |
| `gdalmanage` | 未対応（GDAL に C API なし） |

## 設計のポイント

- **環境を汚染しない**: 親シェル / OS のユーザー環境変数は一切変更しません。GDAL/PROJ のデータパスは `CPLSetConfigOption` / `OSRSetPROJSearchPaths` 経由で内部設定。
- **`argv[0]` ディスパッチ**: バイナリの呼び出し名を `_NSGetExecutablePath` (macOS) / `/proc/self/cmdline` (Linux) / `GetCommandLineArgs` (Windows) で取得し、対応する applet にルーティング。
- **`InvariantGlobalization=true`**: ロケール由来の小数点コンマ事故を回避。

## ビルド

`.NET 10 SDK` が必要。

```bash
# Global tool 用 nupkg (framework-dependent、~10MB 前後)
./scripts/pack-tool.sh

# ポータブル単一バイナリ（self-contained、~84MB）
./scripts/publish-all.sh           # 全 RID
./scripts/publish-all.sh osx-arm64 # 特定 RID のみ
```

両者は同じ csproj から条件分岐で生成されます：
- `dotnet pack` → `PackAsTool=true` ベースで tool nupkg
- `dotnet publish -r <rid>` → RID 指定時のみ `PublishSingleFile=true` + `SelfContained=true` が有効化

## プラットフォーム別の注意

### macOS

未署名バイナリは Gatekeeper が起動を拒否します。配布先で以下を実行してください：

```bash
xattr -d com.apple.quarantine /path/to/ezgdal
```

商用配布する場合は `codesign` + `notarytool` で署名・公証を推奨。

### Linux

ビルドホスト側の `glibc` が新しいと、古いディストリで起動しない場合があります。
配布対象の最低バージョン（例: Debian 12 / Ubuntu 22.04 LTS）と同等以下の glibc でビルドしてください。

### Windows

`ezgdal install-applets` はシンボリックリンクを優先し、Windows で Developer Mode が無効な場合は自動的にコピーへフォールバックします（`--copy` で明示的にコピーを強制可）。

## 外部プラグインの利用

内蔵ドライバに含まれない GDAL ドライバを `.so / .dylib / .dll` プラグイン形式で追加できます。

```bash
# プラグイン (例: ogr_GeoAccess.so) をユーザーローカルに配置
ezgdal install-plugin /path/to/ogr_GeoAccess.so

# 配置済みプラグインを一覧
ezgdal list-plugins

# 自動ロード確認
ezgdal ogrinfo --formats | grep GeoAccess

# 削除
ezgdal remove-plugin ogr_GeoAccess.so
```

配置先:

| OS | パス |
|---|---|
| macOS | `~/Library/Application Support/ezgdal/plugins/` |
| Linux | `$XDG_DATA_HOME/ezgdal/plugins/` (未設定時 `~/.local/share/ezgdal/plugins/`) |
| Windows | `%APPDATA%\ezgdal\plugins\` |

ezgdal は起動時に上記ディレクトリを `GDAL_DRIVER_PATH` に追加します。ユーザー側で `GDAL_DRIVER_PATH` を立てている場合は両方が連結されます。

> **ABI 互換性は自己責任**: プラグインは内蔵 GDAL（現状 3.12.x、`ezgdal gdalinfo --version` で確認）と同じ minor バージョンに対してビルドしてください。違う minor だと dlopen 失敗 / silent crash の原因になります。プラグインを自作する場合のビルド手順・ABI 互換のための注意は [`docs/plugin-authoring.md`](docs/plugin-authoring.md) を参照。

## 既知の制限

- **起動オーバーヘッド**: .NET ランタイム + ネイティブ展開で 100-500ms 程度。シェルスクリプトで多重ループ起動する用途では本物の GDAL EXE のほうが高速です。
- **`gdalmanage` は未対応**: GDAL の C API に対応関数がありません。代わりに `ezgdal vsi list` / `vsi copy` 等の VSI コマンドを使ってください。
- **Windows での外部プラグインは β サポート**: macOS / Linux ではプラグインビルド時に `-undefined dynamic_lookup` / `--allow-shlib-undefined` で host の libgdal にシンボル解決を委ねられますが、Windows DLL では同等の手段がないため、ezgdal 同梱 libgdal の import library が必要です（現状は提供していません）。

## License

- ezgdal 自体: **MIT** (リポジトリルートの [`LICENSE`](LICENSE)、nupkg 配布物にも同梱)
- 同梱する GDAL とその依存ライブラリ (PROJ / GEOS / SQLite / libtiff / OpenSSL / Apache Arrow ほか): 各 upstream のライセンス。一覧と SPDX ID と再配布時の注意点は [`licenses/README.md`](licenses/README.md) を参照
- GDAL/OGR 自体の `LICENSE.TXT` (degrib / FlatGeobuf 等の embedded 部分も網羅) は `runtimes/any/native/gdal-data/LICENSE.TXT` として配布物内に同梱。実行時には `ezgdal --license` でも表示可
