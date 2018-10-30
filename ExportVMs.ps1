$Path = (get-date).ToString('M-d-y')
$VMs = "DC1"
Export-VM -Name $VMs -Path $Path