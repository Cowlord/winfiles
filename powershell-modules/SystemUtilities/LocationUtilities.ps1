#!/usr/bin/env pwsh.exe
#Requires -Version 5
Set-StrictMode -Version 2.0

function Get-SpecialFolder {
    param(
        [System.Environment+SpecialFolder]$Alias
    )

    [Environment]::GetFolderPath([System.Environment+SpecialFolder]$Alias)
}

# On Windows, I set a "profile" directory which is usually at one of the drive
# roots.  If a multi-disk system this is usually D:\Profile but for a single
# disk system it would be C:\Profile.  I then put most of the standard folders
# here that comprise my "home".  Due to issues with windows you can't simply
# move the entire C:\User\<username> folder someplace else so my profile serves
# the same purpose but the $HOME and $USERPROFILE are still the User directory.
function Set-ProfileLocation {
    [CmdletBinding(DefaultParameterSetName = "Path")]
    param(
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]
        $Path,
        [switch]$Force = $false
    )

    if ($Force -or [string]::IsNullOrEmpty($env:PROFILEPATH)) {
        [Environment]::SetEnvironmentVariable("PROFILEPATH", $Path, "User")
        $env:PROFILEPATH = $Path
    }
}

function Set-LocationToSpecialFolder {
    param(
        [System.Environment+SpecialFolder]$Alias,
        [string]$Subfolder = ""
    )

    $specialFolder = Get-SpecialFolder $Alias
    if (Test-Path $specialFolder) {
        Set-ToFolderInternal -RootPath $specialFolder -Subfolder $Subfolder
    }
    else {
        Write-Warning "The Special folder does not exist or is not configured."
    }
}

function Set-LocationToProfileFolder {
    param(
        [string]$Subfolder = ""
    )

    if ([string]::IsNullOrEmpty($env:PROFILEPATH) -or (-not (Test-Path $env:PROFILEPATH))) {
        Write-Warning "The Profile location has not been set or does not exist.  Set it first and try again."
    }
    else {
        Set-ToFolderInternal -RootPath $env:PROFILEPATH -Subfolder $Subfolder
    }
}

function Set-ToFolderInternal {
    param(
        [ValidateScript( { Test-Path $_ -PathType "Container" })]
        [string]$RootPath,
        [string]$Subfolder = ""
    )

    if ([string]::IsNullOrEmpty($Subfolder)) {
        Set-Location $RootPath
    }
    else {
        $path = Join-Path -Path $RootPath -ChildPath $Subfolder
        do {
            if ((-not ([string]::IsNullOrEmpty($path))) -and (Test-Path $path)) {
                Set-Location $path
                return
            }
            $path = Split-Path $path -Parent
        } while (-not ([string]::IsNullOrEmpty($path)))

        # Failsafe
        Set-Location $RootPath
    }
}

function Set-LocationToNewDir {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Path
    )

    $pwd = Get-Location
    $newPath = Join-Path "$pwd" "$Path"
    New-Item -Path $newPath -ItemType Directory -ErrorAction SilentlyContinue

    if (-not (Test-Path $newPath)) {
        Write-Error "Unable to create path $newPath"
    }

    Set-Location $newPath
}

function New-DateDir {
    $date = Get-Date -format "yyyy-MM-dd"
    $pwd = Get-Location
    $newPath = Join-Path "$pwd" "$date"
    New-Item -Path $newPath -ItemType Directory -ErrorAction SilentlyContinue
}

function New-DateFile {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Extension = "md",
        [string]
        $Prefix = ""
    )

    $date = Get-Date -format "yyyy-MM-dd"
    $file = "$Prefix$date.$Extension"
    $pwd = Get-Location
    $newPath = Join-Path "$pwd" "$file"
    New-Item -Path $newPath -ItemType File -ErrorAction SilentlyContinue
}

# Special folder locations

function Set-LocationToParent {
    Set-Location ".."
}

function Set-LocationToDesktop {
    Set-LocationToSpecialFolder "DesktopDirectory"
}

function Set-LocationToMusic {
    Set-LocationToSpecialFolder "MyMusic"
}

function Set-LocationToVideos {
    Set-LocationToSpecialFolder "MyVideos"
}

function Set-LocationToMyDocuments {
    Set-LocationToSpecialFolder "MyDocuments"
}

function Set-LocationToPictures {
    Set-LocationToSpecialFolder "MyPictures"
}

function Set-LocationToUserProfile {
    Set-LocationToSpecialFolder "UserProfile"
}

Set-Alias Set-LocationToHome Set-LocationToUserProfile
