# install.ps1 - Windows Dotfiles Deployment Script
# 🚀 Deployment script for WezTerm, Komorebi, AutoHotkey, and YASB

$ErrorActionPreference = "Stop"

function Write-Info($Message) {
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Success($Message) {
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-ErrorMsg($Message) {
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# --- 1. Check for Package Managers ---
Write-Info "Checking for Scoop..."
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Info "Scoop not found. Installing Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Write-Success "Scoop installed."
}

# --- 2. Install Requirements ---
Write-Info "Adding Scoop buckets..."
scoop bucket add extras
scoop bucket add nerd-fonts

$Apps = @(
    "wezterm",
    "komorebi",
    "autohotkey",
    "python" # Requirement for YASB
)

foreach ($App in $Apps) {
    Write-Info "Checking if $App is installed..."
    if (-not (Get-Command $App -ErrorAction SilentlyContinue)) {
        Write-Info "Installing $App..."
        scoop install $App
    } else {
        Write-Success "$App is already installed."
    }
}

# Install YASB (using pip as it's the common way)
Write-Info "Checking for YASB..."
if (-not (Get-Command yasb -ErrorAction SilentlyContinue)) {
    Write-Info "Installing YASB via pip..."
    pip install yasb
    Write-Success "YASB installed."
}

# --- 3. Setup Configuration (Symlinks) ---
$DotfilesRoot = Get-Item $PSScriptRoot\..
$HomeDir = [System.Environment]::GetFolderPath("UserProfile")
$ConfigDir = Join-Path $HomeDir ".config"

if (-not (Test-Path $ConfigDir)) {
    New-Item -Path $ConfigDir -ItemType Directory
}

# Helper for symlinking
function New-ConfigSymLink($Source, $Target) {
    if (Test-Path $Target) {
        Write-Info "Backing up existing config: $Target"
        $BackupPath = "$Target.bak"
        if (Test-Path $BackupPath) { Remove-Item $BackupPath -Recurse -Force }
        Move-Item $Target $BackupPath
    }
    Write-Info "Linking $Source -> $Target"
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source
}

# Link WezTerm
New-ConfigSymLink -Source "$DotfilesRoot\config\wezterm\.wezterm.lua" -Target "$HomeDir\.wezterm.lua"

# Link Komorebi
New-ConfigSymLink -Source "$DotfilesRoot\config\komorebi" -Target "$ConfigDir\komorebi"

# Link YASB
New-ConfigSymLink -Source "$DotfilesRoot\config\yasb" -Target "$ConfigDir\yasb"

# --- 4. Post-Installation Setup ---
Write-Info "Configuring Komorebi static configuration..."
komorebic start

Write-Info "Starting AutoHotkey script for Komorebi..."
Start-Process -FilePath "autohotkey.exe" -ArgumentList "$ConfigDir\komorebi\komorebi.ahk"

Write-Info "Starting YASB..."
yasb

Write-Success "Deployment complete! Enjoy your new Windows workflow."
