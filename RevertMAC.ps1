. .\Config.ps1

[int]$InterfaceIndex = (Get-NetAdapter | Where-Object Name -eq $NetworkAdapterName).InterfaceIndex

[string]$InterfaceIndexReg = "{0:d4}" -f ($InterfaceIndex-1)

Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\$InterfaceIndexReg" -Name 'NetworkAddress' -Force