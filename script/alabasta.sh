#!/bin/bash

# Update dan install
apt update
apt install lynx speedtest-cli -y

# Nonaktifkan verivikasi certificate pada saat menjalankan script python
export PYTHONHTTPSVERIFY=0

# Sambungkan dengan proxy
export http_proxy="http://192.182.2.3:5000"