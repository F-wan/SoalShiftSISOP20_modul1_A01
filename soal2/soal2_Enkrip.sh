#!/bin/bash 


time=$(date +"%H")
echo $time

lama=$1
n=$time
echo $n 
 for (( n=1 ; $n<=$time; n++ ))
	do
		baru=$(echo $lama | tr '[A-Za-z]' '[B-ZAb-za]')
		lama=$baru
	done
lama=$1

mv $lama.txt $baru.txt