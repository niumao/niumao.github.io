---
title: CROSS THE WALL
tags:
---
SS:
apt update && apt install shadowsocks-libev
vim /etc/shadowsocks-libev/config.json
{
  "server":"x.x.x.x",
  "server_port":33333,
  "local_address":"127.0.0.1",
  "local_port":1080,
  "password":"hohng3sho5S",
  "timeout":300,
  "method":"aes-128-gcm",
  "fast_open": false
}
/etc/init.d/shadowsocks-libev start
systemctl start shadowsocks-libev
