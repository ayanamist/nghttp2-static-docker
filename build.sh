#!/bin/bash
set -x

ZLIB_VER=1.2.8
ZLIB_URL=http://zlib.net/zlib-${ZLIB_VER}.tar.gz
ZLIB_SHA256=36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d

LIBEV_VER=4.22
LIBEV_URL=http://dist.schmorp.de/libev/libev-${LIBEV_VER}.tar.gz
LIBEV_SHA256=736079e8ac543c74d59af73f9c52737b3bfec9601f020bf25a87a4f4d0f01bd6

OPENSSL_VER=1.0.2h
OPENSSL_URL=ftp://ftp.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
OPENSSL_SHA256=1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919

NGHTTP2_VER=1.15.0
NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VER}/nghttp2-${NGHTTP2_VER}.tar.gz
NGHTTP2_SHA256=3c8bd105c65d2fe9b582e61adac3f571cf15f547a6d559106979c9019e3b8901

WGET="wget --no-check-certificate --secure-protocol=TLSv1 -T 30"

mkdir /build &&\
cd /build &&\
${WGET} -O zlib.tar.gz ${ZLIB_URL} &&\
echo "$ZLIB_SHA256  zlib.tar.gz" | sha256sum -c - &&\
tar xf zlib.tar.gz &&\
mv zlib-${ZLIB_VER} zlib &&\
rm -f zlib.md5 zlib.tar.gz &&\
cd zlib &&\
./configure --static &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf zlib &&\
${WGET} -O libev.tar.gz ${LIBEV_URL} &&\
echo "${LIBEV_SHA256}  libev.tar.gz" | sha256sum -c - &&\
tar xf libev.tar.gz &&\
mv libev-${LIBEV_VER} libev &&\
rm -f libev.sha256 libev.tar.gz &&\
cd libev &&\
./configure --enable-static --disable-shared &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf libev &&\
${WGET} -O openssl.tar.gz ${OPENSSL_URL} &&\
echo "${OPENSSL_SHA256}  openssl.tar.gz" | sha256sum -c - &&\
tar xf openssl.tar.gz &&\
mv openssl-${OPENSSL_VER} openssl &&\
rm -f openssl.sha256 openssl.tar.gz &&\
cd openssl &&\
./config zlib &&\
make clean install &&\
cd .. &&\
rm -rf openssl &&\
${WGET} -O nghttp2.tar.gz ${NGHTTP2_URL} &&\
echo "${NGHTTP2_SHA256}  nghttp2.tar.gz" | sha256sum -c - &&\
tar xf nghttp2.tar.gz && \
mv nghttp2-${NGHTTP2_VER} nghttp2 &&\
rm -f nghttp2.sha256 nghttp2.tar.gz &&\
cd nghttp2 && \
export PKG_CONFIG_PATH="/usr/local/ssl/lib/pkgconfig:/usr/local/lib/pkgconfig" &&\
export PKG_CONFIG="pkg-config --static" &&\
export LDFLAGS="-static-libgcc -static-libstdc++ -static" &&\
./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --disable-xmltest --with-libxml2=no --with-spdylay=no --enable-static --disable-shared &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf nghttp2
