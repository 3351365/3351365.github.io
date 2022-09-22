#!/bin/bash
DataURL='https://3351365.github.io/ss'
kBit=$(getconf LONG_BIT)
[ "$kBit" == '32' ] && Bit='i386'
[ "$kBit" == '64' ] && Bit='amd64'
mkdir -p /tmp
cd /tmp
apt-get -q update
apt-get install -y --no-install-recommends -f -qq apg asciidoc debhelper po-debconf intltool-debian libev-dev libpcre3-dev pkg-config xmlto libcap2-bin libpam-cap
DebList="shadowsocks-v2ray-plugin_1.3.1-3+b6_$Bit.deb"
for DebINS in `echo $DebList`
do
  echo -ne '\033[33m'${DebINS}'\033[0m\t'
  [ -f ''${DebINS}'' ] || wget --no-check-certificate -q ''${DataURL}'/amd64d11/'${DebINS}''
  DEBIAN_FRONTEND=noninteractive dpkg -i --ignore-depends=libc6,locales,libpcre3,init-system-helpers ''${DebINS}'' >>/dev/null 2>&1
  [ $? == '0' ] && echo -e '\033[33m[\033[32mok\033[33m] \033[0m' || echo -e '\033[33m[\033[31mfail\033[33m] \033[0m'
done 
