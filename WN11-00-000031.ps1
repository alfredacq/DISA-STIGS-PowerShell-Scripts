<#
.SYNOPSIS
    Automates BitLocker registry configurations to enforce TPM-based startup authentication
    and strengthen protection against unauthorized access to encrypted data.

.NOTES
    Author          : Alfred Acquah
    LinkedIn        : linkedin.com/in/alfredacquah
    GitHub          : github.com/alfredacq
    Date Created    : 2026-11-23
    Last Modified   : 2026-11-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000031
    Documentation   : https://stigaview.com/products/win11/v2r2/WN11-00-000031/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN11-00-000031).ps1 
#>

# Configure BitLocker Advanced Startup and TPM Authentication

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"

# Create registry key if it does not exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure required DWORD values
$Settings = @{
    "UseAdvancedStartup" = 1
    "UseTPMPIN"          = 1
    "UseTPMKeyPIN"       = 1
}

foreach ($Setting in $Settings.GetEnumerator()) {
    New-ItemProperty -Path $RegistryPath `
        -Name $Setting.Key `
        -Value $Setting.Value `
        -PropertyType DWord `
        -Force | Out-Null
}

# Verify configuration
Get-ItemProperty -Path $RegistryPath |
    Select-Object UseAdvancedStartup, UseTPMPIN, UseTPMKeyPIN

Write-Host "BitLocker registry settings configured successfully." -ForegroundColor Green
