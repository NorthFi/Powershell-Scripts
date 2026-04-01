# Variables
$rdpserver = "vm-srv01.local"
$rdpsec = "superSecurePassword"

# Run mstsc with target
Start-Process "mstsc.exe" "/v:$rdpserver"

# Wait up to 10 seconds for the Windows Security window
$timeout = (Get-Date).AddSeconds(10)
$found = $false

while ((Get-Date) -lt $timeout) {
    $win = Get-Process | Where-Object { $_.MainWindowTitle -like "*Windows Security*" }
    if ($win) {
        $found = $true
        break
    }
    Start-Sleep -Milliseconds 500
}

if (-not $found) {
    [System.Windows.Forms.MessageBox]::Show("Failed to find Remote Desktop Connection")
    exit
}

# Send keystrokes (requires Windows Forms)
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait($rdpsec)
Start-Sleep -Milliseconds 100
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Wait for the RDP session window
$timeout = (Get-Date).AddSeconds(10)
$found = $false
while ((Get-Date) -lt $timeout) {
    $win = Get-Process | Where-Object { $_.MainWindowTitle -like "*$rdpserver*" }
    if ($win) {
        $found = $true
        break
    }
    Start-Sleep -Milliseconds 500
}

if (-not $found) {
    [System.Windows.Forms.MessageBox]::Show("Failed to find active session")
    exit
}

Start-Sleep -Milliseconds 1500
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
exit
