#!/bin/bash

while true; do 
	kode=$(head /dev/urandom | tr -dc A-Za-z0-9 | fold -w 28 | head -n 1)
	read -r -p "Nama file = " file
	if [[ ($file =~ [0-9]) || ($file == *['!'@#\$%^\&*()_+]*) ]];then 
		echo "Only Alphabet Input"
		break
	else 
		filetx="$file.txt"
		echo "$kode" > "$file"
		break
	fi
done 
