#!/usr/bin/env pwsh.exe
#Requires -Version 5
#Requires -RunAsAdministrator
Set-StrictMode -Version 2.0

########  Path Environment Variables
Write-Host "Updating Paths"

if (Test-Path "$env:APPDATA\Python\Python37\Scripts") {
    Add-ToPath "$env:APPDATA\Python\Python37\Scripts"
}
if (Test-Path "$env:APPDATA\Python\Python38\Scripts") {
    Add-ToPath "$env:APPDATA\Python\Python38\Scripts"
}

if (Test-Path "$env:PROFILEPATH\cloud\win-bin") {
    Add-ToPath "$env:PROFILEPATH\cloud\win-bin"
}

######## Windows Terminal
Write-Host "Linking Windows Terminal Settings"
Invoke-Expression "$PSScriptRoot\..\shared\symlink-terminal-settings.ps1"
