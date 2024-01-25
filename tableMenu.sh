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
select action in "LIST" "DROP" "CREATE" "INSERT" "SELECT" "UPDATE" "DEELTE" "BackToDB"
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
	constraintColumn[ $fNumber ]=''
	echo "Frist Column Sould Be Primary Key"
	while [ $index -lt $fNumber ]
	do
		echo "Enter Column "$(($index+1))
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
		if [ $index -eq  0 ]
		then
		     constraintColumn[ $index ]="PK"
		else
		     constraintColumn[ $index ]="NotNull"
		fi
		let index=$index+1
	done
	echo ${columnName[@]} >> $tblName
	echo ${dataTypeColumn[@]} >> $tblName
	echo ${constraintColumn[@]} >> $tblName
	columnName=()
	dataTypeColumn=()
	constraintColumn=()
	;;
	4)
	allPkarr=()
	echo "Enter Table  Name"
	read tblName
	checkFoundOrNot
	if [ $? -eq 1 ]
	then
		numberOfField=$(awk -F' ' '{ if(NR == 1)  print NF }' $tblName)
		i=1
		valueArr=[ $numberOfField ]=''
		pkIndex=0
		for pk in `awk -F' ' '{print $1}' $tblName`
		do
			allPkarr[ $pkIndex ]=$pk
			let pkIndex=pkIndex+1
		done

		while [ $numberOfField -ge  $i ]
		do
			columnName=$(awk -F' ' '{ if(NR == 1) print  $'$i' }' $tblName)
			dataTypeField=$(awk -F' ' '{ if(NR == 2)  print  $'$i'  }' $tblName)
			echo "Enter Value Of "$columnName
			read val
			validated=0
			set -x
			if [ $dataTypeField == "Int" ]
			then
				while [ $validated -eq 0 ]
				do 
					flag=0
					if [ $i -eq 1 ]
		                      	then
	                      			for (( j=0 ; j < ${#allPkarr[@]} ; j++))
						do 
							if [[ $val == ${allPkarr[j]} ]]
							then	
								flag=1
								echo "primary key is already exist "
								echo "Enter Value Of "$columnName " Again"
								read val
								break
							fi
						done
					fi
					if ! [[  "$val" =~  ^[0-9]  ]]
					then
						echo "You Must Enter Int for  " $columnName
		                       		read val
		                       	elif [[ "$val" =~  ^[0-9] ]] && [ $flag -eq 0 ] 
 		                       	then
		                       		valueArr[ $i ]=$val
		                               	validated=1
					fi
				done
			fi 
			validated=0
			if [ $dataTypeField == "String" ]
			then
				while [ $validated -eq 0 ]
				do 
					flag=0
					if [ $i -eq 1 ]
		                      	then
	                      			for (( j=0 ; j < ${#allPkarr[@]} ; j++))
						do 
							if [[ $val == ${allPkarr[j]} ]]
							then	
								flag=1
								echo "primary key is already exist "
								echo "Enter Value Of "$columnName " Again"
								read val
								break
							fi
						done
					fi
					
					if ! [[  "$val" =~  ^[a-z]+  ]]
					then
						echo "You Must Enter String for  " $columnName
		                       		read val
		                       	elif [[ "$val" =~  ^[a-z]+ ]] && [ $flag -eq 0 ] 
 		                       	then
		                       		valueArr[ $i ]=$val
		                               	validated=1
					fi
				done
			fi
			let i=i+1
		done
		echo ${valueArr[@]} >> $tblName
		valueArr=()
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
		select choice in all basedColumn
		do
			case $REPLY in 
			1)
			awk -F' ' '{ if (NR > 3) print $0  }' $tblName
			;;
			2)
			awk -F' ' '{for (i=1;i<NF;i++) if ( NR == 1) print $i }' $tblName
			echo "Enter Filed Number"
			read filedNumber
			echo "Enter Value"
			read value
			awk -F' ' '{ if(NR > 3 && $'$filedNumber'=="'"$value"'")  print $0}' $tblName
			;;
			*)
			echo "Option Not Found"
			esac
		done
	else
		echo "Table Not Found"
	fi
	;;
	8)
	cd ../
	source ../dataBaseMenu.sh
	;;
	*)
	echo "Not Found This Action"
	esac
done
