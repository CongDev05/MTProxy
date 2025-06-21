FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài g++ và các thư viện cần thiết
RUN apt update && apt install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libpcre3-dev \
    libevent-dev \
    ca-certificates \
    make \
    && rm -rf /var/lib/apt/lists/*

# Clone source MTProxy chính chủ
RUN git clone https://github.com/TelegramMessenger/MTProxy.git /MTProxy

WORKDIR /MTProxy

# Build project
RUN make

# Tạo biến môi trường hoặc sửa tại đây
ENV PORT=443
ENV TAG=ffffffffffffffffffffffffffffffff
ENV SECRET=0123456789abcdef0123456789abcdef

# Cổng Render.com sẽ tự động map PORT env
EXPOSE $PORT

# CMD chạy proxy
CMD ./objs/bin/mtproto-proxy \
  -u nobody \
  -p $PORT \
  -H $PORT \
  -S $SECRET \
  -P $TAG \
  -M 1
