#!/bin/bash

a=$(awk -F '\t' '
{
  if(NR > 1) profit[$13] += $NF;
}
END{
  maxprofit = 0

  for (i in profit) {
    if(profit[i] > maxprofit) maxprofit = profit[i];
  }

  minprofit = maxprofit
  for (i in profit) {
    if(profit[i] < minprofit) minprofit = profit[i];
  }

  for (i in profit) {
    if (profit[i] == minprofit) print i
  }
}' Sample-Superstore.tsv)

echo "A. region with minimum profit : "
echo "   "$a

b1=$(awk -v a="$a" -F '\t' '
{
  if(NR > 1 && $13 == a) profit[$11] += $NF;
}
END{
  maxprofit = 0

  for (i in profit) {
    if(profit[i] > maxprofit) maxprofit = profit[i];
  }

  minprofit = maxprofit

  for (i in profit) {
    if(profit[i] < minprofit) minprofit = profit[i];
  }

  for (i in profit) {
    if (profit[i] == minprofit) print i
  }
}' Sample-Superstore.tsv)

b2=$(awk -v a="$a" -v b1="$b1" -F '\t' '
{
  if(NR > 1 && $13 == a) profit[$11] += $NF;
}
END{
  maxprofit = 0

  for (i in profit) {
    if(profit[i] > maxprofit) maxprofit = profit[i];
  }

  minprofit = maxprofit

  for (i in profit) {
    if (i != b1)
      if(profit[i] < minprofit) minprofit = profit[i];
  }

  for (i in profit) {
    if (profit[i] == minprofit) print i
  }
}' Sample-Superstore.tsv)

echo "B. 2 state dengan profit paling sedikit pada region "$a" adalah : "
echo "   "$b1 $b2


echo "C. 10 produk dengan keuntungan terkecil pada region "$a" dan pada state" $b1 $b2 "adalah sebagai berikut :"

awk -v a="$a" -v b1="$b1" -v b2="$b2" -F '\t' '
{
  if(NR > 1 && $13 == a && ($11 == b1 || $11 == b2))
  {
    profit[$17] += $21;
  }
}
END{
  maxprofit = 0

  for (i in profit){
    if(profit[i] > maxprofit) maxprofit = profit[i];
  }

  minprofit = maxprofit
  minprofit_2 = maxprofit
  minprofit_3 = maxprofit
  minprofit_4 = maxprofit
  minprofit_5 = maxprofit
  minprofit_6 = maxprofit
  minprofit_7 = maxprofit
  minprofit_8 = maxprofit
  minprofit_9 = maxprofit
  minprofit_10 = maxprofit

  for (i in profit) {
    if(profit[i] < minprofit) minprofit = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_2 && profit[i] > minprofit) minprofit_2 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_3 && profit[i] > minprofit_2) minprofit_3 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_4 && profit[i] > minprofit_3) minprofit_4 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_5 && profit[i] > minprofit_4) minprofit_5 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_6 && profit[i] > minprofit_5) minprofit_6 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_7 && profit[i] > minprofit_6) minprofit_7 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_8 && profit[i] > minprofit_7) minprofit_8 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_9 && profit[i] > minprofit_8) minprofit_9 = profit[i];
  }

  for (i in profit) {
    if(profit[i] < minprofit_10 && profit[i] > minprofit_9) minprofit_10 = profit[i];
  }

  for (i in profit) {
    if (profit[i] == minprofit) minProf =  i
    if (profit[i] == minprofit_2) minProf_2 = i
    if (profit[i] == minprofit_3) minProf_3 = i
    if (profit[i] == minprofit_4) minProf_4 = i
    if (profit[i] == minprofit_5) minProf_5 = i
    if (profit[i] == minprofit_6) minProf_6 = i
    if (profit[i] == minprofit_7) minProf_7 = i
    if (profit[i] == minprofit_8) minProf_8 = i
    if (profit[i] == minprofit_9) minProf_9 = i
    if (profit[i] == minprofit_10) minProf_10 = i
  }

  print "\t1\t"minProf
  print "\t2\t"minProf_2
  print "\t3\t"minProf_3
  print "\t4\t"minProf_4
  print "\t5\t"minProf_5
  print "\t6\t"minProf_6
  print "\t7\t"minProf_7
  print "\t8\t"minProf_8
  print "\t9\t"minProf_9
  print "\t10\t"minProf_10
}' Sample-Superstore.tsv