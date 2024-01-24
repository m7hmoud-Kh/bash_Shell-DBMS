#!/bin/bash
read -p "Enter name table" table
read -p "Enter number of field" field
read -p "enter old value" ovalue
read -p "enter new value " nvalue
read -p "Enter number of field condtion" cfield
read -p "Enter value of field condtion" vcvalue
#read -p "enter value match to delete " value
#awk -v vfield="$feild" -v vvalue="$value" '{ if($vfield == vvalue) print " " }' "$table"
#awk -v vfield="$field" -v vvalue="$value" '$vfield != vvalue' "$table" > temp_file && mv temp_file "$table"
echo update row success

