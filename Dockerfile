FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git curl build-essential libssl-dev zlib1g-dev && \
    git clone https://github.com/TelegramMessenger/MTProxy.git /mtproxy && \
    cd /mtproxy && \
    make

WORKDIR /mtproxy

EXPOSE 443

CMD ./objs/bin/mtproto-proxy \
  -u nobody \
  -p 443 \
  -H 443 \
  -S ee11223344556677889900aabbccddeeff \
  -M 1 \
  -P 00000000000000000000000000000000
