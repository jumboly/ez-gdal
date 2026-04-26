# ezgdal 用 GDAL ドライバプラグイン作成ガイド

ezgdal は内蔵の MaxRev.Gdal 経由で 200+ ドライバを既に同梱しているが、
ユーザー独自の GDAL ドライバを `.so / .dylib / .dll` プラグイン形式で
追加できる。本書はそのプラグインを作成するための作者向けガイド。

> 利用者向けのインストール手順は `README.md` の「外部プラグインの利用」節を参照。

## 1. 対象 ABI (内蔵 GDAL バージョン)

ezgdal が同梱する GDAL のバージョンに合わせてプラグインをビルドする
必要がある。違う minor バージョンに対してビルドしたプラグインは
silent crash / dlopen 失敗 / シンボル不整合を起こしうる。

ezgdal 0.1.x の同梱 GDAL バージョン（minor は全 RID で 3.12 系、patch は MaxRev runtime
リリース時期で異なる）:

- macOS arm64 / macOS x64: GDAL 3.12.2
- Linux x64 / Linux arm64: GDAL 3.12.0
- Windows x64: GDAL 3.12.0
- 共通: MaxRev.Gdal.Core 3.12.3.499 (C# bindings)

実機では `ezgdal gdalinfo --version` で確認できる:

```bash
$ ezgdal gdalinfo --version
GDAL 3.12.2 "Chicoutimi", released 2026/02/11
```

## 2. プラグインファイル名と登録関数の規約

GDAL の `AutoLoadDrivers` はファイル名から登録関数名を導出する。

| 種別 | ファイル名 | 登録関数 |
|---|---|---|
| Vector (OGR) | `ogr_<DriverName>.{so,dylib,dll}` | `RegisterOGR<DriverName>` |
| Raster (GDAL) | `gdal_<DriverName>.{so,dylib,dll}` | `GDALRegister_<DriverName>` |

例: `ogr_GeoAccess.so` → `RegisterOGRGeoAccess` を `extern "C"` で公開。

## 3. 最小実装

OGR (vector) ドライバの最小例:

```cpp
#include "ogrsf_frmts.h"

extern "C" void CPL_DLL RegisterOGRMyDriver();

void RegisterOGRMyDriver()
{
    if (GDALGetDriverByName("MyDriver") != nullptr)
        return;  // 多重登録ガード (AutoLoadDrivers が複数回呼ばれることがある)

    auto *driver = new GDALDriver();
    driver->SetDescription("MyDriver");
    driver->SetMetadataItem(GDAL_DMD_LONGNAME, "My Custom OGR Driver");
    driver->SetMetadataItem(GDAL_DCAP_VECTOR, "YES");
    driver->SetMetadataItem(GDAL_DCAP_OPEN, "YES");
    // 必要に応じて拡張子・MIME・コールバックを設定する
    // driver->pfnIdentify = MyIdentify;
    // driver->pfnOpen = MyOpen;

    GetGDALDriverManager()->RegisterDriver(driver);
}
```

完全に動く動作確認用ダミーは `verify/DummyPlugin/` を参照。

## 4. ビルド時の注意

### 4.1 libgdal への依存を残さない

プラグインは ezgdal が起動時にロードしている libgdal にシンボル解決される
必要がある。プラグイン側で host とは別の libgdal (例: Homebrew の
`/opt/homebrew/opt/gdal/lib/libgdal.38.dylib`) を依存に持つと、プロセス内に
2 つの libgdal が並列でロードされ、driver manager が分裂する (プラグイン内
で `GetGDALDriverManager()` が ezgdal とは別のインスタンスを返す) ため、
登録したドライバが ezgdal から見えなくなる。

#### macOS

```cmake
target_include_directories(ogr_MyDriver PRIVATE
    $<TARGET_PROPERTY:GDAL::GDAL,INTERFACE_INCLUDE_DIRECTORIES>
)
target_link_options(ogr_MyDriver PRIVATE -Wl,-undefined,dynamic_lookup)
# 注: GDAL::GDAL をリンクライブラリとして指定しない (ヘッダのみ使う)
```

ビルド済みのライブラリ依存を後から修正する場合:

```bash
install_name_tool -change /opt/homebrew/opt/gdal/lib/libgdal.38.dylib \
    @rpath/libgdal.38.dylib \
    ogr_MyDriver.so
# ezgdal extract dir 内の libgdal.38.dylib を rpath で解決させる
```

#### Linux

```cmake
target_include_directories(ogr_MyDriver PRIVATE ${GDAL_INCLUDE_DIRS})
target_link_options(ogr_MyDriver PRIVATE -Wl,--allow-shlib-undefined)
```

ビルド済みのライブラリ依存を後から修正する場合:

```bash
patchelf --remove-needed libgdal.so.38 ogr_MyDriver.so
```

#### Windows

Windows の DLL では undefined symbol を許容できない。プラグインを
ezgdal 配布物内の `gdal.lib` (import library) にリンクするか、ezgdal の
ヘッダ + libgdal.dll の `.lib` import library を別途配布する経路が必要。
現状この経路は β サポートとし、メインターゲットは macOS / Linux。

### 4.2 関数ポインタ (`pfnIdentify` / `pfnOpen` など) の代入

`GDALDriver` クラスのメモリレイアウトは GDAL の minor バージョン間で
追加・並べ替えが起こりうる。プラグインを host と異なる minor バージョン
の GDAL ヘッダでビルドしている場合、関数ポインタフィールドへの直接代入が
別フィールドを破壊する可能性がある。

可能であれば host と完全同一の GDAL バージョンの header に対してビルド
すること。やむを得ず差がある場合は `pfnIdentify` / `pfnOpen` などの直接
代入を避け、メタデータ API (`SetMetadataItem`) のみで構成し、Open ハンドラ
は別途登録 API (例: `SetOpenCallback` など) があれば利用する。

### 4.3 Linux の C++ stdlib ABI

Linux ではプラグインの C++ stdlib 選択が host と一致している必要がある。
MaxRev.Gdal の Linux runtime は `libstdc++` (GNU) でビルドされているため、
プラグイン側も `libstdc++` でビルドすること。`clang++ -stdlib=libc++` で
ビルドするとプロセス内に libc++ と libstdc++ の両方がロードされ、
`std::string` / `std::vector` 等の layout 不一致で silent crash しうる。

加えて GLIBCXX dual ABI (`_GLIBCXX_USE_CXX11_ABI=0/1`) は libstdc++ を
共有するライブラリ間で揃っている必要がある。デフォルトの `=1` のままで
ビルドすれば現代の Linux ディストリでは概ね一致するが、古いツールチェイン
で `=0` を強制している環境ではプラグイン側も同じ設定にすること。

### 4.4 GEOS / PROJ などの転送依存ライブラリ

プラグインから GEOS / PROJ / SQLite などを **直接リンクして使うのは避ける**。
host (ezgdal 内蔵 MaxRev libgdal) は自身のバージョンの GEOS/PROJ を bundle
しており、プラグインが別バージョンの GEOS にリンクするとプロセス内に 2 つの
GEOS がロードされ、両方を跨ぐオブジェクトの取り回しで crash する。

幾何処理が必要な場合は GDAL の API (`OGRGeometry::Buffer` / `Transform`
等) 経由で host の GEOS を間接的に使うこと。これらは GDAL の C++ ABI を
通すため、§4.1 / §4.2 の制約を超える追加リスクを生まない。

### 4.5 Safe pattern と Risky pattern

以下を「Safe」(高確率で動く) と「Risky」(要十分なテスト) で分類する。Safe
側に収まっているプラグインは本書に従っていれば実用上問題ないが、Risky 側
に踏み込むなら ABI 互換の現物確認 (実機での open / read / 数件の代表的な
データ処理) を必ず行うこと。

| 分類 | 内容 |
|---|---|
| **Safe** | (1) `GetGDALDriverManager()->RegisterDriver()` で driver を登録し、`SetMetadataItem` でメタデータを与えるだけ |
|   | (2) `pfnIdentify` / `pfnOpen` のみ設定し、コールバック内では C API (`GDALOpenInfo` の getter / `OGRSFDriverRegistrar`) を経由 |
|   | (3) GEOS / PROJ を直接使わず、必要なら GDAL 経由 (`OGRGeometry::Buffer` 等) |
|   | (4) 自前の `GDALDataset` / `OGRLayer` 派生クラスは保持するが、フィールドはプリミティブ + `std::unique_ptr` 程度に留める |
| **Risky** | (1) `GDALDataset` / `OGRLayer` を継承し多数の virtual 関数を override (vtable 互換が ABI 全域に依存) |
|   | (2) `std::string` / `std::vector` / `std::map` を引数・戻り値に取る GDAL 内部 API (`CPLString` 系を含む) を多用 |
|   | (3) GEOS / PROJ / SQLite を直接リンク (§4.4 参照) |
|   | (4) GDAL の inline テンプレート (`OGRSpatialReference` の一部メソッド等) を多用、ODR 違反のリスクあり |
|   | (5) GDAL の internal header (`_p.h` サフィックスを持つ `ogr_p.h` / `cpl_minixml_p.h` 等) を使用 |

シンプルなフォーマット reader (独自バイナリの Identify + Open + 行を
yield) は Safe、CRS 変換 + 幾何加工 + ストリーミングを行う高機能な
driver は Risky。Risky 寄りの実装をする場合は `verify/DummyPlugin/` を
雛形に、必要な機能を最小限ずつ追加し、各段階で `ezgdal ogrinfo --formats`
+ 実データ open のスモークテストを通すこと。

## 5. インストールと自動ロード

ユーザーは `ezgdal install-plugin <ファイル>` で以下のディレクトリに配置する:

| OS | 配置先 |
|---|---|
| macOS | `~/Library/Application Support/ezgdal/plugins/` |
| Linux | `$XDG_DATA_HOME/ezgdal/plugins/` (未設定時 `~/.local/share/ezgdal/plugins/`) |
| Windows | `%APPDATA%\ezgdal\plugins\` |

ezgdal は起動時に Bootstrap で `Gdal.SetConfigOption("GDAL_DRIVER_PATH", ...)`
を呼んで自動的にこのディレクトリを GDAL に渡すため、ユーザー側の env 設定
は不要。

## 6. 動作確認

```bash
# インストール
ezgdal install-plugin /path/to/ogr_MyDriver.so

# 配置確認
ezgdal list-plugins

# ロード + 一覧
ezgdal ogrinfo --formats | grep MyDriver
# → "MyDriver -vector- (...): My Custom OGR Driver" が出ればロード成功

# データを開いてみる
ezgdal ogrinfo "MyDriver:..."

# 削除
ezgdal remove-plugin ogr_MyDriver.so
```

## 7. トラブルシュート

### `Auto register` が出ない (= AutoLoadDrivers が拾わない)

- ファイル名が `ogr_*` / `gdal_*` で始まっているか確認
- `ezgdal list-plugins` で正しく配置されているか確認
- `CPL_DEBUG=ON ezgdal gdalinfo --version 2>&1 | grep -i plugin` で
  GDAL_DRIVER_PATH の探索ログを確認

### `Auto register` は出るが `ogrinfo --formats` に表示されない

GDAL の `--formats` フィルタは applet ごとに表示対象を絞る:

- `ogrinfo --formats` → vector (`DCAP_VECTOR=YES` のもの)
- `gdalinfo --formats` → raster (`DCAP_RASTER=YES` のもの)
- `ezgdal gdal --formats` → 全種別

プラグインに正しい DCAP メタデータ (`DCAP_VECTOR` / `DCAP_RASTER`) が
設定されていることを確認する。

### dlopen 失敗 / silent crash

- `otool -L plugin.so` (macOS) / `ldd plugin.so` (Linux) で依存ライブラリを
  確認。host と異なる libgdal への絶対パス依存があれば §4.1 の手順で除去
- 内蔵 GDAL のバージョン (`ezgdal gdalinfo --version`) と
  プラグインビルド時の GDAL バージョンの minor が一致するか確認
- Linux で libc++ / libstdc++ が混在していないか確認 (§4.3)
- GEOS / PROJ / SQLite の重複ロード (host と plugin が別バージョンを持ち込んで
  いないか) を `otool -L` / `ldd` で確認 (§4.4)
- 上記をすべて満たしてもなお crash する場合、§4.5 の Risky pattern に該当
  しないか確認

### `--format <name>` は通るが `--formats` で出ない

GDAL の `--formats` print loop は `nOptions` で raster/vector を絞り込む。
ezgdal は applet 名 (gdalinfo / ogrinfo / ...) から自動で適切な `nOptions` を
渡すが、プラグイン側で `DCAP_VECTOR` / `DCAP_RASTER` のいずれも未設定だと
どの applet からも見えない。

## 8. 参考

- 動く最小例: `verify/DummyPlugin/`
- 実プラグイン例: `gdal-ga-driver` (GeoAccess `SHAPE$` 列を読む独立プラグイン)
- GDAL 公式: https://gdal.org/development/dev_practices.html#building-gdal-from-the-source-code
