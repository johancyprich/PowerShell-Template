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


class AppInfo
{
	$_cmd = ""				# command line parameter
	$_xml = ""				# Settings.xml
	$_startDate = ""		# start date when script started running
	
	$ExitScript = $false	# stop running script?

	###############################################################################################
	# Constructor
	###############################################################################################

	AppInfo ($cmd, $xml)
	{
		$this._cmd = $cmd
		$this._xml = $xml

		$this._startDate = Get-Date

		# Display program info and help screen (if requested)

		$this.WriteProgramInfo()
		$this.DisplayHelp()
	}

	
	###############################################################################################
	# SUMMARY:
	# Display help screen when user enters "?" or "help". Calls function HelpScreen which user
	# defines the content of the application help.
	#
	# PARAMETERS:
	# $global:cmd (in) - Command line parameters.
	###############################################################################################

 	DisplayHelp ()
	{
		if (($this._cmd -eq "?") -or ($this._cmd -eq "help"))
		{
			HelpScreen

			$this.ExitScript = $true
		}
	} # DisplayHelp


	###############################################################################################
	# SUMMARY:
	# Writes the name of the app, copyright, and license. If $copyright is blank, then only the app
	# name will be displayed. License will be displayed if its not an empty string.
	#
	# PARAMETERS:
	# $appName (in) - Name of the app.
	# $copyright (in) -  Year and copyright name.
	###############################################################################################

 	WriteProgramInfo ()
	{
		[string] $appName = $this._xml.Settings.Application.Name + " " + $this._xml.Settings.Application.Version
		[string] $copyright = $this._xml.Settings.Application.Legal.Copyright
		[string] $license = $this._xml.Settings.Application.Legal.License

		Write-Host
		Write-Host -BackgroundColor Black -ForegroundColor White $appName

		if ($copyright -ne "")
		{
			Write-Host "Copyright (C) $copyright. All rights reserved. "

			if ($license -ne "") { Write-Host $license }
		}

		Write-Host "---"
		Write-Host
	} # WriteProgramInfo


	###############################################################################################
	# SUMMARY:
	# Display the running time of the script and the closing Done message.
	#
	# PARAMETERS:
	# $runningTime (in) - display running time?
	# $doneMessage (in) - display Done message?
	###############################################################################################

	QuitProgram ([bool] $runningTime, [bool] $doneMessage)
	{
		if ($runningTime)
		{
			Write-Host
			Write-Host -ForegroundColor Green "Running time:" $($(Get-Date) - $this._startDate)		
		}

		if ($doneMessage)
		{
			Write-Host
			Write-Host " Done " -ForegroundColor White -BackgroundColor DarkRed
		}

		Write-Host	
	}
} # AppInfo


#=[ LIBRARIES ]=====================================================================================

#[string] $libraries = "$PSScriptRoot\lib\"

#."$libraries\Cirrus.PowerShell.Toolkit\Cirrus.Settings.ps1"


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