#!/data/data/com.termux/files/usr/bin/bash
#Basic Web InFo Scanner
#Coded By CyberBullet
basic_scan_server () {
server=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep -i "server: " | awk '{ print $2 }')
if [[ $server == "" ]];then
echo "\e[1;31mCould Not Detected"
else
echo $server
fi
}
basic_scan_cflare () {
cloudflare=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep "cloudflare")
if [[ $cloudflare != "" ]];then
echo "Detected"
else
echo "\e[1;31mCould Not Detected"
fi
}
basic_scan_cookie () {
cookie=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep -i "set-cookie: " | awk '{ print $2 }')
if [[ $cookie == "" ]];then
echo "\e[1;31mFound No Cookie"
else
echo $cookie
fi
}
basic_scan_xssp () {
xssp=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep -i "x-xss-protection: " | awk '{ print $2 }')
if [[ $xssp == "" ]];then
echo "\e[1;31mCould Not Detected"
else
echo $xssp
fi
}
basic_scan_title () {
title=$(curl -ks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep -o '<title>.*</title>' | sed 's/\(<title>\|<\/title>\)//g')
if [[ $title == "" ]];then
echo "\e[1;31mCould Not Detected"
else
echo $title
fi
}
basic_scan_robot () {
robot=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/robots.txt | head -n 1 | awk '{ print $2 }')
if [[ $robot == "200" ]];then
echo "Found"
else
echo "\e[1;31mCould Not Found"
fi
}
basic_scan_cms () {
wp=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/wp-login.php)
wpt=$(curl -ks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/wp-login.php | grep "user_login")
if [[ $wp != "404" && $wpt != "" ]];then
echo "WordPress"
else
joom=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/media/com_joomlaupdate)
joomt=$(curl -ks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | grep "joomla")
if [[ $joom != "404" && $joomt != "" && $status_code == "200" ]];then
echo "Joomla"
else
mag=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/index.php/admin)
magjs=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/js/mage/cookies.js | head -n 1 | awk '{ print $2 }')
if [[ $mag == "200" || $magjs == "200" ]];then
echo "Magento"
else
drupal=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target/misc/drupal.js | head -n 1 | awk '{ print $2 }')
if [[ $drupal == "200" ]];then
echo "Drupal"
else
echo "Could Not Detected"
fi
fi
fi
fi
}
basic_scan () {
echo -e "\e[1;36mScan Type : \e[1;34mBasic Information Gathering\e[0m"
echo -e "\e[1;32mTarget Site : \e[1;33m$target\e[0m"
echo -e "\e[1;32mStatus Code : \e[1;33m$status_code\e[0m"
echo -e "\e[1;32mIp Address  : \e[1;33m$ip\e[0m"
echo -e "\e[1;32mWeb Server  : \e[1;33m$(basic_scan_server)\e[0m"
echo -e "\e[1;32mCloudFlare  : \e[1;33m$(basic_scan_cflare)\e[0m"
echo -e "\e[1;32mSet-Cookie  : \e[1;33m$(basic_scan_cookie)\e[0m"
echo -e "\e[1;32mXSS-Protection  : \e[1;33m$(basic_scan_xssp)\e[0m"
echo -e "\e[1;32mWeb Title   : \e[1;33m$(basic_scan_title)\e[0m"
echo -e "\e[1;32mRobot File   : \e[1;33m$(basic_scan_robot)\e[0m"
echo -e "\e[1;32mCMS Detect   : \e[1;33m$(basic_scan_cms)\e[0m"
echo ""
}
main () {
target=$1
ip=$(ping -c1 $(echo $target | awk -F/ '{ print $3 }') | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
status_code=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target | head -n 1 | awk '{ print $2 }')
bash banner.sh
basic_scan
}
if [[ $1 == "" ]];then
echo -e "\e[1;33mPlease Run The Script As bash basic-info.sh https://target.xom \e[0m"
exit
else
main $1
fi
