#!/bin/bash
#
clear
green=`tput setaf 4`
reset=`tput sgr0`
echo " ${green}press 8 :to exit${reset}"
echo " ${green}press 9 :main menu${reset}"
#
if [ -d  ~/dbstorage/$dbname ]
then
cd ~/dbstorage/$dbname

echo "**you are in '$dbname' database " 
echo ""
echo " 		1-show table data "
echo " 		2-drop table"
echo " 		3-create table "
echo "		4-update table "
echo " 		5-insert a record into table "
echo " 		6-delete a record from table "
echo " 		7-show tables "in" "$dbname" database"
echo ""
echo "**please enter your choice : "
read choice 

if [ $choice == 9 ]
then 
dbengine.sh
elif [ $choice = 8 ]
then 
echo bye
exit
elif [ $choice == 7 ]
then
echo "**tables in "$dbname" are: "
y=`ls  ~/dbstorage/$dbname/database`
echo "$y" 
usechoose.sh
#####################
elif [ $choice == 1 ]
then 
tabdata.sh
#####################
#Drop table 
elif [ $choice == 2 ]
then 
droptab.sh
#####################
elif [ $choice == 3 ]
then 
create_tb.sh
#####################
elif [ $choice == 4 ]
then 
updaterow.sh
#####################
elif [ $choice == 5 ]
then 
insertrow.sh
#####################
elif [ $choice == 6 ]
then
entable.sh
exit
#####################
else 
dboption.sh
fi
#############################
else
echo ""
echo "error :'$dbname' database not exist  "
echo ">>press y : to try again  "
read choice 
if [  $choice == y ]
then 
usedb.sh
elif [ $choice == 9 ]
then 
clear
dbengine.sh
elif [ $choice == 8 ]
then
exit
else 
usedb.sh
fi
fi 
