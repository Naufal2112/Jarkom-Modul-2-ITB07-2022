echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update

# nomor 8
apt-get install apache2 -y
service apache2 start
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y
service apache2 
apt-get install ca-certificates openssl -y
apt-get install git -y
apt-get install unzip -y
apt-get install wget -y
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e' -O /root/wise.zip
unzip /root/wise.zip -d /root
echo '
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.ITB07.com
        ServerName wise.ITB07.com
        ServerAlias www.wise.ITB07.com
</VirtualHost>
' > /etc/apache2/sites-available/wise.ITB07.com.conf
a2ensite wise.ITB07.com
mkdir /var/www/wise.ITB07.com
cp -r /root/wise/. /var/www/wise.ITB07.com
service apache2 restart

# Nomor 9
a2enmod rewrite
service apache2 restart
echo "
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule (.*) /index.php/\$1 [L]" > /var/www/wise.ITB07.com/.htaccess
echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.ITB07.com
        ServerName wise.ITB07.com
        ServerAlias www.wise.ITB07.com

        <Directory /var/www/wise.ITB07.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/wise.ITB07.com.conf

service apache2 restart

# Nomor 10
echo '
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.ITB07.com
        ServerName eden.wise.ITB07.com
        ServerAlias www.eden.wise.ITB07.com


        <Directory /var/www/wise.ITB07.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>' > /etc/apache2/sites-available/eden.wise.ITB07.com.conf

wget --no-check-certificate 'https://docs.google.com/uc?export=dowload&id=1q9g6nM85bW5T9f5yoyXtDqonUKKCHOTV' -O /root/eden.wise.zip

unzip /root/eden.wise.zip -d /root
a2ensite eden.wise.ITB07.com
mkdir /var/www/eden.wise.ITB07.com  
cp -r /root/eden.wise/. /var/www/eden.wise.ITB07.com
service apache2 restart

echo "<?php echo 'akdushdc' ?>" > /var/www/eden.wise.ITB07.com/index.php

# Nomor 11
echo '
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.ITB07.com
        ServerName eden.wise.ITB07.com
        ServerAlias www.eden.wise.ITB07.com

        <Directory /var/www/eden.wise.ITB07.com/public>
                Options +Indexes
        </Directory>


        <Directory /var/www/wise.ITB07.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>' > /etc/apache2/sites-available/eden.wise.ITB07.com.conf

service apache2 restart

# Nomor 12
echo '
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.ITB07.com
        ServerName eden.wise.ITB07.com
        ServerAlias www.eden.wise.ITB07.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.ITB07.com/public>
                Options +Indexes
        </Directory>


        <Directory /var/www/wise.ITB07.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>' > /etc/apache2/sites-available/eden.wise.ITB07.com.conf

service apache2 restart
