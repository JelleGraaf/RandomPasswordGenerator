##############################################################################
# Script name: Generate-RandomPassword.ps1
# Version: 0.1
# Created by: Jelle de Graaf
# Last change: 20-09-2017
# GitHub repository: https://github.com/JelleGraaf/RandomPasswordGenerator
##############################################################################

<#
TO DO:
- Check the password for containing at least one member of each chosen character set.
- Add the option to exclude similar characters (0 and O, for example)
#>

<#
.Synopsis
   Generates a random password
.DESCRIPTION
   Generates a random password, to your specifications. Parameters for several customizations are available
.EXAMPLE
   Generate-RandomPassword
   This command generates a random password of 8 characters, with at least one letter, one number and one symbol.
.EXAMPLE
   Another example of how to use this workflow
#>

param (
    $LowerLetter = $true,
    $UpperLetter = $false,
    $Number = $true,
    $Symbol = $true,
#    [switch]$ExcludeSimilarCharacters,
    $Length = 12
)

#Define variables
$LowerLetterLibrary = [char[]]([int][char]'a'..[int][char]'z')
$UpperLetterLibrary = [char[]]([int][char]'A'..[int][char]'Z')
$NumberLibrary = [char[]]([int][char]'0'..[int][char]'9')
$SymbolLibrary = @("!","@","#","$","%","^","&","*","(",")","-","_","=","+","[","]","{","}",":",";",",",".","<",">","/","\")
$Password = $null

##########################
#Main script starts here #
##########################
#Determine the characterset
$i = 0
[array]$PasswordTemp = $null
[array]$CharacterSets = @()
if ($LowerLetter) {$CharacterSets += '1'}
if ($UpperLetter) {$CharacterSets += '2'}
if ($Number) {$CharacterSets += '3'}
if ($Symbol) {$CharacterSets += '4'}

#Build a temporary password with the correct length and placeholders for the character types
While ($i -le $Length) {
    $PasswordTemp += ($CharacterSets | Get-Random)
    $i ++
}

#Build the password from the selectet character sets
foreach ($Character in $PasswordTemp) {
    if ($Character -eq 1) {$Password += ($LowerLetterLibrary | Get-Random)}
    if ($Character -eq 2) {$Password += ($UpperLetterLibrary | Get-Random)}
    if ($Character -eq 3) {$Password += ($NumberLibrary | Get-Random)}
    if ($Character -eq 4) {$Password += ($SymbolLibrary | Get-Random)}
}

#Write the result to screen
Write-Host "Your password is: " -NoNewline
Write-Host $Password -ForegroundColor Yellow