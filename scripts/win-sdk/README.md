# scripts/win-sdk — Windows プラグイン作者向け SDK 生成

`Jumboly.EzGdal.win-x64` nupkg の `sdk/` フォルダに同梱される
**import library (`gdal.lib`) + GDAL 公開ヘッダ + CMake config** を
生成するスクリプト群。

> 経緯と判断材料: [`docs/win-plugin-poc.md`](../../docs/win-plugin-poc.md) /
> [`docs/external-plugin-support.md`](../../docs/external-plugin-support.md)。
> 利用者向けの組み込み手順: [`docs/plugin-authoring.md` §4.1](../../docs/plugin-authoring.md#windows)

## なぜ存在するか

ez-gdal が同梱する `MaxRev.Gdal.WindowsRuntime.Minimal` は `gdal.dll` のみ
を含み、プラグイン側で MSVC リンクするのに必要な **import library
(`gdal.lib`) と GDAL ヘッダ**を提供しない。本ディレクトリのスクリプトで
それらを自前生成し、CI windows ジョブで `Jumboly.EzGdal.win-x64` nupkg に
同梱して配布する。

| スクリプト | 役割 |
|---|---|
| `generate-sdk.ps1` | **エントリポイント**。下 2 本を呼び出し、`build/sdk/{lib,include,cmake}/` に最終配置する |
| `gen-import-lib.ps1` | `gdal.dll` から `dumpbin /exports` → `.def` → `lib /def` で `gdal.lib` を生成 |
| `fetch-gdal-headers.ps1` | GDAL 公式 release tarball から必要ヘッダを抽出して `include/gdal/` に平坦化 |
| `templates/EzGdalSdkConfig.cmake.in` | `find_package(EzGdalSdk)` 用の CMake config テンプレート (`@VAR@` 置換) |

## 前提環境

- **Windows + Visual Studio (MSVC)**: `dumpbin.exe` / `lib.exe` / `tar.exe` が PATH 上にあること
- PowerShell 5.1+ (Windows PowerShell でも PowerShell 7 でも可)
- 「Developer Command Prompt for VS」または `vcvarsall.bat` 実行後のセッションから起動

ローカル macOS / Linux dev では MSVC が無いため SDK 生成は動かない。
CI (`.github/workflows/release.yml` の `pack-windows` ジョブ) が tag push 時に
自動で生成する。

## 使い方 (Windows ローカル)

```powershell
# 1. MaxRev nupkg を restore (gdal.dll を ~/.nuget/packages/ に配置)
dotnet restore src/EzGdal/EzGdal.csproj -p:_NeedWindows=true -p:RuntimeIdentifier=win-x64

# 2. SDK 一式生成 (gdal.lib + headers + cmake config)
.\scripts\win-sdk\generate-sdk.ps1
# → scripts\win-sdk\build\sdk\
#     lib\gdal.lib                  (~3.0 MB)
#     include\gdal\*.h              (173 headers, ~2.6 MB)
#     cmake\EzGdalSdkConfig.cmake

# 3. nupkg に同梱して pack
bash ./scripts/pack-tool.sh win-x64
# → nupkg/Jumboly.EzGdal.win-x64.<ver>.nupkg (~44.6 MB、内 sdk/ 5.6 MB)
```

`generate-sdk.ps1` の引数 `-MaxRevGdalVersion` / `-GdalUpstreamVersion` は
省略時に `EzGdal.csproj` の `<MaxRevGdalVersion>` / `<GdalUpstreamVersion>`
property と同じデフォルトを使う。MaxRev バンプ時は csproj とこの 2 つの
property を更新するだけで全ジョブが追従する。

## 動作確認 (リンクが通るかの最小チェック)

```powershell
$build = "scripts\win-sdk\build\sdk"
@"
extern "C" void GDALAllRegister();
int main() { GDALAllRegister(); return 0; }
"@ | Set-Content -Encoding ASCII probe.cpp

cl /nologo /EHsc /I "$build\include\gdal" probe.cpp /link "$build\lib\gdal.lib"
.\probe.exe
```

リンクが通って起動できれば import library として実用に足る。実プラグイン
レベルの end-to-end 確認は `verify/DummyPlugin/` の Windows ビルド分岐
(`docs/plugin-authoring.md §4.1`) で行う。

## CI (`.github/workflows/release.yml`)

`pack-windows` ジョブが tag push 時に以下を順に走らせる:

1. `dotnet restore -p:_NeedWindows=true` で MaxRev nupkg を取得
2. `vswhere` + `Enter-VsDevShell` で MSVC env (dumpbin / lib / cl が PATH に)
3. `.\scripts\win-sdk\generate-sdk.ps1` で `build/sdk/` 生成
4. `bash ./scripts/pack-tool.sh win-x64` で nupkg に同梱
5. `actions/upload-artifact` で `nupkgs-windows` として保存

`verify` ジョブの win-x64 matrix が install 後の SDK で `verify/DummyPlugin`
を build → install-plugin → ogrinfo --formats まで通すことで、配布物の
end-to-end 妥当性を毎回ガードする。

## 出力ディレクトリ

`scripts/win-sdk/build/` 配下にすべての成果物が出る。`.gitignore` で
無視済み。中間 / 最終ファイル:

- `gdal.exports.txt` — dumpbin の生出力 (中間)
- `gdal.def` — パース後の .def (中間)
- `lib-staging/gdal.lib` — gen-import-lib の出力 (中間)
- `hdr-staging/include/gdal/*.h` — fetch-gdal-headers の出力 (中間)
- `gdal-<version>.tar.gz` — GDAL 公式 release キャッシュ
- `src/gdal-<version>/` — tarball 展開先
- **`sdk/lib/gdal.lib`** — 配布対象
- **`sdk/include/gdal/*.h`** — 配布対象 (フラット、internal `*_p.h` は除外)
- **`sdk/cmake/EzGdalSdkConfig.cmake`** — 配布対象 (find_package 用)

## 既知の制限

- **patch level の整合**: MaxRev `gdal.dll` の upstream patch とヘッダの
  patch が完全一致するように `EzGdal.csproj` の `<MaxRevGdalVersion>` と
  `<GdalUpstreamVersion>` を 1 ヶ所で揃えて運用する。
- **`gdal_version.h`**: configure 生成のため、Major/Minor/Rev/RELEASE_NAME
  のみのスタブを生成する。`GDAL_VERSION_BUILD` や `GDAL_RELEASE_DATE` は
  埋め込まない (プラグインで参照されることは稀)。
- **internal header (`*_p.h`) は除外**: GDAL の内部 ABI に依存するプラグインは
  そもそも Risky pattern (`docs/plugin-authoring.md §4.5`) なので非公開
- **frmts/ サブドライバヘッダは未網羅**: `frmts/*.h` のうち各ドライバ
  サブディレクトリ (`frmts/gtiff/*.h` 等) は再帰しない。プラグインから
  ドライバ実装に直接アクセスする用途は ABI リスクが高いため非対象
