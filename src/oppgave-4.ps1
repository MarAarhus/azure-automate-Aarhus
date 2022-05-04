
[CmdletBinding()]
param (
    # parameter er ikke obligatorisk siden vi har default verdi
    [Parameter(HelpMessage = "URL til kortstokk", Mandatory = $false)]
    [string]
    # når paramater ikke er gitt brukes default verdi
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)


# For en enkel feilhåndtering, se bruk av $ErrorActionPreference i hint til oppg 3
# For mer spesifikk feilhåndtering, søk opp bruk av try{} catch{} i PowerShell på Google

# resten av koden er som oppgave 3


$ErrorActionPreference = 'Stop'

$webRequest = Invoke-WebRequest -Uri $UrlKortstokk


$kortstokkJson = $webRequest.content



$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson


function kortstokkTilStreng {
    [OutputType([string])]
    param (
        [object[]]
        $kortstokk
    )
    $streng = ""
    foreach ($kort in $kortstokk) {
        $streng = $streng + "$($kort.suit[0])" + "$($kort.value),"
    }
    return $streng.Substring(0,$streng.Length-1)
}

Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"

