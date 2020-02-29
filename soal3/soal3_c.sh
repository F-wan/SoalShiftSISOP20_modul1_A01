#!/bin/bash
mkdir duplicate kenangan

grep "Location: " wget.log > location.log

awk '
{
  printf("%s %03d\n", $2, a + 1)
  a++
}' location.log | sort -g > test

awk '
{
  idx = $2 + 0
  if(loc == $1)
    call = "mv pdkt_kusuma_"idx " duplicate/duplicate_"idx
  else
  {
    loc = $1
    call = " mv pdkt_kusuma_"idx " kenangan/kenangan_"idx
  }
  system(call)
}' test

rm test

mv location.log location.log.bak
mv wget.log wget.log.bak
