
# Run as Administrator

# === CONFIG ===
$enableMacSpoof = $true  # Set to $false if you don't want MAC address spoofing
$newGuid = [guid]::NewGuid().ToString()

Write-Host "Resetting Cursor AI trial..." -ForegroundColor Cyan

# === 1. Delete AppData config ===
$paths = @(
    "$env:APPDATA\Cursor",
    "$env:LOCALAPPDATA\Cursor",
    "$env:APPDATA\Code"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Remove-Item $path -Recurse -Force
        Write-Host "Deleted: $path"
    }
}

# === 2. Backup and Reset Machine GUID ===
$regPath = "HKLM:\SOFTWARE\Microsoft\Cryptography"
$backupGuidPath = "$env:USERPROFILE\machine_guid_backup.txt"

$currentGuid = Get-ItemProperty -Path $regPath -Name "MachineGuid" | Select-Object -ExpandProperty MachineGuid
$currentGuid | Out-File -FilePath $backupGuidPath -Encoding ASCII

Set-ItemProperty -Path $regPath -Name "MachineGuid" -Value $newGuid
Write-Host "Backed up old MachineGuid to: $backupGuidPath"
Write-Host "Set new MachineGuid: $newGuid"

# === 3. Spoof MAC Address ===
if ($enableMacSpoof) {
    $mac = ((0..5) | ForEach-Object { '{0:X2}' -f (Get-Random -Minimum 0 -Maximum 256) }) -join ''
    Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
        Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword "NetworkAddress" -RegistryValue $mac
        Write-Host "Spoofed MAC Address on adapter: $($_.Name) to $mac"
    }
}

# === 4. Prompt to Clear Browser Data ===
Write-Host "`n🧼 Don't forget to clear browser cache for cursor.so before logging in again." -ForegroundColor Yellow

# === 5. Suggest Restart ===
Write-Host "`n✅ Done. Please RESTART your computer before launching Cursor again." -ForegroundColor Green
