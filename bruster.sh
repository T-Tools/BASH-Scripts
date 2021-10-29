#!/data/data/com.termux/files/usr/bin/bash
multi () {
if [[ -e $2 && -e $3 ]];then                               while IFS= read -r sites ;do
while ISF= read -r paths ;do
url="$sites/$paths"
echo -e "\e[1;33mChecking -> $url\e[0m"
echo -ne "\e[1;32mStatus :"
status_code=$(curl -Iks -A "Chrom" -L $url | head -n 1 | awk '{ print $2 }')
if [[ $status_code != "404" ]];then
echo -ne "\e[1;32m Found [\e[1;35m $status_code \e[1;31m] \e[0m"
else
echo -ne "\e[1;31m Not Found [\e[1;35m $status_code \e[1;31m]\e[0m"
fi
echo -ne "\n"
done <$3
done <$2
else
echo -e "\e[1;33mPlease Run The Script As ./bruster.sh multi sites.txt dir.txt \e[0m"
fi
}
single () {
echo -e "\e[1;32m[\e[1;35m$(date | awk '{print $4}')\e[1;32m]\e[1;35m Target Site : \e[1;31m$1\e[0m"
if [[ $1 != "" && -e $2 ]];then
while ISF= read -r paths ;do
url="$1/$paths"
echo -e "\e[1;33mChecking -> $url\e[0m"
echo -ne "\e[1;32mStatus :"
status_code=$(curl -Iks -A "Chrom" -L $url | head -n 1 | awk '{ print $2 }')
if [[ $status_code != "404" ]];then
echo -ne "\e[1;32m Found [\e[1;35m $status_code \e[1;31m] \e[0m"
else
echo -ne "\e[1;31m Not Found [\e[1;35m $status_code \e[1;31m]\e[0m"
fi
echo -ne "\n"
done <$2
else
echo -e "\e[1;33mPlease Run The Script As ./bruster.sh example.com dir.txt\e[0m"
fi
}
start () {
if [[ $1 == "multi" ]];then
multi $1 $2 $3
else
single $1 $2
fi
}
bash banner.sh
echo -e "\e[1;31m
 ____                 _
|  _ \               | |
| |_) |_ __ _   _ ___| |_ ___ _ __
|  _ <|  __| | | / __| __/ _ \  __|
| |_) | |  | |_| \__ \ ||  __/ |
|____/|_|   \____|___/\__\___|_|

          \e[1;32mBy S0|0 3xpl0it3r


\e[0m"
if [[ $1 == "" && $2 == "" ]];then
echo -e "\e[1;33mPlease Run The Script As ./bruster.sh example.com dir.txt (or) ./bruster.sh multi sites.txt dir.txt \e[0m"
exit
else
start $1 $2 $3
fi
