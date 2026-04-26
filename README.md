# ez-gdal

GDAL を内包したワンバイナリ・ポータブル CLI ツール。
**GDAL 3.12+ の統一 CLI** (`gdal raster info` / `gdal vector convert` / `gdal raster pipeline ...`) を、追加インストールも環境変数設定もなしに 1 つの実行ファイルから使えます。

- **対象 OS**:
  - Global tool (.NET nupkg): Windows x64 / Linux x64 / Linux arm64 / macOS x64 / macOS arm64
  - Portable single-file: Windows x64 / Linux x64 / macOS x64 / macOS arm64
- **GDAL バージョン**: 3.12.x（MaxRev.Gdal NuGet 経由、実機では `ezgdal raster info --version`）
- **配布形式**: Self-contained single-file（.NET ランタイム同梱、約 84MB）
- **PMTiles**: 読み書き両対応
- **内蔵ドライバ**: 200+（GDAL 標準ビルドとほぼ同等。`ezgdal raster --formats` / `ezgdal vector --formats` で確認）

## インストール

### A. Global tool（.NET 10 ランタイム必須、最も手軽）

PackageId は **RID 別**に分かれています。自分のプラットフォームに対応する 1 つを選んでください：

| プラットフォーム | PackageId | nupkg サイズ |
|---|---|---|
| Apple Silicon Mac | `Jumboly.EzGdal.osx-arm64` | ~51MB |
| Intel Mac | `Jumboly.EzGdal.osx-x64` | ~58MB |
| Linux x64 | `Jumboly.EzGdal.linux-x64` | ~50MB |
| Linux arm64 | `Jumboly.EzGdal.linux-arm64` | ~47MB |
| Windows x64 | `Jumboly.EzGdal.win-x64` | ~39MB |

```bash
dotnet tool install -g Jumboly.EzGdal.osx-arm64   # 自分の RID に置き換え
ezgdal raster info /path/to/sample.tif            # すぐ使える
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

アンインストール:

```bash
dotnet tool uninstall -g Jumboly.EzGdal.osx-arm64   # install したのと同じ ID
```

### B. ポータブル単一バイナリ（.NET ランタイム不要）

ビルド済み `ezgdal` (Windows なら `ezgdal.exe`) を任意のディレクトリに 1 ファイル置くだけ：

```bash
# Linux/macOS
mv ezgdal /usr/local/bin/

# Windows (PowerShell)
Move-Item ezgdal.exe C:\Tools\ezgdal\
```

PATH に通せば即使えます。設定ファイルも環境変数も不要。

## 使い方

統一 CLI のサブコマンドツリー全体は `ezgdal raster <TAB>` / `ezgdal vector <TAB>` で引けます (シェル補完を有効にした場合)。

### シェル補完を有効化する

補完スクリプト (bash 4+ / zsh / fish / PowerShell) は ezgdal バイナリに内蔵されています。`ezgdal completion <shell>` で stdout に出力できるので、各シェルの初期化スクリプトに 1 行追加するだけで有効化できます (rc ファイルには `eval` 行が入るだけで補完スクリプト本体は展開されないため肥大化しません)。

```bash
# bash (4+)
echo 'eval "$(ezgdal completion bash)"' >> ~/.bashrc && source ~/.bashrc

# zsh
echo 'eval "$(ezgdal completion zsh)"' >> ~/.zshrc && source ~/.zshrc

# fish
echo 'ezgdal completion fish | source' >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish

# PowerShell
Add-Content $PROFILE 'ezgdal completion powershell | Out-String | Invoke-Expression'; . $PROFILE
```

末尾の `source` / `. $PROFILE` で現在のセッションでも即時有効化されます (新規シェル起動時は次回から自動的に読み込まれます)。

ロケール切替 (`LANG=ja_JP.UTF-8` で説明文を日本語化) など詳細は [scripts/completions/README.md](scripts/completions/README.md) を参照。

### よく使う raster 操作

```bash
# 情報表示
ezgdal raster info input.tif

# フォーマット変換
ezgdal raster convert --of PNG input.tif output.png

# 再投影
ezgdal raster reproject --dst-crs EPSG:3857 input.tif output.tif

# モザイク / VRT
ezgdal raster mosaic tile1.tif tile2.tif tile3.tif --output mosaic.vrt

# オーバービュー（ピラミッド）作成
ezgdal raster overview add input.tif --levels 2,4,8,16

# DEM 系
ezgdal raster hillshade dem.tif shade.tif
ezgdal raster slope dem.tif slope.tif
ezgdal raster contour --interval 10 dem.tif contours.shp

# タイル生成
ezgdal raster tile --min-zoom 0 --max-zoom 12 input.tif tiles/

# 空のラスター作成
ezgdal raster create --size 1024,1024 --datatype Byte blank.tif
```

### よく使う vector 操作

```bash
# 情報表示
ezgdal vector info input.shp

# フォーマット変換（PMTiles 出力含む）
ezgdal vector convert --of GPKG in.shp out.gpkg
ezgdal vector convert --of PMTiles features.geojson tiles.pmtiles

# 再投影
ezgdal vector reproject --dst-crs EPSG:4326 in.shp out.shp

# SQL 実行
ezgdal vector sql --sql "SELECT * FROM layer WHERE pop > 10000" in.gpkg out.gpkg

# ジオメトリ操作
ezgdal vector buffer --distance 100 in.shp buffered.shp
ezgdal vector simplify --tolerance 5 in.shp simplified.shp
ezgdal vector clip --like mask.shp in.shp clipped.shp
```

### Pipeline（複数演算を中間ファイルなしで連結）

統一 CLI ならではの機能。1 プロセス内で複数の処理を `!` で繋げられます：

```bash
# 読み込み → 再投影 → 切り抜き → 書き出し
ezgdal raster pipeline \
  read input.tif ! \
  reproject --dst-crs EPSG:3857 ! \
  clip --bbox 100,30,140,40 ! \
  write output.tif
```

旧来 `gdalwarp` → `gdal_translate` を順次起動して中間 `.tif` を 2 つ作っていた処理が、メモリ内で完結します。

### 旧 EXE と統一 CLI の主な対応

| 旧 EXE | 統一 CLI | |
|---|---|---|
| `gdalinfo` | `ezgdal raster info` | |
| `gdal_translate` | `ezgdal raster convert` | |
| `gdalwarp` | `ezgdal raster reproject` | |
| `gdaladdo` | `ezgdal raster overview add` | |
| `gdalbuildvrt` | `ezgdal raster mosaic` | |
| `gdaldem hillshade` | `ezgdal raster hillshade` | |
| `gdal_rasterize` | `ezgdal vector rasterize` | |
| `ogrinfo` | `ezgdal vector info` | |
| `ogr2ogr` | `ezgdal vector convert` | |
| `gdalmdiminfo` | `ezgdal mdim info` | |
| `sozip` | `ezgdal vsi sozip create` | |

オプション名は再整理されています（旧 `-of` → 新 `--format`、出力ファイルは `--output` または最後の位置引数など）。各サブコマンドの詳細は `ezgdal raster info --help` のように個別にヘルプを引いてください。

## 旧 EXE 名で呼びたい場合（互換モード）

既存の GDAL スクリプトをそのまま動かしたい、`gdalinfo input.tif` のように昔ながらに叩きたい、という場合は次のコマンドで `gdalinfo` / `gdal_translate` / `ogr2ogr` … の symlink を作れます：

```bash
ezgdal install-applets         # PATH 内に 14 個の symlink を生成
gdalinfo input.tif             # 旧 argv 互換で動作
gdal_translate -of PNG in.tif out.png
ogr2ogr -f PMTiles tiles.pmtiles features.geojson
```

サポートされる旧 EXE 名:

| applet | 実装 |
|---|---|
| `gdalinfo` / `gdal_translate` / `gdalwarp` / `ogr2ogr` / `ogrinfo` | C# から GDAL Util API 経由で直接実行 |
| `gdaladdo` / `gdalbuildvrt` / `gdal_rasterize` / `gdal_grid` / `gdaldem` | 同上 |
| `nearblack` / `gdalmdimtranslate` / `gdal_contour` / `gdal_footprint` | 同上 |
| `gdaltindex` / `gdal_create` / `sozip` / `gdal_viewshed` | 統一 CLI 相当サブコマンドへ転送 |
| `gdalmanage` | 未対応（`ezgdal vsi list` / `vsi copy` で代替） |

`dotnet tool update` 後は再度 `ezgdal install-applets` の実行が必要です（symlink が tool ディレクトリ内に作成されているため、update で消えます）。アンインストールは `ezgdal uninstall-applets`。

> 統一 CLI に完全移行できる新規スクリプトでは `install-applets` 不要。Windows 配布で symlink 権限（Developer Mode）の問題も避けられます。

## 設計のポイント

- **環境を汚染しない**: 親シェル / OS のユーザー環境変数は一切変更しません。GDAL/PROJ のデータパスは `CPLSetConfigOption` / `OSRSetPROJSearchPaths` 経由で内部設定。
- **`InvariantGlobalization=true`**: ロケール由来の小数点コンマ事故を回避。
- **`argv[0]` ディスパッチ**: 互換モードの symlink から呼ばれた際は、バイナリの呼び出し名を `_NSGetExecutablePath` (macOS) / `/proc/self/cmdline` (Linux) / `GetCommandLineArgs` (Windows) で取得して対応 applet にルーティング。

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

互換モード (`ezgdal install-applets`) はシンボリックリンクを優先し、Developer Mode が無効な場合は自動的にコピーへフォールバックします（`--copy` で明示的にコピーを強制可）。統一 CLI のみ使うなら無関係。

## 外部プラグインの利用

内蔵ドライバに含まれない GDAL ドライバを `.so / .dylib / .dll` プラグイン形式で追加できます。

```bash
# プラグイン (例: ogr_GeoAccess.so) をユーザーローカルに配置
ezgdal install-plugin /path/to/ogr_GeoAccess.so

# 配置済みプラグインを一覧
ezgdal list-plugins

# 自動ロード確認
ezgdal vector --formats | grep GeoAccess

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

> **ABI 互換性は自己責任**: プラグインは内蔵 GDAL（現状 3.12.x、`ezgdal raster info --version` で確認）と同じ minor バージョンに対してビルドしてください。違う minor だと dlopen 失敗 / silent crash の原因になります。プラグインを自作する場合のビルド手順・ABI 互換のための注意は [`docs/plugin-authoring.md`](docs/plugin-authoring.md) を参照。

## 既知の制限

- **起動オーバーヘッド**: .NET ランタイム + ネイティブ展開で 100-500ms 程度。シェルスクリプトで多重ループ起動する用途では本物の GDAL EXE のほうが高速です。pipeline サブコマンドを活用すると多重起動自体を減らせます。
- **未移植サブコマンド（本家 GDAL 3.12 の制約）**: `gdaltransform` / `gdalsrsinfo` / `pct2rgb.py` は統一 CLI に未移植のため、ezgdal でも未対応です。
- **Windows での外部プラグインは β サポート**: macOS / Linux ではプラグインビルド時に `-undefined dynamic_lookup` / `--allow-shlib-undefined` で host の libgdal にシンボル解決を委ねられますが、Windows DLL では同等の手段がないため、ezgdal 同梱 libgdal の import library が必要です（現状は提供していません）。

## License

- ezgdal 自体: **MIT** (リポジトリルートの [`LICENSE`](LICENSE)、nupkg 配布物にも同梱)
- 同梱する GDAL とその依存ライブラリ (PROJ / GEOS / SQLite / libtiff / OpenSSL / Apache Arrow ほか): 各 upstream のライセンス。一覧と SPDX ID と再配布時の注意点は [`licenses/README.md`](licenses/README.md) を参照
- GDAL/OGR 自体の `LICENSE.TXT` (degrib / FlatGeobuf 等の embedded 部分も網羅) は `runtimes/any/native/gdal-data/LICENSE.TXT` として配布物内に同梱。実行時には `ezgdal --license` でも表示可
