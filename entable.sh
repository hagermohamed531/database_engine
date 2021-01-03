#!/bin/bash
cd ~/dbstorage/$dbname/database
echo "please enter table name "
read tablename
export tablename
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
delrow.sh
exit 
else 
echo " '$tablename' unknown table "
entable.sh
fi

else 
entable.sh
fi


