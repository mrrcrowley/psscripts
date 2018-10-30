$CodeName = "DFW"
$EmailName = "dfw"
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
New-DistributionGroup -Name "Offerpad $CodeName Disposition Contact" -Type Distribution -PrimarySmtpAddress "$EmailName-dispositioncontact@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName New Disposition" -Type Distribution -PrimarySmtpAddress "$EmailName-newdisposition@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName New Disposition Offer" -Type Distribution -PrimarySmtpAddress "$EmailName-newdispositionoffer@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName New Renovation" -Type Distribution -PrimarySmtpAddress "$EmailName-newrenovation@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName Repairs Completed" -Type Distribution -PrimarySmtpAddress "$EmailName-repairscompleted@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName Contracts" -Type Distribution -PrimarySmtpAddress "$EmailName-contracts@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName HUD" -Type Distribution -PrimarySmtpAddress "$EmailName-hud@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName Offer Accepted" -Type Distribution -PrimarySmtpAddress "$EmailName-offeraccepted@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName Offer Declined" -Type Distribution -PrimarySmtpAddress "$EmailName-offerdeclined@offerpad.com"
New-DistributionGroup -Name "Offerpad $CodeName Partner Request" -Type Distribution -PrimarySmtpAddress "$EmailName-partnerrequest@offerpad.com"
Remove-PSSession $Session
