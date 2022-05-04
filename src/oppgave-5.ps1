
[CmdletBinding()]
param (
    # parameter er ikke obligatorisk siden vi har default verdi
    [Parameter(HelpMessage = "URL til kortstokk", Mandatory = $false)]
    [string]
    # når paramater ikke er gitt brukes default verdi
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)



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

#oppg5
# ...

### Regn ut den samlede poengsummen til kortstokk
#   Nummererte kort har poeng som angitt på kortet
#   Knekt (J), Dronning (Q) og Konge (K) teller som 10 poeng
#   Ess (A) teller som 11 poeng

# 1. - utgave - summen av poeng for kort er form for loop/iterere oppgave

$poengKortstokk = 0

# hva er forskjellen mellom -eq, ieg og ceq?
# # https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2

foreach ($kort in $kortstokk) {
    if ($kort.value -ceq 'J') {
        $poengKortstokk = $poengKortstokk + 10
    }
    elseif ($kort.value -ceq 'Q') {
        $poengKortstokk = $poengKortstokk + 10
    }
    elseif ($kort.value -ceq 'K') {
        $poengKortstokk = $poengKortstokk + 10
    }
    elseif ($kort.value -ceq 'A') {
        $poengKortstokk = $poengKortstokk + 11
    }
    else {
        $poengKortstokk = $poengKortstokk + $kort.value
    }
}

Write-Host 'Poengsum:' $poengKortstokk