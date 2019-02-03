#!/bin/sh

set -x

ZLIB_URL=http://zlib.net/zlib-1.2.11.tar.gz
ZLIB_SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1

LIBEV_URL=http://dist.schmorp.de/libev/Attic/libev-4.25.tar.gz
LIBEV_SHA256=78757e1c27778d2f3795251d9fe09715d51ce0422416da4abb34af3929c02589

OPENSSL_URL=https://www.openssl.org/source/openssl-1.1.1a.tar.gz
OPENSSL_SHA256=fc20130f8b7cbd2fb918b2f14e2f429e109c31ddd0fb38fc5d71d9ffed3f9f41

NGHTTP2_URL=https://github.com/nghttp2/nghttp2/releases/download/v1.36.0/nghttp2-1.36.0.tar.gz
NGHTTP2_SHA256=6b222a264aca23d497f7878a7751bd9da12676717493fe747db49afb51daae79

C_ARES_URL=https://github.com/c-ares/c-ares/releases/download/cares-1_15_0/c-ares-1.15.0.tar.gz
C_ARES_SHA256=6cdb97871f2930530c97deb7cf5c8fa4be5a0b02c7cea6e7c7667672a39d6852

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
