#!/bin/bash
PS3="Choose action from Menu "
function checkFoundOrNot {

	let foundName=0
        for dir in  `ls .` 
        do
          	if [ $dir == $dbName ]
                then
                    	let foundName=1
                        break
                fi
        done
	return $foundName
}
cd DB/
echo "What is you want to do in DB"
select action in "CREATE" "LIST" "DROP" "CONNECT"
do
	case $REPLY in
	1)
	echo "Enter database Name"
	read dbName
	checkFoundOrNot
	if [ $? -eq  1 ]
	then
		echo "Database Already Exist"
	else
		mkdir $dbName
                echo "Database Created Successfully"
	fi
	;;
	2)
	ls -l 
	;;
	3)
	echo "Enter Database Name"
	read dbName
	checkFoundOrNot
	if [ $? -eq 1 ]
	then
		rm -R $dbName
	else
		echo "Database Not Found"
	fi 
	;;
	4)
	echo "Enter Database Name"
	read dbName
	checkFoundOrNot
	if [ $? -eq 1 ]
	then
		source ../tableMenu.sh $dbName
	else
		echo "Database Not Found"
	fi
	;;
	*)
	echo "Not Found This Action"
	esac
done
