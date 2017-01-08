#!/bin/bash
set -x

if [[ -z ${MAKE_J} ]]; then
  MAKE_J=$(grep -c ^processor /proc/cpuinfo)
fi

ZLIB_VER=1.2.10
ZLIB_URL=http://zlib.net/zlib-${ZLIB_VER}.tar.gz
ZLIB_SHA256=8d7e9f698ce48787b6e1c67e6bff79e487303e66077e25cb9784ac8835978017

LIBEV_VER=4.23
LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-${LIBEV_VER}.tar.gz
LIBEV_SHA256=c7fe743e0c3b50dd34bf222ebdba4e8acac031d41ce174f17890f8f84eeddd7a

OPENSSL_VER=1.0.2j
OPENSSL_URL=ftp://ftp.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
OPENSSL_SHA256=e7aff292be21c259c6af26469c7a9b3ba26e9abaaffd325e3dccc9785256c431

NGHTTP2_VER=1.18.1
NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VER}/nghttp2-${NGHTTP2_VER}.tar.gz
NGHTTP2_SHA256=131475e5dbfa1b497ec75637cf9d7b9149c51c83cbd6fc4e55bc6c9d12afa597

C_ARES_VER=1.12.0
C_ARES_URL=https://c-ares.haxx.se/download/c-ares-${C_ARES_VER}.tar.gz
C_ARES_SHA256=8692f9403cdcdf936130e045c84021665118ee9bfea905d1a76f04d4e6f365fb

WGET="wget --no-check-certificate --secure-protocol=TLSv1 -T 30 -nv"

mkdir /build &&\
cd /build &&\
${WGET} -O zlib.tar.gz ${ZLIB_URL} &&\
echo "$ZLIB_SHA256  zlib.tar.gz" | sha256sum -c - &&\
tar xf zlib.tar.gz &&\
mv zlib-${ZLIB_VER} zlib &&\
rm -f zlib.tar.gz &&\
cd zlib &&\
./configure --static &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf zlib &&\
${WGET} -O libev.tar.gz ${LIBEV_URL} &&\
echo "${LIBEV_SHA256}  libev.tar.gz" | sha256sum -c - &&\
tar xf libev.tar.gz &&\
mv libev-${LIBEV_VER} libev &&\
rm -f libev.tar.gz &&\
cd libev &&\
./configure --enable-static --disable-shared &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf libev &&\
${WGET} -O openssl.tar.gz ${OPENSSL_URL} &&\
echo "${OPENSSL_SHA256}  openssl.tar.gz" | sha256sum -c - &&\
tar xf openssl.tar.gz &&\
mv openssl-${OPENSSL_VER} openssl &&\
rm -f openssl.tar.gz &&\
cd openssl &&\
./config zlib &&\
make clean install &&\
cd .. &&\
rm -rf openssl &&\
${WGET} -O c-ares.tar.gz ${C_ARES_URL} &&\
echo "${C_ARES_SHA256}  c-ares.tar.gz" | sha256sum -c - &&\
tar xf c-ares.tar.gz &&\
mv c-ares-${C_ARES_VER} c-ares &&\
rm -f c-ares.tar.gz &&\
cd c-ares &&\
./configure --disable-dependency-tracking --enable-shared=no --enable-static=yes &&\
make clean install &&\
cd .. &&\
rm -rf c-ares &&\
${WGET} -O nghttp2.tar.gz ${NGHTTP2_URL} &&\
echo "${NGHTTP2_SHA256}  nghttp2.tar.gz" | sha256sum -c - &&\
tar xf nghttp2.tar.gz && \
mv nghttp2-${NGHTTP2_VER} nghttp2 &&\
rm -f nghttp2.sha256 nghttp2.tar.gz &&\
cd nghttp2 && \
export PKG_CONFIG_PATH="/usr/local/ssl/lib/pkgconfig:/usr/local/lib/pkgconfig" &&\
export PKG_CONFIG="pkg-config --static" &&\
export LDFLAGS="-static-libgcc -static-libstdc++ -static" &&\
./configure --enable-app=yes --enable-asio-lib=no --enable-examples=no --enable-hpack-tools=no --enable-python-bindings=no --with-libxml2=no --with-spdylay=no --enable-static --disable-shared --disable-dependency-tracking &&\
make clean install -j${MAKE_J} &&\
cd .. &&\
rm -rf nghttp2
