FROM ubuntu:16.04
ARG nghttp2ver=1.11.1
ARG nghttp2dep="curl g++ make binutils autoconf automake autotools-dev libtool pkg-config zlib1g-dev libssl-dev libev-dev libjemalloc-dev"
RUN mkdir /build && \
  cd /build && \
  apt-get update && \
  apt-get install -y ${nghttp2dep} && \
  curl -L -m 300 https://github.com/nghttp2/nghttp2/releases/download/v${nghttp2ver}/nghttp2-${nghttp2ver}.tar.xz | tar -x -J -C /build && \
  cd /build/nghttp2-${nghttp2ver} && \
  export PKG_CONFIG="pkg-config --static" && \
  export LDFLAGS="-static-libgcc -static-libstdc++ -static" && \
  ./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --disable-xmltest --with-libxml2=no --with-spdylay=no --enable-static --disable-shared && \
  make clean install && \
  rm -rf /build && \
  apt-get remove -y ${nghttp2dep} && \
  apt-get autoremove --purge -y && \
  rm -rf /var/lib/apt/lists/*

  
