function Save-PSScriptFile {
    <#
        .SYNOPSIS
            Function for saving script file

        .DESCRIPTION
            This function will save the newly created script (.ps1) file to a location saved in the configuration settings

        .EXAMPLE
            An example

        .NOTES
            None
    #>

    [CmdletBinding()]
    param(
        [string]
        $Filepath,

        [string]
        $ScriptName,

        [System.Collections.ArrayList]
        $ScriptFileContents,

        [bool]
        $EnableException
    )

    begin {
        if (-Not $Filepath) {
            $Filepath = Get-PSFConfigValue -FullName 'PSNewScriptFile.Save.Directory'
        }
    }

    process {
        try {
            if (-NOT (Test-Path -Path $Filepath -ErrorAction SilentlyContinue)) {
                Write-PSFMessage -Level Host -String 'Save-PSScriptFile.DirectoryNotFound' -StringValues $Filepath
                New-Item -Path $Filepath -ItemType Directory -Force
            }
        }
        catch {
            Stop-PSFFunction -String 'Save-PSScriptFile.DirectoryException' -EnableException $EnableException -ErrorRecord $_
        }

        try {
            Find-ExistingScript -ScriptName $ScriptName
            Write-PSFMessage -Level Host -String 'Save-PSScriptFile.SaveScript' -StringValues $ScriptName
            $ScriptFileContents | Set-Content -Path (Join-Path -Path $Filepath -ChildPath ("$ScriptName.ps1")) # using set-content will output to string, all out commands go through the ps formatter
        }
        catch {
            Stop-PSFFunction -String "Save-PSScriptFile.FileException" -EnableException $EnableException -ErrorRecord $_
        }
    }
    end {}
}