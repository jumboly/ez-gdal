# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 言語方針

- 自然言語の出力（コードコメント、commit メッセージ、README、プラン、設計ドキュメント、CLI のヘルプ文字列など）は **日本語** で書く
- コード識別子・API 名・shell コマンド・ファイルパス・URL は原語（英語）のまま
- コメントは Why のみ書く。What は識別子で表現できるので書かない。タスク・PR・呼び出し元への言及も書かない（PR 説明欄・git log の役割）

## プロジェクトの目的

GDAL を内包したワンバイナリ・ポータブル C# CLI ツール (.NET 10)。2 形態で配布する：

1. **.NET global tool** — `dotnet tool install -g Jumboly.EzGdal.<rid>`、framework-dependent
2. **Self-contained single-file** — `dotnet publish -r <rid>` の出力（~84MB、.NET ランタイム不要）

旧 GDAL EXE (`gdalinfo` / `gdal_translate` / `ogr2ogr` ほか 14 種) と argv 互換、加えて GDAL 3.12+ 統一 CLI (`gdal raster info` 等) も実行可能。MaxRev.Gdal NuGet (3.12.x) 経由で PMTiles 含む 200+ ドライバを内蔵。

## 主要コマンド

### ビルド・パック

```bash
# global tool 用 RID 別 nupkg を 4 つ生成（osx-arm64 / linux-x64 / linux-arm64 / win-x64）
./scripts/pack-tool.sh

# 1 つの RID のみ
./scripts/pack-tool.sh osx-arm64

# Self-contained portable single-file
./scripts/publish-all.sh             # 3 RID（win-x64 / linux-x64 / osx-arm64）
./scripts/publish-all.sh osx-arm64   # 1 つの RID

# 通常の dev-loop ビルド（host platform のみ MaxRev runtime を restore）
dotnet build src/EzGdal/EzGdal.csproj

# バージョン上書き（csproj デフォルトは 0.1.0）
dotnet pack src/EzGdal/EzGdal.csproj -c Release -p:PackTargetRid=osx-arm64 -p:Version=1.0.0
```

### ローカル検証（global tool 経路、グローバル環境を汚さない）

```bash
rm -rf tool-test
dotnet tool install --tool-path ./tool-test --add-source ./nupkg Jumboly.EzGdal.osx-arm64
./tool-test/ezgdal install-applets
./tool-test/gdalinfo /path/to/sample.tif
```

### 検証用 Probe

`verify/DriverProbe/` は MaxRev.Gdal を実機検証するスタンドアロン。MaxRev のバージョンを上げたとき / 新 RID を追加したときに走らせる：

- PMTiles ドライバの含有有無 + Create capability
- `OSGeo.GDAL.Algorithm*` 型の C# expose 状況
- `GdalBase.ConfigureAll()` 後に env が漏れていないか

```bash
dotnet run --project verify/DriverProbe/DriverProbe.csproj
```

### シェル補完の再生成 (GDAL バンプ時)

`scripts/completions/` 配下の bash/zsh/fish/PowerShell 補完スクリプトは静的添付方式で、GDAL 統一 CLI ツリーをハードコードしている。MaxRev.Gdal を上げたら 3 ステップで追従する：

```bash
# 1. gdal --json-usage を data/usage-en.json に再抽出 (system gdal を使う、要 jq)
./scripts/completions/tools/extract.sh

# 2. 前回スナップショットと diff し、変化分のみ Claude API で日本語訳
export ANTHROPIC_API_KEY=sk-ant-...
uv run --project scripts/completions/tools scripts/completions/tools/translate-diff.py

# 3. 4 シェル分の補完スクリプトを再生成 + bash/zsh/fish の syntax check
uv run --project scripts/completions/tools scripts/completions/tools/compile.py
```

NuGet.org への push（メンテナ向け）は `docs/release.md` を参照。

## ドキュメント

- `README.md` — エンドユーザー向け、インストール手順 / RID 別 PackageId 一覧 / 外部プラグインの利用方法
- `docs/release.md` — メンテナ向け、ローカルビルド (`pack-tool.sh` / `publish-all.sh`) と NuGet.org publish 手順
- `docs/plugin-authoring.md` — 外部 GDAL ドライバプラグイン作成者向け。ABI 互換性、ファイル命名規約、ビルドフラグ (`-undefined dynamic_lookup` / `--allow-shlib-undefined`)、トラブルシュート
- `verify/DriverProbe/` — MaxRev.Gdal の機能確認スタンドアロン（前述）
- `verify/DummyPlugin/` — install-plugin / list-plugins / remove-plugin 動作確認用の最小 OGR ドライバ (`ogr_Dummy.so`)。CMake で host GDAL (Homebrew / apt) に対してビルド
- `scripts/completions/README.md` — bash/zsh/fish/PowerShell 補完スクリプトの導入手順 (ユーザー向け) と再生成手順 (メンテナ向け)

## アーキテクチャ

### 起動フロー（`src/EzGdal/`）

```
Main(args)                              [Program.cs]
  ├─ Bootstrap.Initialize()             [Bootstrap.cs]
  │   ├─ Thread.CurrentCulture = Invariant       ※ GDAL/PROJ は C locale 期待
  │   ├─ ApplyUserPluginPath()                   ※ ConfigureAll 前に SetConfigOption
  │   │     └─ PluginPaths.GetUserPluginDir() を GDAL_DRIVER_PATH に追加
  │   ├─ GdalBase.ConfigureAll()                 ※ MaxRev が GDAL native を初期化
  │   ├─ Gdal.DontUseExceptions() / Ogr.DontUseExceptions()  ※ legacy EXE と挙動を揃える
  │   └─ ProcessExit / CancelKeyPress に Cleanup を登録
  │
  ├─ ResolveAppName()                   [Program.cs + Util/NativeExecutablePath.cs]
  │   └─ macOS: _NSGetExecutablePath / Linux: /proc/self/cmdline
  │      （AppHost が argv[0] を書き換えるため OS レベルの呼び出しパスを読む）
  │
  └─ Dispatch(appName, args)            [Program.cs]
      ├─ AppletRegistry.Dispatchers[appName] → GdalCli.Process で標準フラグ前処理 → 該当 applet を実行
      ├─ "ezgdal" / "gdal" → RunMainEntry
      │   ├─ "install-applets" / "uninstall-applets" → InstallAppletsApplet
      │   ├─ "install-plugin" / "list-plugins" / "remove-plugin" → 各 Applet (前処理スキップ)
      │   ├─ args[0] が legacy applet 名 → そちらの handler に転送 (前処理あり)
      │   └─ それ以外 → GdalCli.Process → UnifiedCliApplet（GDAL 3.12 統一 CLI）
      └─ それ以外 → UnknownApplet（候補列挙して exit 1）
```

### Applet 名の単一ソース

`Applets/AppletRegistry.cs` の `Dispatchers` 辞書がすべての旧 EXE 名と Run デリゲートを保持する単一ソース。`Program.Dispatch` / `InstallAppletsApplet`（symlink 生成対象）/ `UnknownApplet`（候補表示）はすべてここから派生する。新しい legacy applet を追加するときは Dispatchers に 1 行加えれば、3 ヶ所が同時に同期する。

C API の安定したラッパーがない 4 種（`gdaltindex` / `gdal_create` / `sozip` / `gdal_viewshed`）は、Dispatchers の lambda で `UnifiedCliApplet.Run` の equivalent サブコマンドへ転送している。

### Applet 実装パターン

各 `Applets/*Applet.cs`（14 個）は本物の `apps/<name>_bin.cpp` を最小限再現した薄いラッパー：

```csharp
var (options, positionals) = new ArgParser(Arity).Split(args);   // 位置引数とオプションに分離
if (positionals.Count != 2) { /* usage */ return ExitCode.UsageError; }

using var src = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenRasterRead, "<applet>");
if (src == null) return ExitCode.Failure;

using var opts  = new GDAL<X>Options(options.ToArray());
using var outDs = Gdal.<UtilApi>(positionals[1], src, opts, null, null);
return outDs == null ? ExitCode.Failure : ExitCode.Success;
```

`Util/ArgParser.cs` は applet 固有の `Arity` Dictionary（`-of` は 1 引数、`-co` は 1 引数、等）を使って `(options, positionals)` に分解する。`Util/GdalHelper.cs` は `OpenEx + null チェック + エラー出力` の重複を集約している。

### 外部プラグイン対応

外部 GDAL ドライバプラグイン (`ogr_<X>.{so,dylib,dll}` / `gdal_<X>.{...}`) を ezgdal の管理下にインストールする経路:

- `Util/PluginPaths.cs` — OS 別ユーザープラグインディレクトリ (macOS: `~/Library/Application Support/ezgdal/plugins/`、Linux: `$XDG_DATA_HOME/ezgdal/plugins/`、Windows: `%APPDATA%\ezgdal\plugins\`)
- `Bootstrap.ApplyUserPluginPath()` — `GdalBase.ConfigureAll()` の前に `Gdal.SetConfigOption("GDAL_DRIVER_PATH", combined)` を呼んで自動ロードを仕込む。env を OS / 親シェルに書き戻さない不変条件を維持
- `Applets/InstallPluginApplet.cs` / `ListPluginsApplet.cs` / `RemovePluginApplet.cs` — `ezgdal install-plugin / list-plugins / remove-plugin` の 3 サブコマンド。`AppletRegistry.Dispatchers` には登録せず、`Program.RunMainEntry` の硬コーディング分岐で扱う (legacy GDAL EXE 名互換ではないため)
- 動作確認: `verify/DummyPlugin/` の最小 OGR ドライバ (`ogr_Dummy.so` / Windows は `ogr_Dummy.dll`) を `cmake -S . -B build && cmake --build build` でビルドし、`ezgdal install-plugin verify/DummyPlugin/build/ogr_Dummy.so` → `ezgdal ogrinfo --formats | grep Dummy` で end-to-end 確認
- Windows プラグイン作者向け SDK (`scripts/win-sdk/`) — `Jumboly.EzGdal.win-x64` nupkg は `sdk/` フォルダに `gdal.lib` (import library) + GDAL ヘッダ + `EzGdalSdkConfig.cmake` config を同梱する。生成は `scripts/win-sdk/generate-sdk.ps1` (内部で `gen-import-lib.ps1` + `fetch-gdal-headers.ps1` を呼ぶ) が CI windows ジョブで実行。MaxRev `gdal.dll` から `dumpbin /exports` → `.def` → `lib /def` で .lib を起こし、GDAL upstream tarball から公開ヘッダを抽出する。プラグイン作者は `EZGDAL_SDK_DIR` 環境変数で sdk/ を指し `find_package(EzGdalSdk REQUIRED)` で参照。`docs/plugin-authoring.md §4.1` の Windows 章を参照

### GDAL 標準 CLI フラグの統合 (`Util/GdalCli.cs`)

`--version` / `--license` / `--build` / `--formats` / `--format <name>` / `--config K V` / `--debug` / `--locale` / `--optfile` / `--help-general` を全 applet 共通で処理する。SWIG bindings の `Gdal.GeneralCmdLineProcessor(string[], int)` を経由 (Probe 5 で expose 済み確認)。

`--formats` の出力対象は `nOptions` 引数で raster / vector を絞る。ezgdal は applet 名から自動で判別 (`GdalCli.NOptionsFor`):

- ogr* applet (ogrinfo / ogr2ogr 等) → `OF_VECTOR` (4)
- それ以外の legacy applet (gdalinfo / gdalwarp 等) → `OF_RASTER` (2)
- ezgdal / gdal の汎用入口 → `OF_ALL` (30)

`GDALPrintDriverList` は `nOptions==0` を `OF_RASTER` に変換するため、SWIG 経由で 0 を渡すとデフォルト raster only になり、vector-only の外部プラグイン (`DCAP_VECTOR=YES` のみ) が `ogrinfo --formats` でも見えなくなる罠がある。

### シェル補完 (`scripts/completions/`)

GDAL 3.12+ 統一 CLI ツリー (`ezgdal raster info` / `ezgdal vector convert` 等、119 ノード) を 4 シェル分の補完スクリプトに展開する。生成は `scripts/completions/tools/` の Python パイプラインが担い、生成物 `ezgdal.{bash,zsh,fish,ps1}` は `src/EzGdal/EzGdal.csproj` が `<EmbeddedResource>` で assembly に埋め込む。実行時は `Applets/CompletionApplet.cs` が `LogicalName` キーで取り出して stdout にバイト列のまま流すだけで、補完ロジック自体には触らない (`ezgdal completion <bash|zsh|fish|powershell>`)。

3 段階のデータパイプライン:

- `tools/extract.sh` — `gdal --json-usage` を `data/usage-en.json` に保存 (system gdal を使う。ezgdal 自身は root algorithm の `--json-usage` 経路を持たないため)
- `tools/translate-diff.py` — `data/usage-en.snapshot.json` と diff し、新規・変更ノードのみ Claude API でバッチ翻訳して `data/usage-ja.json` を更新。終了時に snapshot を refresh
- `tools/compile.py` — `data/` を読んで `ezgdal.{bash,zsh,fish,ps1}` を再生成。en / ja 両方を埋め込み、`LANG`/`LC_ALL`/`LC_MESSAGES` (PowerShell は `CurrentCulture`) で実行時に切替
- `tools/common.py` — `walk_tree` / `normalize_oneline` を compile.py / translate-diff.py で共有

**en と ja を分離する理由**: GDAL バンプで構造ごと変わる en は丸ごと再抽出、ja は変わらない部分を温存して新規・変更分だけ LLM へ送る。これで翻訳コストと品質ブレを抑える。手で直した日本語は次回バンプでも保たれる (snapshot との diff に乗らないため)。

bash は `complete -F` の制約で説明文を出さず候補名のみ。zsh / fish / PowerShell は en/ja 両テーブルから locale で選んで説明付き候補を出す。

### NuGet パッケージング設計

`src/EzGdal/EzGdal.csproj` の `_NeedMacArm64` / `_NeedLinuxX64` / `_NeedLinuxArm64` / `_NeedWindows` プロパティが 3 つの呼び出しシナリオ（`PackTargetRid` 指定 / `RuntimeIdentifier` 指定 / dev-loop）から、必要な MaxRev runtime のみを選択する。MaxRev は OS×arch 単位で別 NuGet パッケージを公開しているので、ezgdal も RID と 1:1 で揃え、各 nupkg には自分の RID 分の native だけを入れる。

- `dotnet pack -p:PackTargetRid=osx-arm64` → `Jumboly.EzGdal.osx-arm64`（~51MB）
- `dotnet pack -p:PackTargetRid=linux-x64` → `Jumboly.EzGdal.linux-x64`（~50MB、x64 native のみ）
- `dotnet publish -r osx-arm64` → portable single-file（~84MB）
- `dotnet build` → host RID のみ（dev-loop 高速）

Intel Mac (osx-x64) は GitHub Actions の macos-13 runner が deprecation/queue 待ちで verify が安定しないため公開対象外（v1.0.0 から）。

## 設計上の不変条件

- **環境変数を OS / 親シェルに書き戻さない**。GDAL_DATA / PROJ_DATA は MaxRev の `GdalBase.ConfigureAll()` が `CPLSetConfigOption` 経由で設定（Probe 3 で確認済、env が `<unset>` のまま動作）。GDAL_DRIVER_PATH も Bootstrap.ApplyUserPluginPath() が `Gdal.SetConfigOption` で立てる (Probe 0a/0b で `ConfigureAll` の前に呼べることと値の保持を確認済み)
- **argv[0] 取得は `NativeExecutablePath.Get()` を優先**。`Environment.ProcessPath` は AppHost が解決後のパスへ書き換える
- **`InvariantGlobalization=true`（csproj） + Bootstrap で CurrentCulture 固定**。小数点コンマ等で GeoTransform / WKT が壊れる事故を防ぐ
- **Native AOT は採用しない**。MaxRev の SWIG バインディングは reflection を多用するため
- **Applet 名のリストは `AppletRegistry.Dispatchers` のみが信頼ソース**。Program / InstallApplets / UnknownApplet の各所はそこから派生させる
- **シェル補完の生成データは `scripts/completions/` に閉じる**。C# 本体は `Applets/CompletionApplet.cs` が `<EmbeddedResource>` を stdout に流すだけで、補完ロジック (シェル別の `complete` / `_arguments` / `Register-ArgumentCompleter` 構文) は触らず Python の `compile.py` で再生成する。`data/*.json` と生成物 `ezgdal.{bash,zsh,fish,ps1}` の両方をコミット対象にし、後者は csproj から `LogicalName="EzGdal.completions.ezgdal.<ext>"` で参照する。エンドユーザーは uv も `ANTHROPIC_API_KEY` も持たない前提

## 既知の制限

- 起動オーバーヘッド ~100-500ms（.NET ランタイム + ネイティブ展開）。シェルスクリプトで多重ループ起動する用途では本物 GDAL EXE のほうが高速
- `gdalmanage` は GDAL に C API がなく未対応（`ezgdal vsi list` / `vsi copy` 等で代替推奨）
- bash 補完は bash 4+ 必須 (連想配列 `declare -A` を使うため、macOS の system bash 3.2 では何もしない)。シェル補完の対象は GDAL 3.12+ 統一 CLI ツリーのみ — legacy applet (`gdalinfo` / `ogr2ogr` 等) の単独補完は提供しない
