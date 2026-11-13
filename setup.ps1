<#
.SYNOPSIS
    Script cài đặt bộ cấu hình Antigravity Starter vào dự án đích.

.DESCRIPTION
    Đưa các rules, skills, và templates chuẩn vào thư mục .agents/ của dự án đích.
    Giữ nguyên toàn bộ mã nguồn của dự án, bỏ qua các file giống hệt, và cảnh báo
    rõ ràng các file trùng nhưng khác nội dung để bảo vệ cấu hình hiện tại.

.PARAMETER ProjectPath
    Đường dẫn tới thư mục dự án đích (mặc định là thư mục hiện tại ".").

.PARAMETER Overwrite
    Ghi đè file nếu có xung đột nội dung (mặc định giữ nguyên file của dự án).

.EXAMPLE
    .\setup.ps1 -ProjectPath "D:\MyProjects\AwesomeApp"
    .\setup.ps1 -ProjectPath "." -Overwrite
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$ProjectPath = ".",

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

# 1. Xác định đường dẫn nguồn và đích
$sourceRoot = $PSScriptRoot
$sourceAgents = Join-Path $sourceRoot ".agents"

if (-not (Test-Path $sourceAgents)) {
    Write-ColorHost "[LỖI] Không tìm thấy thư mục nguồn .agents tại: $sourceAgents" Red
    exit 1
}

# Resolve target directory
if (-not (Test-Path $ProjectPath)) {
    Write-ColorHost "[THÔNG BÁO] Thư mục dự án đích chưa tồn tại, đang tạo: $ProjectPath" Yellow
    New-Item -ItemType Directory -Force -Path $ProjectPath | Out-Null
}

$resolvedTarget = (Resolve-Path $ProjectPath).Path
$targetAgents = Join-Path $resolvedTarget ".agents"

Write-ColorHost "Thư mục nguồn bộ cài : $sourceAgents" Gray
Write-ColorHost "Thư mục dự án đích   : $resolvedTarget" Gray
Write-ColorHost "Thư mục đích .agents : $targetAgents`n" Gray

if (-not (Test-Path $targetAgents)) {
    New-Item -ItemType Directory -Force -Path $targetAgents | Out-Null
}

# 2. Duyệt qua tất cả các file nguồn và đồng bộ hóa
$sourceFiles = Get-ChildItem -Path $sourceAgents -Recurse -File
$stats = @{
    Created = 0
    Identical = 0
    Conflict = 0
    Overwritten = 0
}
$conflictedFiles = @()

foreach ($file in $sourceFiles) {
    # Tính đường dẫn tương đối từ .agents
    $relativeSubPath = $file.FullName.Substring($sourceAgents.Length).TrimStart('\', '/')
    $displaySubPath = ".agents/" + ($relativeSubPath -replace '\\', '/')
    $destFile = Join-Path $targetAgents $relativeSubPath
    $destDir = Split-Path -Parent $destFile

    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    }

    if (-not (Test-Path $destFile)) {
        # File chưa tồn tại -> Cài mới
        Copy-Item -Path $file.FullName -Destination $destFile -Force
        Write-ColorHost "  [TẠO MỚI] $displaySubPath" Green
        $stats.Created++
    }
    else {
        # File đã tồn tại -> Kiểm tra hash SHA256
        $srcHash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash
        $dstHash = (Get-FileHash -Path $destFile -Algorithm SHA256).Hash

        if ($srcHash -eq $dstHash) {
            # File giống hệt nhau -> Bỏ qua
            Write-ColorHost "  [BỎ QUA - GIỐNG HỆT] $displaySubPath" DarkGray
            $stats.Identical++
        }
        else {
            # File trùng nhưng khác nội dung -> Cảnh báo xung đột
            if ($Overwrite) {
                Copy-Item -Path $file.FullName -Destination $destFile -Force
                Write-ColorHost "  [GHI ĐÈ THEO YÊU CẦU] $displaySubPath" Magenta
                $stats.Overwritten++
            }
            else {
                Write-ColorHost "  [CẢNH BÁO - KHÁC NỘI DUNG] $displaySubPath" Yellow
                Write-ColorHost "     -> Đã tồn tại trong dự án với nội dung khác. Giữ nguyên để tránh mất cấu hình!" Yellow
                $stats.Conflict++
                $conflictedFiles += $displaySubPath
            }
        }
    }
}

# 3. Kiểm tra các công cụ hệ thống hỗ trợ skills
Write-ColorHost "`n--- Kiểm tra công cụ môi trường cho Skills ---" Cyan

$toolsToCheck = @(
    @{ Name = "Git"; Command = "git"; Reason = "Cần cho skills 'find-bugs', 'code-reviewer'" },
    @{ Name = "Node.js"; Command = "node"; Reason = "Cần cho skills 'webapp-testing', 'frontend-design'" },
    @{ Name = "npm / npx"; Command = "npm"; Reason = "Cần cho chạy Playwright, Vitest trong 'webapp-testing'" }
)

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
    Write-ColorHost "Vui lòng xem hướng dẫn cài đặt chi tiết trong file README.md." Yellow
}

# 4. Báo cáo tổng kết
Write-ColorHost "`n=======================================================" Cyan
Write-ColorHost "                 KẾT QUẢ THIẾT LẬP                     " Cyan
Write-ColorHost "=======================================================" Cyan
Write-ColorHost "  - File tạo mới       : $($stats.Created)" Green
Write-ColorHost "  - File bỏ qua (trùng): $($stats.Identical)" DarkGray
if ($stats.Conflict -gt 0) {
    Write-ColorHost "  - File xung đột nội dung (đã giữ nguyên): $($stats.Conflict)" Yellow
    foreach ($cf in $conflictedFiles) {
        Write-ColorHost "      * $cf" Yellow
    }
    Write-ColorHost "  (Gợi ý: Thêm tham số -Overwrite nếu bạn muốn ghi đè các file trên)`n" Gray
}
if ($stats.Overwritten -gt 0) {
    Write-ColorHost "  - File đã ghi đè     : $($stats.Overwritten)" Magenta
}

Write-ColorHost "`nThiết lập hoàn tất cho dự án tại: $resolvedTarget`n" Green
