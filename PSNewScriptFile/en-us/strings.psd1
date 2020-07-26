# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'New-PSScriptFile.StartScript'         = 'Starting script generation'
	'New-PSScriptFile.EndScript'           = 'Script generation completed'
	'New-ScriptFile.ConfigPath'            = 'Setting configuration path to: {0}' # $ConfigurationFile
	'Save-PSScriptFile.DirectoryNoteFound' = '{0} directory not found. Creating directory' # $Filepath
	'Save-PSScriptFile.Failure'            = 'Failure generating custom script file'
	'Save-PSScriptFile.SaveScript'         = 'Saving {0}.'
	"Save-PSScriptFile.DirectoryFailure"   = "Directory Exception: Please check the debug log for more information"
	"Save-PSScriptFile.FileFailure"        = "File Exception: Please check the debug log for more information"
	'Initialize-NewScript.CreatingScript'  = 'Generating new script file: {0}' # $ScriptName
	'Initialize-NewScript.Failure'         = 'Failure generating custom script file'
}