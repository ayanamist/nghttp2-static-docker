#!/bin/bash
set -x

if [[ -z ${MAKE_J} ]]; then
  MAKE_J=$(grep -c ^processor /proc/cpuinfo)
fi

export PERL=/usr/local/bin/perl

cd /build &&\
tar xf zlib.tar.gz &&\
cd zlib-* &&\
CFLAGS="-fPIC" ./configure --static &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
tar xf libev.tar.gz &&\
cd libev-* &&\
./configure --enable-static --disable-shared &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
tar xf openssl.tar.gz &&\
cd openssl-* &&\
./config zlib &&\
make clean install_sw &&\
cd .. &&\
tar xf c-ares.tar.gz &&\
cd c-ares-* &&\
./configure --disable-dependency-tracking --enable-shared=no --enable-static=yes &&\
make clean install &&\
cd .. &&\
tar xf nghttp2.tar.gz && \
cd nghttp2-* && \
export PKG_CONFIG_PATH="/usr/local/ssl/lib/pkgconfig:/usr/local/lib/pkgconfig" &&\
export PKG_CONFIG="pkg-config --static" &&\
export LDFLAGS="-static-libgcc -static-libstdc++ -static" &&\
./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --with-libxml2=no --enable-static --disable-shared --disable-dependency-tracking &&\
make clean install -j${MAKE_J} &&\
cd / &&\
rm -rf /build
