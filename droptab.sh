#!/bin/bash
#1-remove data 
echo "please inter table name to delete :"
read tablename 
if [[ $tablename == 8 ]]
then
echo "bye"
exit

elif [[ $tablename == 9 ]]
then
dbengine.sh

elif [[ ! "$tablename" =~   ^[[:blank:]]*$ ]] 
then

cd ~/dbstorage/$dbname/database

if [ -f $tablename ]
then
rm $tablename
cd ~/dbstorage/$dbname/metadata
rm $tablename
echo "table dropped successfly"
else 
echo " '$tablename' unknown table "
droptab.sh
fi
usechoose.sh
else 
droptab.sh
fi


