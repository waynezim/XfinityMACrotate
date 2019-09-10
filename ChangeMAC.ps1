$NetworkAdapterName = 'Wi-Fi 2'

[string] $MACAddress = '02' + [BitConverter]::ToString([BitConverter]::GetBytes((Get-Random -Maximum 0xFFFFFFFFFFFF)), 0, 5).Replace('-', '')

[int]$InterfaceIndex = (Get-NetAdapter | Where-Object Name -eq $NetworkAdapterName).InterfaceIndex

[string]$InterfaceIndexReg = "{0:d4}" -f ($InterfaceIndex-1)

Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\$InterfaceIndexReg" -Name 'NetworkAddress'

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\$InterfaceIndexReg" -Name 'NetworkAddress' -Value $MACAddress -Force

Get-NetAdapter -Name $NetworkAdapterName | Restart-NetAdapter

Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\$InterfaceIndexReg" -Name 'NetworkAddress'

netsh wlan connect name='xfinitywifi'

while ((Get-NetIPAddress -InterfaceIndex $InterfaceIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object IPAddress -ne 127.0.0.1).SuffixOrigin -ne 'Dhcp') {sleep -Milliseconds 100}

$test = 0
do {
    $gateway = (Get-NetRoute | Where-Object RouteMetric -eq 0).nexthop

    if($null -ne $gateway)
    {
        if(Test-Connection $gateway -Quiet -Count 1 -ErrorAction SilentlyContinue)
        {
            $test++
        }
    }
    else 
    {
        Start-Sleep -Milliseconds 100
    }
}While ($test -lt 2)

. .\NewWifiPass.ps1