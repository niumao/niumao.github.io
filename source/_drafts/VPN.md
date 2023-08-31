---
title: VPN
tags:
---
MESH:
nebula:
1.download
wget https://github.com/slackhq/nebula/releases/download/v1.7.2/nebula-linux-amd64.tar.gz
tar zxvf nebula-linux-amd64.tar.gz
2.lighthouse
./nebula-cert ca -name "Myorg, Inc"
./nebula-cert sign -name "lighthouse" -ip "192.168.100.1/24"
./nebula-cert sign -name "pixel" -ip "192.168.100.5/24"
./nebula-cert sign -name "server" -ip "192.168.100.9/24"
curl -o config.yml https://raw.githubusercontent.com/slackhq/nebula/master/examples/config.yml
cp config.yml config-lighthouse.yaml
cp config.yml config.yaml
3.start
mkdir /etc/nebula
cp config-lighthouse.yaml /etc/nebula/config.yaml
cp ca.crt /etc/nebula/ca.crt
cp lighthouse.crt /etc/nebula/host.crt
cp lighthouse.key /etc/nebula/host.key
/opt/nebula/nebula -config config.yml
test:
mkdir /etc/nebula
cp config.yaml /etc/nebula/config.yaml
cp ca.crt /etc/nebula/ca.crt
cp server.crt /etc/nebula/host.crt
cp server.key /etc/nebula/host.key
