#!/bin/bash

# Lakukan postrouting
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.182.0.0/16

# Update dan install
apt update
apt install isc-dhcp-relay -y

# Edit isc-dhcp-relay sehingga mengarah ke DHCP server
echo '
SERVERS="192.182.2.4"

INTERFACES=""

OPTIONS=""
' > /etc/default/isc-dhcp-relay

# Restart DHCP relay
service isc-dhcp-relay restart