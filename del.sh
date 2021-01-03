#!/bin/bash
# enable extglob option
shopt -s extglob;
export LC_COLLATE=C

source checkname.sh


validatetype() {
let flag=1
	if [[ $colType == "int" ]]
	then 
	while [ $flag -eq 1 ]
	do
		if [[ $data =~ ^[1-9][0-9]*$ ]]
		then 
			flag=0
			return 0
		else
			echo "please insert valid integer " 
			echo -e "$fieldName($colType)= \c"
			read data
		fi
	done	
	elif [[ $colType == "string" ]]
	then 
	while [ $flag -eq 1 ]
	do
		if [[ $data =~ ^[[:alpha:]]*$ ]]
		then 
			flag=0
			return 0
		else
			echo "please insert valid string " 
			echo -e "$fieldName($colType)= \c"
			read data
		fi
	done
	elif [[ $colType == "mixed" ]]	
	then 
	while [ $flag -eq 1 ]
	do
		if [[ $data =~ ^[[:alpha:]][[:alnum:]]*$ ]]
		then 
			flag=0
			return 0
		else
			echo "please insert valid string " 
			echo -e "$fieldName($colType)= \c"
			read data
		fi
	done 
	
	fi
}

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
            #echo $rowno
        #awk 'BEGIN{FS="|"}{if(NR != 1)print $(('$i'))}' ~/dbstorage/$dbname/database/$tbname 
        #awk -v lvar="$pkvalue" '$0~lvar {print NR-1}' ~/dbstorage/$dbname/database/$tbname
        else
            echo "this value doesn't exist ! "
            primarykeyvalue
        fi
        break;
    fi
done

}


checkfield() {
if [ -f choices ]
then
    rm choices
fi
#choices=$(awk 'BEGIN{FS="|"} NR == 1{for(i=1;i<NF;i++){print i":"$i}}' ~/dbstorage/$dbname/database/$tbname | sed -e "${fieldno}d" )
awk 'BEGIN{FS="|"} NR == 1{for(i=1;i<NF;i++){print i":"$i}}' ~/dbstorage/$dbname/database/$tbname | sed -e "${fieldno}d" >>choices
let flagdata=1;
while [ $flagdata -eq 1 ]
do
    #can't change primary key value
    echo -e "the name of the field you want to change :";
    read fieldName;
    if [ ! -z $fieldName ]
    then
    #echo | awk -v fName="$fieldName" -v awkvar="$choices" 'BEGIN{FS=":"}{ print awkvar; } ' | awk 'BEGIN{FS=":"}index($0, fName){print $i}'    
            read datacol <<< $(awk -v fName="$fieldName" 'BEGIN{FS=":"}{if ($2==fName){print $1}}' choices)
            if [[ ! -z $datacol ]]
            then
                #echo $datacol;
                flagdata=0;
                return 0;
            else
                echo "this Column not exist or it's primary key!"
                
            fi
       
    fi
    
done
rm choices
}



updaterow() {
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
            checkfield
            #changevalue
            if [[ $? == 0 ]]
            then 
                colType=$( awk -v fieldNamee="$fieldName" 'BEGIN{FS="|"}{if($1==fieldNamee) print $2}' ~/dbstorage/$dbname/metadata/$tbname)
                echo "insert the new value of $fieldName($colType) for row with pk $pkvalue"
             
              
                fi
            fi
            
		fi
    fi
}
updaterow
