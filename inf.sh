#!/bin/bash
# enable extglob option
shopt -s extglob;
export LC_COLLATE=C

source checkname.sh

deletedb() {
checkname "database"
	if [[ $? == 0 ]]
	then 
		dbdelname=$name
        if [[ -d ~/dbstorage/$dbdelname ]]
        then
        rm -R  ~/dbstorage/$dbdelname
        echo Database $dbdelname Was Deleted Successfuly ..
        else
            echo "this database doesn't exist"
        fi
    fi


}

deletedb