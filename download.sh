#!/bin/sh

set -x

ZLIB_URL=http://zlib.net/zlib-1.2.11.tar.gz
ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-4.33.tar.gz
LIBEV_SHA256=507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea

OPENSSL_URL=https://www.openssl.org/source/openssl-1.1.1g.tar.gz
OPENSSL_SHA256=ddb04774f1e32f0c49751e21b67216ac87852ceb056b75209af2443400636d46

NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.gz
NGHTTP2_SHA256=eacc6f0f8543583ecd659faf0a3f906ed03826f1d4157b536b4b385fe47c5bb8

C_ARES_URL=https://c-ares.haxx.se/download/c-ares-1.16.1.tar.gz
C_ARES_SHA256=d08312d0ecc3bd48eee0a4cc0d2137c9f194e0a28de2028928c0f6cae85f86ce

WGET="wget -T 30 -nv"

apt-get update &&\
apt-get install -y wget &&\
cd /tmp &&\
${WGET} -O zlib.tar.gz ${ZLIB_URL} &&\
echo "$ZLIB_SHA256  zlib.tar.gz" | sha256sum -c - &&\
${WGET} -O libev.tar.gz ${LIBEV_URL} &&\
echo "${LIBEV_SHA256}  libev.tar.gz" | sha256sum -c - &&\
${WGET} -O openssl.tar.gz ${OPENSSL_URL} &&\
echo "${OPENSSL_SHA256}  openssl.tar.gz" | sha256sum -c - &&\
${WGET} -O c-ares.tar.gz ${C_ARES_URL} &&\
echo "${C_ARES_SHA256}  c-ares.tar.gz" | sha256sum -c - &&\
${WGET} -O nghttp2.tar.gz ${NGHTTP2_URL} &&\
echo "${NGHTTP2_SHA256}  nghttp2.tar.gz" | sha256sum -c - &&\
mkdir /download &&\
mv *.tar.* /download
