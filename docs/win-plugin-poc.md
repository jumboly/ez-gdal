# Windows プラグイン正式サポート PoC まとめ

> ステータス: **Phase 1 (調査と PoC) 完了** (2026-04-26)。
> **Phase 2 (本番経路化) 完了** (2026-04-26、配布方式 A2 採用)。
>
> 本書は判断材料の記録として保持する。実装は以下に取り込まれた:
> - SDK 生成: [`scripts/win-sdk/generate-sdk.ps1`](../scripts/win-sdk/generate-sdk.ps1) (PoC 2 本のラッパー)
> - 同梱: [`src/EzGdal/EzGdal.csproj`](../src/EzGdal/EzGdal.csproj) の `<ItemGroup Condition="'$(PackTargetRid)' == 'win-x64' ...">`
> - CI: [`.github/workflows/release.yml`](../.github/workflows/release.yml) の `pack-windows` ジョブ + `verify` の Windows e2e smoke
> - 利用ガイド: [`docs/plugin-authoring.md` §4.1](plugin-authoring.md#windows)

ez-gdal の外部プラグイン機構は macOS / Linux で完成しているが、Windows は
β サポート (`README.md` 既知の制限 / `docs/plugin-authoring.md §4.1`)。
正式サポート化に向けた準備フェーズとして、ABI 互換性確保と SDK 配布
経路の実現性を調査した。

関連:
- 経緯と背景: [`docs/external-plugin-support.md`](external-plugin-support.md)
- PoC スクリプト: [`scripts/win-sdk/`](../scripts/win-sdk/)

## 1. 調査結果サマリ

### 1.1 MaxRev WindowsRuntime nupkg の中身

`MaxRev.Gdal.WindowsRuntime.Minimal` 3.12.3.499 (現行 ez-gdal が依存する
バージョン) を `dotnet restore` で取得して中身を確認:

| 項目 | 結果 |
|---|---|
| `runtimes/win-x64/native/gdal.dll` | あり (~22MB) + 67 個の依存 dll |
| `gdal.lib` (import library) | **なし** |
| `*.h` (GDAL ヘッダ) | **なし** |
| `*.def` (export definition) | **なし** |
| upstream GDAL バージョン | **3.12.3** (nuspec の `description` / `releaseNotes` で確認) |

旧版 `3.12.0.397` も同レイアウト。MaxRev は import library とヘッダを
nupkg に同梱しない方針が確立している。**ez-gdal 側で何らかの形で補完
する必要がある**。

### 1.2 vcpkg gdal port の現行バージョン

microsoft/vcpkg master の `ports/gdal/vcpkg.json` を参照:

| 項目 | 値 |
|---|---|
| vcpkg gdal port | **3.12.4** |
| MaxRev WindowsRuntime upstream | 3.12.3 |
| 差分 | patch level 1 つ (3.12.3 vs 3.12.4) |

minor (3.12.x) は揃うが patch がずれる。プラグイン作者ガイドライン
(`docs/plugin-authoring.md §1`) は「同 minor」を推奨しているが、patch ずれ
の ABI 影響は GDAL upstream の方針次第 (公式は patch リリース内での ABI
不変を表明していない)。

### 1.3 PoC スクリプト

[`scripts/win-sdk/`](../scripts/win-sdk/) に 2 本の PoC を新設し、ローカル
PowerShell で構文チェック済み:

| スクリプト | 機能 | 実行環境 |
|---|---|---|
| `gen-import-lib.ps1` | `gdal.dll` → `dumpbin /exports` → `.def` → `lib /def:` で `gdal.lib` 生成 | Windows + MSVC |
| `fetch-gdal-headers.ps1` | GDAL 公式 release tarball (v3.12.3) から `port/` `gcore/` `alg/` `ogr/` `ogr/ogrsf_frmts/` `frmts/` の `*.h` を平坦化抽出 | Windows + tar.exe (Win10 1803+ 標準) |

実機 MSVC でのリンク検証は当初 Phase 3 送りだったが、§1.4 のとおり Phase 1
内で前倒し実施した。

### 1.4 GHA 実機検証結果 (2026-04-26)

`.github/workflows/win-sdk-poc.yml` (workflow_dispatch 専用) を windows-2022
runner で 1 回実行し、PoC スクリプト 2 本 + リンク確認 + `probe.exe` 起動
までを通した:

| 項目 | 値 |
|---|---|
| `gdal.dll` の export 数 | **8653** |
| 生成された `gdal.lib` サイズ | **3.0 MB** (3,142,176 bytes) |
| 抽出された GDAL ヘッダ数 | **173** |
| 抽出ヘッダ合計サイズ | **2.6 MB** |
| **SDK 配布候補合計 (lib + headers)** | **約 5.6 MB** |
| `cl /EHsc /I include\gdal probe.cpp /link gdal.lib` | 成功 |
| `probe.exe` 実行 (実 `gdal.dll` を dlopen して `GDALAllRegister()` 呼出) | exit 0 |
| job 全体実行時間 | 1m15s |
| 中間ファイル (配布対象外) | `gdal.def` 460KB / `gdal.exports.txt` 644KB |

- run URL: https://github.com/jumboly/ez-gdal/actions/runs/24949574893
- artifact 名: `win-sdk-poc-build` (90 日保管)

これで Phase 1 の中心的仮説 (「MaxRev 同梱 `gdal.dll` に対して自前生成の
`gdal.lib` + 抽出ヘッダで MSVC リンク + 実 dlopen が成立する」) が実機で
確認された。Phase 2 で配布方式 (A1/A2/A3) を決めるためのサイズ実数値も
これで揃う。

## 2. Phase 2 判断材料

Phase 2 で「Windows プラグイン作者向けに何を配布するか」を選択する。
3 案の比較:

| 案 | 内容 | 工数 | ABI リスク | 利用者体験 |
|---|---|---|---|---|
| **A1**: 別 SDK nupkg | `Jumboly.EzGdal.Sdk.win-x64` を新規発行。`gdal.lib` + headers + CMake find script を同梱 | 中 (csproj 1 本追加 + CI ジョブ + nuget push 経路) | 最小 (ez-gdal と同 patch を保証) | `dotnet add package` 1 行で完結 |
| **A2**: メイン nupkg 同梱 | `Jumboly.EzGdal.win-x64` の `sdk/` フォルダに lib + headers を入れる | 小 | 最小 (同上) | nupkg サイズが **+5.6MB** (~14% 増、§1.4 実測)。プラグイン不要なユーザーにも負担 |
| **A3**: ドキュメントのみ | 「vcpkg gdal を使う」「自前で `gdal.lib` を作る」手順を `docs/plugin-authoring.md` に追記 | 最小 | 中 (vcpkg は patch ずれ、自前生成は作者責任) | プラグイン作者の初期セットアップが大きい |

### 推奨: **A2 (メイン nupkg 同梱) を Phase 2 の出発点にする**

根拠:

1. **patch 整合の必要性**: §1.2 のとおり vcpkg gdal は patch がずれる。
   GDAL upstream は patch 内 ABI 不変を保証していないため、A3 (vcpkg 利用)
   は ezgdal バンプ毎に「動くかどうか」が確率的になる。SDK 配布は ezgdal
   と同じ patch のものを必ず提供できる
2. **nupkg サイズへの影響は許容範囲**: §1.4 の実機計測で `gdal.lib` は
   **3.0MB** (8653 exports 分の export table)、ヘッダは **173 ファイルで
   合計 2.6MB**。SDK 同梱で **+5.6MB** (現状 `Jumboly.EzGdal.win-x64`
   ~39MB → ~44.6MB、約 14% 増)。global tool 利用者にとっては許容範囲
3. **A1 vs A2 の選択**: Phase 2 で別 nupkg に分割するメリットは「SDK が
   不要なユーザーが nupkg を小さく保てる」こと。ただし global tool 利用者は
   ほとんどが「ezgdal を CLI として使う」だけで、わずかな膨張は気にならない。
   一方で別 nupkg にすると CI ジョブ追加、nuget push 経路の追加、依存解決
   (どちらか単独で動くか、SDK が main を依存に持つか) の整理が要る。
   Phase 2 の最初のステップとしては A2 で済ませ、需要が出たら A1 に移行する

A1 への将来移行は csproj の `<PackageId>` 条件分岐 (`Jumboly.EzGdal.Sdk.win-x64`)
を追加するだけで済む構造になっており、A2 で先行してもロックインされない。

## 3. Phase 1 で消化した未確定事項 (`docs/external-plugin-support.md §8` より)

| 項目 | 結果 |
|---|---|
| MaxRev.Gdal nupkg に GDAL ヘッダが含まれるか | **含まれない** (3.12.3.499 確認済み)。Windows 用は別途配布が必要 |
| MaxRev libgdal の独自パッチ有無 (ABI ズレ可能性) | nuspec では明記なし。実機 `gdal.dll` の version リソース確認は Phase 3 (Windows runner で実施) |
| 案 C 実装時の PackageId 命名規則 | A1 採用時は `Jumboly.EzGdal.Sdk.win-x64` を提案 (本書 §2 参照) |

## 4. Phase 2 推奨スコープ

1. `EzGdal.csproj` に Windows 限定の `<None Include="...sdk/**/*" Pack="true" PackagePath="sdk/" />` を追加
2. `pack-tool.sh` (または GHA `pack-windows.yml`) の win-x64 ステップで本 PoC 2 本を呼び、`sdk/lib/gdal.lib` + `sdk/include/gdal/*.h` + `sdk/cmake/EzGdalSdk.cmake` (新規) を生成
3. `verify/DummyPlugin/CMakeLists.txt` に Windows 分岐追加: `find_package(EzGdalSdk REQUIRED)` で SDK パス解決
4. windows-latest GHA runner で smoke test: ezgdal install-plugin + ezgdal vector --formats | grep Dummy

Phase 3 (実装) の見積りは別途。
