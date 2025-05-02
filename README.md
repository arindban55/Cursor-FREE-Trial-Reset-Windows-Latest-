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
Navigate to the folder:

powershell
cd "C:\Path\To\Script"
Run the script:

powershell
.\Reset-CursorTrial.ps1
Restart your PC and clear browser cache before using Cursor again.

📝 Notes
Original MachineGuid is backed up automatically to your home directory.

MAC spoofing may not work on all adapters (can be disabled).
