$Users = ,"allen.pell@offerpad.com","allison.holguin@offerpad.com","amber.king@offerpad.com","amir.ghawala@offerpad.com","andy.figueroa@offerpad.com","chris@offerpad.com","craig.fecteau@offerpad.com","dan.mcguigan@offerpad.com","denise.white@offerpad.com","derek@offerpad.com","elijah.carino@offerpad.com","garrett@offerpad.com","gus@offerpad.com","jason.rogers@offerpad.com","jerome.milner@offerpad.com","jesse.elliot@offerpad.com","jim.bolger@offerpad.com","joe.skeldon@offerpad.com","john.benally@offerpad.com","jorge.zarate@offerpad.com","joseph.delatorre@offerpad.com","julio.cuevas@offerpad.com","justin.brown@offerpad.com","justin.horner@offerpad.com","kristen.hansen@offerpad.com","logan.nakano@offerpad.com","megan.smith@offerpad.com","mike.sammons@offerpad.com","nicolle.arrington@offerpad.com","rafael.artigas@offerpad.com","randy.colby@offerpad.com","rick.meek@offerpad.com","rjones@elevationsolar.com","rob.smith@offerpad.com","stjepan.rajko@offerpad.com","tim.belshe@offerpad.com","trevor.walker@offerpad.com","v.chidambaram@offerpad.com",""
Write-Host $Users
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication  Basic -AllowRedirection
Import-PSSession $Session

foreach ($User in $Users)
{
    Add-DistributionGroupMember adminusers@offerpad.com -Member $User -Verbose
}
