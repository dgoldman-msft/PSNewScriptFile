<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

# Attributes that make up the script documentation
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ScriptName' -value "ScriptName" -Initialize -Validation 'string' -Description "ScriptName Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.FilePath' -value "FilePath" -Initialize -Validation 'string' -Description "FilePath Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.Synopsis' -value "Synopsis" -Initialize -Validation 'string' -Description "Synopsis Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.Description' -value "Description" -Initialize -Validation 'string' -Description "Description Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.Notes' -value "Notes" -Initialize -Validation 'string' -Description "Notes Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.NumberOfParameters' -value "NumberOfParameters" -Initialize -Validation 'string' -Description "NumberOfParameters Property"

# Parameter validation attributes
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.HelpMessage' -value "HelpMessage" -Initialize -Validation 'string' -Description "HelpMessage Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.Mandatory' -value "Mandatory" -Initialize -Validation 'string' -Description "Mandatory Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ParameterSetName' -value "ParameterSetName" -Initialize -Validation 'string' -Description "ParameterSetName Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValueFromPipeline' -value "ValueFromPipeline" -Initialize -Validation 'string' -Description "ValueFromPipeline Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValueFromPipelineByPropertyName' -value "ValueFromPipelineByPropertyName" -Initialize -Validation 'string' -Description "ValueFromPipelineByPropertyName Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValueFromRemainingArguments' -value "ValueFromRemainingArguments" -Initialize -Validation 'string' -Description "ValueFromRemainingArguments Property"

# Attribute for aliases
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.Alias' -value "Alias" -Initialize -Validation 'string' -Description "Alias Property"

# Attributes that control how null or empty parameters are handled

# Parameter validation attributes
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.AllowNull' -value "AllowNull" -Initialize -Validation 'string' -Description "AllowNull Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.AllowEmptyString' -value "AllowEmptyString" -Initialize -Validation 'string' -Description "AllowEmptyString Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.AllowEmptyCollection' -value "AllowEmptyCollection" -Initialize -Validation 'string' -Description "AllowEmptyCollection Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateNotNull' -value "ValidateNotNull" -Initialize -Validation 'string' -Description "ValidateNotNull Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateNotNullOrEmpty' -value "ValidateNotNullOrEmpty" -Initialize -Validation 'string' -Description "ValidateNotNullOrEmpty Property"

# Attributes that validate string lengths or array element counts
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateCount' -value "ValidateCount($min, $max)" -Initialize -Validation 'string' -Description "ValidateCount Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateLength' -value "ValidateLength($min, $max)" -Initialize -Validation 'string' -Description "ValidateLength Property"

# Attributes that validate argument values against numeric ranges, regular expression patterns, or explicit sets of values
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidatePattern' -value "ValidatePattern($pattern)" -Initialize -Validation 'string' -Description "ValidatePattern Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateRange' -value "ValidateRange($min, $max)" -Initialize -Validation 'string' -Description "ValidateRange Property"
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateSet' -value "ValidateSet(set of values...)" -Initialize -Validation 'string' -Description "ValidateSet Property"

# Performs custom validation actions by specifying a scriptblock
Set-PSFConfig -Module 'PSNewScriptFile' -Name 'Configuration.Property.ValidateScript' -value "ValidateScript{scriptblock}" -Initialize -Validation 'string' -Description "ValidateScript Property"

