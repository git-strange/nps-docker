FROM alpine:3.12
MAINTAINER docker <>

ENV NPS_VERSION 0.26.10
ENV MODE kcp
ENV WEB_PASSWORD password
ENV PUBLIC_VKEY 12345678
ENV BRIDGE_PORT 8024
ENV ALLOW_POSTS "53,9001-9009,10001,11000-12000"
ENV HTTP_PROXY_PORT 80
ENV HTTPS_PROXY_PORT 443
ENV DOMAIN nps.panyan.tech
ENV TZ=Asia/Shanghai
LABEL name=nps


WORKDIR /

RUN set -x && \
        apk add -U tzdata ca-certificates openssl && \
	wget --no-check-certificate https://github.com/cnlh/nps/releases/download/v${NPS_VERSION}/linux_amd64_server.tar.gz && \ 
	tar xzf linux_amd64_server.tar.gz && \
        wget --no-check-certificate https://github.com/cnlh/nps/releases/download/v${NPS_VERSION}/linux_amd64_client.tar.gz && \
        tar xzf linux_amd64_client.tar.gz && \
	rm -rf *.tar.gz
  
VOLUME /conf
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
