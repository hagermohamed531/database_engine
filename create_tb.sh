#!/bin/bash
# enable extglob option
shopt -s extglob;
export LC_COLLATE=C


source checkname.sh

colcountcheck() {
#elflag 3lshan lw m3mlthosh awl ma ad5l invalid value hy5rg
let flag=1
while [ $flag -eq 1 ]
do
	echo "please insert the number of columns"
	read colcount
	if [[ -z "$colcount" ]]
	then
		echo "number of columns can't be empty value !"
		#msh m7tag return l2n kda kda lazm y5rg mn while loop
		#return 1
	elif [[ "$colcount" =~ ^[1-9][0-9]*$ ]]
	then
		#mkdir $tbname
		#echo the count is "$colcount"
		flag=0
		return 0
	else
		#3ayzen nb2a n5rgo bra 5ales hna lw zh2
		echo "please insert valid number !"
		#return 1
	fi
done

}

source datatype.sh
 

primarykeyfn() {
	select choice in "1-Primary key" "2-value"
	do
		case $REPLY in 
			1)pkey="Pk"
				flagpk=0
				break
				;;
			2)pkey=""
				break
				;;
			*)echo $REPLY is not one of the choices.
				;;
		esac
	done
}

primarynotexist() {

$(awk 'BEGIN{FS="|"} {print $3 > "resultfilepk" }' ~/dbstorage/$dbname/metadata/$tbname)
grep -q Pk resultfilepk
if [ $? -eq 0 ] ; 
then 
	rm resultfilepk;
else 
	rm resultfilepk;
	echo "you have to choose the value of primary key !";
		awk '
	BEGIN{FS="|"}
	{arr2[FNR]=FNR":"$1 ;}
	END{ 	
			for(i=1; i<=NR; i++)
			{
				print arr2[i] ;
			};	
	}' ~/dbstorage/$dbname/metadata/$tbname
flagpkexist=0
flagpke=0;
while [ "$flagpke" -eq 0 ] 

do
read -p "your choice ! " 
	if [[  "$REPLY" =~ [[:digit:]]+ ]]
	then
		if [[ "$REPLY" -gt "0" && "$REPLY" -le "$colcount" ]]  
		then
			PKrow="$REPLY";
			#echo $PKrow;
			#sed -i ""$PKrow"i Pk" $tbname/~/dbstorage/$dbname/metadata
			#add pk to end of line pkrow
			sed -i -e "${PKrow}s/$/Pk/" ~/dbstorage/$dbname/metadata/$tbname >> ~/dbstorage/$dbname/metadata/$tbname
			flagpke=1;
		else
			echo "you entered outboundry number";
		fi
	else
		echo "you entered invalid answer type";
	
	fi
done
fi
}


colcreation() {
	pkey=""
	flagpk=1
	colcountcheck
	if [[ $? == 0 ]]
	then
		i=1
		while [ $i -le $colcount ]
		do

			checkname "column no. $i"
			#colname=$name
			if [[ $? == 0 ]]
			then
				colname=$name
				
				datatype
				if [[ $? == 0 ]]
				then 
					colmtype=$coltype
					if [[ $? == 0 ]]
					then
						if [[ $flagpk == 1 ]]
						then
							primarykeyfn
						fi
					fi
				fi
				tbmetadata=$colname"|"$colmtype"|"$pkey
				tbheaderdata=$colname"|"
				pkey=""
			let i++
			fi
#to enter the valid values only and if not valid not entered empty value
			if [ ! -z $tbmetadata ]
			then
				echo -e $tbmetadata >> ~/dbstorage/$dbname/metadata/$tbname
				printf $tbheaderdata >> ~/dbstorage/$dbname/database/$tbname
				tbmetadata=""
				tbheaderdata=""
			fi
		done
#to add primary key at last if forget to add it 

		primarynotexist
		
	fi

}


tbcreation() {

		checkname "table"
			#if return is 0 (validname)
			if [[ $? == 0 ]]
			then 
				tbname=$name
				#if table name not exist as directory
				#lsa tb3n hna elpath
				if [ ! -f ~/dbstorage/$dbname/metadata/$tbname ]
				then
					#lw f3ln 7slo create kml w 2ol ao created
					#mkdir $tbname
					#touch $tbname/"~/dbstorage/$dbname/metadata"
					#touch $tbname/"database"
					#mkdir ~/dbstorage/$dbname/metadata database
					touch ~/dbstorage/$dbname/metadata/$tbname
					touch ~/dbstorage/$dbname/database/$tbname
					colcreation
					if [[ $? == 0 ]]
					then
						echo table "\"$tbname\"" created successfully..
usechoose.sh
				exit
					fi
				else
					echo "this table is already exist"
				usechoose.sh
				exit
				fi
			
fi
}

tbcreation
