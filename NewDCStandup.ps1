$MachineName = "DFWDC02"
$DeploymentScrtipt = c:\temp\DeploymentConfigTemplate.xml





function InstallDefaults
{
    Install-WindowsFeature –ConfigurationFilePath $DeploymentScrtipt
}
/#function ConfigureDHCP 
{
    $Prompt = Read-Host -Prompt "Is this the primary or secondary enter y/n?"
    if ($Prompt -eq "y") {Add-DhcpServerv4Scope -Name $DHCPScopeName -StartRange $DCHPScopeStart -EndRange $DCHPScopeEnd -SubnetMask 255.255.255.0}
    else { Add-DhcpServerv4Failover -ComputerName "dhcpserver.contoso.com" -Name "SFO-SIN-Failover" -PartnerServer "dhcpserver2.contoso.com" -ServerRole Standby -ScopeId 192.168.0.0}
}
#/


Rename-Computer -NewName $MachineName
New-NetLbfoTeam -Name 'Nic Team' -TeamMembers 'Nic1','Nic2'
& d:\sophos.exe --quiet
InstallDefaults