
$ErrorActionPreference = 'Stop'

$webRequest = Invoke-WebRequest -Uri http://nav-deckofcards.herokuapp.com/shuffle


$kortstokkJson = $webRequest.content



$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson



# 1. utgave - foreach loop som skriver ut et kort per linje
foreach ($kort in $kortstokk) {
    Write-Output $kort
}
