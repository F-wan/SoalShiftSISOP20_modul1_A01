#!/bin/bash

# a
for ((i=1; i<=28; i++))
do
  wget -a "wget.log" -O "pdkt_kusuma_$i" https://loremflickr.com/320/240/cat
done

# b
# 5 6-23/8 * * 0-5 cd /home/kaori02/SoalShiftSISOP20_modul1_F01/soal3/; bash soal3.sh