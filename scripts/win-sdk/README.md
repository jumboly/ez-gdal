# scripts/win-sdk — Windows プラグインサポート確立 PoC

ez-gdal の Windows 外部プラグインサポートを β から正式に引き上げる
ための PoC スクリプト群。

> ステータス: **PoC**。本番 CI 統合と SDK nupkg 化は Phase 2/3 で再相談。
> 経緯と判断材料は [`docs/win-plugin-poc.md`](../../docs/win-plugin-poc.md)
> および [`docs/external-plugin-support.md`](../../docs/external-plugin-support.md) を参照。

## なぜ存在するか

ez-gdal が同梱する `MaxRev.Gdal.WindowsRuntime.Minimal` は `gdal.dll` のみ
を含み、プラグイン側で MSVC リンクするのに必要な **import library
(`gdal.lib`) と GDAL ヘッダ**を提供しない。本ディレクトリの 2 本の PoC で
それらを自前生成する経路が成立するか検証する。

| スクリプト | 役割 |
|---|---|
| `gen-import-lib.ps1` | `gdal.dll` から `dumpbin /exports` → `.def` → `lib /def` の流れで `gdal.lib` を生成 |
| `fetch-gdal-headers.ps1` | GDAL 公式 release tarball から必要ヘッダを抽出して `include/gdal/` に平坦化 |

## 前提環境

- **Windows + Visual Studio (MSVC)**: `dumpbin.exe` / `lib.exe` / `tar.exe` が PATH 上にあること
- PowerShell 5.1+ (Windows PowerShell でも PowerShell 7 でも可)
- 「Developer Command Prompt for VS」または `vcvarsall.bat` 実行後のセッションから起動

ローカル macOS / Linux dev では MSVC が無いため `gen-import-lib.ps1` は
動かない。後述の GHA workflow_dispatch 経路を使う。

## 使い方 (Windows ローカル)

```powershell
# 1. MaxRev nupkg を restore して gdal.dll の場所を特定
dotnet restore src/EzGdal/EzGdal.csproj -p:_NeedWindows=true -p:RuntimeIdentifier=win-x64
$dll = "$env:USERPROFILE\.nuget\packages\maxrev.gdal.windowsruntime.minimal\3.12.3.499\runtimes\win-x64\native\gdal.dll"

# 2. import library 生成
.\scripts\win-sdk\gen-import-lib.ps1 -DllPath $dll
# -> scripts\win-sdk\build\gdal.lib

# 3. ヘッダ抽出 (バージョンは MaxRev の upstream に合わせる)
.\scripts\win-sdk\fetch-gdal-headers.ps1 -Version 3.12.3
# -> scripts\win-sdk\build\include\gdal\*.h
```

## 動作確認 (リンクが通るかの最小チェック)

```powershell
$build = "scripts\win-sdk\build"
$probe = @"
extern "C" void GDALAllRegister();
int main() { GDALAllRegister(); return 0; }
"@
$probe | Set-Content -Encoding ASCII probe.cpp

cl /nologo /EHsc /I "$build\include\gdal" probe.cpp /link "$build\gdal.lib"
.\probe.exe
```

リンクが通って起動できれば import library として実用に足る。実際の
ドライバプラグインビルドは `verify\DummyPlugin\` の Windows 対応で
別途検証 (Phase 3)。

## ローカル MSVC を持たない場合 (GHA workflow_dispatch 経由)

Phase 3 で `.github/workflows/win-sdk-poc.yml` (仮) に組み込む予定。
それまでは Windows 実機 (または windows-latest GHA runner) を借りて手で
回す。本 PoC スクリプト自体は単独実行可能なので、CI 化前に
個別に検証できる。

## 出力ディレクトリ

`scripts/win-sdk/build/` 配下にすべての成果物が出る。`.gitignore` で
無視されるようルートの `.gitignore` に追加済み。中間ファイル:

- `gdal.exports.txt` — dumpbin の生出力
- `gdal.def` — パース後の .def
- `gdal.lib` — 生成された import library
- `gdal-<version>.tar.gz` — GDAL 公式 release キャッシュ
- `src/gdal-<version>/` — tarball 展開先
- `include/gdal/*.h` — 抽出されたヘッダ (フラット)

## 既知の制限 (PoC スコープ)

- **patch level の整合**: MaxRev 3.12.3.499 は upstream GDAL 3.12.3。`-Version` は
  これに揃える。MaxRev のバンプに合わせて手で更新する (Phase 2 で自動化)
- **`gdal_version.h`**: configure 生成のため、本 PoC では Major/Minor/Rev/
  RELEASE_NAME のみのスタブを生成する。`GDAL_VERSION_BUILD` や
  `GDAL_RELEASE_DATE` は埋め込まない (プラグインで参照されることは稀)
- **internal header (`*_p.h`) は除外**: GDAL の内部 ABI に依存するプラグインは
  そもそも Risky pattern (`docs/plugin-authoring.md §4.5`) なので
  公開しない方針
- **frmts/ サブドライバヘッダは未網羅**: `frmts/*.h` のうち各ドライバ
  サブディレクトリ (`frmts/gtiff/*.h` 等) は再帰しない。プラグインから
  ドライバ実装に直接アクセスする用途は ABI リスクが高いため非対象
