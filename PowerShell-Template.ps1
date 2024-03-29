# PowerShell-Template
#
# SUMMARY:
# Template for building PowerShell scripts.
#
# REQUIREMENTS:
# PowerShell 5.x or higher

#[string] $lib = "$PSScriptRoot\lib\"
#."$lib\AppInfo.ps1"

# Example for accessing data: $xml.Settings.Emails.Email.Name
#$xml = [xml](get-content $PSScriptRoot\Settings.xml)

param
(
	[string] $cmd              # command line parameter
)


[string] $global:appName = "PowerShell-Template"
[string] $global:appVersion = "5.0.0"
[string] $global:appDate = "October 6, 2022"
[string] $global:appAuthor = "Johan Cyprich"
[string] $global:appAuthorContact = "jcyprich@live.com"
[string] $global:appCopyright = "2014-2022 Johan Cyprich"
[string] $global:appLicense = "Licensed under The MIT License (MIT)."


#=== AppInfo - DO NOT MODIFY ======================================================================


class AppInfo
{
	$_cmd = ""
	$_xml = ""
	$_startDate = ""
	$ExitScript = $false
	
	AppInfo($cmd, $xml)
	{
		$this._cmd = $cmd
		$this._xml = $xml
		$this._startDate = Get-Date

		$this.WriteProgramInfo()
		$this.DisplayHelp()
	}
	
 	DisplayHelp()
	{
		if (($this._cmd -eq "?") -or ($this._cmd -eq "help"))
		{
			HelpScreen
			$this.ExitScript = $true
		}
	}

 	WriteProgramInfo()
	{
		Write-Host
		Write-Host -BackgroundColor Black -ForegroundColor White $global:appName $global:appVersion

		if ($global:appCopyright -ne "")
		{
			Write-Host "Copyright (C) $global:appCopyright. All rights reserved. "

			if ($global:appLicense -ne "") { Write-Host $global:appLicense }
		}

		Write-Host "---"
		Write-Host
	}

	QuitProgram([bool] $runningTime, [bool] $doneMessage)
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
}


#=== Help Screen ==================================================================================


function HelpScreen()
{
	Write-Host "Help Screen"
	Write-Host 
}


#=== Functions ====================================================================================


#=== Main =========================================================================================


# Display application info.

$app = New-Object -TypeName AppInfo($cmd, $xml)
if ($app.ExitScript) { exit }

#
# Write code that does something.
#

# Quit the program and display running time.

$app.QuitProgram($true, $true)