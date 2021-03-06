@{
    ModuleVersion     = '1.0.0'

    GUID              = '5772a6c5-ef4a-4423-975a-5c04f1e92768'

    Author            = 'Brennan Fee'

    Copyright         = '(c) 2019 Brennan Fee. All rights reserved.'

    Description       = 'My custom profile settings and utilities for my profile.'

    PowerShellVersion = '5.0'

    RequiredModules = @(
        @{
            ModuleName="Pscx";
            ModuleVersion="3.3.0";
            Guid="0fab0d39-2f29-4e79-ab9a-fd750c66e6c5"
        },
        @{
            ModuleName="SystemUtilities";
            ModuleVersion="1.0.0";
            Guid="1e581f7d-584d-40bf-b0f3-3d1ee63164f8"
        }
    )

    NestedModules = @(
        'Aliases.ps1',
        'CustomPrompt.ps1',
        'Set-DefaultEditor.ps1',
        'Set-MyCustomProfileLocation.ps1',
        'Navigation.ps1',
        'GitAliases.ps1'
    )

    CmdletsToExport = ''

    FunctionsToExport = @(
        'Get-CustomPrompt',
        'Set-DefaultEditor',
        'Set-HomeEnvironmentVariable',
        'Set-MyCustomProfileLocation',
        'Get-Listing*',
        'Set-LocationTo*',
        'Search-Listing*'
    )

    VariablesToExport = ''

    AliasesToExport = '*'
}
