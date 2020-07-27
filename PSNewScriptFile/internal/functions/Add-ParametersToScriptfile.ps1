function Add-ParametersToScriptfile {
    <#
    .SYNOPSIS
        Function for adding parameters to the default script file

    .DESCRIPTION
        This helper functionn will calculate all of the necessary properties and add them to the script file template

    .NOTES
        None
    #>

    [CmdletBinding()]
    param(
        [Hashtable]
        $ParameterList
    )

    # construct two seperate lists
    [System.Collections.ArrayList]$attributeList = @()
    [string[]]$returnList = @()
    $propertiesToRemove = @(
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.Mandatory"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ParameterSet"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromPipeline"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromPipelineByPropertyName"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromRemainingArguements"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.HelpMessage")
    )

    foreach ($removeProp in $propertiesToRemove) {
        [void]$ParameterList.Remove($removeProp)
        [void]$attributeList.Add($removeProp)
    }

    $returnList += "`t[Parameter("
    $commaCounter = 1
    foreach ($prop in $attributeList) {
        switch ($prop) {
            { $prop -eq 'Mandatory' } {
                $returnList += "$prop = `$True"
                break
            }

            { $prop -eq 'Position' } {
                $returnList += "$prop = #"
                break
            }

            { $prop -eq 'ValueFromPipeline' -or $prop -eq 'ValueFromPipelineByPropertyName' -or $prop -eq 'ValueFromRemainingArguements' } {
                $returnList += "$prop = `$True"
                break
            }

            { $prop -eq 'ParameterSet' } {
                $returnList += "$prop = ('Set1')"
                break
            }

            { $prop -eq 'ValidateSet' } {
                $returnList += "$prop = ('one', 'two', 'three')"
                break
            }

            { $prop -eq 'HelpMessage' } {
                $returnList += "$prop = 'Your message goes here'"
                break
            }
        }

        if ($commaCounter -lt $attributeList.Count) {
            $commaCounter++
            $returnList += ", "
        }
        else {
            $returnList += ")]"
            $returnList = Join-String -InputObject $returnList
        }
    }

    foreach ($Parameter in $ParameterList.Keys) {
        switch ($Parameter) {
            { $Parameter -eq 'Alias' } {
                $returnList += "`t[$Parameter('Default')]"
                break
            }

            { $Parameter -eq 'AllowOrNull' -or $Parameter -eq 'AllowEmptyString' -or $Parameter -eq 'AllowEmptyCollection' -or $Parameter -eq 'ValidateNotNull' -or $Parameter -eq 'ValidateNotNullOrEmpty' } {
                $returnList += "`t[$Parameter()]"
                break
            }

            { $Parameter -eq 'ValidateCount' -or $Parameter -eq 'ValidateLength' } {
                $returnList += "`t[$Parameter(min, max)]"
                break
            }

            { $Parameter -eq 'ValidatePattern' } {
                $returnList += "`t[$Parameter('^[a-z][A-Z]')]"
                break
            }

            { $Parameter -eq 'ValidateRange' } {
                $returnList += "`t[$Parameter(min, max)]"
                break
            }

            { $Parameter -eq 'ValidateScript' } {
                $returnList += "`t[$Parameter({scriptblock})]"
                break
            }
        }
    }

    return $returnList
}

