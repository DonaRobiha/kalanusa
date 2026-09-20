Kalanusa

Deskripsi Aplikasi

Kalanusa adalah aplikasi berbasis travel yang dirancang untuk
membantu pengguna mengelola informasi anggota, menemukan destinasi
wisata Nusantara, merencanakan perjalanan, menghitung anggaran
perjalanan, serta mengakses fitur konversi tanggal dan kalender
tradisional Indonesia.

Aplikasi memiliki halaman login admin untuk mengakses menu utama.
Kalanusa dikembangkan dengan Flutter sebagai frontend dan Laravel API
serta MySQL sebagai backend dan basis data.

Tujuan Aplikasi

Membantu admin mengelola data anggota.

Menyediakan informasi dan pengelolaan destinasi wisata Nusantara.

Memudahkan perencanaan anggaran perjalanan.

Membantu pengguna membuat dan mengelola rencana perjalanan.

Menyediakan perhitungan usia secara real time.

Menyediakan konversi kalender Masehi ke Hijriah dan kalender
Nusantara.

Menyediakan navigasi aplikasi yang sederhana dan mudah digunakan.

Fitur Utama

1. Login Admin

Admin melakukan login untuk masuk ke halaman menu utama aplikasi.

2. Daftar Anggota

Fitur ini digunakan untuk menampilkan dan mengelola data anggota.

Data anggota terdiri dari:

Nama

NIM

3. Destinasi Nusantara

Fitur ini digunakan untuk menemukan, menyimpan, dan mengelola destinasi
wisata Nusantara.

Informasi destinasi meliputi:

Nama destinasi

Lokasi

Kategori wisata

Estimasi biaya

Foto wisata

Fitur yang tersedia:

Create: menambahkan destinasi baru.

Read: menampilkan daftar dan detail destinasi.

Update: mengubah data destinasi.

Delete: menghapus destinasi.

Upload foto: menambahkan foto destinasi wisata.

4. Komputasi Perjalanan

Fitur ini digunakan untuk menghitung estimasi biaya perjalanan dan
membantu pengguna merencanakan anggaran.

Komponen perhitungan meliputi:

Jumlah orang

Transportasi

Penginapan

Makan

Tiket atau aktivitas

Sistem menghitung total biaya perjalanan berdasarkan data yang
dimasukkan.

Catatan pengembangan: Saat ini bagian perhitungan belum menampilkan
output hasil perhitungan. Fitur berikutnya adalah menyelesaikan proses
kalkulasi dan menampilkan total biaya secara jelas kepada pengguna.

5. Rencana Perjalanan

Fitur ini digunakan untuk membuat dan mengelola rencana perjalanan
Nusantara.

Data yang dapat ditambahkan:

Tujuan perjalanan

Tanggal perjalanan

Jumlah orang

Budget

Catatan

Fitur yang tersedia:

Create: membuat rencana perjalanan.

Read: melihat daftar dan detail rencana.

Update: mengubah rencana perjalanan.

Delete: menghapus rencana perjalanan.

6. Konversi & Waktu

Fitur ini digunakan untuk mengelola tanggal, menghitung usia, dan
melakukan konversi kalender.

6.1 Perhitungan Usia Real Time

Pengguna memasukkan tanggal lahir. Sistem menampilkan usia saat ini
secara real time dengan format:

Tahun

Bulan

Hari

Jam

Menit

Detik

Contoh input:

25 Oktober 2005

Contoh keluaran:

20 tahun, 10 bulan, 24 hari, 20 jam, 23 menit, dan beberapa detik.

Nilai detik harus terus diperbarui selama halaman atau fitur sedang
aktif.

6.2 Konversi Masehi ke Hijriah

Pengguna memasukkan tanggal Masehi, kemudian sistem menampilkan tanggal
Hijriah.

Contoh:

Input: 25 Oktober 2005

Output: 21 Ramadhan 1426 H

7. Kalender Nusantara

Fitur ini digunakan untuk menampilkan informasi kalender tradisional
Indonesia berdasarkan tanggal yang dimasukkan.

7.1 Kalender Jawa

Informasi yang ditampilkan:

Hari

Pasaran

Weton

Neptu

7.2 Kalender Saka Bali

Informasi yang direncanakan untuk ditampilkan:

Tahun Saka

Sasih

Wuku

Catatan pengembangan: Data atau perhitungan Sasih dan Wuku belum
tersedia, sehingga fitur tersebut masih perlu dikembangkan.

8. Navigasi Aplikasi

Aplikasi memiliki navigasi utama yang terdiri dari:

Home: kembali ke halaman utama.

Stopwatch: menjalankan dan mereset stopwatch.

Bantuan: menampilkan informasi bantuan aplikasi.

8.1 Stopwatch

Fitur stopwatch menyediakan:

Mulai

Reset

8.2 Bantuan

Halaman bantuan berisi:

Tentang Kalanusa

Keluar atau logout

Fitur logout digunakan untuk mengakhiri sesi admin dan kembali ke
halaman login.

Alur Penggunaan Aplikasi

Admin membuka aplikasi Kalanusa.

Admin melakukan login.

Admin masuk ke halaman menu utama.

Admin memilih fitur yang dibutuhkan.

Data yang dimasukkan melalui Flutter dikirim ke Laravel API.

Laravel memproses data dan menyimpannya ke database MySQL.

Data dapat ditampilkan kembali, diubah, atau dihapus melalui
aplikasi sesuai hak akses fitur.

Teknologi yang Digunakan

Frontend: Flutter

Backend: Laravel

Database: MySQL (XAMPP / phpMyAdmin)

- Nama Database: kalanusa
- Host: localhost (Port 3306)
- User: root
- Password: (kosong)
- Skema & Seed: kalanusa.sql

API: REST API

Platform pengujian: Flutter Web melalui Chrome atau perangkat
fisik Android.

Status Pengembangan

Fitur Status

Login Admin Tersedia

Daftar Anggota Tersedia

Destinasi Nusantara CRUD tersedia

Upload Foto Wisata Dalam pengembangan/penyesuaian

Komputasi Perjalanan Perhitungan dan output belum
selesai

Rencana Perjalanan CRUD tersedia

Perhitungan Usia Real Time Dalam pengembangan

Konversi Masehi ke Hijriah Dalam pengembangan

Kalender Jawa Dalam pengembangan

Kalender Saka Bali Tahun Saka tersedia, Sasih dan Wuku
belum tersedia

Home Tersedia

Stopwatch Mulai dan reset tersedia

Bantuan Tersedia

Logout Tersedia

Pengembangan Selanjutnya

Prioritas pengembangan berikutnya adalah:

Menghubungkan seluruh form Flutter dengan Laravel API.

Memastikan data CRUD tersimpan dan terbaca dari MySQL.

Menyelesaikan output perhitungan Komputasi Perjalanan.

Menambahkan upload dan penyimpanan foto destinasi.

Membuat perhitungan usia real time.

Menambahkan konversi tanggal Masehi ke Hijriah.

Melengkapi perhitungan kalender Jawa.

Menambahkan data Sasih dan Wuku pada kalender Saka Bali.

Melakukan pengujian seluruh fitur melalui Chrome atau perangkat
fisik.
