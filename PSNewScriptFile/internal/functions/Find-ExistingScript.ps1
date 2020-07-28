function Find-ExistingScript {
    <#
    .SYNOPSIS
        Function for scanning for existing script with the same name

    .DESCRIPTION
        This helper function will look for a script with the same name and if found will rename the existing script to to be unique with a # at the end

    .NOTES
        None
    #>

    [CmdletBinding()]
    param(
        [string]
        $ScriptName
    )
    begin {
        $FilePath = Get-PSFConfigValue -FullName 'PSNewScriptFile.Save.Directory'
        $file = Join-Path -Path $FilePath -ChildPath ("$ScriptName")
    }
    process {
        try {
            Write-PSFMessage -Level Verbose -String 'Find-ExistingScript.SearchingForExistingScript' -StringValues $file
            foreach($file in (Get-ChildItem -Path $FilePath -Filter "$ScriptName*") | Sort-Object -Descending)
            {
                if("$ScriptName.ps1" -ne $file.Name)
                {
                    [System.Collections.ArrayList]$currentFilename = $file.Fullname -split '-'
                    [Int]$fileNumber = $currentFilename[2] -replace '\.ps1$'
                    $fileNumber ++
                    [void]$currentFilename.RemoveAt(2)
                    [void]$currentFilename.Add(([string]$fileNumber + ".ps1"))
                    $newFilename = Join-String -Separator '-' -InputObject $currentFilename
                    Rename-Item -Path $file.FullName -NewName $newFilename
                    $currentFilename.Clear()
                }
                else {
                    [string]$currentFilename = $file.FullName -replace '\.ps1$'
                    $newFileName = $currentFilename + "-1.ps1"
                    Rename-Item -Path $file.FullName -NewName $newFileName
                }

            }
        }
        catch {
            Stop-PSFFunction -String 'Find-ExistingScript.Failure' -EnableException $EnableException -ErrorRecord $_
        }
    }
    end {}
}