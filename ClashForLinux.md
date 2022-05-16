## Clash for linux

### 下载和安装

下载[Clash](https://github.com/Dreamacro/clash/releases)对应版本并解压

``` bash
wget https://github.com/Dreamacro/clash/releases/download/v1.10.6/clash-linux-amd64-v1.10.6.gz
gzip -d clash-linux-amd64-v1.10.6.gz
```

得到`clash-linux-amd64-v3-v1.10.6`，将其移动至`usr/bin/`目录下并重命名为`clash`

```
sudo mv clash-linux-amd64-v3-v1.10.6 /usr/bin/clash
```

赋予运行权限`sudo chmod +x /usr/bin/clash`

测试是否安装成功`clash -v`

为 clash 添加绑定低位端口的权限，这样运行clash的时候无需root权限

```
sudo setcap cap_net_bind_service=+ep /usr/bin/clash
```

创建`～/.config/clash`目录，将配置文件`config.yaml`和`Country.mmdb`放入此文件夹中。（其中`config.yaml`从机场下载，文件名重命名为`config.yaml`）。

直接运行命令`clash`，正常运行结果如下

```
$ clash     
INFO[0000] Start initial compatible provider Proxy      
INFO[0000] Start initial compatible provider Domestic   
INFO[0000] Start initial compatible provider Others     
INFO[0000] Start initial compatible provider GlobalTV   
INFO[0000] Start initial compatible provider AsianTV
```

### 开机启动

创建service文件

```
sudo touch /etc/systemd/system/clash.service
```

添加以下内容

```
[Unit]
Description=clash daemon

[Service]
Type=simple
User=ubuntu
ExecStart=/usr/bin/clash -d /home/ubuntu/.config/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

重新加载 systemd 模块

```
sudo systemctl daemon-reload
```

设置为开机启动

```
sudo systemctl enable clash.service
```

相关命令

```
## 启动Clash ##
sudo systemctl start clash.service

## 重启Clash ##
sudo systemctl restart clash.service

## 查看Clash运行状态 ##
sudo systemctl status clash.service

## 实时滚动状态 ##
sudo journalctl -u clash.service -f

## 取消Clash开机启动 ##
sudo systemctl disable clash.service
```
