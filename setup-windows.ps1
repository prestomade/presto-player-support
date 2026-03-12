#Requires -RunAsAdministrator

Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Presto Player Support Assistant Setup" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ReposDir = Join-Path $ScriptDir ".repos"

# --- Check/Install Node.js ---
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Host "[1/5] Installing Node.js..." -ForegroundColor Yellow
    winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
} else {
    Write-Host "[1/5] Node.js already installed ($(node -v)). ✓" -ForegroundColor Green
}

# --- Check/Install GitHub CLI ---
if (-not (Get-Command "gh" -ErrorAction SilentlyContinue)) {
    Write-Host "[2/5] Installing GitHub CLI..." -ForegroundColor Yellow
    winget install GitHub.cli --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
} else {
    Write-Host "[2/5] GitHub CLI already installed. ✓" -ForegroundColor Green
}

# --- Authenticate GitHub ---
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[3/5] Authenticating with GitHub..." -ForegroundColor Yellow
    gh auth login --web --git-protocol https
} else {
    Write-Host "[3/5] GitHub authenticated. ✓" -ForegroundColor Green
}

# --- Install Claude Code CLI ---
if (-not (Get-Command "claude" -ErrorAction SilentlyContinue)) {
    Write-Host "[4/5] Installing Claude Code CLI..." -ForegroundColor Yellow
    npm install -g @anthropic-ai/claude-code
} else {
    Write-Host "[4/5] Claude Code CLI already installed. ✓" -ForegroundColor Green
}

# --- Clone repositories ---
Write-Host "[5/5] Cloning Presto Player repository..." -ForegroundColor Yellow

if (-not (Test-Path $ReposDir)) {
    New-Item -ItemType Directory -Path $ReposDir | Out-Null
}

$TargetDir = Join-Path $ReposDir "presto-player"
if (Test-Path $TargetDir) {
    Write-Host "       presto-player already cloned. ✓" -ForegroundColor Green
} else {
    Write-Host "       Cloning presto-player..."
    gh repo clone prestomade/presto-player $TargetDir -- --depth 1
}

$WikiDir = Join-Path $ReposDir "presto-player-support.wiki"
if (-not (Test-Path $WikiDir)) {
    Write-Host "       Cloning wiki..."
    git clone --depth 1 "https://github.com/prestomade/presto-player-support.wiki.git" $WikiDir 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "       Wiki not found (will use local wiki/ folder). ✓" -ForegroundColor Yellow
    }
}

# --- Create desktop shortcut ---
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "Presto Player Support.lnk"
$LaunchScript = Join-Path $ScriptDir "launch-windows.bat"

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $LaunchScript
$Shortcut.WorkingDirectory = $ScriptDir
$Shortcut.Description = "Launch Presto Player Support Assistant"
$Shortcut.Save()

Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start: Double-click 'Presto Player Support' on your Desktop"
Write-Host "Or run: .\launch-windows.bat"
Write-Host ""
