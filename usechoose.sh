#/bin/bash

echo "do you want to reuse to "$dbname" database ? y/n?"
read choice 


if [[ ! "$choice" =~   ^[[:punct:]]*$ ]] 
then
if [ $choice == 8 ]
then
exit 
elif [ $choice == 9 ]
then
dbengine.sh


elif [ $choice == y ]
then 
dboption.sh
elif [ $choice == n ]
then 
dbengine.sh
else 
usechoose.sh
fi
else 
usechoose.sh

fi

