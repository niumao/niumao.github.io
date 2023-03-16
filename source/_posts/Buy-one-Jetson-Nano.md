---
title: Buy one Jetson Nano
date: 2023-03-17 01:40:20
categories:
tags:
description: some what i occured with jetson Nano
---
wifi:
nmcli device wifi connect WIFI password PASS

sample:
/usr/local/cuda/samples
cd 5_Simulations/oceanFFT/ 
make
./oecanFFT
cd 5_Simulations/nbody/
./nbody 
./nbody -cpu
3.ls /dev/video*
v4l-utils v4l2-ctl --list-formats-ext --device=/dev/video0
