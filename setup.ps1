# Agent Foundry - Script cai dat cau hinh
param (
    [Parameter(Position = 0)][string]$ProjectPath = ".",
    [ValidateSet("web")][string]$Preset,
    [string[]]$Skills,
    [string[]]$Rules,
    [switch]$Overwrite
)

$source = Join-Path $PSScriptRoot ".agents"
if (-not (Test-Path $source)) { Write-Error "Khong tim thay thu muc .agents nguon."; exit 1 }

if (-not (Test-Path $ProjectPath)) { New-Item -ItemType Directory -Force -Path $ProjectPath | Out-Null }
$dest = Join-Path (Resolve-Path $ProjectPath).Path ".agents"

$allSkills = (Get-ChildItem (Join-Path $source "skills") -Directory).Name
$allRules = (Get-ChildItem (Join-Path $source "rules") -File).BaseName

if ($Skills -or $Rules) {
    $selSkills = if ($Skills) { $Skills | ForEach-Object { $_.Trim() } | Where-Object { $allSkills -contains $_ } } else { @() }
    $selRules = if ($Rules) { $Rules | ForEach-Object { ($_ -replace '\.md$', '').Trim() } | Where-Object { $allRules -contains $_ } } else { @() }
} else {
    $selSkills = $allSkills
    $selRules = $allRules
}

function Copy-ConfigItem([string]$srcFile, [string]$dstFile, [string]$rel) {
    $parent = Split-Path $dstFile -Parent
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    if ((Test-Path $dstFile) -and (-not $Overwrite)) {
        Write-Host "  [Da co, bo qua] $rel" -ForegroundColor DarkGray
    } else {
        Copy-Item -Path $srcFile -Destination $dstFile -Force
        Write-Host "  [Da chep] $rel" -ForegroundColor Green
    }
}

Write-Host "`nDang cai cau hinh vao: $dest" -ForegroundColor Cyan

foreach ($s in $selSkills) {
    $sDir = Join-Path $source "skills\$s"
    if (Test-Path $sDir) {
        Get-ChildItem -Path $sDir -Recurse -File | ForEach-Object {
            $rel = ".agents" + $_.FullName.Substring($source.Length)
            Copy-ConfigItem $_.FullName (Join-Path $dest $_.FullName.Substring($source.Length)) $rel
        }
    }
}

foreach ($r in $selRules) {
    $rFile = Join-Path $source "rules\$r.md"
    if (Test-Path $rFile) {
        $rel = ".agents/rules/$r.md"
        Copy-ConfigItem $rFile (Join-Path $dest "rules\$r.md") $rel
    }
}

$needLearnings = ($selSkills -match "ai-learning|human-learning") -or ($selRules -contains "load-learnings") -or (-not ($Skills -or $Rules))
if ($needLearnings) {
    $lDir = Join-Path $dest "learnings"
    if (-not (Test-Path $lDir)) { New-Item -ItemType Directory -Force -Path $lDir | Out-Null }
    $gk = Join-Path $lDir ".gitkeep"
    if (-not (Test-Path $gk)) { New-Item -ItemType File -Force -Path $gk | Out-Null }
}

Write-Host "Hoan tat.`n" -ForegroundColor Cyan
