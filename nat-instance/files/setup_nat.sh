#!/bin/bash

apt-get update
apt install -y firewalld

# Firewall rules
default_iface=$(ip route get 8.8.8.8 | grep -Po '(?<=(dev ))(\S+)')
firewall-offline-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o $default_iface -j MASQUERADE
firewall-offline-cmd --direct --add-rule ipv4 filter FORWARD 0 -i $default_iface -j ACCEPT
/bin/systemctl restart firewalld

# sysctl conf
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/98-ip-forward.conf
sysctl -p /etc/sysctl.d/98-ip-forward.conf