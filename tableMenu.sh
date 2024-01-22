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
select action in "LIST" "DROP" "CREATE" "INSERT" "SELECT" "UPDATE" "DEELTE" 
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
	echo "Enter Table  Name"
	read tblName
	checkFoundOrNot
	if [ $? -eq 1 ]
	then
		numberOfField=$(awk -F' ' '{ if(NR == 1)  print NF }' $tblName)
		i=1
		valueArr=[ $numberOfField ]=''
		while [ $numberOfField -ge  $i ]
		do
			columnName=$(awk -F' ' '{ if(NR == 1) print  $'$i' }' $tblName)
			dataTypeField=$(awk -F' ' '{ if(NR == 2)  print  $'$i'  }' $tblName)
			echo "Enter Value of "$columnName
			read val
			if [ $dataTypeField == 'Int' ]
			then
				case $val in 
				*[0-9] )
					valueArr[ $i ]=$val
				;;
				*)
					echo "Error in data"
				esac
			else
				valueArr[ $i ]=$val
			fi
			let i=i+1
		done
		echo ${valueArr[@]} >> $tblName
	else
		echo "Table Not Found"
	fi 
	;;
	5)
	echo "Enter table Name"
	read tblName
	checkFoundOrNot
	if [ $? -eq 1 ]
	then
		set -x
		select choice in all basedColumn
		do
			case $REPLY in 
			1)
			awk -F' ' '{ if (NR >= 3) print $0  }' $tblName
			;;
			2)
			awk -F' ' '{for (i=1;i<=NF;i++) if ( NR == 1) print $i }' $tblName
			echo "Enter Filed Number"
			read filedNumber
			echo "Enter Value"
			read value
			awk -F' ' '{ if(NR >= 3 && $'$filedNumber'=="'"$value"'")  print $0}' $tblName
			;;
			*)
			echo "Option Not Found"
			esac
		done
	else
		echo "Table Not Found"
	fi
	;;
	*)
	echo "Not Found This Action"
	esac
done
