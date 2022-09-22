#!/bin/bash
arch="$(dpkg --print-architecture)"
[ -n "$arch" ] || exit 1
[ "$arch" == 'amd64' -o "$arch" == 'i386' ] || exit 1
wget --no-check-certificate -qO "/tmp/shadowsocks-v2ray-plugin_1.3.1-3+b6_${arch}.deb" "https://3351365.github.io/ss/amd64d11/shadowsocks-v2ray-plugin_1.3.1-3+b6_${arch}.deb"
dpkg -i "/tmp/shadowsocks-v2ray-plugin_1.3.1-3+b6_${arch}.deb"
