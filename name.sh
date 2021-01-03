#!/bin/bash
echo ">>>please enter name of database to create:  "
read dbname

if [ $dbname != 9 ] 
then 
if [ $dbname != 8 ]
then

if [[ ! "$dbname" =~   ^[[:alpha:]][[:alnum:]]*$ ]] 
then 

echo "                   "
echo "error : you can use small and upper letter and numbers with letter"

echo "	       and numbers with only letter"

echo "  "
name.sh 

else
if [ -d $dbname ]
then
echo "                   "
echo "error : the name '$dbname' already exists"
echo "  "
name.sh


else
mkdir -p ~/dbstorage/$dbname/database  ~/dbstorage/$dbname/metadata

echo "  "
echo " 			***database '$dbname' created successfully***"
choice.sh
fi
fi

else 
exit
fi
else 
dbengine.sh
fi

exit
