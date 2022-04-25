
$ErrorActionPreference = 'Stop'

$webRequest = Invoke-WebRequest -Uri http://nav-deckofcards.herokuapp.com/shuffle


$kortstokkJson = $webRequest.content



$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson

# suit     value
# ----     -----
# SPADES   8
# HEARTS   J
# DIAMONDS A
# HEARTS   K
# CLUBS    J
# DIAMONDS 6
# CLUBS    A
# CLUBS    K
# DIAMONDS 3
# ...

# å skrive ut kortene i kortstokken er form for loop/iterere oppgave
# https://4sysops.com/archives/powershell-loops-for-foreach-while-do-until-continue-break/
# https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/

# 1. utgave - foreach loop som skriver ut et kort per linje
#foreach ($kort in $kortstokk) {
#    Write-Output $kort
#}

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.1#subexpression-operator--

# En streng (string) er en array av karakterer @('S','P','A','D','E')
# 2. utgave - interessert i 1. karakter i merke - (S)PADE - og verdi
foreach ($kort in $kortstokk) {
    Write-Output "$($kort.suit[0])+$($kort.value)"
}


# hvorfor kommer det et komma ',' etter siste kort?
# frivillig oppgave - kan du forbedre funksjonen 'kortTilStreng' - ikke skrive ut komma etter siste kort?