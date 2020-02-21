# SoalShiftSISOP20_modul1_F01

## file .sh
- [Soal 1](soal1/soal1.sh)
- [Soal 2](soal1/soal2.sh)
- [Soal 3](soal3/soal3.sh)

## soal no. 1

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “​ Sample-Superstore.tsv” ​ .
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

### A. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit
Kita gunakan `awk` untuk memeriksa seluruh file `Sample-Superstore.tsv` yang telah disediakan. Berikut keseluruhan command `awk` untuk penyelesaian soal a
```awk
a=$(awk -F '\t' '
{
  if(NR > 1){
    if(arrReg[$13] == $13){
      profit[$13] += $21;
    }
    else{
      arrReg[$13] = $13
    }
  }
}
END{
  maxprofit = 0

  for (i in arrReg) {
    if(arrReg[i] != "Region"){
      if(profit[i] > maxprofit) maxprofit = profit[i];
    }
  }

  minprofit = maxprofit
  for (i in arrReg) {
    if(arrReg[i] != "Region"){
      if(profit[i] < minprofit) minprofit = profit[i];
    }
  }

  for (i in arrReg) {
    if(arrReg[i] != "Region"){
      if (profit[i] == minprofit)
        print arrReg[i]
    }
  }
}' Sample-Superstore.tsv)

echo "A. region with minimum profit : "
echo "   "$a
```

#### PENJELASAN
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$21` apabila nama regionnya sama 
```awk
if(NR > 1){
  if(arrReg[$13] == $13){
    profit[$13] += $21;
  }
  else{
    arrReg[$13] = $13
  }
}
```
- Pada bagian `END` kita tentukan nilai maksimum dari profit yang akan digunakan sebagai batas atas dari `minprofit`. 
- `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil

### B. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a
```awk
b=$(awk -v a="$a" -F '\t' '
{
  if(NR > 1 && $13 == a){
    if(arrState[$11] == $11){
      profit[$11] += $21;
    }
    else{
      arrState[$11] = $11
    }
  }
}
END{
  maxprofit = 0

  for (i in arrState) {
    if(arrState[i] != "State"){
      if(profit[i] > maxprofit) maxprofit = profit[i];
    }
  }

  minprofit = maxprofit
  secondMinProfit = maxprofit

  for (i in arrState) {
    if(arrState[i] != "State"){
      if(profit[i] < minprofit) minprofit = profit[i];
    }
  }

  for (i in arrState) {
    if(arrState[i] != "State"){
      if(profit[i] < secondMinProfit && profit[i] != minprofit) secondMinProfit = profit[i];
    }
  }
  for (i in arrState) {
    if(arrState[i] != "State"){
      if (profit[i] == minprofit) minProState =  i
      if (profit[i] == secondMinProfit) SecMinProState = i
    }
  }
  print minProState, SecMinProState
}' Sample-Superstore.tsv)

echo "B. 2 state dengan profit paling sedikit pada region "$a" adalah : "
echo "   "$b
```

#### PENJELASAN
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- `-v a="$a"` merupakan deklarasi variabel a yang nilainya diisi dengan jawaban soal a
- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$21` apabila nama statenya sama 
```awk
if(NR > 1 && $13 == a){
  if(arrState[$11] == $11){
    profit[$11] += $21;
  }
  else{
    arrState[$11] = $11
  }
}
```
- Pada bagian `END` kita tentukan nilai maksimum dari profit yang akan digunakan sebagai batas atas dari `minprofit` dan `secondMinProfit` 
- `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil
- `secondMinProfit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil setelah `minprofit`

### C. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b

```awk
echo "C. 10 produk dengan keuntungan terkecil pada region "$a" dan pada state" $b "adalah sebagai berikut :"

awk -v a="$a" -F '\t' '
{
  if(NR > 1 && $13 == a && ($11 == "Illinois" || $11 == "Texas")){
    if(arrProd[$17] == $17){
      profit[$17] += $21;
    }
    else{
      arrProd[$17] = $17
    }
  }
}
END{
  maxprofit = 0

  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] > maxprofit) maxprofit = profit[i];
    }
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

  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit) minprofit = profit[i];
    }
  }

  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_2 && profit[i] > minprofit) minprofit_2 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_3 && profit[i] > minprofit_2) minprofit_3 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_4 && profit[i] > minprofit_3) minprofit_4 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_5 && profit[i] > minprofit_4) minprofit_5 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_6 && profit[i] > minprofit_5) minprofit_6 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_7 && profit[i] > minprofit_6) minprofit_7 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_8 && profit[i] > minprofit_7) minprofit_8 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_9 && profit[i] > minprofit_8) minprofit_9 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
      if(profit[i] < minprofit_10 && profit[i] > minprofit_9) minprofit_10 = profit[i];
    }
  }
  for (i in arrProd) {
    if(arrProd[i] != "Product Name"){
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
```

#### PENJELASAN
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- `-v a="$a"` merupakan deklarasi variabel a yang nilainya diisi dengan jawaban soal a yang merupakan region
- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$21` apabila nama produknya sama dan nama statenya adalah **Illinois** atau **Texas** 
```awk
if(NR > 1 && $13 == a && ($11 == "Illinois" || $11 == "Texas")){
  if(arrProd[$17] == $17){
    profit[$17] += $21;
  }
  else{
    arrProd[$17] = $17
  }
}
```
- Pada bagian `END` kita tentukan nilai maksimum dari profit yang akan digunakan sebagai batas atas dari `10` nilai `minprofit`
- Semua `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil
- Dengan catatan `minprofit_n` selalu lebih besar daripada `minprofit_(n-1)` 