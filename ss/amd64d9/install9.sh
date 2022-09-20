#!/bin/bash

OBFS='http'
PORT='80'
PASSWORD='MoeClub.org'
METHOD='chacha20-ietf-poly1305'

DataURL='https://3351365.github.io/ss'
kBit=$(getconf LONG_BIT)
[ "$kBit" == '32' ] && Bit='i386'
[ "$kBit" == '64' ] && Bit='amd64'

mkdir -p /tmp
cd /tmp

apt-get -q update
apt-get install -y --no-install-recommends -f -qq apg asciidoc debhelper po-debconf intltool-debian libev-dev libpcre3-dev pkg-config xmlto libcap2-bin libpam-cap

DebList="libc-bin_2.24-11+deb9u4_$Bit.deb libc6_2.24-11+deb9u4_$Bit.deb locales-all_2.24-11+deb9u4_$Bit.deb libc-dev-bin_2.24-11+deb9u4_$Bit.deb libc6-dev_2.24-11+deb9u4_$Bit.deb libudns0_0.4-1+b1_$Bit.deb libc-ares2_1.14.0-1~bpo9+1_$Bit.deb libc-ares-dev_1.14.0-1~bpo9+1_$Bit.deb libsodium23_1.0.17-1~bpo9+1_amd64_$Bit.deb libsodium-dev_1.0.17-1~bpo9+1_$Bit.deb libcork16_0.15.0+ds-11_$Bit.deb libcork-dev_0.15.0+ds-11_$Bit.deb libcorkipset1_1.1.1+20150311-7_$Bit.deb libcorkipset-dev_1.1.1+20150311-7_$Bit.deb libbloom1_1.6-3~bpo9+1_$Bit.deb libbloom-dev_1.6-3~bpo9+1_$Bit.deb libmbedcrypto0_2.4.2-1+deb9u4_$Bit.deb libmbedx509-0_2.4.2-1+deb9u4_$Bit.deb libmbedtls10_2.4.2-1+deb9u4_$Bit.deb libmbedtls-dev_2.4.2-1+deb9u4_$Bit.deb libjsonparser1.1_1.1.0-1~bpo9+1_$Bit.deb shadowsocks-libev_3.3.5+ds-1~bpo9+1_$Bit.deb simple-obfs_0.0.5-5~bpo9+1_$Bit.deb"

for DebINS in `echo $DebList`
do
  echo -ne '\033[33m'${DebINS}'\033[0m\t'
  [ -f ''${DebINS}'' ] || wget --no-check-certificate -q ''${DataURL}'/amd64d9/'${DebINS}''
  DEBIAN_FRONTEND=noninteractive dpkg -i --ignore-depends=libc6,locales,libpcre3,init-system-helpers ''${DebINS}'' >>/dev/null 2>&1
  [ $? == '0' ] && echo -e '\033[33m[\033[32mok\033[33m] \033[0m' || echo -e '\033[33m[\033[31mfail\033[33m] \033[0m'
done 

mkdir -p /etc/shadowsocks-libev
cat>/etc/shadowsocks-libev/config.json<<EOF
{
    "server":"0.0.0.0",
    "server_port":$PORT,
    "local_port":1080,
    "password":"$PASSWORD",
    "timeout":600,
    "method":"$METHOD",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=$OBFS"
}

EOF
cat>/etc/shadowsocks-libev/config-obfs.json<<EOF
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"$PASSWORD",
    "timeout":600,
    "method":"$METHOD",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"obfs-server",
    "plugin_opts":"obfs=$OBFS;failover=127.0.0.1:8443;fast-open"
}
EOF

[ -f /etc/init.d/shadowsocks-libev ] && bash /etc/init.d/shadowsocks-libev restart


