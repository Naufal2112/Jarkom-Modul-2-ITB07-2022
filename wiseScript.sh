echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update  
apt-get install bind9 -y  

mkdir /etc/bind/wise

echo '
zone "wise.ITB07.com" {  
        type master;  
        file "/etc/bind/wise/wise.ITB07.com";
};
' > /etc/bind/named.conf.local

echo '
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

' > /etc/bind/wise/wise.ITB07.com

service bind9 restart

# nomor 3
echo '
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
' > /etc/bind/wise/wise.ITB07.com

service bind9 restart

# nomor 4
echo '
zone "wise.ITB07.com" {  
        type master;  
        file "/etc/bind/wise/wise.ITB07.com";  
};

zone "2.48.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.48.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

echo '
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
' > /etc/bind/wise/2.48.10.in-addr.arpa

service bind9 restart

# nomor 5
echo '
zone "wise.ITB07.com" {  
        type master;
        notify yes;
        also-notify {10.48.3.2;};  //Masukan IP Berlint tanpa tanda petik
        allow-transfer {10.48.3.2;}; // Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.ITB07.com";
};
  
zone "2.48.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.48.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

service bind9 restart


# nomor 6

echo '
$TTL    604800
@       IN      SOA     wise.ITB07.com. root.wise.ITB07.com. (
                        2021100401      ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.ITB07.com.
@               IN      A       10.48.3.3 ; IP Eden
www             IN      CNAME   wise.ITB07.com.
eden            IN      A       10.48.3.3 ; IP eden
www.eden        IN      CNAME   eden.wise.ITB07.com.
ns1             IN      A       10.48.3.2; IP Berlint
operation       IN      NS      ns1
' > /etc/bind/wise/wise.ITB07.com

echo "
options {
        directory \"/var/cache/bind\";
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options

echo '
zone "wise.ITB07.com" {
        type master;
        //notify yes;
        //also-notify {10.48.3.2;};  Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.ITB07.com";
        allow-transfer {10.48.3.2;}; // Masukan IP Berlint tanpa tanda petik
};

zone "2.48.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.48.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

service bind9 restart
