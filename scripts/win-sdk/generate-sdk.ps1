#requires -Version 5.1
<#
ez-gdal Windows プラグイン SDK の本番生成スクリプト。

なぜラッパーが必要か:
- 既存 PoC 2 本 (gen-import-lib.ps1 / fetch-gdal-headers.ps1) は単体で
  動作するが、出力物が build/ 直下にバラけるため pack-tool.sh + csproj が
  「sdk/ ディレクトリを Include="..." Pack="true"」で 1 ヶ所で拾う構造に
  揃わない。本スクリプトで sdk/lib + sdk/include + sdk/cmake をまとめて
  scripts/win-sdk/build/sdk/ 配下に整える。
- MaxRev / GDAL upstream バージョンを EzGdal.csproj の <MaxRevGdalVersion>
  / <GdalUpstreamVersion> から渡せるようにし、CI と csproj が同じ値を
  使うようにする (バンプ時の追従を 1 ヶ所に閉じ込める)。
#>

[CmdletBinding()]
param(
    # EzGdal.csproj <MaxRevGdalVersion> と揃える
    [string]$MaxRevGdalVersion = "3.12.3.499",

    # MaxRev.Gdal.WindowsRuntime.Minimal の upstream GDAL version。
    # nuspec の description / releaseNotes で確認 (3.12.3.499 → GDAL 3.12.3)
    [string]$GdalUpstreamVersion = "3.12.3",

    # 同梱対象ディレクトリ。csproj の <None Include="..."> も同パスを参照
    [string]$OutDir = (Join-Path $PSScriptRoot "build\sdk")
)

$ErrorActionPreference = "Stop"

# 1. MaxRev nupkg 内の gdal.dll を解決する。dotnet restore 後の
#    ~/.nuget/packages/ レイアウトを前提とする。
$dll = Join-Path $env:USERPROFILE ".nuget\packages\maxrev.gdal.windowsruntime.minimal\$MaxRevGdalVersion\runtimes\win-x64\native\gdal.dll"
if (-not (Test-Path -LiteralPath $dll)) {
    throw "gdal.dll not found at $dll. 先に 'dotnet restore src/EzGdal/EzGdal.csproj -p:_NeedWindows=true -p:RuntimeIdentifier=win-x64' を実行してください。"
}

# 2. 出力ディレクトリ初期化。再生成時に古いファイルが残らないよう毎回クリア
if (Test-Path -LiteralPath $OutDir) { Remove-Item -LiteralPath $OutDir -Recurse -Force }
$libDir   = Join-Path $OutDir "lib"
$cmakeDir = Join-Path $OutDir "cmake"
New-Item -ItemType Directory -Force -Path $libDir   | Out-Null
New-Item -ItemType Directory -Force -Path $cmakeDir | Out-Null
# include/gdal は fetch-gdal-headers.ps1 が作る

# 3. import library 生成 (PoC スクリプトを呼ぶ)
$tmpLib = Join-Path $PSScriptRoot "build\lib-staging"
& (Join-Path $PSScriptRoot "gen-import-lib.ps1") -DllPath $dll -OutDir $tmpLib
Copy-Item (Join-Path $tmpLib "gdal.lib") -Destination $libDir -Force

# 4. headers 抽出 (PoC スクリプトを呼ぶ、$OutDir 配下に直接書き出させる)
$tmpHdr = Join-Path $PSScriptRoot "build\hdr-staging"
& (Join-Path $PSScriptRoot "fetch-gdal-headers.ps1") -Version $GdalUpstreamVersion -OutDir $tmpHdr
Copy-Item (Join-Path $tmpHdr "include") -Destination $OutDir -Recurse -Force

# 5. cmake config 生成 (template の @VAR@ を置換)
$tmplPath = Join-Path $PSScriptRoot "templates\EzGdalSdk.cmake.in"
if (-not (Test-Path -LiteralPath $tmplPath)) {
    throw "template not found: $tmplPath"
}
$cmakeContent = (Get-Content -Raw -LiteralPath $tmplPath) `
    -replace '@GdalUpstreamVersion@', $GdalUpstreamVersion `
    -replace '@MaxRevGdalVersion@',   $MaxRevGdalVersion
Set-Content -Encoding ASCII -LiteralPath (Join-Path $cmakeDir "EzGdalSdk.cmake") -Value $cmakeContent

# 6. サマリ
$libBytes = (Get-Item (Join-Path $libDir "gdal.lib")).Length
$hdrCount = (Get-ChildItem -Recurse -Path (Join-Path $OutDir "include") -Filter "*.h").Count
Write-Host ""
Write-Host "=== EzGdal SDK generated ==="
Write-Host "  $OutDir"
Write-Host "    lib/gdal.lib                      ($([math]::Round($libBytes / 1MB, 2)) MB)"
Write-Host "    include/gdal/*.h                  ($hdrCount headers)"
Write-Host "    cmake/EzGdalSdk.cmake             (find_package(EzGdalSdk))"
Write-Host ""
Write-Host "次: bash ./scripts/pack-tool.sh win-x64  で sdk/ が同梱された nupkg を作成"
