$hostname = $env:COMPUTERNAME
$gateway = "192.168.1.1"
$dns = "192.168.1.1"

$ipMap = @{
    "ws2016-01" = "192.168.1.10"
    "ws2016-02" = "192.168.1.11"
    "ws2016-03" = "192.168.1.12"
    "ws2016-04" = "192.168.1.13"
    "ws2016-05" = "192.168.1.14"
    "ws2016-06" = "192.168.1.15"
    "ws2016-07" = "192.168.1.16"
    "ws2016-08" = "192.168.1.17"
    "ws2016-09" = "192.168.1.18"
    "ws2016-10" = "192.168.1.19"
    "ws2016-11" = "192.168.1.20"
    "ws2016-12" = "192.168.1.21"
    "ws2016-13" = "192.168.1.22"
    "ws2016-14" = "192.168.1.23"
    "ws2016-15" = "192.168.1.24"
}

if ($ipMap.ContainsKey($hostname)) {
    $ip = $ipMap[$hostname]
    $adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
    New-NetIPAddress -InterfaceAlias $adapter.Name -IPAddress $ip -PrefixLength 24 -DefaultGateway $gateway
    Set-DnsClientServerAddress -InterfaceAlias $adapter.Name -ServerAddresses $dns
    Unregister-ScheduledTask -TaskName "StartupConfig" -Confirm:$false
}
