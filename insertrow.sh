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
			echo -e "$colName($colType)$colKey = \c"
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
			echo -e "$colName($colType)$colKey = \c"
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
			echo -e "$colName($colType)$colKey = \c"
			read data
		fi
	done 
	
	fi
}
validateprimarykeyvalue() {
if [[ $colKey == "Pk" ]]; 
then
      while [[ true ]]; 
	  do
        if [[ $data =~ ^[`awk 'BEGIN{FS="|"}
		{if(NR != 1)print $(('$i'))}' ~/dbstorage/$dbname/database/$tbname`]$ ]]; 
		then
		
          echo -e "Primary Key should be unique value!!"
        else
          break;
        fi
        echo -e "$colName ($colType) = \c"
        read data
		validatetype
      done
fi
}
insertrow() {
checkname "table"
	#if return is 0 (validname)
	if [[ $? == 0 ]]
	then 
		tbname=$name
		#if table name not exist as directory
		#lsa tb3n hna elpath
		if [[ ! -f ~/dbstorage/$dbname/metadata/$tbname ]] || [[ ! -f ~/dbstorage/$dbname/database/$tbname ]]
		then
			echo "this table isn't exist"
		else
            colNum=`awk 'END{print NR}' ~/dbstorage/$dbname/metadata/$tbname`
		
			for (( i = 1; i <= $colNum; i++ )); 
			do
				colName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' ~/dbstorage/$dbname/metadata/$tbname)
				colType=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' ~/dbstorage/$dbname/metadata/$tbname)
				colKey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' ~/dbstorage/$dbname/metadata/$tbname)
				echo -e "$colName($colType)$colKey = \c"
				read data
				if [ ! -z $data ]
				then 
					validatetype
					if [ $? -eq 0 ] 
					then
						validateprimarykeyvalue
						if [ $? -eq 0 ]
						then
						#to diffrentiate betweem last col and other rows
							if [[ $i -eq "1" ]]
							then
								inserteddata="\n"$inserteddata$data"|"
							else
								inserteddata=$inserteddata$data"|"
							fi
						fi
					fi
				else 
					echo "can't be empty ! "
				fi
				
				if [ ! -z $inserteddata ]
				then
				echo -e $inserteddata"\c" >> ~/dbstorage/$dbname/database/$tbname
				inserteddata=""
				fi
				#printf $inserteddata;
				
			done
		fi
	fi
}


insertrow
