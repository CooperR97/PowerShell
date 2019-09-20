#Created by: Cooper Redfern
#Date Created: 08/12/2019
function ResetPassword{
param()
    #Gets the name and password expiry data date
    $Users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed", EmailAddress 
    # $ListItem = New-Object psobject | select Item, object
    foreach($User in $Users)
    {
        #Cast the password expiry data to a datetime
        $ExpiryDate = $([datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed'))
        $Email = $User.EmailAddress
        #Determine the amount of time until expiration by comparing current date to expiry date
        $ExpireIn = New-TimeSpan -Start $(Get-Date) -End $ExpiryDate
        $DaysLeft = $ExpireIn.Days #Casting the time-span to an integer representing days
        HasPassedDate $Email $DaysLeft

    }
}

function HasPassedDate{
param($UserEmail, $UserDaysLeft)

    #if the customer has 14 days or less left, remind them to change their password, by generating an email
    if($UserDaysLeft -le 14 -and $UserDaysLeft -ge 1)
    {
       Write-Host "Email to be sent to "$UserEmail
       Write-Host $UserDaysLeft
       SendMail $UserEmail $UserDaysLeft
    }
}

#Takes in an email address and days til expiration to generate an email to client
function SendMail{
param($To, $Days)
    $From = "someEmail"
    $Subject = "Password Expiration"
    $Body = "Your password is going to expire in " + $Days + " Days. Create a new password or contact 'someEmail' for support."
    $SMTPServer = "someServer"
    $SMTPPort = "somePort"
    Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort
}