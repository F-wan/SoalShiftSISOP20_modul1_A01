# SoalShiftSISOP20_modul1_F01

## file .sh
- [Soal 1](soal1/)
- [Soal 2](soal2/)
- [Soal 3](soal3/)

## Soal no. 1

Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “​ Sample-Superstore.tsv” ​ .
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

### A. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit
Kita gunakan `awk` untuk memeriksa seluruh file `Sample-Superstore.tsv` yang telah disediakan. Berikut keseluruhan command `awk` untuk penyelesaian soal a
```sh
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
```

#### PENJELASAN
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$NF`(field terakhir) apabila nama regionnya sama 
```awk
if(NR > 1) profit[$13] += $NF;
```
- Pada bagian `END` kita tentukan nilai maksimum dari profit yang akan digunakan sebagai batas atas dari `minprofit`. 
- `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil

### B. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a
```sh
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
```

#### PENJELASAN
- untuk mencari 2 state denga profit paling sedikit pada region `Central`, kami menggunakan 2 variabel untuk menyimpan state pertama dan kedua, yaitu `b1` dan `b2`
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- `-v a="$a"` merupakan deklarasi variabel `a` yang nilainya diisi dengan jawaban soal A
- `-v b1="$b1"` merupakan deklarasi variabel `b1` yang nilainya diisi dengan nilai variabel `$b1`

- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$NF`(field terakhir) apabila nama statenya sama 
```awk
if(NR > 1 && $13 == a) profit[$11] += $NF;
```
- Pada bagian `END` kita tentukan nilai maksimum dari profit yang akan digunakan sebagai batas atas dari `minprofit` untuk `b1` dan `b2` 
- pada `b1`, `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil
- pada `b2`, `minprofit` akan terus dibandingkan hingga file selesai untuk menemukan region dengan profit paling kecil setelah kecuali yang nama statenya sama dengan `b1`

### C. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b

```sh
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
```

#### PENJELASAN
- `-F '\t'` digunakan untuk menunjukkan bahwa pemisah tiap field pada tiap baris adalah tab field
- `-v a="$a"` merupakan deklarasi variabel a yang nilainya diisi dengan jawaban soal a yang merupakan region
- Pada bagian body `awk` kita lakukan pengecekan agar baris pertama tidak diperiksa dan menambah nilai `profit` yang disimpan pada `$NF`(field terakhir) apabila nama produknya sama dan nama statenya sama dengan `b1` atau `b2` 
```awk
if(NR > 1 && $13 == a && ($11 == b1 || $11 == b2))
{
  profit[$17] += $21;
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

```sh
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
```
#### PENJELASAN
- `mkdir duplicate kenangan` digunakan untuk membuat folder bernama **duplicate** dan **kenangan**
- `grep "Location: " wget.log > location.log` digunakan untuk membuat list lokasi file yang ada pada `wget.log` dan kemudian dimasukkan ke dalam file `location.log`
- Kemudian pada file `location.log` dilakukan penomoran untuk setiap nama asli file untuk dijadikan semacam indeks. kemudian berdasarkan indeks tersebut, isi dari `location.log` diurutkan dengan `sort -g` kemudian dimasukkan ke file bernama `test`
- Kemudian dari file test dilakukan pemeriksaan apakah nama tiap file sama. apabila sama, file paling baru dipindahkan ke folder `duplicate`.
- Kemudian semua file yang berbeda satu sama lain akan masuk ke folder `kenangan`
- Hapus file `test`
- ganti nama semua file `.log` menjadi `.log.bak`
