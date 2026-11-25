<#
.SYNOPSIS
    This PowerShell script prevents Windows Installer packages from automatically running with 
    elevated privileges, reducing the risk of unauthorized privilege escalation.

.NOTES
    Author          : Alfred Acquah
    LinkedIn        : linkedin.com/in/alfredacquah
    GitHub          : github.com/alfredacq
    Date Created    : 2026-11-25
    Last Modified   : 2026-11-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315
    Documentation   : https://stigaview.com/products/win11/v2r3/WN11-CC-000315/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN11-CC-000315).ps1 
#>

# Disable AlwaysInstallElevated

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"

# Create registry key if it does not exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set AlwaysInstallElevated to 0
New-ItemProperty -Path $RegistryPath `
    -Name "AlwaysInstallElevated" `
    -Value 0 `
    -PropertyType DWord `
    -Force | Out-Null

# Verify configuration
Get-ItemProperty -Path $RegistryPath -Name "AlwaysInstallElevated"
