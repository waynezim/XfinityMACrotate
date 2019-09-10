Import-Module Selenium

$browser = Start-SeEdge

Enter-SeUrl -Driver $browser -Url "http://msftconnect.com/redirect"

$getstarted = Find-SeElement -Driver $browser -LinkText 'Get Started' -Wait

Invoke-SeClick -Element $getstarted -Driver $browser

$FreePass = Find-SeElement -Driver $browser -ID 'offersFreeList1' -wait

Invoke-SeClick -Element $FreePass -Driver $browser

$ContinueButton = Find-SeElement -Driver $browser -ID 'continueButton' -wait
 
Invoke-SeClick -Element $ContinueButton -Driver $browser

$cancelbutton = Find-SeElement -Driver $browser -Id 'upgradeOfferCancelButton' -Wait

Invoke-SeClick -Driver $browser -Element $cancelbutton

$RandomNum = Get-Random -Maximum 99999

$pwquestion = Find-SeElement -Driver $browser -Id 'dk0-combobox' -Wait
Invoke-SeClick -Driver $browser -Element $pwquestion
Send-SeKeys -Element $pwquestion -Keys ([OpenQA.Selenium.Keys]::Down)
Send-SeKeys -Element $pwquestion -Keys ([OpenQA.Selenium.Keys]::Enter)

$Form = @(
    @{
        id = 'firstName'
        value = 'posh'
    },
    @{
        id = 'lastName'
        value = 'bits'
    },
    @{
        id = 'userName'
        value = "poshbits$RandomNum"
    },
    @{
        id = 'alternateEmail'
        value = "jww$RandomNum@tuofs.com"
    },
    @{
        id = 'secretAnswer'
        value = 'none'
    },
    @{
        id = 'password'
        value = 'Jackson5'
    },
    @{
        id = 'passwordRetype'
        value = 'Jackson5'
    }
)

ForEach($item in $form)
{
    $formelement = Find-SeElement -Driver $browser -id $item.id -Wait
    Send-SeKeys -Element $formelement -Keys $item.value
}

$submitbutton = Find-SeElement -Driver $browser -Id 'submitButton' -Wait

Invoke-SeClick -Driver $browser -Element $submitbutton

$orderconfirmation = Find-SeElement -Driver $browser -Id '_orderConfirmationActivatePass' -Wait

Invoke-SeClick -Driver $browser -Element $orderconfirmation

$justwaiting = Find-SeElement -Driver $browser -LinkText 'My Account' -Wait

Enter-SeUrl -Driver $browser -Url "https://wifiondemand.xfinity.com/wod/selfservice/"