#!/bin/bash

# Tambahkan nameserver ke /etc/resolv.conf
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Update dan install
apt update
apt install isc-dhcp-server -y

# Tambahkan interface yang mengarah ke router (Foosha)
echo 'INTERFACES="eth0"' > /etc/default/isc-dhcp-server

# Edit konfigurasi DHCP server
echo '
# Switch 2 (penghubung DHCP server ke DHCP relay)
subnet 192.182.2.0 netmask 255.255.255.0 {
}

# Switch 1 (Loguetown dan Alabasta)
subnet 192.182.1.0 netmask 255.255.255.0 {
        range 192.182.1.20 192.182.1.99;
        range 192.182.1.150 192.182.1.169;
        option routers 192.182.1.1;
        option broadcast-address 192.182.1.255;
        option domain-name-servers 192.182.2.2;
        default-lease-time 360;
        max-lease-time 7200;
}

# Switch 3 (TottoLand)
subnet 192.182.3.0 netmask 255.255.255.0 {
        range 192.182.3.30 192.182.3.50;
        option routers 192.182.3.1;
        option broadcast-address 192.182.3.255;
        option domain-name-servers 192.182.2.2;
        default-lease-time 720;
        max-lease-time 7200;
}

# Fix address buat Skypie
host Skypie {
        hardware ethernet a2:14:f1:99:8c:7e;
        fixed-address 192.182.3.69;
}
' > /etc/dhcp/dhcpd.conf