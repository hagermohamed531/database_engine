#!/bin/bash
# enable extglob option
shopt -s extglob;
export LC_COLLATE=C

source checkname.sh
primarykeyvalue() {
colNum=`awk 'END{print NR}' ~/dbstorage/$dbname/metadata/$tbname`
for (( i = 1; i <= $colNum; i++ )); 
do
    colName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' ~/dbstorage/$dbname/metadata/$tbname)
    colType=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' ~/dbstorage/$dbname/metadata/$tbname)
    colKey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' ~/dbstorage/$dbname/metadata/$tbname)
    if [[ $colKey == "Pk" ]]; 
    then
        pkName=$colName
        echo -e "enter the value of the primary key:$pkName :-"
        read pkvalue
        if [[ $pkvalue =~ ^[`awk 'BEGIN{FS="|"}
        {if(NR != 1)print $(('$i'))}' ~/dbstorage/$dbname/database/$tbname`]$ ]]; 
        then
            fieldno=$i
            rowno=$(awk 'BEGIN{FS="|"}{if(NR != 1)print $(('$i'))}' ~/dbstorage/$dbname/database/$tbname | awk -v lvar="$pkvalue" '$0~lvar {print NR}' ~/dbstorage/$dbname/database/$tbname)
           
        else
            echo "this value doesn't exist ! "
            primarykeyvalue
        fi
        break;
    fi
done

}

searchrow() {
checkname "database"
dbname=$name
if [[ $? == 0 ]]
then
    if [[ ! -d ~/dbstorage/$dbname ]] 
    then
        echo "this database doesn't exist"
    else
checkname "table"
	#if return is 0 (validname)
	if [[ $? == 0 ]]
	then 
		tbname=$name
		#if table name not exist as directory
		#lsa tb3n hna elpath
		if [[ ! -f ~/dbstorage/$dbname/metadata/$tbname ]] || [[ ! -f ~/dbstorage/$dbname/database/$tbname ]]
		then
			echo "this table doesn't exist"
        else
            primarykeyvalue
            
            echo "the row you choose is :"
            awk 'NR == 1{print $0}' ~/dbstorage/$dbname/database/$tbname
            awk -v VM="$rowno" 'NR == VM{print $0}' ~/dbstorage/$dbname/database/$tbname           
            
		fi
    fi
fi
fi
}
searchrow