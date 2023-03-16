#!/bin/bash
# Author: Mao Niu 
# PURPOSE:
# SET UP HEXO WITH THEME NEXT SIMPLE

if [ -z "$1" ]; then
    echo "no params!"
    echo "do: bash run.sh [init|goon]"
    exit
fi

if [ $1 == "init" ]; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs
    npm config set registry=https://registry.npmmirror.com
    npm install hexo
    export PATH=`pwd`/node_modules/hexo-cli/bin/:$PATH 
    hexo init /gp
    cd /gp
    npm install
    git clone https://github.com/theme-next/hexo-theme-next themes/next
    cd themes/next
    npm install
    npm install hexo-generator-searchdb
    cd ../..
    hexo g
    hexo s
elif [ $1 == "goon" ]; then
    npm install
    git clone https://github.com/theme-next/hexo-theme-next themes/next
    cd themes/next
    npm install
else
    echo "fail"
    exit
fi
