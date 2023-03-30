---
title: OPENWRT PLUGINS
tags:
---
PREPARE:
docker run -itd --privileged=true --name openwrt openwrtorg/sdk:x86_64-22.03.3 

PASSWALL:
echo "src-git pw_packages https://github.com/xiaorouji/openwrt-passwall.git;packages" >> feeds.conf.default
echo "src-git pw_luci https://github.com/xiaorouji/openwrt-passwall.git;luci" >> feeds.conf.default
./scripts/feeds clean
mkdir -p /home/build/openwrt/feeds/luci
git clone https://github.com/openwrt/luci.git
cp luci/luci.mk /home/build/openwrt/feeds/luci/
mkdir  -p /home/build/openwrt/feeds/packages/lang/
svn co https://github.com/openwrt/packages/branches/openwrt-21.02/lang/golang
cp -r golang /home/build/openwrt/feeds/packages/lang/ 
./scripts/feeds update -a
#./scripts/feeds install -a
./scripts/feeds install -a -f -p pw_packages
./scripts/feeds install luci-app-passwall
make defconfig
make menuconfig
make -j8 download V=s
make -j8 V=s
ls /home/build/openwrt/bin/packages/x86_64/passwall_packages/

tips:
UPX:
apt-get update

apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex quilt uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev xsltproc libxml-parser-perl mercurial bzr ecj cvs texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf
apt-get install upx -y
cp /usr/bin/upx staging_dir/host/bin
cp /usr/bin/upx-ucl staging_dir/host/bin

./scripts/feeds install luci-app-passwall

make package/luci-app-passwall/{clean,compile} -j4
#debug
make package/luci-app-passwall/compile V=99

生成 index 和签名
make package/index

make package/trojan/compile V=99
编译出来后的固件路径:/home/xiaoxie/openwrt/bin/targets/x86/64

ipk rep：
https://op.dllkids.xyz
定义固件：
https://op.supes.top
固件：
https://openwrt.mpdn.fun:8443
更新快：https://github.com/zhangguanzhang/Actions-OpenWrt

passwall  优选ip

ss:
https://linhongbo.com/posts/shadowsocks-on-openwrt/
https://github.com/xiaorouji/openwrt-passwall/discussions/1603 
