FROM ubuntu:20.04

RUN apt update && apt install -y git curl build-essential libssl-dev zlib1g-dev

WORKDIR /mtproxy
RUN git clone --recursive https://github.com/TelegramMessenger/MTProxy . && make

EXPOSE 443

CMD ./objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S 11223344556677889900aabbccddeeff --allow-skip-dh -M 1
