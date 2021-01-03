#!/bin/bash
#use database
clear
green=`tput setaf 4`
reset=`tput sgr0`
echo " ${green}press 8 :to exit${reset}"
echo " ${green}press 9 :main menu${reset}"
#goto database 
cd ~/dbstorage
echo " " 						        

echo "**please enter database name to use  : "

read dbname
export dbname
clear
if [[ ! "$dbname" =~   ^[[:punct:]]*$ ]] 
then 
if [ $dbname == 9 ]
then 
clear
dbengine.sh
elif [ $dbname == 8 ]
then
echo bye
exit
else

 dboption.sh
exit
fi
else
usedb.sh
fi
