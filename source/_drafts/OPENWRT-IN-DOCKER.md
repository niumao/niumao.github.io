---
title: OPENWRT IN DOCKER
tags:
---
failed
NETWORK:
ip link set eno1 promisc on
docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=eno1 dockervlan
docker run -itd --cap-add=NET_ADMIN --name openwrt --ip=192.168.1.111 --network dockervlan openwrtorg/rootfs:x86_64-22.03.3

PREPARE:
opkg remove dnsmasq 
rm -rf /etc/config/dhcp 
opkg install dnsmasq-full wget-ssl luci-compat coreutils libustream-openssl ca-bundle ca-certificates luci-lib-ipkg kmod-tcp-bbr 
opkg list-upgradable | cut -f 1 -d ' ' | xargs 
opkg upgrade 
sed -i 's/downloads.openwrt.org/mirrors.ustc.edu.cn\/openwrt/g' /etc/opkg/distfeeds.conf
opkg update

CONFIG:
opkg install luci-app-travelmate
opkg install luci
/etc/init.d/uhttpd enable
/etc/init.d/uhttpd start

host 2 container

ip link add hclink link eno1 type macvlan mode bridge
ip addr add 192.168.1.112 dev hclink
ip link set hclink up
ip route add 192.168.1.111 dev hclink

COMMUNICATE:
docker run -itd --name busybox2 --ip=192.168.1.112 --network dockervlan busybox
docker exec -it busybox2 /bin/sh
docker network create -d macvlan --subnet=172.16.20.0/24 --gateway=172.16.20.1 -o parent=enp0s3 macvlan2

OPENWRT:
opkg remove dnsmasq 
rm -rf /etc/config/dhcp 
opkg install dnsmasq-full wget-ssl luci-compat coreutils libustream-openssl ca-bundle ca-certificates luci-lib-ipkg kmod-tcp-bbr
opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade
sed -i 's/downloads.openwrt.org/mirrors.ustc.edu.cn\/openwrt/g' /etc/opkg/distfeeds.conf
opkg update

Internation:
luci-i18n-base-zh-cn

PASSWALL:
luci-i18n-passwall-zh-cn

ref:http://dockeradv.baoshu.red/advanced_network/macvlan.html
