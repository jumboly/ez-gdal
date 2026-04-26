# 外部 GDAL ドライバプラグイン対応（仕様書 / 経緯）

> ステータス: **実装済み** (2026-04-26)。ezgdal 0.x 以降で `install-plugin` / `list-plugins` / `remove-plugin` サブコマンドを提供。本書は当時の検討経緯を残すための歴史ドキュメントで、利用者向け情報は README.md、プラグイン作者向け情報は `docs/plugin-authoring.md` を参照。
> 想定読者: 当時の判断基準を辿りたい開発者

## 1. 背景と目的

ezgdal は MaxRev.Gdal NuGet 内蔵のドライバセット（GeoTIFF / GeoPackage / Shapefile / PMTiles など 200+）で動作するワンバイナリ CLI として設計されている。

一方で、ユーザーが独自の GDAL ドライバ DLL（`ogr_<DriverName>.{so,dylib,dll}`）を組み合わせて使いたいケースがある。

ezgdal の `README.md` / `CLAUDE.md` の現状記述は「**追加プラグインは非対応**」だが、2026-04-26 の検証で **環境変数 `GDAL_DRIVER_PATH` 経由でのプラグインロードは現状でも動く**ことが判明した。本仕様書はこれを踏まえ、対応方針と必要な改修を整理する。

## 2. 検証結果（2026-04-26、macOS arm64）

### 2.1 環境

| 項目 | 値 |
|---|---|
| ezgdal バイナリ | `/Users/masa/src/ez-gdal/publish/osx-arm64/ezgdal` |
| ezgdal 内蔵 GDAL | MaxRev.Gdal 3.12.x（実体は GDAL 3.12.2） |
| 検証プラグイン | host GDAL (Homebrew 3.12.x) に対してビルドした OGR ドライバ |
| プラグインのリンク先 | Homebrew `/opt/homebrew/opt/gdal/lib/libgdal.38.dylib` (current 38.3.12) |
| エクスポート シンボル | `_RegisterOGR<DriverName>` |

### 2.2 確認したこと

```bash
CPL_DEBUG=ON GDAL_DRIVER_PATH=/path/to/plugin/dir \
  /Users/masa/src/ez-gdal/publish/osx-arm64/ogrinfo --formats 2>&1 \
  | grep -i -E "plugin|register"
```

CPL_DEBUG ログに以下のような自動登録メッセージが出る:

```
GDAL: Auto register .../ogr_<DriverName>.so using RegisterOGR<DriverName>.
```

→ **plugin の dlopen + register 自体は成功**。MaxRev の `GdalBase.ConfigureAll()` が内部で呼ぶ `GDALAllRegister()` がプロセス env から `GDAL_DRIVER_PATH` を読み、自動で plugin をロードしている。ezgdal の Bootstrap は env を**書き換えない**設計なので、env が立っていればそのまま GDAL に届く構造。

### 2.3 動かなかったこと（と原因）

| 症状 | 原因 |
|---|---|
| `ogrinfo --formats` の出力にプラグイン名が出ない | ezgdal の applet が `--formats` を未知のオプションとして弾いている。プラグインのロードとは別問題（§4.2） |

### 2.4 結論

**ezgdal は現状の構成のまま、`GDAL_DRIVER_PATH` 経由で外部 GDAL plugin をロードできる**。

```bash
GDAL_DRIVER_PATH=/path/to/plugin/dir gdalinfo /path/to/data
GDAL_DRIVER_PATH=/path/to/plugin/dir ogrinfo "CUSTOM:..."
```

README / CLAUDE.md の「追加プラグイン非対応」という記述は実態と乖離している。

## 3. 残課題

### 3.1 ABI 互換性

検証で動いたのは**偶然 ABI 互換だった**ことに依存する：

- 検証プラグインは Homebrew GDAL 3.12.x に対してビルド・リンク
- ezgdal が同梱する MaxRev の libgdal も 3.12.2
- 同一プロセスに 2 つの libgdal がロードされる（dlopen の依存解決経由）が、両者とも 3.12 minor でシンボル互換のため動いた

#### リスクシナリオ

| シナリオ | 結果 |
|---|---|
| MaxRev の libgdal が独自パッチで ABI ずれ | 静かに crash / 症状が間欠的 |
| ユーザーが Homebrew GDAL を持たない環境（Linux 一般、Windows） | 絶対パス `/opt/homebrew/opt/gdal/...` の依存解決失敗 |
| MaxRev が GDAL 3.13 に上がる | 同 minor の前提が崩れる |

#### 対策案

| アプローチ | 内容 |
|---|---|
| (a) MaxRev nupkg のバイナリにリンク | MaxRev.Gdal.<Rid>Runtime.Minimal.nupkg を展開して `runtimes/<rid>/native/libgdal.*` を取り出し、それに対してビルド |
| (b) GDAL 公式 source からビルド | 同 minor バージョン（3.12.2）の release source を取得して `find_package(GDAL)` させる |
| (c) `install_name_tool` で書き換え | 既存ビルド済みバイナリの依存を `@rpath/libgdal.38.dylib` に変更し、ezgdal extract dir を rpath に |

### 3.2 GDAL 標準フラグ未対応

GDAL 公式 EXE の本物は `main()` 冒頭で `GDALGeneralCmdLineProcessor(argc, argv, 0)` を呼び、以下のフラグを共通で処理する：

| フラグ | 役割 |
|---|---|
| `--version` | GDAL バージョン文字列を出して exit 0 |
| `--license` | LICENSE.TXT を出して exit 0 |
| `--build` | ビルド情報を出して exit 0 |
| `--formats` | 全ドライバ一覧を出して exit 0 |
| `--format <name>` | 特定ドライバの詳細を出して exit 0 |
| `--config <key> <value>` | 実行時 config を設定して argv から除外 |
| `--debug ON\|OFF\|<level>` | CPL_DEBUG レベル設定 |
| `--locale <name>` | ロケール設定 |
| `--optfile <file>` | ファイルから追加 argv を読む |
| `--help-general` | 上記の説明を出して exit 0 |

ezgdal の各 applet ではこれらが未実装で、`--formats` 等はすべて未知オプション扱いされて usage error になる。これが「プラグインがロードされても `--formats` で確認できない」原因。

#### 対応設計

`Bootstrap.Initialize()` の後、`Dispatch` の前に以下を挟む：

```csharp
// 仮実装イメージ
static string[] PreprocessArgs(string[] args)
{
    // SWIG バインディングに Gdal.GeneralCmdLineProcessor が expose されているか
    // 要 Probe 検証（DriverProbe でメソッド一覧を確認）
    return Gdal.GeneralCmdLineProcessor(args, 0)
           ?? args;  // null なら GDAL が --version 等を処理して exit 想定
}
```

#### 確認事項

- `OSGeo.GDAL.Gdal.GeneralCmdLineProcessor` の C# 公開状況（`verify/DriverProbe/Program.cs` の reflection リストで確認可能）
- 公開されていない場合は `gdal_priv.h` 相当の関数を P/Invoke する補完が必要

### 3.3 配布物への同梱（オプション）

ezgdal の配布物に独自 plugin を**同梱**して、ユーザーが `GDAL_DRIVER_PATH` を立てる手間なく使えるようにする選択肢。

#### 配置案

```
ezgdal extract dir (= AppContext.BaseDirectory)
└── runtimes/<rid>/native/
    ├── libgdal.38.3.12.2.dylib       (MaxRev 同梱)
    ├── ogr_<DriverName>.dylib        (新規同梱、@rpath で libgdal を解決)
    └── ...
```

#### Bootstrap 改修

```csharp
var pluginDir = Path.Combine(AppContext.BaseDirectory, "runtimes",
                             RuntimeInformation.RuntimeIdentifier, "native");
Gdal.SetConfigOption("GDAL_DRIVER_PATH", pluginDir);
```

(または `CPLSetConfigOption` を P/Invoke)

#### PackageId の独立

メイン `Jumboly.EzGdal.<rid>` は維持し、plugin 同梱版は別 ID で配布する場合、サフィックス命名規則（例: `Jumboly.EzGdal-<DriverName>.<rid>`）はバンドル対象が出てきた時点で決定する。

メインに混ぜると 4 nupkg のサイズが膨らむ + plugin 不要なユーザーが困るため。

## 4. 実装方針の選択肢

| 案 | 内容 | 工数 | 影響範囲 |
|---|---|---|---|
| **A. 現状維持（記述訂正のみ）** | README / CLAUDE.md の「非対応」を「`GDAL_DRIVER_PATH` 経由で利用可、ABI 互換は自己責任」に書き換え。ezgdal 側のコード変更なし | 小（30 分） | docs |
| **B. 最小改修** | A + `GDALGeneralCmdLineProcessor` を Bootstrap で統合し `--formats` / `--version` 等を共通対応。ABI 互換性ガイド追記 | 中（半日〜1日） | Bootstrap + Program、各 applet の Arity 表は変更不要 |
| **C. 同梱版を独立配布** | 独立プラグインを ezgdal リポジトリの build 経路に組み込み、`Jumboly.EzGdal-<DriverName>.<rid>` として独立配布。MaxRev libgdal に対するクロスビルド環境を整備 | 大（数日〜週） | csproj、scripts、CI、新規 nupkg、ABI 整合の検証マトリクス |

### 採用結果

**案 B 相当を採用 + さらにユーザーローカルディレクトリへの install サブコマンドを追加**。

- `Util/PluginPaths.cs` で OS 別ユーザープラグインディレクトリ取得
- `Bootstrap` の ConfigureAll 前に `Gdal.SetConfigOption("GDAL_DRIVER_PATH", ...)` で自動ロード
- `ezgdal install-plugin / list-plugins / remove-plugin` サブコマンドで管理
- `Util/GdalCli.cs` で `--version` / `--formats` 等を全 applet 共通処理 (applet 名から `OF_RASTER` / `OF_VECTOR` / `OF_ALL` を自動選択)
- 動作確認用ダミーは `verify/DummyPlugin/`

案 C は当時の懸念事項のまま未採用。独立プラグインを bundle したい場合の今後の選択肢として残置。

## 5. 別セッションでの作業手順

### 5.1 案 B を実装する場合

1. **Probe 拡張**: `verify/DriverProbe/Program.cs` を編集し、`Gdal.GeneralCmdLineProcessor` 系メソッドが OSGeo.GDAL バインディングに expose されているか reflection で確認
2. expose されている場合:
   - `Bootstrap.PreprocessArgs(string[])` を新設、`Program.Main` で `Dispatch` 前に呼ぶ
   - 戻り値が `null` なら GDAL 側で処理済み → `Util.ExitCode.Success` で exit
3. expose されていない場合:
   - `Util/PInvoke/GdalCli.cs` 新設、`GDALGeneralCmdLineProcessor` を直接 P/Invoke
   - シグネチャ: `int GDALGeneralCmdLineProcessor(int argc, char ***ppapszArgv, int nOptions)` (cf. gdal/port/cpl_conv.h)
4. ezgdal の README / CLAUDE.md から「非対応」記述を訂正、`GDAL_DRIVER_PATH` の使い方を documented
5. スモークテストに以下を追加:
   - `GDAL_DRIVER_PATH=... ogrinfo --formats | grep <PluginName>`
   - `--version` / `--license` の出力確認

### 5.2 案 C を実装する場合（B 完了後）

1. ABI 互換ビルド環境の調査:
   - MaxRev.Gdal.MacosRuntime.Minimal.arm64.nupkg に headers が含まれるか確認
   - 含まれていない場合、GDAL 公式 release（v3.12.2）からヘッダ取得 + MaxRev 同梱の libgdal にリンク
2. `external/<plugin-repo>/` を git submodule で追加（または ExternalProject_Add）
3. csproj に MSBuild Target を追加して `cmake -DCMAKE_BUILD_TYPE=Release ...` を呼ぶ
4. 生成された `ogr_<DriverName>.<ext>` を `runtimes/<rid>/native/` に Copy
5. `install_name_tool -change` で依存を `@rpath/libgdal.38.dylib` に書き換え（macOS）/ `patchelf` で `RPATH` 設定（Linux）
6. `Bootstrap` に `Gdal.SetConfigOption("GDAL_DRIVER_PATH", ...)` を追加
7. 新 PackageId 用の `PackTargetRid=*-<plugin>` を csproj に追加
8. CI: 4 RID 分のクロスビルド環境（macOS arm64/x64、Ubuntu x64/arm64、Windows x64）

## 6. 参考コマンド

```bash
# プラグインのリンク先確認
otool -L /path/to/ogr_<DriverName>.so

# Register シンボル確認
nm -gU /path/to/ogr_<DriverName>.so | grep Register

# ezgdal でのプラグインロード確認
CPL_DEBUG=ON GDAL_DRIVER_PATH=/path/to/plugin/dir \
  /Users/masa/src/ez-gdal/publish/osx-arm64/ogrinfo --formats 2>&1 \
  | grep -i -E "plugin|register"

# Identify 呼び出しテスト（プラグイン側の Open 実装が必要）
CPL_DEBUG=ON GDAL_DRIVER_PATH=... ogrinfo "CUSTOM:..."

# 動作確認用に外部プラグインを MaxRev libgdal にリンクし直す（案 C 検討用）
install_name_tool -change /opt/homebrew/opt/gdal/lib/libgdal.38.dylib \
  @rpath/libgdal.38.dylib \
  /path/to/ogr_<DriverName>.so
```

## 7. 関連リポジトリ・ファイル

- ezgdal 本体: `/Users/masa/src/ez-gdal/` (本リポジトリ)
- 既存制約記述（要更新）: `/Users/masa/src/ez-gdal/README.md` の「既知の制限」、`/Users/masa/src/ez-gdal/CLAUDE.md` の「既知の制限」
- 検証用 Probe: `/Users/masa/src/ez-gdal/verify/DriverProbe/Program.cs`

## 8. 未確定事項

- [x] `Gdal.GeneralCmdLineProcessor` の C# 公開状況 → SWIG bindings に expose 済み (Probe 5)。P/Invoke 不要
- [x] `Gdal.SetConfigOption` を `GdalBase.ConfigureAll()` の前に呼べるか + 値が保持されるか → 両方 OK (Probe 0a/0b)
- [x] MaxRev.Gdal nupkg に GDAL ヘッダが含まれるか → **含まれない**。Windows runtime nupkg (3.12.3.499 / 3.12.0.397 双方確認) は `gdal.dll` のみで `.lib` / `.h` / `.def` 一切なし。Windows プラグイン正式サポート化時は ez-gdal 側で生成・配布が必要。詳細は [`docs/win-plugin-poc.md`](win-plugin-poc.md)
- [x] MaxRev WindowsRuntime の upstream GDAL バージョン → 3.12.3 (nuspec の `description` / `releaseNotes` で確認、3.12.3.499 時点)
- [x] MaxRev libgdal の独自パッチ有無（ABI ズレ可能性）→ Phase 1 PoC で実機 MSVC リンク + `GDALAllRegister()` 起動成立を確認済 (`docs/win-plugin-poc.md §1.4`)。ABI 互換性の継続確認は `verify/DummyPlugin/` の Windows e2e smoke が `release.yml` の verify ジョブでガード
- [x] Windows プラグイン SDK の配布方式 → A2 (メイン nupkg `Jumboly.EzGdal.win-x64` の `sdk/` フォルダ同梱) で実装済。詳細は [`docs/win-plugin-poc.md §2`](win-plugin-poc.md)

Windows プラグイン正式サポート (案 B の延長線) は **完了**。
Phase 1 (調査と PoC) と Phase 2 (本番経路化) の記録は
[`docs/win-plugin-poc.md`](win-plugin-poc.md)、SDK 生成スクリプトは
[`scripts/win-sdk/`](../scripts/win-sdk/) を参照。

## 9. 実装時の落とし穴 (備忘)

### `--formats` がプラグインドライバを表示しない問題 (解決済み)

GDAL 3.12 の `GDALPrintDriverList(int nOptions, bool bJSON)` は `nOptions==0` を `OF_RASTER` に変換するため、SWIG 経由で 0 を渡すとデフォルト raster only になる。`DCAP_VECTOR=YES` のみのプラグインは `ogrinfo --formats` でも見えなくなる。

→ `Util/GdalCli.cs` で applet 名から `OF_VECTOR` / `OF_RASTER` / `OF_ALL` を自動選択する `NOptionsFor` を実装し、`Gdal.GeneralCmdLineProcessor(argv, nOptions)` の第 2 引数に渡すことで解決。

### プラグインの libgdal 依存問題 (`-undefined dynamic_lookup`)

プラグインを `-lgdal` でリンクすると、ezgdal プロセスに 2 つの libgdal (内蔵 MaxRev + プラグインのリンク先 Homebrew 等) が並列で読まれ、driver manager が分裂する (`GetGDALDriverManager()` がプラグインから見たときに別インスタンスを返す)。結果、`AutoLoadDrivers` のログには "Auto register" が出るのに、ezgdal からはドライバが見えない症状になる。

→ プラグイン側で macOS は `-Wl,-undefined,dynamic_lookup`、Linux は `-Wl,--allow-shlib-undefined` を使い、libgdal シンボルを host のものに解決させる。Windows は `Jumboly.EzGdal.win-x64` 同梱の SDK (`sdk/lib/gdal.lib`) にリンクする。詳細は `docs/plugin-authoring.md` §4.1。
