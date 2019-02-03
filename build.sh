#!/bin/bash
set -x

if [[ -z ${MAKE_J} ]]; then
  MAKE_J=$(grep -c ^processor /proc/cpuinfo)
fi

cd /build &&\
tar xf jemalloc.tar.bz2 &&\
cd jemalloc-* &&\
./configure &&\
make clean install &&\
cd .. &&\
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
./config zlib no-shared &&\
make clean install_sw &&\
cd .. &&\
tar xf c-ares.tar.gz &&\
cd c-ares-* &&\
./configure --disable-dependency-tracking --enable-shared=no --enable-static=yes --disable-shared &&\
make clean install &&\
cd .. &&\
tar xf nghttp2.tar.gz && \
cd nghttp2-* && \
export PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:/usr/local/lib/pkgconfig" &&\
export PKG_CONFIG="pkg-config --static" &&\
export LDFLAGS="-static-libgcc -static-libstdc++" &&\
./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --with-libxml2=no --enable-static --disable-shared --disable-examples --disable-dependency-tracking &&\
make clean -j${MAKE_J} &&\
make -j${MAKE_J} &&\
rm -rf /usr/local &&\
make install -j${MAKE_J} &&\
cd / &&\
rm -rf /build
