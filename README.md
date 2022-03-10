# Ubuntu-config

#### 介绍
Ubuntu 20.04 LTS 配置脚本

## 安装zsh
```
sudo apt install zsh
```
## 修改默认路由（网关）
如果使用网关代理使用下方命令，IP地址根据实际修改。
```
修改默认网关
ip route add default via 192.168.0.121
删除默认网关
ip route del default
```
## 安装ohmyzsh

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## zsh-autosuggestion 自动补全
安装完zsh后
```
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

打开`.zshrc`添加`zsh-autosuggestions`
```
plugins=(git zsh-autosuggestions)
```
## Ubuntu 使用代理服务器使用方法
### 修改`proxy-ubuntu.sh`中的地址和端口，然后保存
```
hostip=192.168.0.150
port=7890
```
### 设置代理
```
source ./proxy-ubuntu.sh set
```
### 取消代理
```
source ./proxy-ubuntu.sh unset
```
### 查看代理
```
source ./proxy-ubuntu.sh test
```
## WSL2 代理配置
修改`proxy-wsl2.sh`中的端口，然后保存，使用方法和上面介绍相同。

第一次使用需要设置Windows主机的防火墙：

### 查看Ubuntu的IP
在WSL2中查看Ubuntu的ip地址，使用命令`ip addr show`结果如下：

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 76:25:32:6d:32:78 brd ff:ff:ff:ff:ff:ff
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 1e:db:4c:d2:39:0a brd ff:ff:ff:ff:ff:ff
4: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/ipip 0.0.0.0 brd 0.0.0.0
5: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:b2:b8:a5 brd ff:ff:ff:ff:ff:ff
    inet 172.28.252.63/20 brd 172.28.255.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:feb2:b8a5/64 scope link
       valid_lft forever preferred_lft forever
```

其中第6组数据中的`172.28.252.63`就是WSL2中Ubuntu的IP地址。

### 新建防火墙入站规则

Windows系统下，`控制面板->系统安全->Windows Defender 防火墙->高级设置->入站规则->新建规则`

- 规则类型：自定义
- 程序：所有程序
- 协议和端口：任何
- 作用域：
    - 本地ip处选择“任何IP地址”
    - 远程ip处选择“下列IP地址”，并将wsl2的IP添加进去。（请根据自己WSL2的ip进行计算，我这里添加了172.28.252.63/20）（掩码一般是20位）
- 操作：允许连接
- 配置文件：三个全选
- 名称描述：请自定义

### 在Ubuntu中查看Windows主机的IP地址

运行命令

```
cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'
```

结果如下：

```
172.28.240.1
```

运行命令：

```
ping 172.28.240.1
```

结果如下：

```
lituo@DESKTOP-SG8Q3FM:~$ ping 172.28.240.1
PING 172.28.240.1 (172.28.240.1) 56(84) bytes of data.
64 bytes from 172.28.240.1: icmp_seq=1 ttl=128 time=0.241 ms
64 bytes from 172.28.240.1: icmp_seq=2 ttl=128 time=0.328 ms
64 bytes from 172.28.240.1: icmp_seq=3 ttl=128 time=0.340 ms
```
注意：完成上一步防火墙入站规则后，从WSL2 ping主机的ip应该可以ping通了。