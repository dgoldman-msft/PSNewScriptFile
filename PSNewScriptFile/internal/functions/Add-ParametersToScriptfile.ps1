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
        $UserSuppliedParameterList,

        [Int]
        $Index
    )

    # construct two seperate lists
    [string[]]$returnList = @()
    [System.Collections.ArrayList]$parameterList = @()
    [System.Collections.ArrayList]$validationAttributeList = @()

    $propertiesToRemove = @(
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.Mandatory"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ParameterSetName"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromPipeline"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromPipelineByPropertyName"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.ValueFromRemainingArguments"),
        (Get-PSFConfigValue -FullName "PSNewScriptFile.Configuration.Property.HelpMessage")
    )

    foreach ($prop in $UserSuppliedParameterList.Keys)
    {
        if($propertiesToRemove -contains $prop)
        {
            [void]$parameterList.Add($prop)
        }
        else {
            [void]$validationAttributeList.Add($prop)
        }
    }

    Write-PSFMessage -Level Verbose -String 'Add-ParametersToScriptfile.BuildingParameterAndAttributeList' -StringValues $Index
    $returnList += "`t[Parameter("
    $commaCounter = 1
    foreach ($prop in ($parameterList | Sort-Object)) {
        switch ($prop) {
            { $prop -eq 'Mandatory' } {
                $returnList += "$prop = `$True"
                break
            }

            { $prop -eq 'Position' } {
                $returnList += "$prop = #"
                break
            }

            { $prop -eq 'ValueFromPipeline' -or $prop -eq 'ValueFromPipelineByPropertyName' -or $prop -eq 'ValueFromRemainingArguments' } {
                $returnList += "$prop = `$True"
                break
            }

            { $prop -eq 'ParameterSetName' } {
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

        if ($commaCounter -lt $parameterList.Count) {
            $commaCounter++
            $returnList += ", "
        }
        else {
            $returnList += ")]"
            $returnList = Join-String -InputObject $returnList
        }
    }

    foreach ($parameter in $validationAttributeList) {
        switch ($parameter) {
            { $parameter -eq 'Alias' } {
                $returnList += "`t[$parameter('Default')]"
                break
            }

            { $parameter -eq 'AllowOrNull' -or $parameter -eq 'AllowEmptyString' -or $parameter -eq 'AllowEmptyCollection' -or $parameter -eq 'ValidateNotNull' -or $parameter -eq 'ValidateNotNullOrEmpty' } {
                $returnList += "`t[$parameter()]"
                break
            }

            { $parameter -eq 'ValidateCount' -or $parameter -eq 'ValidateLength' } {
                $returnList += "`t[$parameter(min, max)]"
                break
            }

            { $parameter -eq 'ValidatePattern' } {
                $returnList += "`t[$parameter('^[a-z][A-Z]')]"
                break
            }

            { $parameter -eq 'ValidateRange' } {
                $returnList += "`t[$parameter(min, max)]"
                break
            }

            { $parameter -eq 'ValidateScript' } {
                $returnList += "`t[$parameter({scriptblock})]"
                break
            }
        }
    }

    Write-PSFMessage -Level Verbose -String 'Add-ParametersToScriptfile.PropertyAndAttributeListComplete'
    return $returnList
}

