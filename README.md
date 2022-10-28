# Jarkom-Modul-2-ITB07-2022
Laporan Resmi Pengerjaan Soal Shift Praktikum Jaringan Komputer

Kelompok ITB07: <br>
5027201004 Alda Risma Harjian <br>
5027201042 Ilham Muhammad Sakti <br>
5027201067 Naufal Ramadhan <br>

## Soal:

Twilight (〈黄昏 (たそがれ) 〉, <Tasogare>) adalah seorang mata-mata yang berasal dari negara Westalis. Demi menjaga perdamaian antara Westalis dengan Ostania, Twilight dengan nama samaran Loid Forger (ロイド・フォージャー, Roido Fōjā) di bawah organisasi WISE menjalankan operasinya di negara Ostania dengan cara melakukan spionase, sabotase, penyadapan dan kemungkinan pembunuhan. Berikut adalah peta dari negara Ostania:

![Topologi](./images/topologiModul2.png)

## Soal 1:
WISE akan dijadikan sebagai DNS Master, Berlint akan dijadikan DNS Slave, dan Eden akan digunakan sebagai Web Server. Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet.

### Jawaban Soal 1:
Kami membuat topologi terlebih dahulu sebagai berikut:

![Topologi yang dibuat](./images/jawabanSoal1Topologi.png)

Lalu, kami melakukan konfigurasi jaringan pada setiap node seperti berikut:

**Ostania sebagai router**
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.48.0.0/16
```

Network configuration for Ostania

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.48.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.48.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.48.3.1
	netmask 255.255.255.0

```

**WISE sebagai DNS Master**

```
echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update  
apt-get install bind9 -y
```
![WISE sebagai DNS Master](./images/jawabanSoal1WiseSebagaiDnsMaster.png)

**Berlint sebagai DNS Slave**
```
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install bind9 -y 
```
![Berlint sebagai DNS Slave](./images/jawabanSoal1BerlintSebagaiDnsSlave.png)

**Eden sebagai Web Server**
```
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
```
![Eden sebagai Web Server](./images/jawabanSoal1EdenSebagaiWebServer.png)

**SSS sebagai client**
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update         
apt-get install dnsutils -y
```
![network configuration sss sebagai client](./images/jawabanSoal1SssSebagaiClient.png)

**Garden sebagai client**
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
```
![Garden sebagai client](./images/jawabanSoal1GardenSebagaiClient.png)


## Soal 2:
Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise

### Jawaban Soal 2:
**Server WISE** <br>
Melakukan konfigurasi terhadap file `/etc/bind/named.conf.local` dengan menambahkan
```
zone "wise.ITB07.com" {  
        type master;  
        file "/etc/bind/wise/wise.ITB07.com";
};
```
Membuat direktori baru yaitu `/etc/bind/wise` <br>
Menambahkan konfigurasi pada `/etc/bind/wise/wise.ITB07.com` <br>
```
$TTL    604800  
@       IN      SOA     wise.ITB07.com. root.wise.ITB07.com. (
                        2021100401      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.ITB07.com.
@               IN      A       10.48.2.2 ; IP WISE
www             IN      CNAME   wise.ITB07.com.
```
Melakukan restart service bind9 dengan `service bind9 restart`.

**Server SSS**
```
apt-get install dnsutils -y  
echo "nameserver 10.48.2.2 > /etc/resolv.conf
```

**TESTING**

#1 ping wise.ITB07.com <br>
![testing1](./images/jawabanSoal2Testing1.png) <br>
#2 ping www.wise.ITB07.com <br>
![testing2](./images/jawabanSoal2Testing2.png) <br>
#3 host -t CNAME www.wise.ITB07.com <br>
![testing3](./images/jawabanSoal2Testing3.png) <br>

## Soal 3:
Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden 

### Jawaban Soal 3:
**Server WISE**<br>

Melakukan Edit pada file `/etc/bind/kaizoku/franky.t07.com` menjadi seperti berikut:
```
$TTL    604800  
@       IN      SOA     wise.ITB07.com. root.wise.ITB07.com. (  
                        2021100401      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.ITB07.com.
@               IN      A       10.48.2.2 ; IP WISE
www             IN      CNAME   wise.ITB07.com.
eden            IN      A       10.48.3.3 ; IP Eden
www.eden        IN      CNAME   eden.wise.ITB07.com.
```
Melakukan restart sevice bind9 dengan `service bind9 restart`.

**TESTING**

#1 ping eden.wise.ITB07.com <br>
![testing1](./images/jawabanSoal3Testing1.png) <br>
#2 ping www.eden.wise.ITB07.com <br>
![testing2](./images/jawabanSoal3Testing2.png) <br>
#3 host -t A eden.wise.ITB07.com <br>
![testing3](./images/jawabanSoal3Testing3.png) <br>
#4 host -t CNAME www.eden.wise.ITB07.com <br>
![testing4](./images/jawabanSoal3Testing4.png) <br>

## Soal 4:
Buat juga reverse domain untuk domain utama

### Jawaban Soal 4:
**Server WISE** <br>

Edit file `/etc/bind/named.conf.local` menjadi sebagai berikut:
```zone "wise.ITB07.com" {  
        type master;  
        file "/etc/bind/wise/wise.ITB07.com";  
};

zone "2.48.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.48.10.in-addr.arpa";
};
```
dan lakukan konfigurasi pada file `/etc/bind/wise/2.48.10.in-addr.arpa` seperti berikut ini:
```
$TTL    604800  
@       IN      SOA     wise.ITB07.com. root.wise.ITB07.com. (
                        2021100401      ; Serial
                        604800          ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
2.48.10.in-addr.arpa.   IN      NS      wise.ITB07.com.
2                       IN      PTR     wise.ITB07.com.
```
Melakukan restart sevice bind9 dengan `service bind9 restart`.

**TESTING**

#1 host -t PTR 10.48.2.2 <br>
![testing1](./images/jawabanSoal4Testing1.png) <br>
