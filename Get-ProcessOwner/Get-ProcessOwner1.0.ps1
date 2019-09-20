#Cooper Redfern
#09/11/2019
#Return a list of win32_process objects where the process is Microsoft Project
$process = 'someProcess'
$Users = (Get-WmiObject Win32_Process -ComputerName 'someDomain' | ?{ $_.ProcessName -match $process }).GetOwner() 
#Print User attribute of each object returned
foreach($User in $Users){
write-host($User.User)
}
