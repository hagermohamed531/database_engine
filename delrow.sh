#!/bin/bash
echo  "please enter Column name"
read col 
export col 
if [ $col == 8 ]
then 
exit
elif [ $col == 9 ]
then 
dbengine.sh
fi
colname=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col'") print i}}}' $tablename )
if [[ "$colname" == "" ]]
then
echo "column not exist"
delrow.sh  

else
echo -e "please enter field value "
read colvalue
export  colvalue

if [ $colvalue == 8 ]
then 
exit
elif [ $colvalue == 9 ]
then 
dbengine.sh
fi
value=$(awk 'BEGIN{FS="|"}{if ($'$colname'=="'$colvalue'") print $'$colname'}' $tablename  2>>./.error.log)
if [[ "$value" == "" ]]
then
echo "value not exist"
delrow.sh   
else
NR=$(awk 'BEGIN{FS="|"}{if ($'$colname'=="'$colvalue'") print NR}' $tablename  2>>./.error.log)
sed -i ''$NR'd' $tablename  2>>./.error.log
echo "row deleted "
usechoose.sh
fi
fi

