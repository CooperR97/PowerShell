#Created by: Cooper Redfern
#Created on: 09/20/2019
#Produces the HailStoneSequence with a given input n
Function HailStoneSequence
{
param ([int]$Num)
    #When the output reaches 1, the sequence is complete
    if ($Num -eq 1)
    {
        Write-host 1
        Write-Host Hailstone Sequence complete. -ForegroundColor Green
        break
    }
    #if the output is even then divide by 2 and recursively call the function
    elseif ($Num % 2 -eq 0)
    {
        #Add some color to the console because it is fun
        $ColorNum = Get-Random -Maximum 15
        Write-Host $Num -ForegroundColor $ColorNum
        $newNum = $Num / 2
        #Wait small period of time between each output
        Start-Sleep -Milliseconds 30
        HailStoneSequence $newNum
    }
    #if the output is odd then multiply by 3 and add 1 to the function
    #and recursively call the function
    elseif ($Num % 2 -eq 1)
    {
        #Add some color to the console because it is fun
        $ColorNum = Get-Random -Maximum 15
        Write-Host $Num -ForegroundColor $ColorNum
        $newNum = $Num * 3 + 1
        #Wait a small period of time between each output
        Start-Sleep -Milliseconds 30
        HailStoneSequence $newNum
    }
}