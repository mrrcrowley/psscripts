<#
.SYNOPSIS 
Create accounts for new OfferPad employees
.DESCRIPTION 
This script will create software accounts for a new employee 
.NOTES   
Script requires gShell and AzureAd modules installed and loaded
gShell https://github.com/squid808/gShell
AzureAD https://docs.microsoft.com/en-us/powershell/azure/active-directory/install-adv2?view=azureadps-2.0
#>
Import-Module gShell
Import-Module AzureADPreview
#Script Variables
$Username = ''
$FirstName = ''
$LastName = ''
$DisplayName = ''
$Prompt = ''
$Password = ''


Write-Host "Welcome to the OfferPad New Employee script. This will create accounts for new Offerpad employee"
Write-Host "Please note this will not assign a Confluance account" -ForegroundColor "Red"
Pause
function UserInfo 
    {
        $Script:FirstName = Read-Host "Please enter user's first name"
        $Script:LastName = Read-Host "Please enter user's Last name "
        $Script:Username = "$($FirstName.ToLower()).$($LastName.ToLower())@offerpad.com"
        $Script:DisplayName = Read-Host 'Please enter the users display name'
        $script:Password = "$($FirstName.Substring(0,1))$($LastName.Substring(0,1).ToLower())$((Get-Date).Year)!!" 
        $Script:Title = Read-Host "Please enter job title"
        $script:Location = Read-Host "Please enter location"
        $script:Department = Read-Host "Please enter Department"
        Write-Host "Username will be " -NoNewline
        Write-Host "$($Username)" -ForegroundColor "Red"
        Write-Host "Display name will be " -NoNewline
        Write-Host "$($DisplayName)" -ForegroundColor "Red"
        Write-Host "Password will be " -NoNewline
        Write-Host "$($Password)" -ForegroundColor "Red"
    }
function Office 
    {

        $Prompt = Read-Host "Does this user need and office acccount? Enter y/n"
        if ($Prompt -like "y")
        {
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password= $Password
            Write-Host "Enter you're Office 365 account and password" 
            $UserCredential = Get-Credential
            Connect-AzureAD -Credential $UserCredential
            New-AzureADUser -DisplayName $DisplayName -GivenName $FirstName -SurName $LastName -UserPrincipalName $Username -JobTitle $Title -Department $Department -PhysicalDeliveryOfficeName $Location -UsageLocation US -PasswordProfile $PasswordProfile -MailNickName "$($FirstName.ToLower()).$($LastName.ToLower())" -AccountEnabled $true 
            Start-Sleep -Seconds 5
            $Prompt = Read-Host "Please Enter Exchange or Business"
            if ($Prompt -like "Exchange")
            {
                $license = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
                $license.SkuId = '4b9405b0-7788-4568-add1-99614e613b69'
                $AssignedLicenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
                $AssignedLicenses.AddLicenses = $license
                Set-AzureADUserLicense -ObjectId $Username -AssignedLicenses $AssignedLicenses

            }
            else 
            {
                $license = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
                $license.SkuId = 'f245ecc8-75af-4f8e-b61f-27d8114de5f3'
                $AssignedLicenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
                $AssignedLicenses.AddLicenses = $license
                Set-AzureADUserLicense -ObjectId $Username -AssignedLicenses $AssignedLicenses

            }
            Write-Host "Starting Sleep"
            Start-Sleep -Seconds 30
            #$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
            #Import-PSSession $Session
            #Add-DistributionGroupMember -Identity "Employees" -Member $Username
            #Remove-PSSession $Session
            
        }

    }

function Dropbox  {

    $Prompt = Read-Host "Does this user need and Dropbox? Enter y/n"
    if ($Prompt -like "y")
    {
        $URI = "https://api.dropboxapi.com/2/team/members/add"
        $Headers = @{ authorization = "Bearer eppMq3RFU7AAAAAAABSTPne7xVTBc5kOrOwQxbvjgL_sakMN4J0MQCjuGG3LIRpA" }
        $Body = @{
            "new_members" = @(@{  
                    "member_email" = $Username;
                    "member_given_name" = $FirstName;                        
                    "member_surname" = $LastName;
                    "send_welcome_email" = $true;
                    "role" =  @{".tag" = "member_only"}
               })        
            }
    Invoke-RestMethod -Method Post -Uri $URI -Headers $Headers -Body ($Body | ConvertTo-Json -Depth 8) -ContentType 'application/json'
    } 
    
}

function Gsuite  {
    
    $Prompt = Read-Host "Does this user need and G Suite? Enter y/n"
    if ($Prompt -like "y")
    {
        Set-gShellClientSecrets -ClientId "152790515054-npm4pi6blgr8po6go6ahas9dfanb2b90.apps.googleusercontent.com" -ClientSecret "mdlaGV49Uy2eMymgdXYEoke7"
        New-GAUser -UserName $Username -GivenName $FirstName -FamilyName $LastName -Password $Password -ChangePasswordAtNextLogin $true
    }

    
}

function Email {

     #Provide SendGrid user name, if you are using Microsoft azure you will find the same from the portal   
     $sendgridusername = "opadmin"
     #Enter the send grid password Note: this is not recommended for production. In production, the password should be encrypted
     $SecurePassword=ConvertTo-SecureString '0ff3rP@d' -asplaintext -Force
     $cred = New-Object System.Management.Automation.PsCredential($sendgridusername,$SecurePassword)
     $sub="Welcome to Offerpad"
     $From = "itrequest@offerpad.com"
     $To = $Username
     $body= '<p>Hello New Team Member,</p><p>We are excited to welcome you to OfferPad!</p><p>At OfferPad, we care about giving our employees everything they need to perform their best. We have prepared your workstation with all necessary equipment, and someone from our team will also be by to help you to setup your computer, software and online accounts if you&rsquo;re having trouble.</p><p>We&rsquo;ve also taken the liberty of providing you with a few links to pages of interest on our company wiki.</p><ul><li>OfferPad Wiki Homepage &ndash; <a href="http://offerpad.atlassian.net/">Here</a><ul><li>Here you will find:<ul><li>OfferPad Employee Contact List &ndash; <a href="https://offerpad.atlassian.net/wiki/spaces/IT/pages/272942/The+Employee+Phone+List">Here</a></li><li>IT Department Homepage &ndash; <a href="https://offerpad.atlassian.net/wiki/spaces/IT/overview">Here</a></li><li>HR Homepage &ndash; ereHHHHadfaweasedfaswef<a href="https://offerpad.atlassian.net/wiki/spaces/TAL/overview">Here</a></li><li>Password Best Practices &ndash; <a href="https://offerpad.atlassian.net/wiki/spaces/IT/pages/1182716/A+Guide+to+Strong+Easy-to-Remember+Passwords">Here</a></li><li>Signature Requirements &ndash; <a href="https://offerpad.atlassian.net/wiki/spaces/IT/pages/624782/How+To+Create+an+Email+Signature">Here</a></li><li>Adding A Printer - <a href="https://offerpad.atlassian.net/wiki/spaces/IT/pages/396938/Adding+A+New+Printer">Here</a></li></ul></li><li>Webmail &ndash; <a href="http://portal.office.com/">Here</a></li><li>How to Get IT help &ndash; Please email <a href="mailto:itrequest@offerpad.com">itrequest@offerpad.com</a></li></ul></li></ul><p>If you have any questions, please feel free to send us an email and we&rsquo;ll be more than happy to help you.</p><p>We are looking forward to working with you and seeing you achieve great things!</p><p>Best regards,</p><p>OfferPad IT Dept.</p><ol><li>480-562-1041</li><li><a href="mailto:itrequest@offerpad.com">itrequest@offerpad.com</a></li></ol>'
     Send-MailMessage -From $From -To $To -Subject $sub -Body $body -Priority High -SmtpServer "smtp.sendgrid.net" -Credential $cred -UseSsl -Port 587 -BodyAsHtml

    
}


UserInfo

Pause
Office
Dropbox
Gsuite
Email

Write-Host "Done creating accounts. You will need to add them to distro groups, assign Platform, and Confluance"
$Urls = "https://admin.offerpad.com/users","https://offerpad.atlassian.net/admin/users"
ForEach ($Url in $Urls)
{
    Start-Process -FilePath chrome.exe -ArgumentList $Url  
} 

