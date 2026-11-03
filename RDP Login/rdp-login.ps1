# root/RDP Login/rdp-login.ps1
# Launch RDP without sending credentials to whichever window has focus.
# Windows Credential Manager / domain SSO handles authentication.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ComputerName,

    [ValidateRange(1, 65535)]
    [int]$Port = 3389
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# mstsc accepts host:port for non-default ports; IPv6 literals require brackets.
if ($ComputerName -match '[\r\n"]') {
    throw 'ComputerName contains unsupported characters.'
}
if ($ComputerName -match ':') {
    if ($ComputerName -notmatch '^\[.*\]$') {
        throw 'IPv6 addresses must be enclosed in brackets.'
    }
}
$target = if ($Port -eq 3389) { $ComputerName } else { "${ComputerName}:$Port" }

try {
    Start-Process -FilePath "$env:SystemRoot\System32\mstsc.exe" -ArgumentList "/v:$target" -ErrorAction Stop
}
catch {
    Write-Error "Unable to launch Remote Desktop Connection: $_"
    exit 1
}
