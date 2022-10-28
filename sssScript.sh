echo 'nameserver 192.168.122.1' > /etc/resolv.conf

apt-get update         
apt-get install dnsutils -y
apt-get install lynx -y
# NOMOR 2
# apt-get update  
# apt-get install dnsutils -y  
# echo "nameserver 10.48.2.2 > /etc/resolv.conf
echo "
nameserver 10.48.2.2
nameserver 10.48.3.2
nameserver 10.48.3.3
" > /etc/resolv.conf
