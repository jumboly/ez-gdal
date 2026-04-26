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
./scripts/publish-all.sh             # 全 RID
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

NuGet.org への push（メンテナ向け）は README.md の「NuGet.org への公開」節を参照。

## アーキテクチャ

### 起動フロー（`src/EzGdal/`）

```
Main(args)                              [Program.cs]
  ├─ Bootstrap.Initialize()             [Bootstrap.cs]
  │   ├─ Thread.CurrentCulture = Invariant   ※ GDAL/PROJ は C locale 期待
  │   ├─ GdalBase.ConfigureAll()             ※ MaxRev が GDAL native を初期化
  │   ├─ Gdal.DontUseExceptions()            ※ legacy EXE と挙動を揃える
  │   └─ ProcessExit / CancelKeyPress に Cleanup を登録
  │
  ├─ ResolveAppName()                   [Program.cs + Util/NativeExecutablePath.cs]
  │   └─ macOS: _NSGetExecutablePath / Linux: /proc/self/cmdline
  │      （AppHost が argv[0] を書き換えるため OS レベルの呼び出しパスを読む）
  │
  └─ Dispatch(appName, args)            [Program.cs]
      ├─ AppletRegistry.Dispatchers[appName] → 該当 applet を実行
      ├─ "ezgdal" / "gdal" → RunMainEntry
      │   ├─ "install-applets" → InstallAppletsApplet
      │   └─ それ以外 → UnifiedCliApplet（GDAL 3.12 統一 CLI）
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

### NuGet パッケージング設計

`src/EzGdal/EzGdal.csproj` の `_NeedMacArm64` / `_NeedLinux` / `_NeedWindows` プロパティが 3 つの呼び出しシナリオ（`PackTargetRid` 指定 / `RuntimeIdentifier` 指定 / dev-loop）から、必要な MaxRev runtime のみを選択する。

- `dotnet pack -p:PackTargetRid=osx-arm64` → `Jumboly.EzGdal.osx-arm64`（51MB）
- `dotnet publish -r osx-arm64` → portable single-file（~84MB）
- `dotnet build` → host RID のみ（dev-loop 高速）

## 設計上の不変条件

- **環境変数を OS / 親シェルに書き戻さない**。GDAL_DATA / PROJ_DATA は MaxRev の `GdalBase.ConfigureAll()` が `CPLSetConfigOption` 経由で設定（Probe 3 で確認済、env が `<unset>` のまま動作）
- **argv[0] 取得は `NativeExecutablePath.Get()` を優先**。`Environment.ProcessPath` は AppHost が解決後のパスへ書き換える
- **`InvariantGlobalization=true`（csproj） + Bootstrap で CurrentCulture 固定**。小数点コンマ等で GeoTransform / WKT が壊れる事故を防ぐ
- **Native AOT は採用しない**。MaxRev の SWIG バインディングは reflection を多用するため
- **Applet 名のリストは `AppletRegistry.Dispatchers` のみが信頼ソース**。Program / InstallApplets / UnknownApplet の各所はそこから派生させる

## 既知の制限

- 起動オーバーヘッド ~100-500ms（.NET ランタイム + ネイティブ展開）。シェルスクリプトで多重ループ起動する用途では本物 GDAL EXE のほうが高速
- `gdalmanage` は GDAL に C API がなく未対応（`ezgdal vsi list` / `vsi copy` 等で代替推奨）
- 追加プラグイン（`GDAL_DRIVER_PATH` 経由の外部 .so/.dll ロード）は single-file 前提のため非対応
