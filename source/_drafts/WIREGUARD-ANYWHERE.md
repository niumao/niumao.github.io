---
title: WIREGUARD ANYWHERE
tags:
---
SERVER:
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.proxy_arp = 1" >> /etc/sysctl.conf
sysctl -p
mkdir -p /etc/wireguard 
chmod  0777 /etc/wireguard
cd /etc/wireguard
umask 077
wg genkey | tee privatekey-server | wg pubkey > publickey-server

echo "
[Interface]
Address = 10.10.10.1/16
SaveConfig = true
ListenPort = 12333
PrivateKey = IMCN6RTE41W2OTairJFXot0GIHBEo8xvEfPqsK9uqkM=
PostUp   = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
[Peer]
PublicKey = 
AllowedIPs = 10.10.10.2/16					
" > wg0.conf


wg syncconf wg0 < (wg-quick strip wg0)

wg-quick up wg0
wg
systemctl enable wg-quick@wg0

CLIENT:
mkdir -p /etc/wireguard 
chmod  0777 /etc/wireguard
cd /etc/wireguard
umask 077
wg genkey | tee privatekey-client | wg pubkey > publickey-client

wg0.conf:
[Interface]
PrivateKey = 
Address = 10.10.10.2/32
DNS = 8.8.8.8
MTU = 1280

[Peer]
PublicKey = bbR1Y/JpCCeoGa3FITNJhacxWSywYcLoJUdLe6fdEX4=
Endpoint = 117.50.181.40:12333  
AllowedIPs = 10.10.10.0/16,172.17.0.11/20 
PersistentKeepalive = 25

wg-quick up ./wg0.conf
wg


TIPS:
wg/[wg show]
wg showconf

wg pubkey < privatekey > publickey


REF:
https://blog.csdn.net/qq_20042935/article/details/127089626
https://cloud.tencent.com/developer/article/1985793
