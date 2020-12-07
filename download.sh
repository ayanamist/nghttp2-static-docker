#!/bin/sh

set -x

ZLIB_URL=http://zlib.net/zlib-1.2.11.tar.gz
ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-4.33.tar.gz
LIBEV_SHA256=507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea

OPENSSL_URL=https://www.openssl.org/source/openssl-1.1.1h.tar.gz
OPENSSL_SHA256=5c9ca8774bd7b03e5784f26ae9e9e6d749c9da2438545077e6b3d755a06595d9

NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v1.42.0/nghttp2-1.42.0.tar.gz
NGHTTP2_SHA256=884d18a0158908125d58b1b61d475c0325e5a004e3d61a56b5fcc55d5f4b7af5

C_ARES_URL=https://c-ares.haxx.se/download/c-ares-1.17.1.tar.gz
C_ARES_SHA256=d73dd0f6de824afd407ce10750ea081af47eba52b8a6cb307d220131ad93fc40

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
