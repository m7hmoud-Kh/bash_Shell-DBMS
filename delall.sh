#!/bin/bash
read -p "Enter name table" table
awk '{ if (NR < 3) print $0 }' "$table" > temp_file && mv temp_file "$table"


echo delete $field row success

