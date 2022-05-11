
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

$poengKortstokk = 0

function sumPoengKortstokk {
    [OutputType([int])]
    param (
        [object[]]
        $kortstokk
    )

    $poengKortstokk = 0

    foreach ($kort in $kortstokk) {
        # Undersøk hva en Switch er
        $poengKortstokk += switch ($kort.value) {
            { $_ -cin @('J','K','Q') } { 10 }
            { $_ -cin @('A')} { 11 }
            default { $kort.value }
        }
    }
    return $poengKortstokk
}

Write-Output "Poengsum: $(sumPoengKortstokk -kortstokk $kortstokk)"

#oppg6
# ...


$meg = $kortstokk[0..1]
Write-Output "meg: $(kortstokkTilStreng $meg)"
$kortstokk = $kortstokk[2..($kortstokk.Count -1)]
$magnus = $kortstokk[0..1]
Write-Output "magnus: $(kortstokkTilStreng $magnus)"
$kortstokk = $kortstokk[2..($kortstokk.Count -1)]
Write-Output "Kortstokk:  $(kortstokkTilStreng $kortstokk)"


#oppg7
#...

function skrivUtResultat {
    param (
        [string]
        $vinner,        
        [object[]]
        $kortStokkMagnus,
        [object[]]
        $kortStokkMeg        
    )
    Write-Output "Vinner: $vinner"
    Write-Output "magnus | $(sumPoengKortstokk -kortstokk $kortStokkMagnus) | $(kortstokkTilStreng -kortstokk $kortStokkMagnus)"    
    Write-Output "meg    | $(sumPoengKortstokk -kortstokk $kortStokkMeg) | $(kortstokkTilStreng -kortstokk $kortStokkMeg)"
}

# bruker 'blackjack' som et begrep - er 21
$blackjack = 21

if (((sumPoengKortstokk -kortstokk $meg) -eq $blackjack ) -AND ((sumPoengKortstokk -kortstokk $magnus) -eq $blackjack)) {
    skrivUtResultat -vinner "draw" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}
elseif ((sumPoengKortstokk -kortstokk $magnus) -eq $blackjack ) {
    skrivUtResultat -vinner "magnus" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}
elseif ((sumPoengKortstokk -kortstokk  $meg) -eq $blackjack ) {
    skrivUtResultat -vinner "meg" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}


#-UrlKortstokk 'https://azure-gvs-test-cases.azurewebsites.net/api/vinnerDraw'
#-UrlKortstokk 'https://azure-gvs-test-cases.azurewebsites.net/api/vinnerMagnus'
#-UrlKortstokk 'https://azure-gvs-test-cases.azurewebsites.net/api/vinnerMeg'

#oppg8
# ...
#oppg10 la til -1 glemte det i oppgaven
while ((sumPoengKortstokk -kortstokk $meg ) -lt 17) {
    $meg += $kortstokk[0]
    $kortstokk = $kortstokk[1..($kortstokk.Count -1)]
}

if ((sumPoengKortstokk -kortstokk $meg) -gt $blackjack) {
    skrivUtResultat -vinner "magnus" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}

#-UrlKortstokk 'https://azure-gvs-test-cases.azurewebsites.net/api/taperMeg'

#oppg9
# ...
#oppg10 la til -1 glemte det i oppgaven
while ((sumPoengKortstokk -kortstokk $magnus) -le (sumPoengKortstokk -kortstokk $meg)) {
    $magnus += $kortstokk[0]
    $kortstokk = $kortstokk[1..($kortstokk.Count -1)]
}


if ((sumPoengKortstokk -kortstokk $magnus) -gt $blackjack) {
    skrivUtResultat -vinner "meg" -kortStokkMagnus $magnus -kortStokkMeg $meg
    exit
}

#-UrlKortstokk 'https://azure-gvs-test-cases.azurewebsites.net/api/taperMagnus'


#oppg10
# ...
skrivUtResultat -vinner "magnus" -kortStokkMagnus $magnus -kortStokkMeg $meg

#-UrlKortstokk 'http://nav-deckofcards.herokuapp.com/shuffle'