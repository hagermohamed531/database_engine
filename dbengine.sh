#!/bin/bash
#main menu
clear

echo "			*****************************************	"			
echo '			* welcome to DBMS engine		*	'
echo "			*****************************************	"
echo "  "

echo "			 _______________________________________ "
echo "			|					|"
echo "			|	1-create database		|"
echo "			|	2-use database 			|"
echo "			|	3-show database			|" 
echo "			|	4-delete database		|"
echo "			|	5-exit				|"
echo "			|_______________________________________|"

echo "        "
echo "please enter your choice from 1 to 5	"
read choice  
if [ $choice -eq 1 ]
then 
clear
createdb.sh
exit
elif [ $choice -eq 2 ]
then 
clear
usedb.sh
exit
exit
elif [ $choice -eq 3 ]
then 
clear
showdb.sh
elif [ $choice -eq 4 ]
then 
echo delete
elif [ $choice -eq 5 ]
then 
exit
else
dbengine.sh
fi


