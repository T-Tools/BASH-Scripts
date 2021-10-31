#!/data/data/com.termux/files/usr/bin/bash
#Basic Port Scanner
#Coded By CyberBullet
n=0
total () {
if [[ $n -gt 0 ]];then
echo -e "\e[1;33m$n Ports are opened\e[0m"
else
echo -e "\e[1;31mNo port are opened\e[0m"
fi
}
scan () {
read -p $'\e[1;34mRange(From) : ' from
read -p $'\e[1;34mRage(To) : ' to
if [[ $to -gt $from ]];then
echo -e "\e[1;33mScanning Ports On $1 From $from To $to\e[0m"
for port in $( eval  echo {$from..$to} );do
(echo > /dev/tcp/$1/$port) > /dev/null 2>&1 && { echo -e "\e[1;32m$port \e[1;33mOpened\e[0m"; n=$(( $n+1 )); }
done
total
else
echo -e "\e[1;35mPort range you provided is invalid\e[0m"
exit
fi
}
check () {
byte=$(ping -c 1 $1 | grep byte | wc -l)
if [[ $byte -gt 0 ]];then
echo -e "\e[1;32mHost Is Up\e[0m"
scan $1
else
echo -e "\e[1;31mHost is down\e[0m"
fi
}
main () {
bash banner.sh
check $1
}
if [[ $1 == "" ]];then
echo -e "\e[1;33mPlease Run The Script As bash port-scan.sh ip\e[0m"
exit
else
main $1
fi
