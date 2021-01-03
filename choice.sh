#!/bin/bash

#echo ">>>please enter your choice "
read choice 
if [ $choice -eq 9 ]
then 
clear
dbengine.sh
elif [ $choice -eq 8 ]
then
echo bye
exit

else 
dbengine.sh
fi

