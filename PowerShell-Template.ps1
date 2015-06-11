### APPLICATION: PowerShell-Template
### VERSION: 2.0.0
#### DATE: June 11, 2015
### AUTHOR: Johan Cyprich
### AUTHOR URL: www.cyprich.com
### AUTHOR EMAIL: jcyprich@live.com
###   
### LICENSE:
### The MIT License (MIT)
### http://opensource.org/licenses/MIT
###
### Copyright (c) 2014-2015 Johan Cyprich. All rights reserved.
###
### Permission is hereby granted, free of charge, to any person obtaining a copy 
### of this software and associated documentation files (the "Software"), to deal
### in the Software without restriction, including without limitation the rights
### to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
### copies of the Software, and to permit persons to whom the Software is
### furnished to do so, subject to the following conditions:
###
### The above copyright notice and this permission notice shall be included in
### all copies or substantial portions of the Software.
###
### THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
### IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
### FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
### AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
### LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
### OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
### THE SOFTWARE.
###
### SUMMARY:
### Template for building PowerShell scripts.

param
(
  [string] $cmd              # command line parameter
)


#=[ SETTINGS ]======================================================================================

$xml = [xml](get-content $PSScriptRoot\Settings.xml)


#=[ LIBRARIES ]=====================================================================================


# Define libraries location if its not in the script directory.
#[string] $libraries = "D:\Projects\Libraries\MyLib\PowerShell"

#."$PSScriptRoot\YourLibrary.ps1"


#=[ GLOBALS ]=======================================================================================


#[string] $global:var = ""


#=[ FUNCTIONS ]=====================================================================================


####################################################################################################
### SUMMARY:
### Display help screen when user enters "?" or "help".
###
### PARAMETERS:
### $global:cmd (in) - Command line parameters.
####################################################################################################

function DisplayHelp
{
  if (($cmd -eq "?") -or ($cmd -eq "help"))
  {
    Write-Host " Usage: PowerShell-Template"
    Write-Host " Example: .\PowerShell-Template"
    Write-Host ""
  
    break  
  }
} # DisplayHelp


####################################################################################################
### SUMMARY:
### Writes the name of the app, copyright, license, and branding.
###
### PARAMTERS:
### $appName (in) - Name of the app.
### $copyright (in) -  Year and copyright name.
### $appFore (in) - Foreground colour of $appName (default White).
### $appBack (in) - Background colour of $appName (default DarkBlue).
### $copyFore (in) - Foreground colour of $copyright (default Black).
### $copyBlack (in) - Background colour of $copyright (default DarkGray).
####################################################################################################

function WriteProgramInfo
{
  param
  (
    [string] $appName, 
    [string] $copyright,
    [string] $appFore = "White",
    [string] $appBack = "DarkBlue",
    [string] $copyFore = "Black",
    [string] $copyBack = "DarkGray"    
  )
  
  [string] $copyrt = " Copyright (C) $copyright. All rights reserved. "
  [string] $license = " Licensed under The MIT License (MIT)."
  [int] $copyrtLength = $copyrt.length
  [string] $linePadding
  [string] $emptyLine = " " * $copyrtLength  
  
  # Write app info and pad with spaces based on the length of the copyright line.
  
  Write-Host ""
  Write-Host $emptyLine -ForegroundColor $appFore -BackgroundColor $appBack
  
  $linePadding = " " * ($copyrtLength - " $appName".length)
  Write-Host " $appName$linePadding" -ForegroundColor $appFore -BackgroundColor $appBack
  
  Write-Host $emptyLine -ForegroundColor $appFore -BackgroundColor $appBack
  Write-Host $emptyLine -ForegroundColor $copyFore -BackgroundColor $copyBack
  Write-Host $copyrt -ForegroundColor $copyFore -BackgroundColor $copyBack
  
  $linePadding = " " * ($copyrtLength - " $license".length)
  Write-Host " Licensed under The MIT License (MIT). $linePadding" -ForegroundColor $copyFore -BackgroundColor $copyBack

  Write-Host $emptyLine -ForegroundColor $copyFore -BackgroundColor $copyBack
  Write-Host ""
} # WriteProgramInfo


#=[ MAIN ]==========================================================================================


#$ErrorActionPreference = 'SilentlyContinue'

WriteProgramInfo "PowerShell-Template 2.0.0" "2014-2015 Johan Cyprich"
DisplayHelp

#
# Write code that does something.
#

Write-Host $xml.Settings.Application.Name
Write-Host $xml.Settings.Application.Version
Write-Host $xml.Settings.Application.Date

# Close the program.

Write-Host ""
Write-Host " Done " -ForegroundColor White -BackgroundColor Red
Write-Host ""
