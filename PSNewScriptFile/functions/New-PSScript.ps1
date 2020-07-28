function New-PSScript {
    <#
    .SYNOPSIS
        Function for creating script files

    .DESCRIPTION
        This helper function will create a fully documented script file with documented parameterss and help

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
        $Example,

        [string]
        $Notes,

        [ValidateRange(1, 20)]
        [Int32]
        $NumberOfParameters = 1,

        [switch]
        $Alias,

        [switch]
        $AllowNull,

        [switch]
        $AllowEmptyString,

        [switch]
        $AllowEmptyCollection,

        [switch]
        $HelpMessage,

        [switch]
        $Mandatory,

        [switch]
        $Position,

        [switch]
        $ParameterSetName,

        [switch]
        $ValueFromPipeline,

        [switch]
        $ValueFromPipelineByPropertyName,

        [switch]
        $ValueFromRemainingArguments,

        [switch]
        $ValidateNotNull,

        [switch]
        $ValidateNotNullOrEmpty,

        [switch]
        $ValidateCount,

        [switch]
        $ValidateLength,

        [switch]
        $ValidatePattern,

        [switch]
        $ValidateRange,

        [switch]
        $ValidateSet,

        [switch]
        $ValidateScript,

        [switch]
        $EnableException
    )

    begin {
        $scriptParameters = $PSBoundParameters | ConvertTo-PSFHashtable -Include FilePath, ScriptName, Synopsis, Description, Notes, `
            NumberOfParameters, Mandatory, Position, Alias, ValueFromPipeline, ValueFromPipelineByPropertyName, ValueFromRemainingArguments, HelpMessage, `
            AllowNull, AllowEmptyString, AllowEmptyCollection, ParameterSetName, ValidateNotNull, ValidateNotNullOrEmpty, `
            ValidateCount, ValidateLength, ValidatePattern, ValidateRange, ValidateSet, ValidateScript, -EnableException
    }
    process {

        Write-PSFMessage -Level Host -String 'New-PSScriptFile.CheckingForExistingScript'
        Write-PSFMessage -Level Host -String 'New-PSScriptFile.StartScript'
        Initialize-NewScript @scriptParameters
    }
    end { Write-PSFMessage -Level Host -String 'New-PSScriptFile.EndScript' }
}