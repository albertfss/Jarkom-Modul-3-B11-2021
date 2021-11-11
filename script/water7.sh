#!/bin/bash

# Tambahkan nameserver ke /etc/resolv.conf
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Update dan install
apt update
apt install squid apache2-utils -y

# Start squid
service squid start

# Backup squid default config
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak

# Edit kofigurasi squid
echo '
# Buat limit waktu akses
include /etc/squid/acl.conf

# Pakai port 5000 dengan hostname Water7
http_port 5000
visible_hostname Water7

# Redirect google.com
acl red url_regex .google.com
http_access deny red
deny_info http://super.franky.b11.com red

# Autentikasi
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic realm UserName
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
acl luffy proxy_auth luffybelikapalB11
acl zoro proxy_auth zorobelikapalB11

# Blacklist dan Whitelist
acl pngjpg url_regex "/etc/squid/pngjpg.files.acl"
acl block url_regex "/etc/squid/blocked.acl"

# Speed limit luffy
delay_pools 1
delay_class 1 1
delay_access 1 allow luffy
delay_parameters 1 1250/8000

# Akses proxy
http_access deny luffy block !pngjpg

# Akses proxy
http_access deny luffy block !pngjpg
http_access allow AVAILABLE_WORKING luffy
http_access allow luffy pngjpg
http_access deny zoro pngjpg
http_access allow AVAILABLE_WORKING zoro
' > /etc/squid/squid.conf

# Buat user
htpasswd -c /etc/squid/passwd luffybelikapalB11 # luffy_B11
htpasswd /etc/squid/passwd zorobelikapalB11 # zoro_B11

# Waktu akses
echo '
acl AVAILABLE_WORKING time MTWH 07:00-11:00
acl AVAILABLE_WORKING time TWHF 17:00-23:59
acl AVAILABLE_WORKING time A    00:00-03:00
' > /etc/squid/acl.conf

# Regex png dan jpg
echo 'public\/images\/(.*)\.(png|jpg)$' > /etc/squid/pngjpg.files.acl

# Regex blocked
echo 'public\/images\/(.*)\.(.*)$' > /etc/squid/blocked.acl

# Tambahkan host agar bisa mengakses Skypie
echo '
127.0.1.1       Water7
127.0.0.1       localhost
192.182.3.69      super.franky.b11.com
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
' > /etc/hosts

# Restart squid
service squid restart