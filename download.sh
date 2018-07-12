#!/bin/sh

set -x

ZLIB_VER=1.2.11
ZLIB_URL=http://zlib.net/zlib-${ZLIB_VER}.tar.gz
ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

LIBEV_VER=4.24
LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-${LIBEV_VER}.tar.gz
LIBEV_SHA256=973593d3479abdf657674a55afe5f78624b0e440614e2b8cb3a07f16d4d7f821

OPENSSL_VER=1.1.0h
OPENSSL_URL=https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
OPENSSL_SHA256=5835626cde9e99656585fc7aaa2302a73a7e1340bf8c14fd635a62c66802a517

NGHTTP2_VER=1.32.0
NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v${NGHTTP2_VER}/nghttp2-${NGHTTP2_VER}.tar.gz
NGHTTP2_SHA256=f75e8f228217f23aa5eabfbab140e061cda00b7c21e34c891ecfb248d663303f

C_ARES_VER=1.14.0
C_ARES_URL=https://github.com/c-ares/c-ares/files/1731591/c-ares-${C_ARES_VER}.tar.gz
C_ARES_SHA256=45d3c1fd29263ceec2afc8ff9cd06d5f8f889636eb4e80ce3cc7f0eaf7aadc6e

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
mv *.tar.gz /download
