#!/bin/bash
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



#awk -v vfield="$field" -v vvalue="$value" '$vfield != vvalue' "$table" > temp_file && mv temp_file "$table"
#echo update row success
#awk -v vfield="$field" -v vvalue="$ovalue" -v fieldcond=$cfield -v valuecond=$vcvalue '{ if(($vfield == vvalue) && ($fieldcond == vcvalue) ) print "fdfsd" }' "$table"
