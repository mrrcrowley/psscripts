Import-Csv C:\Users\opadmin\Desktop\Test.csv | New-ADuser -PassThru | Set-ADAccountPassword -Reset -NewPassword (Read-host -AsSecureString "Account Password") -PassThru | Enable-ADAccount


