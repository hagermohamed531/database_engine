#!/bin/bash

cd ~/dbstorage/$dbname/database
echo "please enter table name"
read tablename
if [[ $tablename == 8 ]]
then
echo "bye"
exit

elif [[ $tablename == 9 ]]
then
dbengine.sh

elif [[ ! "$tablename" =~   ^[[:punct:]]*$ ]] 
then
if [ -f $tablename ]
then
echo ""
echo "**data in "$tablename" "
cat $tablename
echo ""
echo ""
#fi
else 
echo " '$tablename' unknown table "
tabdata.sh
exit
fi
usechoose.sh
else 
tabdata.sh
fi





