$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Get-DistributionGroup -Anr *transactions*
Add-DistributionGroupMember -Identity "Employees" -Member $Username
Remove-PSSession $Session