# Cursor AI Trial Reset Script (Windows)

This PowerShell script resets the free trial of [Cursor AI](https://cursor.so) by:
- Clearing local app data
- Randomizing the MachineGuid
- (Optionally) Spoofing MAC addresses (can be turned off)

## ⚠️ Disclaimer
This script is for educational purposes only. Do not use it to violate the terms of service of any software.

## 💻 Usage

1. Download the script.
2. Run PowerShell as Administrator.
3. Allow scripts to run:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
