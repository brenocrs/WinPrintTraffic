# WinPrintTraffic
Print Network RX/TX traffic based on windows Get-NetAdapterStatistics cmdlet delta.

# BIG DISCLAIMER
This script provide innacurate data, since it's a delta traffic that windows provide, that is refreshed on each seccond.  #
Use this script only for test purpouse.

# Instalation

 - Download the file `WinPrintTraffic.ps1` on your "Documents" directory
 - Make shure that your system fullfil the requirements bellow:
  - windows 10
  - powershell 5.1
  - powershell NetAdapter module

# Utilization

Open the powershell terminal, and navigate to the "Documents" directory, where you save your file, and execute as bellow:
```
PS C:\Users\My_User\Documents> .\WinPrintTraffic.ps1
```

Firts it will prompt to the user for selecting the network interface:

```
PS C:\Users\My_User\Documents> .\WinPrintTraffic.ps1

InterfaceDescription                                                             ifIndex
--------------------                                                             -------
VirtualBox Host-Only Ethernet Adapter                                                 17
Intel(R) Ethernet Connection (6) I219-LM                                              12
Hyper-V Virtual Ethernet Adapter                                                      62
Intel(R) Wireless-AC 9560 160MHz                                                       6


Input the ifIndex for monitoring : 
```

Once the `ifIndex` is selected, the script will get the RX/TX traffic from `Get-NetAdapterStatistics`, convert to bits, calculate the delta and print that information:
```
PS C:\Users\My_User\Documents> .\WinPrintTraffic.ps1

InterfaceDescription                                                             ifIndex
--------------------                                                             -------
VirtualBox Host-Only Ethernet Adapter                                                 17
Intel(R) Ethernet Connection (6) I219-LM                                              12
Hyper-V Virtual Ethernet Adapter                                                      62
Intel(R) Wireless-AC 9560 160MHz                                                       6


Input the ifIndex for monitoring : 12
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0 Mbps RX: 0 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 157,42 Mbps TX:2,91 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 262,84 Mbps TX:3,95 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 259,15 Mbps TX:4,33 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 270,53 Mbps TX:4,45 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 274,51 Mbps TX:4,69 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 268,17 Mbps TX:4,41 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 270,88 Mbps TX:4,43 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 254,70 Mbps TX:4,11 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 48,25 Mbps TX:0,47 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,17 Mbps TX:9,29 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,57 Mbps TX:19,20 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,72 Mbps TX:24,65 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,61 Mbps TX:23,84 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,59 Mbps TX:24,25 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,55 Mbps TX:25,07 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,56 Mbps TX:24,54 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,54 Mbps TX:24,09 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,57 Mbps TX:25,23 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,29 Mbps TX:12,88 Mbps
Intel(R) Ethernet Connection (6) I219-LM -> RX: 0,06 Mbps TX:0,05 Mbps
```
The script will only stop if the user prompt `CTRL+C`.

