FROM ubuntu:20.04

RUN apt update && apt install -y git curl build-essential libssl-dev zlib1g-dev

WORKDIR /app
COPY . /app

RUN make

EXPOSE 443

CMD ./objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S 11223344556677889900aabbccddeeff --aes-pwd proxy-secret proxy-multi.conf -M 1
