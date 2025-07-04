# setup.ps1
# Windows 10/11 Setup Script for IT Help Desk Environments
# Run as Administrator

# -------------------------
# 1. Install Chocolatey
# -------------------------
Write-Host "Installing Chocolatey..." -ForegroundColor Cyan
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# -------------------------
# 2. Install Essential Software
# -------------------------
$apps = @(
    "googlechrome",
    "notepadplusplus",
    "7zip",
    "putty",
    "vlc",
    "git",
    "powertoys",
    "anydesk"
)

foreach ($app in $apps) {
    choco install $app -y
}

# -------------------------
# 3. Enable Useful Windows Features
# -------------------------
Write-Host "Enabling Windows Features..." -ForegroundColor Cyan
Enable-WindowsOptionalFeature -Online -FeatureName "TelnetClient" -All -NoRestart

# -------------------------
# 4. Set Common System Settings
# -------------------------
Write-Host "Configuring system settings..." -ForegroundColor Cyan
# Show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
# Show hidden files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1

# -------------------------
# 5. Clean up
# -------------------------
Write-Host "Cleaning up..." -ForegroundColor Cyan
choco upgrade all -y
Write-Host "Setup complete! Please restart your computer." -ForegroundColor Green
