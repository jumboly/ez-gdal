#requires -Version 5.1
<#
ez-gdal Windows プラグイン正式サポート準備フェーズの PoC スクリプト。
gdal.dll (MaxRev.Gdal.WindowsRuntime.Minimal の中身) から MSVC で
リンク可能な import library (gdal.lib) を生成する。

なぜ自前生成が必要か:
- MaxRev nupkg (3.12.3.499 確認済み) には gdal.dll のみで .lib が同梱されない
- macOS/Linux は -undefined dynamic_lookup / --allow-shlib-undefined で
  host libgdal にシンボル解決を委譲できるが、Windows DLL は同等手段がない
- プラグイン作者が ezgdal 内蔵 gdal.dll に対して MSVC でリンクするには
  この .lib が必要
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, HelpMessage = "Path to gdal.dll inside MaxRev WindowsRuntime nupkg")]
    [string]$DllPath,

    [string]$OutDir = (Join-Path $PSScriptRoot "build"),

    [ValidateSet("x64", "x86", "arm64")]
    [string]$Machine = "x64"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $DllPath)) {
    throw "gdal.dll not found: $DllPath"
}

$dumpbin = (Get-Command dumpbin.exe -ErrorAction SilentlyContinue)
$lib     = (Get-Command lib.exe     -ErrorAction SilentlyContinue)
if (-not $dumpbin -or -not $lib) {
    throw "MSVC tools (dumpbin.exe / lib.exe) not on PATH. Run from a 'Developer Command Prompt for VS' or use vcvarsall.bat first."
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$exportsPath = Join-Path $OutDir "gdal.exports.txt"
$defPath     = Join-Path $OutDir "gdal.def"
$libPath     = Join-Path $OutDir "gdal.lib"

Write-Host "[1/3] dumpbin /exports $DllPath"
& $dumpbin.Source /nologo /exports $DllPath | Out-File -Encoding ASCII -FilePath $exportsPath
if ($LASTEXITCODE -ne 0) { throw "dumpbin failed (exit $LASTEXITCODE)" }

Write-Host "[2/3] parse exports -> $defPath"
# dumpbin /exports の "ordinal hint RVA name" 4 列をパースする。
# forwarded export ("name = target.dll.target_name") の右辺は \S+ のトー
# クン分割で自然に捨てられる。CRT helper 等の予約名も同じパターンで拾える。
$names = New-Object System.Collections.Generic.List[string]
Get-Content -LiteralPath $exportsPath | ForEach-Object {
    if ($_ -match '^\s*(\d+)\s+([0-9A-Fa-f]+)\s+([0-9A-Fa-f]+)\s+(\S+)') {
        $names.Add($Matches[4]) | Out-Null
    }
}

if ($names.Count -eq 0) {
    throw "No exports parsed from $exportsPath. Check dumpbin output format."
}

$defLines = New-Object System.Collections.Generic.List[string]
$defLines.Add("LIBRARY gdal") | Out-Null
$defLines.Add("EXPORTS")        | Out-Null
foreach ($n in $names) { $defLines.Add("    $n") | Out-Null }
$defLines | Set-Content -Encoding ASCII -LiteralPath $defPath
Write-Host "       parsed $($names.Count) exports"

Write-Host "[3/3] lib /def:$defPath -> $libPath"
& $lib.Source /nologo "/def:$defPath" "/machine:$Machine" "/out:$libPath"
if ($LASTEXITCODE -ne 0) { throw "lib /def failed (exit $LASTEXITCODE)" }

Write-Host ""
Write-Host "OK: $libPath"
Write-Host "Verify with: link /nologo /dll /noentry probe.obj $libPath"
