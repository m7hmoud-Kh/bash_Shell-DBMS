#!/bin/bash
PS3="Choose action from Menu "
function checkFoundOrNot {

	let foundName=0
        for table  in  `ls .` 
        do
          	if [ $table == $tblName ]
                then
                    	let foundName=1
                        break
                fi
        done
	return $foundName
}
cd $1/
echo "What is you want to do in $1"
select action in "LIST" "DROP" "CREATE" "INSERT" "SELECT" "UPDATE" "DELETE" 
do
	case $REPLY in
	1)
	ls . -l
	;;
	2)
	echo "Enter Table Name"
	read tblName
	checkFoundOrNot
	if [ $? -eq  1 ]
	then
		rm  $tblName
		echo "Table Droped Successfully"
	else
		echo "Table Not Found"
	fi
	;;
	3)
	echo "Enter New table Name"
	read tblName
	checkFoundOrNot
	if [ $? -eq  1 ]
	then
		echo "Table Already Exist"
	else
		touch $tblName
		echo "Table Created"
	fi
	echo "Enter Number of Feild"
	read fNumber
	let index=0
	columnName[ $fNumber ]=''
	dataTypeColumn[ $fNumber ]=''
	while [ $index -lt $fNumber ]
	do
		echo "Enter Column $index"
		read column
		columnName[ $index ]=$column
		echo "Enter Type of Column"
		select type in "String" "Int"
		do
			case $REPLY in 
			1)
			dataTypeColumn[ $index ]="String"
			break
			;;
			2)
			dataTypeColumn[ $index ]="Int"
			break
			;;
			*)
			echo "Please Choose Data Type"
			esac
		done
		let index=$index+1
	done
	echo ${columnName[@]} >> $tblName
	echo ${dataTypeColumn[@]} >> $tblName
	columnName=()
	dataTypeColumn=()
	;;
	4)
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
	6)
        read -p "Enter name table" table
        if [ -f $table ]
        then
	read -p "Enter number of field" field
	read -p "Enter old value" ovalue
	read -p "Enter new value " nvalue
	read -p "Enter number of field condtion" cfield
	read -p "Enter value of field condtion" vcvalue

	if ! [[ "$field" =~ ^[0-9]+$ ]] || ! [[ "$cfield" =~ ^[0-9]+$ ]]; then
	 echo "Field and condition field must be numeric."
	fi
	awk -v vfield="$field" -v vvalue="$ovalue" -v fieldcond="$cfield" -v valuecond="$vcvalue" -v newvalue="$nvalue" '{ 
		  if(($vfield == vvalue) && ($fieldcond == valuecond))
    			gsub(vvalue, newvalue); 
    				print $0;
	}' "$table" > temp_file && mv temp_file "$table"

	else
    	echo not found file
	fi
	;;
	7)
select action in "DELETE" "DELETE_ALL"
do
	case $REPLY in
	1)
        checkFoundOrNot
	if [ $? -eq 1 ]
	then
        read -p "Enter name table" table
        else
		echo "table Not Found"
	fi 
        read -p "Enter number of field" field
        read -p "enter value match to delete " value
                                                                                                                                                           
        awk -v vfield="$field" -v vvalue="$value" '$vfield != vvalue' "$table" > temp_file && mv temp_file "$table"
         echo delete row success
	;;
	2)
        read -p "Enter name table" table
        awk '{ if (NR < 3) print $0 }' "$table" > temp_file && mv temp_file "$table"
        echo delete $field row success
	;;
	*)
	echo "Not Found This Action"
	esac
done
	;;
	*)
	echo "Not Found This Action"
	esac
done
