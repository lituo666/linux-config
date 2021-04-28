# Ubuntu-config

#### 介绍
Ubuntu 20.04 LTS 配置脚本

## zsh-autosuggestion 自动补全
安装完zsh后
```
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

打开`.zshrc`添加`zsh-autosuggestion`
```
plugins=(git zsh-autosuggestion)
```