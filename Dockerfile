FROM ubuntu:16.04

RUN mkdir /build
WORKDIR /build
ARG MAKE_J=1

ARG BUILD_DEP="curl xz-utils g++ make binutils autoconf automake autotools-dev libtool pkg-config"

ARG ZLIB_VER=1.2.8
ARG ZLIB_MD5=28f1205d8dd2001f26fec1e8c2cebe37

ARG LIBEV_VER=4.22
ARG LIBEV_SHA256=736079e8ac543c74d59af73f9c52737b3bfec9601f020bf25a87a4f4d0f01bd6

ARG OPENSSL_VER=1.0.2h
ARG OPENSSL_SHA256=1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919

ARG NGHTTP2_VER=1.12.0
ARG NGHTTP2_SHA256=445c24243b8132b031c2c9fc9fe99f5abadbce2db4fbdf7eb6d3beaa5797dd4b

RUN apt-get update && apt-get install -y ${BUILD_DEP} &&\
  curl -L -m 300 -o zlib.tar.xz http://zlib.net/zlib-${ZLIB_VER}.tar.xz &&\
  echo "$ZLIB_MD5 zlib.tar.xz" > zlib.md5 &&\
  md5sum -c zlib.md5 &&\
  tar xf zlib.tar.xz &&\
  mv zlib-${ZLIB_VER} zlib &&\
  rm -f zlib.md5 zlib.tar.xz &&\
  cd zlib &&\
  ./configure --static &&\
  make clean install -j${MAKE_J} &&\
  cd .. &&\
  rm -rf zlib &&\
  curl -L -m 300 -o libev.tar.gz http://dist.schmorp.de/libev/libev-${LIBEV_VER}.tar.gz &&\
  echo "${LIBEV_SHA256} libev.tar.gz" > libev.sha256 &&\
  sha256sum -c libev.sha256 &&\
  tar xf libev.tar.gz &&\
  mv libev-${LIBEV_VER} libev &&\
  rm -f libev.sha256 libev.tar.gz &&\
  cd libev &&\
  ./configure --enable-static --disable-shared &&\
  make clean install -j${MAKE_J} &&\
  cd .. &&\
  rm -rf libev &&\
  curl -L -m 300 -o openssl.tar.gz https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz &&\
  echo "${OPENSSL_SHA256} openssl.tar.gz" > openssl.sha256 &&\
  sha256sum -c openssl.sha256 &&\
  tar xf openssl.tar.gz &&\
  mv openssl-${OPENSSL_VER} openssl &&\
  rm -f openssl.sha256 openssl.tar.gz &&\
  cd openssl &&\
  ./config zlib &&\
  make clean install &&\
  cd .. &&\
  rm -rf openssl &&\
  curl -L -m 300 -o nghttp2.tar.xz https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VER}/nghttp2-${NGHTTP2_VER}.tar.xz &&\
  echo "${NGHTTP2_SHA256} nghttp2.tar.xz" > nghttp2.sha256 &&\
  sha256sum -c nghttp2.sha256 &&\
  tar -xf nghttp2.tar.xz && \
  mv nghttp2-${NGHTTP2_VER} nghttp2 &&\
  rm -f nghttp2.sha256 nghttp2.tar.xz &&\
  cd nghttp2 && \
  export PKG_CONFIG_PATH="/usr/local/ssl/lib/pkgconfig:/usr/local/lib/pkgconfig" &&\
  export PKG_CONFIG="pkg-config --static" &&\
  export LDFLAGS="-static-libgcc -static-libstdc++ -static" &&\
  ./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --disable-xmltest --with-libxml2=no --with-spdylay=no --enable-static --disable-shared &&\
  make clean install -j${MAKE_J} &&\
  cd .. &&\
  rm -rf nghttp2 &&\
  apt-get remove -y --purge ${BUILD_DEP} &&\
  apt-get autoremove -y --purge &&\
  rm -rf /build /var/lib/apt/lists/*
 
