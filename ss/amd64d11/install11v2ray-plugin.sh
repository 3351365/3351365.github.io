#!/bin/bash
arch="$(dpkg --print-architecture)"
wget --no-check-certificate -qO "/tmp/shadowsocks-v2ray-plugin_1.3.1-3+b6_amd64.deb" "https://3351365.github.io/ss/amd64d11/shadowsocks-v2ray-plugin_1.3.1-3+b6_amd64.deb"
dpkg -i "/tmp/shadowsocks-v2ray-plugin_1.3.1-3+b6_amd64.deb"
