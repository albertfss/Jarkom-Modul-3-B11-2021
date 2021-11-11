#!/bin/bash

# Tambahkan nameserver ke /etc/resolv.conf
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Update dan install
apt update
apt install bind9 -y

# Buat direktori baru
mkdir /etc/bind/dns

# Buat file konfigurasi jualbelikapal.b11.com
echo '
$TTL    604800
@       IN      SOA     jualbelikapal.b11.com. root.jualbelikapal.b11.com. (
                     2021110801         ; Serial
                         604800         ; Refresh
                          86400         ; Retry