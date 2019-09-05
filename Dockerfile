FROM node:lts-alpine as builder
COPY yapi-1.8.3.tar.gz /home
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
  apk add --no-cache bash curl git python make openssl tar gcc && \
  cd /home && \
  tar zxvf yapi-1.8.3.tar.gz && \
  mv /home/yapi-1.8.3 /home/vendors && \
  cd /home/vendors && \
  ret=`curl -s  https://api.ip.sb/geoip | grep China | wc -l` && \
  if [ $ret -ne 0 ]; then \
    npm config set registry https://registry.npm.taobao.org; \
  fi; \
  npm install -g node-gyp yapi-cli && \
  npm install --production

FROM node:lts-alpine
MAINTAINER master@imhx.me
ENV VERSION     1.8.3
ENV TZ          "Asia/Shanghai"
ENV HOME        "/home"
ENV PORT        3000
ENV ADMIN_EMAIL "master@imhx.me"
ENV DB_SERVER   "mongo"
ENV DB_NAME     "yapi"
ENV DB_PORT     27017
ENV VENDORS     ${HOME}/vendors
ENV GIT_URL     https://github.com/YMFE/yapi.git
ENV GIT_MIRROR_URL  https://gitee.com/mirrors/YApi.git

WORKDIR ${HOME}/
# 这里要从builder里面拷贝过来，不然没有这个目录和文件
COPY --from=builder /home/vendors ${VENDORS}
COPY config.json ${VENDORS}
COPY entrypoint.sh /usr/local/bin
COPY wait-for-it.sh /

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chmod +x /wait-for-it.sh

EXPOSE ${PORT}
ENTRYPOINT ["node"]
