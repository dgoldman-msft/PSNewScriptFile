function New-PSScript {
    <#
    .SYNOPSIS
        Module for creating script files

    .DESCRIPTION
        This helper module will create a fully documented script file with documented parameterss and help

    .EXAMPLE
        C:\> New-PSScript -ScriptName New-Script -NumberOfParameters 10 -Notes "New test script" -Synopsis "Script synopsis" -Description "New script description"

    .NOTES
        General notes
    #>

    [CmdletBinding()]
    param(
        [ValidateNotNull()]
        [parameter(Mandatory = $True, Position = 0)]
        [string]
        $ScriptName,

        [parameter(HelpMessage = "Override value of users save location, otherwise use the stored configuration setting.")]
        [string]
        $FilePath,

        [string]
        $Synopsis,

        [string]
        $Description,

        [string]
        $Notes,

        [ValidateRange(1, 20)]
        [Int32]
        $NumberOfParameters = 1,

        [bool]
        $EnableException
    )

    begin {
        $scriptParameters = $PSBoundParameters | ConvertTo-PSFHashtable -Include FilePath, ScriptName, Synopsis, Description, Notes, NumberOfParameters, EnableException
    }
    process {
        Write-PSFMessage -Level Host -String 'New-PSScriptFile.StartScript'
        Initialize-NewScript @scriptParameters
    }
    end { Write-PSFMessage -Level Host -String 'New-PSScriptFile.EndScript' }
}