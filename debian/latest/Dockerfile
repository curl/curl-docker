###############################################################
#
# Copyright (C) 2019 Jamese Fuller <jim.fuller@webcomposite.com>
#
# SPDX-License-Identifier: MIT

###############################################################

FROM debian:latest AS builder

###############################################################
# set build args
###############################################################

ARG CURL_RELEASE_TAG=latest
ARG CURL_GIT_REPO=https://github.com/curl/curl.git
ARG CURL_CONFIGURE_OPTION="--disable-ldap --enable-ipv6 --enable-unix-sockets --prefix=/usr --with-libssh2 --with-nghttp2 --with-pic --with-ssl --without-libidn --without-libidn2"
ARG LABEL_VERSION=1.0.0
ARG LABEL_NAME=curl
ARG LABEL_DESC=curl

###############################################################
# build curl
###############################################################
RUN apt-get update
RUN apt-get install -y make autoconf automake build-essential openssl nghttp2 libnghttp2-dev libssl-dev libssh2-1 libssh2-1-dev groff libtool

RUN mkdir /src
COPY "curl"  "/src/curl"
WORKDIR "/src/curl"

RUN ./buildconf && \
    autoreconf -vif && \
    ./configure ${CURL_CONFIGURE_OPTION} \
    && make \
    && make DESTDIR="/debian/" install
RUN ls /debian/usr/local/lib

###############################################################
FROM debian:latest

###############################################################
# define docker labels
###############################################################
LABEL Maintainer="James Fuller <jim.fuller@webcomposite.com>"
LABEL Name="curl"
LABEL Version="${LABEL_VERSION}"
LABEL docker.cmd="docker run -it curl/curl-debian http://www.google.com"

###############################################################
# remove curl
###############################################################
RUN apt-get update && apt-get remove --auto-remove curl && apt-get purge --auto-remove curl
RUN apt-get install -y libssl-dev nghttp2 libssh2-1

###############################################################
# install curl built from builder
###############################################################
COPY --from=builder "/debian/usr/local/lib/libcurl.la" "/usr/lib/libcurl.la"
COPY --from=builder "/debian/usr/local/lib/libcurl.a" "/usr/lib/libcurl.a"
COPY --from=builder "/debian/usr/local/bin/curl" "/usr/bin/curl"

###############################################################
# copy and set entrypoint
###############################################################
COPY "scripts/docker-entrypoint.sh" "/docker-entrypoint.sh"
ENTRYPOINT [ "/docker-entrypoint.sh" ]

