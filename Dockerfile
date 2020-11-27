FROM docker.io/linuxserver/transmission:latest

LABEL maintainer="Mindzy"

RUN apk add --no-cache \
    curl && \
    WEBUI_VERSION=$(curl https://github.com/ronggang/transmission-web-control/releases/latest | cut -d'"' -f 2 | cut -d'/' -f 8) && \
    curl -fSL https://github.com/ronggang/transmission-web-control/archive/${WEBUI_VERSION}.zip -o twc.zip && \
    unzip twc.zip -d /tmp && \
    mv -f /usr/share/transmission/web/index.html /usr/share/transmission/web/index.original.html && \
    cp -rf /tmp/transmission-web-control-$(echo $WEBUI_VERSION | cut -c2-)/src/* /usr/share/transmission/web/ && \
    rm -rf /tmp/* && \
    apk del curl

ENV TZ=Asia/Shanghai
ENV GUID=0
ENV PUID=0

EXPOSE 9091 51413
VOLUME /config /downloads /watch
