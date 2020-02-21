# SoalShiftSISOP20_modul1_F01

## file .sh
- [Soal 1](soal1/soal1.sh)
- [Soal 2](soal1/soal2.sh)
- [Soal 3](soal3/soal3.sh)

## Soal no. 1

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “​ Sample-Superstore.tsv” ​ .
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

### A. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit
Kita gunakan `awk` untuk memeriksa seluruh file `Sample-Superstore.tsv` yang telah disediakan. Berikut keseluruhan command `awk` untuk penyelesaian soal a
```sh
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
```sh
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
```sh
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
```sh
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
```sh
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

## soal no. 2
Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan ​ HANYA ​ berupa alphabet​ .
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘​ bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi ​ z ​ , akan kembali ke ​ a ​ , contoh: huruf ​ w dengan jam 5.28,
maka akan menjadi huruf ​ b.​ ) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

```sh
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

```
#### PEMBAHASAN
- Menerima hanya alphabet saja , If nya berfungsi untuk menyaring jika ada angka ataupun charachter spesial
- Karena keterbatasan waktu,  soal 2 belum sempat diselesaikan

## Soal no. 3
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing.


### Soal A
Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"​ https://loremflickr.com/320/240/cat​ " menggunakan command ​ wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan ​ log messages ​ wget kedalam
sebuah file "wget.log"​ . Karena kalian gak suka ribet, kalian membuat penjadwalan untukmenjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan
```sh
# a
for ((i=1; i<=28; i++))
do
  wget -a "wget.log" -O "pdkt_kusuma_$i" https://loremflickr.com/320/240/cat
done
```

#### PENJELASAN
- dilakukan perulangan sebanyak `28` kali untuk mendownload `28` gambar dari `https://loremflickr.com/320/240/cat`
- `-a "wget.log"` digunakan untuk menyimpan log selama download di file **wget.log**
- `-O "pdkt_kusuma_$i"` digunakan agar pada setiap perulangan, nama file yang disimpan adalah `pdkt_kusuma_$i`

### Soal B
setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu ​ Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi.

```
5 6-23/8 * * 0-5 cd /home/kaori02/SoalShiftSISOP20_modul1_F01/soal3/; bash soal3.sh
```

#### PENJELASAN
- pada soal ini kita gunakan crontab untuk menjalankan `soal3.sh` setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu sehingga kita atur waktunya menjadi
```
5 6-23/8 * * 0-5
```

### Soal C
Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di ​ current directory ​ , maka lakukan backup seluruh log menjadi
ekstensi ".log.bak"​ .

#### PENJELASAN
```sh
# c
grep "Location" wget.log > location.log
```
- command diatas digunakan untuk membuat list lokasi file yang ada pada `wget.log`
- Karena keterbatasan waktu,  soal c belum sempat diselesaikan