# PowerShell-Template
#
# See Settings.xml for application, user, and license information.
#
# SUMMARY:
# Template for building PowerShell scripts.
#
# REQUIREMENTS:
# PowerShell 5.x or higher

param
(
	[string] $cmd              # command line parameter
)


#=[ APPINFO ]======================================================================================

# Example for accessing data: $xml.Settings.Application.Name

$xml = [xml](get-content $PSScriptRoot\Settings.xml)    # Settings.xml located in the script folder.


#=[ LIBRARIES ]=====================================================================================

[string] $lib = "$PSScriptRoot\lib\"

."$lib\AppInfo.ps1"


#=[ GLOBALS ]=======================================================================================

#[string] $global:st = "A string."


#=[ FUNCTIONS ]=====================================================================================

function HelpScreen
{
	Write-Host "Usage:" $xml.Settings.Application.Name
	Write-Host 
}

#=[ MAIN ]==========================================================================================

# Display application info and help.

$app = New-Object -TypeName AppInfo ($cmd, $xml)
if ($app.ExitScript) { exit }

#
# Write code that does something.
#

# Quit the program.

$app.QuitProgram($true, $true)