#
# WinPrintTraffic
#
# Print Network RX/TX traffic in Mbps based on windows Get-NetAdapterStatistics cmdlet delta
#
##################################################################################################################################################
#                                                                                                                                                #
# BIG DISCLAMER:                                                                                                                                 #
#                                                                                                                                                #
# This script provide innacurate data, since it'ss calculated based on a delta traffic that windows provide, that is refreshed on each seccond.  #
# Use this script only for test purpouse.                                                                                                        #
#                                                                                                                                                #
##################################################################################################################################################
#
# This script requires:
# - windows 10
# - powershell 5.1
# - powershell NetAdapter module
#
# Author:   Breno Cesar
# github:   github.com/brenocrs
# linkedin: linkedin.com/in/brenocesar/
#
# Base articles and documentation
#  https://devops-collective-inc.gitbook.io/windows-powershell-networking-guide/getting-network-statistics
#  https://devblogs.microsoft.com/scripting/powertip-formatting-numeric-output-using-powershell/
#  https://docs.microsoft.com/en-us/powershell/module/netadapter/get-netadapterstatistics?view=win10-ps
#
##################################################################################################################################################
#
# MAIN
#
# Setting initial Variables
$LAST_RX = "0"
$LAST_TX = "0"
$ACTUAL_RX = "0"
$ACTUAL_TX = "0"
$FIRST = "True"
# Getting the netwirk interfaces on windows
$ADAPTER = (Get-NetAdapter | Select-Object @('InterfaceDescription','ifIndex'))
# Printing the network interfaces
$ADAPTER | Format-Table | Write-Output
# Prompting for user to select the networ interfaces
$NETWORK_CARD = (Read-Host -Prompt "Input the ifIndex for monitoring ")
# Getting the selected network interface description
$NETWORK_CARD_DESCRIPTION = (Get-NetAdapter -ifIndex $NETWORK_CARD | select-object -exp InterfaceDescription)
# Looping the process
while($true)
{
	# Getting the Actual TX/RX traffic rate and converting from Bytes to bit
	$ACTUAL_RX = ((Get-NetAdapter -ifIndex $NETWORK_CARD | Get-NetAdapterStatistics | select-object -exp ReceivedBytes)*8)/1MB
	$ACTUAL_TX = ((Get-NetAdapter -ifIndex $NETWORK_CARD | Get-NetAdapterStatistics | select-object -exp SentBytes)*8)/1MB
    # Calculating the traffic Delta to print
	$PRINTRXBITS = $ACTUAL_RX - $LAST_RX
	$PRINTTXBITS = $ACTUAL_TX - $LAST_TX
	# IF statement, if is the first RUN, print empty, if not print the delta calculation
	if ($FIRST -eq "True"){
		Write-Output "$($NETWORK_CARD_DESCRIPTION) -> RX: 0 Mbps RX: 0 Mbps"
		}
		else {
			Write-Output "$($NETWORK_CARD_DESCRIPTION) -> RX: $("{0:n2}" -f $PRINTRXBITS) Mbps TX:$("{0:n2}" -f $PRINTTXBITS) Mbps" | Format-Table	
			}
	# Setting the last TX/RX traffic for the next delta calculation 
	$LAST_RX = $ACTUAL_RX
	$LAST_TX = $ACTUAL_TX
	# Setting the Next run as false
	$FIRST = "False"
	sleep 0.7
}