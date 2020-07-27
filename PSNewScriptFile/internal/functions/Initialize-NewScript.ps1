function Initialize-NewScript {
    <#
    .SYNOPSIS
        Function for generating a script files

    .DESCRIPTION
        This helper function will generate the script context and build the .ps1 file

    .NOTES
        This is where all the magic happens
    #>

    [CmdletBinding()]
    param(
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
        $ParameterSet,

        [switch]
        $ValueFromPipeline,

        [switch]
        $ValueFromPipelineByPropertyName,

        [switch]
        $ValueFromRemainingArguements,

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

        [bool]
        $EnableException
    )

    begin {
        $index = 0
        $validationParameters = $PSBoundParameters
        $propertiesToRemove = @(
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ScriptName"),
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.FilePath"),
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.Synopsis"),
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.Description"),
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.Notes"),
            (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.NumberOfParameters")
        )

        foreach ($removeProp in $propertiesToRemove) { [void]$validationParameters.Remove("$removeProp") }
    }
    process {
        [System.Collections.ArrayList]$finalScriptFile = @()
        Write-PSFMessage -String 'Initialize-NewScript.CreatingScript' -StringValues $ScriptName
        # Check save file path and create it if the directory is not found
        try {
            #region_Notes
            $finalScriptFile += "function $ScriptName {`n`t<#"

            $finalScriptFile += "`t.SYNOPSIS"
            if (-NOT $Synopsis) { $finalScriptFile += "`t`tThis is a general synopsis." }
            else { $finalScriptFile += "`t`t$Synopsis" }

            $finalScriptFile += "`n`t.DESCRIPTION"
            if (-NOT $Description) { $finalScriptFile += ("`t`tPlease add your description here.") }
            else { $finalScriptFile += "`t`t$Description" }

            while ($index -lt $NumberOfParameters) {
                $index ++
                $finalScriptFile += "`n`t.PARAMETER"
                $finalScriptFile += "`t`t`$parameter$index"
            }

            $finalScriptFile += ("`n`t.EXAMPLE")
            if (-NOT $Example) {
                if ($NumberOfParameters -eq 1) { $finalScriptFile += "`t`tC:\> $ScriptName.ps1 -Parameter Arguement" }
                elseif ($NumberOfParameters -gt 1) {
                    $index = 0
                    while ($index -lt $NumberOfParameters) {
                        $index ++
                        $tempString += "-Parameter Arguement "
                    }
                    $finalScriptFile += "`t`tC:\>$ScriptName.ps1 $tempString"
                }
            }
            else { $finalScriptFile += "`t`t$Example" }

            $finalScriptFile += "`n`t.NOTES"
            if (-NOT $Notes) { $finalScriptFile += "`t`tPlease add your notes here." }
            else { $finalScriptFile += "`t`t$Notes" }
            $finalScriptFile += "`t#>"
            #endregion_Notes

            #region_paramaters
            $finalScriptFile += "`n`t[CmdletBinding()]`n`tparam("

            #region_Construct_Parameters_Output
            $index = 0  # Reset counter
            if ($NumberOfParameters -eq 1) {
                if ($validationParameters.Count -gt 0) {
                    foreach ($item in $validationParameters.Keys) { $finalScriptFile += Add-ParametersToScriptfile -Parameter $item }
                }
                $finalScriptFile += "`t[ObjectType]"
                $finalScriptFile += "`t`$parameter$index"
                $finalScriptFile += "`t)"
            }
            elseif ($NumberOfParameters -gt 1) {
                $index = 0
                while ($index -lt $NumberOfParameters) {
                    $index ++
                    if ($validationParameters.Count -gt 0) {

                        $finalScriptFile += Add-ParametersToScriptfile -ParameterList $validationParameters
                        $finalScriptFile += "`t[ObjectType]"
                        if ($index -ne $NumberOfParameters) { $finalScriptFile += "`t`$parameter$index,`n" }
                        else { $finalScriptFile += "`t`$parameter$index`n" }
                    }
                }
            }
            #endregion_Construct_Parameters_Output

            $finalScriptFile += "`t)"
            $finalScriptFile += "`n`tbegin{}`n`tprocess{}`n`tend{}"
            $finalScriptFile += "`n}"
            #endregion_paramaters

            Save-PSScriptFile -Filepath $FilePath -ScriptName $ScriptName -ScriptFileContents $finalScriptFile $EnableException
        }
        catch {
            Stop-PSFFunction -String 'Initialize-NewScript.Failure' -EnableException $EnableException -ErrorRecord $_
        }
    }
    end {}
}