FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài công cụ cần thiết
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

# Clone mã nguồn MTProxy chính thức
RUN git clone https://github.com/TelegramMessenger/MTProxy.git /MTProxy

WORKDIR /MTProxy

# Build MTProxy
RUN make

# Cấu hình biến môi trường
ENV PORT=443
ENV TAG=abcdef0123456789abcdef0123456789
ENV SECRET=a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6

EXPOSE ${PORT}

# Chạy proxy (Sử dụng `exec` và `&&` để đảm bảo có log ra stdout)
CMD ["sh", "-c", "./objs/bin/mtproto-proxy -u nobody -p $PORT -H $PORT -S $SECRET -P $TAG -M 1 -v 3"]
