Create a Desktop Shortcut:
Follow these simple steps:

Right-click your Desktop → New → Shortcut

Paste this path:
```powershell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\Programming\RDP Login\rdp-login.ps1"
```
Replace with your actual script location

Click Next → Name it (e.g., "RDP Login") → Finish

Right-click the shortcut → Properties

Click Advanced → ✅ Check "Run as administrator" → OK

Optional: Add an icon

Click Change Icon in Properties

Use: C:\Windows\System32\mstsc.exe

Click OK

Done! Double-click to launch with automatic login.
