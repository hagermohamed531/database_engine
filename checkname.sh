#!/bin/bash
# enable extglob option
shopt -s extglob;
export LC_COLLATE=C

checkname() {
	echo "please enter the name of the "$1""
	read name
	if [ -z "$name" ]
	then
		echo "name cann't be empty !"
		return 1
	#include one or more + from pattern ~ but t.k till nw just in the middle#but mmkn ykon fe space fe elawl w ela5er !!
	#blanck is space and tab
	elif [[ "$name" =~ [[:blank:]]+ ]]
	then 
		echo "name cann't contains space !"
		return 1
	elif [[ "$name" = *"."* ]]
	then
		echo "name can't contains dot !"
		return 1
	elif [[ "$name" = *"/"* ]]
	then
		echo "name can't include slashes !"
		return 1
	#start with alpha then ani alphanumeric 
	#elmoshkla hna an la ynf3 yst5dm _ wla ay haga mn [:punct:] char
	elif [[ "$name" =~  ^[[:alpha:]][[:alnum:]]*$ ]]
	then 
		#echo "$1" "\"$name\"" created successfully..
		return 0
	else
		echo "you entered invalid value !"
		#recursion 
		checkname "table"
		#return 1
	fi


}
