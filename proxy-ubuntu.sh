#!/bin/sh
# 修改代理地址和端口号
hostip=192.168.0.150
port=7890
socks5port=7891

PROXY_HTTP="http://${hostip}:${port}"

set_proxy(){
    export http_proxy="${PROXY_HTTP}"
    export HTTP_PROXY="${PROXY_HTTP}"

    export https_proxy="${PROXY_HTTP}"
    export HTTPS_proxy="${PROXY_HTTP}"

    export all_proxy="socks5://${hostip}:${socks5port}"

    git config --global http.proxy "${all_proxy}"
    git config --global https.proxy "${all_proxy}"
}

set_proxy_git(){
    git config --global http.proxy "${all_proxy}"
    git config --global https.proxy "${all_proxy}"
}

unset_proxy(){
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset all_proxy

    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

test_setting(){
    echo "Host ip:" ${hostip}
    echo "Current proxy:" $https_proxy
}
if [ "$1" = "set" ]
then
    set_proxy
elif [ "$1" = "setgit" ]
then
    set_proxy_git
elif [ "$1" = "unset" ]
then
    unset_proxy

elif [ "$1" = "test" ]
then
    test_setting
else
    echo "Unsupported arguments."
fi
