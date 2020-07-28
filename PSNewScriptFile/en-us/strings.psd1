# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	'Add-ParametersToScriptfile.SearchingForExistingScript'       = "Building parameter and attribute list for parameter #{0}." # $Index
	'Add-ParametersToScriptfile.PropertyAndAttributeListComplete' = "Parameter and attribute list completed."
	'Find-ExistingScript.Failure'                                 = 'Exception: Scanning for existing script file'
	'Find-ExistingScript.NoExistingScript'                        = 'No exiting script found with the name of: {0}' # $ScriptName
	'Find-ExistingScript.ExistingScriptFound'                     = "A duplicate script {0} was found!  This script will be renamed on save."  # $ScriptName
	'Initialize-NewScript.Initialize'                             = 'Generating new script file: {0}' # $ScriptName
	'Initialize-NewScript.Failure'                                = 'Failure generating custom script file'
	'New-PSScriptFile.CheckingForExistingScript'                  = 'Checking for existing script with name: {0}' # $ScriptName
	'New-PSScriptFile.StartScript'                                = 'Starting script generation'
	'New-PSScriptFile.EndScript'                                  = 'Script generation completed'
	'New-ScriptFile.ConfigPath'                                   = 'Setting configuration path to: {0}' # $ConfigurationFile
	'Save-PSScriptFile.DirectoryNotFound'                         = '{0} directory not found. Creating directory' # $Filepath
	'Save-PSScriptFile.SaveScript'                                = 'Saving {0}.'
	"Save-PSScriptFile.DirectoryException"                        = "Directory Exception: Please check the debug log for more information"
	'Save-PSScriptFile.DirectoryError'                            = "Directory Create Exception!"
	"Save-PSScriptFile.FileException"                             = "File Exception: Please check the debug log for more information"
}
