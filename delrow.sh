#!/bin/bash

echo  "please enter Column name"
read field 
export field 
if [ $field == 8 ]
then 
exit
elif [ $field == 9 ]
then 
dbengine.sh
fi
fieldname=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tablename )
if [[ "$fieldname" == "" ]]
then
echo "column not exist"
delrow.sh  

else
echo -e "please enter field value "
read fieldvalue
export  fieldvalue

if [ $fieldvalue == 8 ]
then 
exit
elif [ $fieldvalue == 9 ]
then 
dbengine.sh
fi
value=$(awk 'BEGIN{FS="|"}{if ($'$fieldname'=="'$fieldvalue'") print $'$fieldname'}' $tablename  2>>./.error.log)
if [[ "$value" == "" ]]
then
echo "value not exist"
delrow.sh   
else
NR=$(awk 'BEGIN{FS="|"}{if ($'$fieldname'=="'$fieldvalue'") print NR}' $tablename  2>>./.error.log)
sed -i ''$NR'd' $tablename  2>>./.error.log
echo "row deleted "
usechoose.sh
fi
fi

