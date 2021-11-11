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
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      jualbelikapal.b11.com.
@       IN      A       192.182.2.2
' > /etc/bind/dns/jualbelikapal.b11.com

# Buat file konfigurasi super.franky.b11.com
echo '
$TTL    604800
@       IN      SOA     super.franky.b11.com. root.super.franky.b11.com. (
                     2021110801         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@               IN      NS      super.franky.b11.com.
@               IN      A       192.182.3.69
' > /etc/bind/dns/super.franky.b11.com

# Tambahkan zone
echo '
zone "jualbelikapal.b11.com" {
        type master;
        file "/etc/bind/dns/jualbelikapal.b11.com";
};

zone "super.franky.b11.com" {
        type master;
        file "/etc/bind/dns/super.franky.b11.com";
};
' > /etc/bind/named.conf.local

# Tambahkan forwarder
echo '
options {
        directory "/var/cache/bind";
        forwarders {
                192.168.122.1;
        };

        // dnssec-validation auto;
        allow-query { any; };
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

# Restart bind9
service bind9 restart
