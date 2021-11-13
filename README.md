# Jarkom-Modul-3-B11-2021

## **Kelompok B-11**

|      NRP       |         Nama          |
| :------------: | :-------------------: |
| 05111940000079 |    Muhammad Nevin     |
| 05111940000116 | Albert Filip Silalahi |
| 05111940000132 | Jagad Wijaya Purnomo  |

## Soal 1

Luffy bersama Zoro berencana membuat peta tersebut dengan kriteria EniesLobby sebagai DNS Server, Jipangu sebagai DHCP Server, Water7 sebagai Proxy Server

### Jawaban

Membuat topologi sebagai berikut:
![1_1](img/1_1.png)

Lakukan setting network masing-masing node dengan fitur `Edit network configuration` dengan setting sebagai berikut:

**Foosha (sebagai Router / DHCP Relay)**

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.182.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.182.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.182.3.1
	netmask 255.255.255.0
```

**Loguetown (sebagai Client)**

```
auto eth0
iface eth0 inet dhcp
```

**Alabasta (sebagai Client)**

```
auto eth0
iface eth0 inet dhcp
```

**EniesLobby (sebagai DNS Master)**

```
auto eth0
iface eth0 inet static
	address 192.182.2.2
	netmask 255.255.255.0
	gateway 192.182.2.1
```

**Water7 (sebagai Proxy Server)**

```
auto eth0
iface eth0 inet static
	address 192.182.2.3
	netmask 255.255.255.0
	gateway 192.182.2.1
```

**Jipangu (sebagai DHCP Server)**

```
auto eth0
iface eth0 inet static
	address 192.182.2.4
	netmask 255.255.255.0
	gateway 192.182.2.1
```

**Skypie (sebagai Client)**

```
auto eth0
iface eth0 inet static
	address 192.182.3.2
	netmask 255.255.255.0
	gateway 192.182.3.1
```

**TottoLand (sebagai Client)**

```
auto eth0
iface eth0 inet dhcp
```

Ketikkan `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.182.0.0/16` pada router `Foosha`.

Ketikkan `echo nameserver 192.168.122.1 > /etc/resolv.conf` pada node ubuntu yang lain.

Restart semua node dan coba `ping google.com`. Berikut bukti `Jipangu` dapat mengakses internet.

![1_2](img/1_2.png)

## Soal 2

dan Foosha sebagai DHCP Relay. Luffy dan Zoro menyusun peta tersebut dengan hati-hati dan teliti.

### Jawaban

**Pada Foosha**

-   Install aplikasi isc-dhcp-relay.

    ```
    apt-get install isc-dhcp-relay -y
    ```

-   Edit file `/etc/default/isc-dhcp-relay` seperti pada gambar berikut:

    ![2-1](img/2-1.png)

-   Restart isc-dhcp-relay.

    ```
    service isc-dhcp-relay restart
    ```

## Soal 3

Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.20 - [prefix IP].1.99 dan [prefix IP].1.150 - [prefix IP].1.169

### Jawaban

**Pada Jipangu**

-   Install aplikasi isc-dhcp-server.

    ```
    apt-get install isc-dhcp-server -y
    ```

-   Edit file `/etc/default/isc-dhcp-server` seperti pada gambar berikut:

    ![03-01](img/3-1.png)

-   Edit file `/etc/dhcp/dhcpd.conf` seperti pada gambar berikut:

    ![03-02](img/3-2.png)

-   Restart isc-dhcp-server.

    ```
    service isc-dhcp-server restart
    ```

**Pada Loguetown**

-   Edit file `/etc/network/interfaces` seperti pada gambar berikut:

    ![03-03](img/3-3.png)

-   Restart Loguetown dengan klik stop dan start pada node Loguetown.
-   Lakukan testing pada IP dan nameserver.

![image](https://user-images.githubusercontent.com/67728406/141645743-0ce54dc5-461b-4b3c-8b80-d0bc3ec4e5b0.png)

**Pada Alabasta**

-   Edit file `/etc/network/interfaces` seperti pada gambar berikut:

    ![03-03](/img/3-3.png)

-   Restart Alabasta dengan klik stop dan start pada node Alabasta.
-   Lakukan testing pada IP dan nameserver.

![image](https://user-images.githubusercontent.com/67728406/141645762-693addb4-d58a-4f01-bc56-cba821743b1c.png)

## Soal 4

Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.30 - [prefix IP].3.50.

### Jawaban

**Pada Jipangu**

-   Edit file `/etc/dhcp/dhcpd.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141645858-63e36a0d-fa96-4d8e-87fc-03f11d6e95e5.png)

-   Restart isc-dhcp-server.

    ```
    service isc-dhcp-server restart
    ```

**Pada TottoLand**

-   Edit file `/etc/network/interfaces` seperti pada gambar berikut:

    ![03-03](img/3-3.png)

-   Restart TottoLand dengan klik stop dan start pada node TottoLand.
-   Lakukan testing pada IP dan nameserver.

    ![image](https://user-images.githubusercontent.com/67728406/141645897-69316792-4015-4fee-b0b2-e358127ab43e.png)

## Soal 5

Client mendapatkan DNS dari EniesLobby dan client dapat terhubung dengan internet melalui DNS tersebut.

### Jawaban

**Pada EniesLobby**

-   Install aplikasi bind9.

    ```
    apt-get install bind9 -y
    ```

-   Edit file `/etc/bind/named.conf.options` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141645926-a1cba692-212d-4cc2-8b60-c95b47469f2f.png)

-   Restart bind9.

    ```
    service bind9 restart
    ```

**Pada Loguetown**

-   Lakukan ping `google.com`.

    ![05-02](https://user-images.githubusercontent.com/31863229/140724881-a4b97d8d-dfe9-400f-b41e-c24a8ff762bf.PNG)

**Pada Alabasta**

-   Lakukan ping `google.com`.

    ![05-03](https://user-images.githubusercontent.com/31863229/140724883-5ea80709-8bfd-4701-a852-ee3f67ab4671.PNG)

**Pada Skypie**

-   Lakukan ping `google.com`.

    ![05-04](https://user-images.githubusercontent.com/31863229/140724887-a509b39f-f006-4595-8cc7-88cce9038d13.PNG)

**Pada TottoLand**

-   Lakukan ping `google.com`.

    ![05-05](https://user-images.githubusercontent.com/31863229/140724891-80d278a9-893f-4693-ab40-2b55ea662d4a.PNG)

## Soal 6

Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 6 menit sedangkan pada client yang melalui Switch3 selama 12 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 120 menit.

### Jawaban

**Pada Jipangu**

-   Edit file `/etc/dhcp/dhcpd.conf` pada bagian `default-lease-time` dan `max-lease-time` seperti pada gambar berikut:

![image](https://user-images.githubusercontent.com/67728406/141646096-9ccabcc8-d715-485c-a5d0-a680b6e32e64.png)

-   Restart isc-dhcp-server.

    ```
    service isc-dhcp-server restart
    ```

## Soal 7

Luffy dan Zoro berencana menjadikan Skypie sebagai server untuk jual beli kapal yang dimilikinya dengan alamat IP yang tetap dengan IP [prefix IP].3.69.

### Jawaban

**Pada Jipangu**

-   Edit file `/etc/dhcp/dhcpd.conf` seperti pada gambar berikut:
-   ![image](https://user-images.githubusercontent.com/67728406/141646114-de19e1b4-ee65-4f71-84f6-8a13db9b37f8.png)
-   Restart isc-dhcp-server.

    ```
    service isc-dhcp-server restart
    ```

**Pada Skypie**

-   Edit file `/etc/network/interfaces` sesuai dengan IP kelompok & hwaddress yang ada

-   Restart Skypie dengan klik stop dan start pada node Skypie.
-   Lakukan testing pada IP dan nameserver.

    ![image](https://user-images.githubusercontent.com/67728406/141646180-9e8363f6-325e-4d28-8b81-f2e2367befa9.png)

## Soal 8

Pada Loguetown, proxy harus bisa diakses dengan nama `jualbelikapal.yyy.com` dengan port yang digunakan adalah 5000.

### Jawaban

**Pada Water7**

-   Install aplikasi squid dan apache2-utils.

    ```
    apt-get install squid -y
    apt-get install apache2-utils -y
    ```

-   Backup terlebih dahulu file konfigurasi default yang disediakan Squid.

    ```
    mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
    ```

-   Buat konfigurasi Squid baru.

    ```
    nano /etc/squid/squid.conf
    ```

-   Edit file `/etc/squid/squid.conf` seperti pada gambar berikut:

    ![08-01](https://user-images.githubusercontent.com/31863229/140910433-eee46196-648c-4464-ac52-9b7ec803f32b.PNG)

-   Tambahkan IP EniesLobby (192.182.2.2) pada file `/etc/resolv.conf`.
-   Restart squid.

    ```
    service squid restart
    ```

**Pada Loguetown**

-   Install aplikasi lynx.

    ```
    apt-get install lynx -y
    ```

-   Aktifkan proxy dengan syntax berikut:

    ```
    export http_proxy="http://192.182.2.3:5000"
    ```

-   Buka `http://its.ac.id` menggunakan lynx.

    ![08-02](https://user-images.githubusercontent.com/31863229/140910444-3451d55c-9fa1-4192-815f-dfd53a7dc38a.PNG)

## Soal 9

Agar transaksi jual beli lebih aman dan pengguna website ada dua orang, proxy dipasang autentikasi user proxy dengan enkripsi MD5 dengan dua username, yaitu `luffybelikapalyyy` dengan password `luffy_yyy` dan `zorobelikapalyyy` dengan password `zoro_yyy`.

### Jawaban

**Pada Water7**

-   Jalankan perintah berikut untuk membuat akun autentikasi baru dengan username `luffybelikapalB11`. Kita akan diminta untuk memasukkan password baru dan confirm password tersebut diisi `luffy_B11`.

    ```
    htpasswd -cm /etc/squid/passwd luffybelikapalB11
    ```

-   Jalankan perintah berikut untuk membuat akun autentikasi baru dengan username `zorobelikapalB11`. Kita akan diminta untuk memasukkan password baru dan confirm password tersebut diisi `zoro_B11`.

    ```
    htpasswd -m /etc/squid/passwd zorobelikapalB11
    ```

-   Edit file `/etc/squid/squid.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646929-57c8939f-0704-4d81-8176-9aa646859828.png)

-   Restart squid.

    ```
    service squid restart
    ```

**Pada Loguetown**

-   Buka `http://its.ac.id` menggunakan lynx dengan username dan password yang dibuat.
    ![08-02](https://user-images.githubusercontent.com/31863229/140910444-3451d55c-9fa1-4192-815f-dfd53a7dc38a.PNG)

## Soal 10

Transaksi jual beli tidak dilakukan setiap hari, oleh karena itu akses internet dibatasi hanya dapat diakses setiap hari Senin-Kamis pukul 07.00-11.00 dan setiap hari Selasa-Jum’at pukul 17.00-03.00 keesokan harinya (sampai Sabtu pukul 03.00).

### Jawaban

**Pada Water7**

-   Mendefinisikan jadwal sebagai berikut:

    ```
    Jadwal yang diperbolehkan
    Senin		07:00 - 11:00
    Selasa		07:00 - 11:00, 17:00 - 23:59
    Rabu		00:00 - 03:00, 07:00 - 11:00, 17:00 - 23:59
    Kamis		00:00 - 03:00, 07:00 - 11:00, 17:00 - 23:59
    Jumat		00:00 - 03:00, 17:00 - 23:59
    Sabtu		00:00 - 03:00

    Jadwal yang tidak diperbolehkan
    Minggu		00:00 - 23:59
    Senin		00:00 - 06:59, 11:01 - 23:59
    Selasa		00:00 - 06:59, 11:01 - 16:59
    Rabu		03:01 - 06:59, 11:01 - 16:59
    Kamis		03:01 - 06:59, 11:01 - 16:59
    Jumat		03:01 - 16:59
    Sabtu		03:01 - 23:59

    Penggabungan jadwal yang tidak diperbolehkan
    acl AVAILABLE_WORKING_1 time S 00:00-23:59
    acl AVAILABLE_WORKING_2 time MT 00:00-06:59
    acl AVAILABLE_WORKING_3 time M 11:01-23:59
    acl AVAILABLE_WORKING_4 time TWH 11:01-16:59
    acl AVAILABLE_WORKING_5 time WH 03:01-06:59
    acl AVAILABLE_WORKING_6 time F 03:01-16:59
    acl AVAILABLE_WORKING_7 time A 03:01-23:59
    ```

-   Buat file baru bernama `acl.conf` di folder squid.

    ```
    nano /etc/squid/acl.conf
    ```

-   Edit file `/etc/squid/acl.conf` seperti pada gambar berikut:

    ![10-01](https://user-images.githubusercontent.com/31863229/140914095-e687b1e5-3ba5-4644-9140-4b987203551d.PNG)

-   Edit file `/etc/squid/squid.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646912-fc959a41-0f29-4c4e-8717-2ce82b8718d9.png)

-   Restart squid.

    ```
    service squid restart
    ```

**Pada Loguetown**

-   Ubah tanggal dan waktu sesuai jadwal yang tidak diperbolehkan, misal hari Selasa pukul 13.00.
    ```
    date -s "9 NOV 2021 13:00:00"
    ```
-   Buka `http://its.ac.id` menggunakan lynx.

    ![image](https://user-images.githubusercontent.com/67728406/141646308-b8a45bac-57c4-40ce-8cb2-c2c65d0fd7bd.png)

-   Ubah tanggal dan waktu sesuai jadwal yang diperbolehkan, misal hari Rabu pukul 01.00.
    ```
    date -s "10 NOV 2021 01:00:00"
    ```
-   Buka `http://its.ac.id` menggunakan lynx.

    ![08-02](https://user-images.githubusercontent.com/31863229/140910444-3451d55c-9fa1-4192-815f-dfd53a7dc38a.PNG)

## Soal 11

Agar transaksi bisa lebih fokus berjalan, maka dilakukan redirect website agar mudah mengingat website transaksi jual beli kapal. Setiap mengakses `google.com`, akan diredirect menuju `super.franky.yyy.com` dengan website yang sama pada soal shift modul 2. Web server `super.franky.yyy.com` berada pada node Skypie.

### Jawaban

**Pada EniesLobby**

-   Edit file `/etc/bind/named.conf.local` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646344-c49089c2-7ee9-409a-a8d9-af15398b1788.png)

-   Buat folder `kaizoku` di dalam `/etc/bind`.

    ```
    mkdir /etc/bind/kaizoku
    ```

-   Copykan file `db.local` pada path `/etc/bind` ke dalam folder `kaizoku` yang baru saja dibuat dan ubah namanya menjadi `super.franky.B11.com`.

    ```
    cp /etc/bind/db.local /etc/bind/kaizoku/super.franky.B11.com
    ```

-   Edit file `/etc/bind/kaizoku/super.franky.B11.com` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646387-683103de-5b36-446b-86e4-752c7dabe94c.png)

-   Restart bind9.

    ```
    service bind9 restart
    ```

**Pada Skypie**

-   Install aplikasi apache, PHP, dan libapache2-mod-php7.0.

    ```
    apt-get install apache2 -y
    apt-get install php -y
    apt-get install libapache2-mod-php7.0 -y
    ```

-   Pindah ke directory `/etc/apache2/sites-available`.
-   Copy file `000-default.conf` menjadi file `super.franky.B11.com.conf`.
-   Edit file `super.franky.B11.com.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646420-8675637c-9cbb-4a81-890b-76060e39a366.png)

-   Aktifkan konfigurasi super.franky.B11.com.

    ```
    a2ensite super.franky.B11.com
    ```

-   Restart apache.

    ```
    service apache2 restart
    ```

-   Pindah ke directory `/var/www`.
-   Download file zip menggunakan `wget`.

    ```
    wget https://github.com/FeinardSlim/Praktikum-Modul-2-Jarkom/raw/main/super.franky.zip
    ```

-   Lakukan unzip.

    ```
    unzip super.franky.zip
    ```

-   Rename folder `super.franky` menjadi `super.franky.B11.com` dan terdapat isi file seperti pada gambar berikut:

**Pada Water7**

-   Buat file bernama `restrict-sites.acl` di folder squid.
-   Tambahkan alamat url `google.com` yang akan diredirect.
-   Edit file `/etc/squid/squid.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646469-a141a625-0011-4087-b5b3-1a0daff3dd11.png)

-   Restart squid.

    ```
    service squid restart
    ```

**Pada Loguetown**

-   Buka `google.com` menggunakan lynx.

    ![image](https://user-images.githubusercontent.com/67728406/141646485-815e08e3-6d98-4f15-8735-4fd63b45fa76.png)

## Soal 12

Saatnya berlayar! Luffy dan Zoro akhirnya memutuskan untuk berlayar untuk mencari harta karun di `super.franky.yyy.com`. Tugas pencarian dibagi menjadi dua misi, Luffy bertugas untuk mendapatkan gambar (.png, .jpg), sedangkan Zoro mendapatkan sisanya. Karena Luffy orangnya sangat teliti untuk mencari harta karun, ketika ia berhasil mendapatkan gambar, ia mendapatkan gambar dan melihatnya dengan kecepatan 10 kbps.

### Jawaban

**Pada Water7**

-   Buat file bernama `acl-bandwidth.conf` di folder squid.
-   Edit file `/etc/squid/acl-bandwidth.conf` seperti pada gambar berikut:

![image](https://user-images.githubusercontent.com/67728406/141646521-a15ebf85-78ac-4a5a-aefa-34e4f52320f0.png)

-   Edit file `/etc/squid/squid.conf` seperti pada gambar berikut:

    ![image](https://user-images.githubusercontent.com/67728406/141646568-2cea6215-2d7e-4dab-9019-f104e2e7731e.png)

-   Restart squid.

    ```
    service squid restart
    ```

**Pada Loguetown**

-   Buka `super.franky.B11.com` menggunakan lynx dengan akun Luffy dan coba download file `background-frank.jpg`. Dapat dilihat ada delay bandwidth.

    ![12-03](https://user-images.githubusercontent.com/31863229/140922141-a1a0e860-33bf-43e9-acb4-a7f8523cca4e.PNG)

## Soal 13

Sedangkan, Zoro yang sangat bersemangat untuk mencari harta karun, sehingga kecepatan kapal Zoro tidak dibatasi ketika sudah mendapatkan harta yang diinginkannya.

### Jawaban

**Pada Loguetown**

-   Buka `super.franky.B11.com` menggunakan lynx dengan akun Zoro dan coba download file `autocomplete.js.gz`. Dapat dilihat tidak ada delay bandwidth.

![image](https://user-images.githubusercontent.com/67728406/141646866-3304c261-ce06-4a85-9d1f-c602206a8161.png)


## Kendala

1. Kesulitan mengatasi unleashed DHCP relay.
2. Lynx kadang tidak bekerja dengan baik.
3. Kurang paham mengenai delay access.
