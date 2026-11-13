<#
.SYNOPSIS
    Script cài đặt bộ cấu hình Antigravity Starter vào dự án đích.

.DESCRIPTION
    Đưa các rules, skills (kèm toàn bộ file phụ trong thư mục), và templates chuẩn
    vào dự án đích.
    Hỗ trợ 2 chế độ chính:
      1. Cài đặt theo Preset:
         - -Preset base: Chỉ cài file mẫu AGENTS.md tại gốc dự án đích.
         - -Preset web : Trọn bộ cho Web Development (9 skills, 2 rules, learnings).
         - -Preset all : Toàn bộ kho cấu hình (bao gồm AGENTS.md và toàn bộ skills/rules).
      2. Cài đặt chọn lọc từng mục:
         - -Skills <danh sách>: Cài toàn bộ thư mục của skill đã chọn.
         - -Rules <danh sách> : Cài các rule đã chọn.

    Script an toàn với mã nguồn dự án, bỏ qua các file giống hệt nhau, và cảnh báo
    rõ ràng nếu file cấu hình đã tồn tại có nội dung khác.

.PARAMETER ProjectPath
    Đường dẫn tới thư mục dự án đích (mặc định: ".").

.PARAMETER Preset
    Tên gói cấu hình định sẵn: "base", "web", hoặc "all".

.PARAMETER Skills
    Mảng tên các skills cụ thể cần cài (VD: @("frontend-design", "webapp-testing")).

.PARAMETER Rules
    Mảng tên các rules cụ thể cần cài (VD: @("web-design-backbone", "load-learnings")).

.PARAMETER Overwrite
    Ghi đè file nếu có xung đột nội dung (mặc định giữ nguyên file của dự án).

.EXAMPLE
    # Khởi tạo dự án mới với AGENTS.md cơ bản
    .\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset base

    # Bổ sung kỹ năng thiết kế Web và Rule tương ứng
    .\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "frontend-design" -Rules "web-design-backbone"

    # Bổ sung kỹ năng kiểm thử Web
    .\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Skills "webapp-testing"

    # Cài đặt trọn bộ cho dự án Web
    .\setup.ps1 -ProjectPath "D:\Projects\MyApp" -Preset web
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$ProjectPath = ".",

    [Parameter(Mandatory = $false)]
    [ValidateSet("base", "web", "all")]
    [string]$Preset,

    [Parameter(Mandatory = $false)]
    [string[]]$Skills,

    [Parameter(Mandatory = $false)]
    [string[]]$Rules,

    [switch]$Overwrite
)

$ErrorActionPreference = "Stop"

function Write-ColorHost {
    param (
        [string]$Message,
        [ConsoleColor]$Color = [ConsoleColor]::White
    )
    Write-Host $Message -ForegroundColor $Color
}

Write-ColorHost "`n=======================================================" Cyan
Write-ColorHost "   ANTIGRAVITY STARTER - BỘ CÀI ĐẶT CẤU HÌNH DỰ ÁN     " Cyan
Write-ColorHost "=======================================================`n" Cyan

# 1. Định vị thư mục nguồn và đích
$sourceRoot = $PSScriptRoot
$sourceAgents = Join-Path $sourceRoot ".agents"
$templateAgentsMd = Join-Path $sourceRoot "templates\AGENTS.md"

if (-not (Test-Path $sourceAgents)) {
    Write-ColorHost "[LỖI] Không tìm thấy thư mục nguồn .agents tại: $sourceAgents" Red
    exit 1
}

if (-not (Test-Path $ProjectPath)) {
    Write-ColorHost "[THÔNG BÁO] Thư mục dự án đích chưa tồn tại, đang khởi tạo: $ProjectPath" Yellow
    New-Item -ItemType Directory -Force -Path $ProjectPath | Out-Null
}

$resolvedTarget = (Resolve-Path $ProjectPath).Path
$targetAgents = Join-Path $resolvedTarget ".agents"
$targetAgentsMd = Join-Path $resolvedTarget "AGENTS.md"

# 2. Xác định danh sách Skills & Rules cần cài đặt
$allAvailableSkills = (Get-ChildItem -Path (Join-Path $sourceAgents "skills") -Directory).Name
$allAvailableRules = (Get-ChildItem -Path (Join-Path $sourceAgents "rules") -File | Where-Object { $_.Extension -eq ".md" }).BaseName

$selectedSkills = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$selectedRules = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$installBaseTemplate = $false
$installLearnings = $false

$modeDescription = ""

if ($PSBoundParameters.ContainsKey('Skills') -or $PSBoundParameters.ContainsKey('Rules')) {
    $modeDescription = "Tùy chọn từng mục (Custom Selection)"
    if ($Skills) {
        foreach ($s in $Skills) {
            $cleanName = $s.Trim()
            if ($allAvailableSkills -contains $cleanName) {
                [void]$selectedSkills.Add($cleanName)
            } else {
                Write-ColorHost "  [CẢNH BÁO] Không tìm thấy skill '$cleanName' trong kho bộ cài!" Yellow
            }
        }
    }
    if ($Rules) {
        foreach ($r in $Rules) {
            $cleanName = ($r.Trim() -replace '\.md$', '')
            if ($allAvailableRules -contains $cleanName) {
                [void]$selectedRules.Add($cleanName)
            } else {
                Write-ColorHost "  [CẢNH BÁO] Không tìm thấy rule '$cleanName' trong kho bộ cài!" Yellow
            }
        }
    }
    if ($Preset -eq "base") {
        $installBaseTemplate = $true
    }
}
elseif ($Preset -eq "base") {
    $modeDescription = "Preset: 'base' (Khởi tạo AGENTS.md cơ bản tại gốc dự án)"
    $installBaseTemplate = $true
}
elseif ($Preset -eq "web") {
    $modeDescription = "Preset: 'web' (Trọn bộ cho phát triển Web Frontend / Fullstack)"
    foreach ($s in $allAvailableSkills) { [void]$selectedSkills.Add($s) }
    foreach ($r in $allAvailableRules) { [void]$selectedRules.Add($r) }
    $installLearnings = $true
}
elseif ($Preset -eq "all") {
    $modeDescription = "Preset: 'all' (Toàn bộ kho cấu hình bao gồm AGENTS.md và toàn bộ skills/rules)"
    $installBaseTemplate = $true
    foreach ($s in $allAvailableSkills) { [void]$selectedSkills.Add($s) }
    foreach ($r in $allAvailableRules) { [void]$selectedRules.Add($r) }
    $installLearnings = $true
}
else {
    # Mặc định nếu không truyền tham số: Preset web
    $modeDescription = "Preset: 'web' (Mặc định khi không chỉ định preset)"
    foreach ($s in $allAvailableSkills) { [void]$selectedSkills.Add($s) }
    foreach ($r in $allAvailableRules) { [void]$selectedRules.Add($r) }
    $installLearnings = $true
}

Write-ColorHost "Chế độ cài đặt        : $modeDescription" Gray
Write-ColorHost "Thư mục nguồn bộ cài  : $sourceAgents" Gray
Write-ColorHost "Thư mục dự án đích    : $resolvedTarget" Gray
Write-ColorHost "Cài đặt AGENTS.md     : $(if ($installBaseTemplate) { 'Có' } else { 'Không' })" Gray
Write-ColorHost "Skills đã chọn ($($selectedSkills.Count))     : $($selectedSkills -join ', ')" Gray
Write-ColorHost "Rules đã chọn ($($selectedRules.Count))      : $($selectedRules -join ', ')`n" Gray

$stats = @{
    Created = 0
    Identical = 0
    Conflict = 0
    Overwritten = 0
}
$conflictedFiles = @()

# 3. Xử lý cài đặt AGENTS.md (nếu được kích hoạt bởi preset base hoặc all)
if ($installBaseTemplate) {
    if (-not (Test-Path $templateAgentsMd)) {
        Write-ColorHost "[LỖI] Không tìm thấy file mẫu AGENTS.md tại: $templateAgentsMd" Red
    }
    else {
        if (-not (Test-Path $targetAgentsMd)) {
            Copy-Item -Path $templateAgentsMd -Destination $targetAgentsMd -Force
            Write-ColorHost "  [TẠO MỚI] AGENTS.md (tại gốc dự án)" Green
            $stats.Created++
        }
        else {
            $srcHash = (Get-FileHash -Path $templateAgentsMd -Algorithm SHA256).Hash
            $dstHash = (Get-FileHash -Path $targetAgentsMd -Algorithm SHA256).Hash

            if ($srcHash -eq $dstHash) {
                Write-ColorHost "  [BỎ QUA - GIỐNG HỆT] AGENTS.md" DarkGray
                $stats.Identical++
            }
            else {
                if ($Overwrite) {
                    Copy-Item -Path $templateAgentsMd -Destination $targetAgentsMd -Force
                    Write-ColorHost "  [GHI ĐÈ THEO YÊU CẦU] AGENTS.md" Magenta
                    $stats.Overwritten++
                }
                else {
                    Write-ColorHost "  [GIỮ NGUYÊN DỰ ÁN] AGENTS.md" Yellow
                    Write-ColorHost "     -> File AGENTS.md đã tồn tại trong dự án đích. Đã giữ nguyên file hiện có!" Yellow
                    Write-ColorHost "     -> Phần hướng dẫn nên bổ sung vào AGENTS.md hiện có (nếu chưa có):" Cyan
                    Write-ColorHost @"
--------------------------------------------------------------------------------
## Bốn Luật Nền Cốt Lõi:
1. Đọc cấu trúc & theo quy ước hiện có
2. Giữ thay đổi đúng phạm vi
3. Chạy kiểm tra phù hợp trước khi báo xong
4. Tra CATALOG.md để cài thêm đúng mục khi cần

## Hướng Dẫn Dành Cho Anti Khi Cần Thêm Cấu Hình:
- Tra cứu bảng 'Việc cần làm -> mục cần cài' trong file CATALOG.md
- Chạy lệnh setup chọn lọc:
  <Đường_dẫn_kho>\setup.ps1 -ProjectPath "." -Skills "<Tên_Skill>" -Rules "<Tên_Rule>"
--------------------------------------------------------------------------------
"@ DarkCyan
                    $stats.Conflict++
                    $conflictedFiles += "AGENTS.md"
                }
            }
        }
    }
}

# 4. Thu thập danh sách các file Skills / Rules / Learnings cần cài vào .agents/
$filesToProcess = [System.Collections.Generic.List[System.IO.FileInfo]]::new()

# Skills: Thu thập TOÀN BỘ thư mục của từng skill (kèm files phụ trong resources, scripts, references...)
foreach ($skillName in $selectedSkills) {
    $skillDir = Join-Path $sourceAgents "skills\$skillName"
    if (Test-Path $skillDir) {
        $skillFiles = Get-ChildItem -Path $skillDir -Recurse -File
        foreach ($sf in $skillFiles) {
            $filesToProcess.Add($sf)
        }
    }
}

# Rules: Thu thập các file rule được chọn
foreach ($ruleName in $selectedRules) {
    $ruleFile = Join-Path $sourceAgents "rules\$ruleName.md"
    if (Test-Path $ruleFile) {
        $filesToProcess.Add((Get-Item $ruleFile))
    }
}

# Learnings nếu có trong preset
if ($installLearnings) {
    $learningsDir = Join-Path $sourceAgents "learnings"
    if (Test-Path $learningsDir) {
        $lFiles = Get-ChildItem -Path $learningsDir -Recurse -File
        foreach ($lf in $lFiles) {
            $filesToProcess.Add($lf)
        }
    }
}

# 5. Thực hiện sao chép các file vào .agents/ của dự án đích
if ($filesToProcess.Count -gt 0) {
    if (-not (Test-Path $targetAgents)) {
        New-Item -ItemType Directory -Force -Path $targetAgents | Out-Null
    }

    foreach ($file in $filesToProcess) {
        $relPath = $file.FullName.Substring($sourceAgents.Length).TrimStart('\', '/')
        $displayPath = ".agents/" + ($relPath -replace '\\', '/')
        $destFile = Join-Path $targetAgents $relPath
        $destDir = Split-Path -Parent $destFile

        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Force -Path $destDir | Out-Null
        }

        if (-not (Test-Path $destFile)) {
            Copy-Item -Path $file.FullName -Destination $destFile -Force
            Write-ColorHost "  [TẠO MỚI] $displayPath" Green
            $stats.Created++
        }
        else {
            $srcHash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash
            $dstHash = (Get-FileHash -Path $destFile -Algorithm SHA256).Hash

            if ($srcHash -eq $dstHash) {
                Write-ColorHost "  [BỎ QUA - GIỐNG HỆT] $displayPath" DarkGray
                $stats.Identical++
            }
            else {
                if ($Overwrite) {
                    Copy-Item -Path $file.FullName -Destination $destFile -Force
                    Write-ColorHost "  [GHI ĐÈ THEO YÊU CẦU] $displayPath" Magenta
                    $stats.Overwritten++
                }
                else {
                    Write-ColorHost "  [CẢNH BÁO - KHÁC NỘI DUNG] $displayPath" Yellow
                    Write-ColorHost "     -> File đã tồn tại trong dự án nhưng nội dung khác với bộ cài! (Đã giữ nguyên file của dự án)" Yellow
                    $stats.Conflict++
                    $conflictedFiles += $displayPath
                }
            }
        }
    }
}

# 6. Kiểm tra các công cụ hệ thống dựa trên skills được cài
if ($selectedSkills.Count -gt 0) {
    Write-ColorHost "`n--- Kiểm tra công cụ môi trường cho Skills đã cài ---" Cyan

    $needGit = $selectedSkills.Contains("find-bugs") -or $selectedSkills.Contains("code-reviewer")
    $needNode = $selectedSkills.Contains("frontend-design") -or $selectedSkills.Contains("webapp-testing")
    $needNpm = $selectedSkills.Contains("webapp-testing")

    $toolsToCheck = @()
    if ($needGit) {
        $toolsToCheck += @{ Name = "Git"; Command = "git"; Reason = "Cần cho skill 'find-bugs' (git diff) và 'code-reviewer'" }
    }
    if ($needNode) {
        $toolsToCheck += @{ Name = "Node.js"; Command = "node"; Reason = "Cần cho 'webapp-testing' và 'frontend-design'" }
    }
    if ($needNpm) {
        $toolsToCheck += @{ Name = "npm / npx"; Command = "npm"; Reason = "Cần để chạy Playwright / Vitest trong 'webapp-testing'" }
    }

    $missingTools = @()
    foreach ($tool in $toolsToCheck) {
        $exists = Get-Command $tool.Command -ErrorAction SilentlyContinue
        if ($exists) {
            Write-ColorHost "  [OK] $($tool.Name) đã sẵn sàng." Green
        }
        else {
            Write-ColorHost "  [THIẾU] $($tool.Name): $($tool.Reason)" Yellow
            $missingTools += $tool.Name
        }
    }

    if ($missingTools.Count -gt 0) {
        Write-ColorHost "`n[LƯU Ý]: Phát hiện thiếu công cụ: $($missingTools -join ', ')." Yellow
        Write-ColorHost "Vui lòng xem bảng hướng dẫn cài đặt chi tiết trong file README.md." Yellow
    } elseif ($toolsToCheck.Count -gt 0) {
        Write-ColorHost "  Tất cả công cụ cần thiết cho các skills đã chọn đều sẵn sàng!" Green
    }
}

# 7. Báo cáo tổng kết
Write-ColorHost "`n=======================================================" Cyan
Write-ColorHost "                 KẾT QUẢ THIẾT LẬP                     " Cyan
Write-ColorHost "=======================================================" Cyan
Write-ColorHost "  - File tạo mới       : $($stats.Created)" Green
Write-ColorHost "  - File bỏ qua (trùng): $($stats.Identical)" DarkGray
if ($stats.Conflict -gt 0) {
    Write-ColorHost "  - File giữ nguyên do xung đột nội dung: $($stats.Conflict)" Yellow
    foreach ($cf in $conflictedFiles) {
        Write-ColorHost "      * $cf" Yellow
    }
    Write-ColorHost "  (Gợi ý: Thêm cờ -Overwrite nếu bạn muốn ghi đè các file trên theo chuẩn bộ cài)`n" Gray
}
if ($stats.Overwritten -gt 0) {
    Write-ColorHost "  - File đã ghi đè     : $($stats.Overwritten)" Magenta
}

Write-ColorHost "`nCài đặt hoàn tất cho dự án tại: $resolvedTarget`n" Green
