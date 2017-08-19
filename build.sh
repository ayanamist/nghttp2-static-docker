#!/bin/bash
set -x

if [[ -z ${MAKE_J} ]]; then
  MAKE_J=$(grep -c ^processor /proc/cpuinfo)
fi

ZLIB_VER=1.2.11
ZLIB_URL=http://zlib.net/zlib-${ZLIB_VER}.tar.gz
ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

LIBEV_VER=4.24
LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-${LIBEV_VER}.tar.gz
LIBEV_SHA256=973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821

OPENSSL_VER=1_0_2l
OPENSSL_URL=https://github.com/openssl/openssl/archive/OpenSSL_${OPENSSL_VER}.tar.gz
OPENSSL_SHA256=a3d3a7c03c90ba370405b2d12791598addfcafb1a77ef483c02a317a56c08485

NGHTTP2_VER=1.25.0
NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VER}/nghttp2-${NGHTTP2_VER}.tar.gz
NGHTTP2_SHA256=23fe0c97505a73154bbdfd2fcf47f5fa652ad8be4a88c3a4bfe8ff517026ef0f

C_ARES_VER=1.12.0
C_ARES_URL=https://c-ares.haxx.se/download/c-ares-${C_ARES_VER}.tar.gz
C_ARES_SHA256=8692f9403cdcdf936130e045c84021665118ee9bfea905d1a76f04d4e6f365fb

WGET="wget --no-check-certificate --secure-protocol=TLSv1 -T 30 -nv"

mkdir /build &&\
cd /build &&\
${WGET} -O zlib.tar.gz ${ZLIB_URL} &&\
echo "$ZLIB_SHA256  zlib.tar.gz" | sha256sum -c - &&\
tar xf zlib.tar.gz &&\
cd zlib-${ZLIB_VER} &&\
./configure --static &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
${WGET} -O libev.tar.gz ${LIBEV_URL} &&\
echo "${LIBEV_SHA256}  libev.tar.gz" | sha256sum -c - &&\
tar xf libev.tar.gz &&\
cd libev-${LIBEV_VER} &&\
./configure --enable-static --disable-shared &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
${WGET} -O openssl.tar.gz ${OPENSSL_URL} &&\
echo "${OPENSSL_SHA256}  openssl.tar.gz" | sha256sum -c - &&\
tar xf openssl.tar.gz &&\
cd openssl-OpenSSL_${OPENSSL_VER} &&\
./config zlib &&\
make clean install &&\
cd .. &&\
${WGET} -O c-ares.tar.gz ${C_ARES_URL} &&\
echo "${C_ARES_SHA256}  c-ares.tar.gz" | sha256sum -c - &&\
tar xf c-ares.tar.gz &&\
cd c-ares-${C_ARES_VER} &&\
./configure --disable-dependency-tracking --enable-shared=no --enable-static=yes &&\
make clean install &&\
cd .. &&\
${WGET} -O nghttp2.tar.gz ${NGHTTP2_URL} &&\
echo "${NGHTTP2_SHA256}  nghttp2.tar.gz" | sha256sum -c - &&\
tar xf nghttp2.tar.gz && \
cd nghttp2-${NGHTTP2_VER} && \
export PKG_CONFIG_PATH="/usr/local/ssl/lib/pkgconfig:/usr/local/lib/pkgconfig" &&\
export PKG_CONFIG="pkg-config --static" &&\
export LDFLAGS="-static-libgcc -static-libstdc++ -static" &&\
./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --with-libxml2=no --with-spdylay=no --enable-static --disable-shared --disable-dependency-tracking &&\
make clean install -j${MAKE_J} &&\
cd / &&\
rm -rf /build
