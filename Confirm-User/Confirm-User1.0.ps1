#Created by: Cooper Redfern
#Created on: 08/15/2019

#Filter through users in mail exchange to determine non-users and remove them
#Parse the columns, select first letter of first name and last name

#All Mail Accounts
$ExchangeAccounts = import-csv "someDirectory"

#List of account exceptions for various reasons
$exceptionEmails = @()
$exceptionEmails += "list of emails"
$confirmedUsers = @()
$nonConfirmedUsers = @()

foreach($account in $ExchangeAccounts)
{
    #Split the display name into array of strings
    $text = $account.'Display Name'.Split()

    #Assign first name to first string in list
    $firstName = $text[0]

    #Create an Alias by concatenating first letter of first word with the second word
    $CreatedAlias = $firstName[0] + $text[1]
    $Alias = $account.Alias

    #Create new var to determine mail type
    $MailType = $account.'Recipient Type Details'.Split()

    #Check the created alias against the actual alias
    if($CreatedAlias -eq $Alias -or $MailType[0] -eq 'Room' -or $account.'Primary SMTP Address' -in $exceptionEmails){
        $confirmedUsers += $account
    }
    else
    {
        $nonConfirmedUsers += $account
    }

}

#Test Before Export
Write-Host "Confirmed Users: "
foreach ($account in $confirmedUsers)
{
    #Write-Host $account.'Display Name'
}
Write-Host "Non-Confirmed Users: "
foreach($account in $nonConfirmedUsers)
{
    #Write-Host $account.'Display Name'
}

#Export to new csv files
$nonConfirmedUsers | export-csv 'someDirectory'
$confirmedUsers |  export-csv 'someDirectory'