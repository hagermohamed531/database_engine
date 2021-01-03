#!/bin/bash
#show all databases 
clear 
#cd ~/dbstorage
echo ""
green=`tput setaf 4`
reset=`tput sgr0`
echo " ${green}press 8 :to exit${reset}"
echo " ${green}press 9 :main menu${reset}"
echo ""

echo "available database : "
echo " 					"
#read dbname
a=`ls ~/dbstorage`
echo "---------"
echo    "$a "
echo "---------"
echo ""
read choice
if [ $choice == 9 ]
then 
clear
dbengine.sh
elif [ $choice == 8 ]
then
exit
else 
showdb.sh

fi 
