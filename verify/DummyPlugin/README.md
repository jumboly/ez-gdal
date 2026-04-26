# DummyPlugin — ezgdal 動作確認用ダミー OGR ドライバ

`ezgdal install-plugin` / `list-plugins` / `remove-plugin` と起動時の
自動ロードフローを、外部リポジトリに依存せずスモークテストするため
の最小 OGR ドライバ。

## ドライバ仕様

| 項目 | 値 |
|---|---|
| ドライバ名 | `Dummy` |
| ファイル名 | `ogr_Dummy.so` (macOS / Linux) / `ogr_Dummy.dll` (Windows) |
| エクスポートシンボル | `RegisterOGRDummy` |
| 機能 | なし。Identify は常に 0、Open は常に nullptr |

`ogrinfo --formats` の出力に `Dummy` が登場することが、外部プラグイン
の dlopen + register が正しく動いた証拠になる。

## ABI 互換性

ezgdal 内蔵 GDAL (MaxRev.Gdal の libgdal) と **同 minor バージョン** の
GDAL ヘッダ・ライブラリにリンクすること。バージョン不一致時は dlopen
失敗 / 静的初期化での crash / シンボル mismatch エラーになりうる。

ezgdal の内蔵 GDAL は 3.12.x（RID 別 patch 番号は
[`docs/plugin-authoring.md §1`](../../docs/plugin-authoring.md#1-対象-abi-内蔵-gdal-バージョン)
参照）。host GDAL も 3.12.x で揃える。

```bash
ezgdal gdalinfo --version             # 内蔵バージョン
pkg-config --modversion gdal          # host 側 (Homebrew の例)
```

## ビルド (macOS / Linux)

```bash
cd verify/DummyPlugin
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
# → verify/DummyPlugin/build/ogr_Dummy.so
```

`find_package(GDAL)` は host にインストールされた GDAL を使う:
- macOS (Homebrew): `brew install gdal`
- Linux (apt): `sudo apt install libgdal-dev`
- Linux (conda): `conda install -c conda-forge gdal`

## ビルド (Windows)

Windows DLL は undefined symbol を許容しないため、ezgdal が同梱する
gdal.dll に対する import library (gdal.lib) にリンクする必要がある。
`Jumboly.EzGdal.win-x64` nupkg は `sdk/` フォルダに gdal.lib + headers +
cmake config を同梱しているので、それを `EZGDAL_SDK_DIR` で指す:

```powershell
# 1. ezgdal を tool install
dotnet tool install --tool-path .\tool-test Jumboly.EzGdal.win-x64

# 2. SDK ディレクトリを環境変数で指す (.store/.../tools/net10.0/any/sdk)
$sdk = (Get-ChildItem -Recurse -Filter gdal.lib -Path tool-test).Directory.Parent.FullName
$env:EZGDAL_SDK_DIR = $sdk

# 3. Developer Command Prompt for VS から (cl / cmake が PATH 上)
cmake -S verify\DummyPlugin -B verify\DummyPlugin\build -A x64
cmake --build verify\DummyPlugin\build --config Release
# → verify\DummyPlugin\build\Release\ogr_Dummy.dll
```

## ezgdal で使う

```bash
# install
ezgdal install-plugin verify/DummyPlugin/build/ogr_Dummy.so

# 一覧
ezgdal list-plugins

# 自動ロード確認
ogrinfo --formats | grep Dummy

# 削除
ezgdal remove-plugin ogr_Dummy.so
```
