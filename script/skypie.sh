#!/bin/bash

# Update dan install
apt update
apt install php apache2 libapache2-mod-php7.0 wget unzip -y

# Download, unzip, dan pindahkan ke /var/www
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/mai$
unzip super.franky.zip
mv super.franky /var/www

# Start apache2
service apache2 start

# Buat konfigurasi apache
echo '
<VirtualHost *:80>
        DocumentRoot /var/www/super.franky
        ServerName super.franky.b11.com
        ServerAlias www.super.franky.b11.com

        <Directory /var/www/super.franky/error>
                Options -Indexes
        </Directory>

        <Directory /var/www/super.franky/public/js>
                Options -Indexes
        </Directory>

        <Directory /var/www/super.franky/public/css>
                Options -Indexes
        </Directory>

        <Directory /var/www/super.franky>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-available/super.franky.b11.com.conf

# Tambahkan .htaccess untuk error 404
echo 'ErrorDocument 404 /error/404.html' > /var/www/super.franky/.htaccess

# Enable konfigurasi dan restart apache
a2ensite super.franky.b11.com.conf
service apache2 restart