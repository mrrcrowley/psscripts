$FullNameAdmin = 'OP Admin'
$NameAdmin = 'OPAdmin'
$PasswordAdmin = ConvertTo-SecureString 'D0ntBr3@kth3N3tw0rk#' -AsPlainText -Force

## Add OP admin to Administrator Group
New-LocalUser -Name $NameAdmin -Password $PasswordAdmin -FullName $FullNameAdmin
Add-LocalGroupMember -Group "Administrators" -Member $NameAdmin  
Write-Host = 'OP Admin Created'



