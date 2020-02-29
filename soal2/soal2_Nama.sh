#!/bin/bash


while true; do  
	kode=$(head /dev/urandom | tr -dc A-Za-z0-9 | fold -w 3 | head -n 1)
	while [[ !($kode =~ [[:upper:]]) || !($kode =~ [[:lower:]]) || !($kode =~ [0-9]) ]]
		do 
		kode=$(head /dev/urandom | tr -dc A-Za-z0-9 | fold -w 3 | head -n 1)
	done
	read -r -p "Nama file = " file
	if [[ ($file =~ [0-9]) || ($file == *['!'@#\$%^\&*()_+]*) ]];then 
		echo "Only Alphabet Input"
		break
	else 
		filetx="$file.txt"
		echo "$kode" > "$file.txt"
		break
	fi
done 