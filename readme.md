# Winfiles

My ['dotfiles'](https://dotfiles.github.io) and configuration scripts for Windows

## Purpose

### A 'mostly' Automated Windows Setup

Unlike better operating systems (ahem... Linux), Windows can't fully be configured automatically.  Well, simple installations might be able to but full desktop configurations with disparate applications and settings is nearly impossible to achieve.

This is my attempt at making the setup of my machines as quick and "automatic" as possible.  There are still a number of manual steps I have to take and even the "automatic" process is a multi-step affair.  But, I can usually get a brand new Windows installation up and running fairly quickly and **consistently** with this setup.

### Not just installation but config as well

This repository also contains my personal settings and configurations much in the same way that `dotfiles` are used on Linux.  In fact, a sub-module of this repository is in fact my Linux\Mac `dotfiles` so that I can share some files between all systems.

During installation, the scripts will prompt for what "system type" the installation is for.  I offer two options, "Home" and "Work", which should largely be self explanatory.  The primary difference between the two types are the mix of applications installed and which settings are being used.

## Installation Overview

Full installation steps, including the manual portions can be found in [Installation Steps](installation-steps.md).

In summary, the broad steps (particularly the automated parts) are as follows:

1. Install Windows & Run Updates
2. Open PowerShell as an Administrator
    * Run: `Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
    * Or: `iex ((iwr -UseBasicParsing -Uri 'https://git.io/fjBQX').Content)`
3. Once complete run: `.\01-setup-profile.ps1'
4. Once complete, close PowerShell and re-open as Administrator.
5. Run: `.\02-bootstrap.ps1`, this will take a while
6. Reboot.  Re-open PowerShell as Administrator
7. Run: `.\03-app-installs.ps1`, this will take a **LONG** time
8. Reboot (again).  Re-open PowerShell as Administrator
9. Run: `.\04-cleanup.ps1`

At that point the automated portions are complete.  For more details and further (manual) instructions, see [Installation Steps](installation-steps.md).

### Option Without Running Web Script

The initial script run in Step 2 above will initialize Git and clone this repository.  If instead it is preferred to do that manually, you can.  Afterward, you can start at Step 3 above from within the folder for this repository.

## Applications

I install as many applications as I can automatically using two different install managers.  [AppGet](https://appget.net/) and [Scoop](https://scoop.sh/).

### AppGet

AppGet is generally the first source to install an application.  If both Scoop and AppGet offer the same application, AppGet is used (with a few minor exceptions).  It manages updates to applications well and can even works well with applications that self-update (such as Google Chrome or Firefox).  That last feature was a major reason for me switching away from [Chocolatey](https://chocolatey.org/).

### Scoop

Scoop is best for managing command-line applications or tools where multiple versions may be needed (such as programming languages like Python, Ruby, Java).  While the focus is on command-line tools, when AppGet doesn't offer an application Scoop will still be used.

## License

[MIT](license) © 2020 [Brennan Fee](https://github.com/brennanfee)
