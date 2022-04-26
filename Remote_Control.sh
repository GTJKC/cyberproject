#!/bin/bash

function inst()
{
#install relevant applications on the local computer
git clone https://github.com/htrgouvea/nipe.git && cd nipe
sudo cpan install Try::Tiny Config::Simple JSON
sudo perl nipe.pl install
apt install geoip-bin
sudo apt-get install nmap
sudo apt-get install whois
sudo apt-get install sshpass
}

function anon()
{
#check if the connection is from your original country
sudo updatedb
cd ~/nipe
sudo perl nipe.pl start
sudo perl nipe.pl restart
geoiplookup 89.234.157.254 
}

function vps()
{
#communicate via SSH and execute nmap scans and whois queries
#ssh into new terminal
#get input from the user: whois or nmap
sshpass -p cFcnrpr0ject ssh root@137.184.215.90 nmap 8.8.8.8
sshpass -p cFcnrpr0ject ssh root@137.184.215.90 whois 8.8.8.8
}

inst #run installation
anon #check anonymous
vps #connect and execute
