$Username = 'q0127019'
$Password = 'Cl3@nF0und1!'
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$Session = New-SFTPSession -ComputerName "sftp.offerpad.com" -Credential $Credentials
$Items = Get-SFTPChildItem -SFTPSession $Session -Path "/Projects Shared With Me/Wells Fargo CC"
foreach ($item in $Items)
{
    Get-SFTPFile -SFTPSession $Session -RemoteFile $item.FullName -LocalPath Z:\www_root\oracle
}
$Date = Get-Date -f yyyy-MM-dd-mm-ss
$Docs = Get-ChildItem -Path z:\www_root\oracle -Recurse | ? {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}
$Test = 0
foreach ($Doc in $Docs) 
{
    copy-item -Path "z:\www_root\oracle\$Doc" -Destination "z:\Archive\CreditCards\$Date $Test.gpg" -Force
    $Test = $Test +1
}
#| Where-Object {$_.FullName -like "*gpg"}