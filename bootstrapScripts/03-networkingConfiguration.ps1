#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

Write-Host "Check PSRemoting"
$r = Test-WSMan -Authentication default -ErrorAction SilentlyContinue
$enabled = if ($r) { $true } else { $false }

if (-not $enabled) {
    Write-Host "Setting network profiles to private"
    # Turn all network connections to "Private"
    Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

    Write-Host "Enabling PSRemoting"

    $command = "$PSScriptRoot\..\shared\ConfigureRemotingForAnsible.ps1 " +
    "-CertValidityDays 3650 -ForceNewSSLCert -Verbose"

    Invoke-Expression $command
}
else {
    Write-Host "PSRemoting already enabled"
}

Write-Host "Enabling Remote Desktop"
Enable-RemoteDesktop
