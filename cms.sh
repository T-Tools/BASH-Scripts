#!/data/data/com.termux/files/usr/bin/bash
#CMS Detector
#Coded By CyberBullet
banner () {
bash banner.sh
echo -e "\e[1;34m
         ____ _  _ ____ ___  ____ ___ ____ ____ ___ ____ ____ 
         |    |\/| [__  |  \ |___  |  |___ |     |  |  | |__/ 
         |___ |  | ___] |__/ |___  |  |___ |___  |  |__| |  \ 

\e[1;33mAvailable Dectors : \e[1;31mWordPress, Joomla, Magento, Drupal

\e[0m"
}
detector () {
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
target () {
read -p $'\e[1;32mTarget Site : \e[0m' target
echo -ne "\e[1;36mDetecting : "
echo -ne "\e[1;33m$(detector)\e[0m"
echo
}
main () {
banner
target
}
main
