$NetworkAdapterName = Get-NetAdapter | Where-Object Name -like '*Wi-Fi*' | Select-Object -expand Name

$InterfaceName = (Get-NetAdapter | Where-Object Name -eq $NetworkAdapterName).InterfaceDescription

$List = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" -ErrorAction SilentlyContinue | Select-Object pspath

$AdapterRegPath = $List | Get-ItemProperty -Name DriverDesc -ErrorAction SilentlyContinue | Where-Object DriverDesc -eq $InterfaceName | Select-Object -expand pspath

if ($null -eq $AdapterRegPath){
    Throw "Failed to translate $NetworkAdapterName to DriverDesc in registry"
}

Remove-ItemProperty -Path $AdapterRegPath -Name 'NetworkAddress' -Force