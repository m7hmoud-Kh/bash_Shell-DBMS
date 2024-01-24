#!/bin/bash
read -p "Enter name table" table
read -p "Enter number of field" field
read -p "enter value match to delete " value
#awk -v vfield="$feild" -v vvalue="$value" '{ if($vfield == vvalue) print " " }' "$table"
                                                                                                                                                           شرط 
awk -v vfield="$field" -v vvalue="$value" '$vfield != vvalue' "$table" > temp_file && mv temp_file "$table"
echo delete row success

