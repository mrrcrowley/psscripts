$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
$SearchName = "BadStuff"
Import-PSSession $Session


New-ComplianceSearchAction -SearchName $SearchName -Purge -PurgeType SoftDelete



Remove-PSSession $Session