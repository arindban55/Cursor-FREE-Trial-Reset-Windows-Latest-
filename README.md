<#
.SYNOPSIS
    Resets the trial data for Cursor AI on Windows.

.DESCRIPTION
    This script deletes local data files and registry keys associated with the trial usage
    of Cursor AI, giving the appearance of a fresh installation.

.NOTES
    Author: arindban55
    GitHub: https://github.com/arindban55/Cursor-FREE-Trial-Reset-Windows-Latest-
    Intended for educational use only.
#>

function Remove-Folder {
    param([string]$path)
    if (Test-Path $path) {
        try {
            Remove-Item -Path $path -Recurse -Force
            Write-Host "✅ Removed: $path"
        } catch {
            Write-Warning "⚠️ Failed to remove $path: $_"
        }
    } else {
        Write-Host "ℹ️ Path not found: $path"
    }
}

function Remove-RegistryKey {
    param([string]$keyPath)
    if (Test-Path $keyPath) {
        try {
            Remove-Item -Path $keyPath -Recurse -Force
            Write-Host "✅ Removed registry key: $keyPath"
        } catch {
            Write-Warning "⚠️ Failed to remove registry key $keyPath: $_"
        }
    } else {
        Write-Host "ℹ️ Registry key not found: $keyPath"
    }
}

Write-Host "`n🧹 Resetting Cursor AI Trial..." -ForegroundColor Cyan

# Kill Cursor process if running
Get-Process -Name "Cursor" -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        Stop-Process -Id $_.Id -Force
        Write-Host "🛑 Process killed: Cursor"
    } catch {
        Write-Warning "⚠️ Could not kill Cursor process: $_"
    }
}

# Delete trial-related folders
$foldersToDelete = @(
    "$env:APPDATA\Cursor",
    "$env:LOCALAPPDATA\Cursor",
    "$env:USERPROFILE\.cursor"
)

foreach ($folder in $foldersToDelete) {
    Remove-Folder -path $folder
}

# Delete registry keys (adjust these if needed)
$registryKeys = @(
    "HKCU:\Software\Cursor",
    "HKCU:\Software\Classes\CLSID\{Cursor-App-Example}"
)

foreach ($key in $registryKeys) {
    Remove-RegistryKey -keyPath $key
}

Write-Host "`n✅ Cursor AI Trial reset complete. Restart the app to check." -ForegroundColor Green
