FROM　linuxserver/transmission:latest

LABEL maintainer="Mindzy"

ENV WEBUI_VERSION=v1.6.1-update1

RUN apk add --no-cache \
    curl && \
    curl -fSL https://github.com/ronggang/transmission-web-control/archive/${WEBUI_VERSION}.zip -o twc.zip && \
    unzip twc.zip -d /tmp && \
    mv -f /usr/share/transmission/web/index.html /usr/share/transmission/web/index.original.html && \
    cp -rf /tmp/transmission-web-control-${WEBUI_VERSION}/src/* /usr/share/transmission/web/ && \
    rm -rf /tmp/* && \
    apk del curl


ENV TZ=Asia/Shanghai
ENV GUID=0
ENV PUID=0

COPY /root/ /

EXPOSE 9091 51413
VOLUME /config /downloads /watch
