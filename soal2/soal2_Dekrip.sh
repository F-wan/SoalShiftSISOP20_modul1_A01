#!/bin/bash 


time=$(date -r $1.txt "+%H")
echo $time

lama=$1
echo $lama
n=$time
echo $n 
 for (( n=1 ; $n<=$time; n++ ))
	do
		baru=$(echo $lama | tr '[B-ZAb-za]' '[A-Za-z]')
		lama=$baru
	done
lama=$1
echo $baru
mv $lama.txt $baru.txt


