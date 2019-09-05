# yapi+mongodb docker-compose 脚本

## 软件版本
[yapi 1.8.3](https://github.com/YMFE/yapi)

mongodb

## 安装docker
``` bash
$ curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -

$ service docker restart
```

## 安装docker-compose
``` bash
# 下载文件
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# 设置权限
sudo chmod +x /usr/local/bin/docker-compose

# 检测是否安装成功
$ docker-compose version
#docker-compose version 1.24.1, build 4667896b
#docker-py version: 3.7.3
#CPython version: 3.6.8
#OpenSSL version: OpenSSL 1.1.0j  20 Nov 2018
```

## 使用
### 初始化
首先初始化文件夹
``` bash
bash init.sh
```

### 启动
``` bash
docker-compose up -d
```

### 访问
http://your-ip:3000

### TODO
- 可用nginx做反代
- 将nginx加入docker-compose编排
