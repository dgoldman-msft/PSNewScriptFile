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
            $Filepath = Get-PSFConfigValue -FullName "PSNewScriptFile.Save.Directory"
        }
    }

    process {
        try {
            if (-NOT (Test-Path -Path $Filepath -ErrorAction SilentlyContinue)) {
                Write-PSFMessage -Level Host -String 'Save-PSScriptFile.DirectoryNoteFound' -StringValues $Filepath
                New-Item -Path $Filepath -ItemType Directory -Force
            }
        }
        catch {
            Stop-PSFFunction -String "Save-PSScriptFile.DirectoryFailure" -EnableException $EnableException -ErrorRecord $_
        }

        try {
            $newFileName = Join-Path -Path $FilePath -ChildPath ("$ScriptName.ps1")
            Write-PSFMessage -String 'Save-PSScriptFile.SaveScript' -StringValues $newFileName
            $ScriptFileContents | Out-File -FilePath $newFileName
        }
        catch {
            Stop-PSFFunction -Message "Save-PSScriptFile.FileFailure" -EnableException $EnableException -ErrorRecord $_
        }
    }
    end {}
}