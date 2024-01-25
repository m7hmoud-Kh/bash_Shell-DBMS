#!/bin/bash
PS3="Choose action from Menu "


select choice in "CREATE" "CONNECT" "LIST" "DROP" "Exit"
do
   case $REPLY in

1)

   read -p "name database:" database 
if [ -d  $database ]
   then
   echo "already created" 
else
   mkdir $database
#  cd $database
#touch DDL.sh
# cp ../../DDL.sh ./DDL.sh  

   echo $database create success 
fi
;;
2) 
  lsdatabas=`ls`
   read -p "enter name database use:" usedatabase 
if [ -d  $usedatabase  ]
   then
   source ../tableMenu.sh $usedatabase
   cd $usedatabase
   echo use $usedatabase database
    name=$usedatabase
else
   echo "   $usedatabase no found database" 
   ls
fi
;;
3) ls
;;
4) ls 
   read -p "enter name database drop:" dropdatabase 
if [ -d $dropdatabase ]
   then
   rm -r $dropdatabase
   echo drop success
else
    echo not found database
fi
;;
5)
exit
;;
*) echo  $REPLY unknown choices.
;;
esac
done

