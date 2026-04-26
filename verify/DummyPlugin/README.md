# DummyPlugin — ezgdal 動作確認用ダミー OGR ドライバ

`ezgdal install-plugin` / `list-plugins` / `remove-plugin` と起動時の
自動ロードフローを、外部リポジトリに依存せずスモークテストするため
の最小 OGR ドライバ。

## ドライバ仕様

| 項目 | 値 |
|---|---|
| ドライバ名 | `Dummy` |
| ファイル名 | `ogr_Dummy.so` |
| エクスポートシンボル | `RegisterOGRDummy` |
| 機能 | なし。Identify は常に 0、Open は常に nullptr |

`ogrinfo --formats` の出力に `Dummy` が登場することが、外部プラグイン
の dlopen + register が正しく動いた証拠になる。

## ABI 互換性

ezgdal 内蔵 GDAL (MaxRev.Gdal の libgdal) と **同 minor バージョン** の
GDAL ヘッダ・ライブラリにリンクすること。バージョン不一致時は dlopen
失敗 / 静的初期化での crash / シンボル mismatch エラーになりうる。

ezgdal 0.x (内蔵 GDAL 3.12.2) → host GDAL 3.12.x で揃える。

```bash
# 内蔵バージョンの確認
ezgdal gdalinfo --version   # GDAL 一般フラグ統合後

# host 側の GDAL バージョン確認 (Homebrew の例)
pkg-config --modversion gdal
```

## ビルド

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
