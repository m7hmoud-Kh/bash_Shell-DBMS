#!/bin/bash
let found=1
for dir in `ls .`
do 
	if [ $dir == 'DB'  ]
	then
		found=0
		break
	fi
done
if [ $found -eq  1 ]
then
	mkdir DB
fi
source ./dataBaseMenu.sh

