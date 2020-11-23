###############################################################
#
# Copyright (C) 2020 James Fuller <jim.fuller@webcomposite.com>
#
# SPDX-License-Identifier: MIT
#
# pinning builder image to Alpine 3.11.5
###############################################################
FROM registry.hub.docker.com/library/alpine:3.11.5 AS builder

###############################################################
# set build args
###############################################################
ARG CURL_RELEASE_TAG=latest
ARG CURL_GIT_REPO=https://github.com/curl/curl.git
ARG CURL_CONFIGURE_OPTION
ARG LABEL_VERSION=1.0.0
ARG LABEL_NAME=curl
ARG LABEL_DESC=curl

###############################################################
# build curl
###############################################################
# install deps and use latest curl release source
RUN apk --update add                                    \
        autoconf automake build-base                    \
        groff curl-dev ca-certificates                  \
        python3 python3-dev                             \
        libtool curl stunnel perl                       \
        libssh2 libssh2-dev libssh2-static              \
        nghttp2 nghttp2-dev nghttp2-static              \
        openssl openssl-dev openssl-libs-static         \
        zlib-static zlib-dev

RUN mkdir /src
COPY "curl"  "/src/curl"
WORKDIR /src/curl

###############################################################
# build the tag version
###############################################################
RUN ./buildconf && \
    autoreconf -vif && \
    ./configure ${CURL_CONFIGURE_OPTION} &&\
    make -j$(nproc) curl_LDFLAGS=-all-static &&\
    #make test &&\
    make DESTDIR="/scratch/" install  -j$(nproc)

RUN strip --strip-debug --strip-unneeded /scratch/usr/local/bin/curl
RUN ldd /scratch/usr/local/bin/curl
RUN ls -l /scratch/usr/local/bin/curl

###############################################################
# install and update ca certificates
###############################################################
RUN update-ca-certificates

###############################################################
# pinning image to Alpine 3.11.5
###############################################################
FROM scratch

###############################################################
# install curl built from builder
###############################################################
COPY --from=builder "/scratch/usr/local/bin/curl" "/curl"
COPY --from=builder "/etc/ssl/certs/ca-certificates.crt" "/etc/ssl/certs/ca-certificates.crt"

###############################################################
# set command
###############################################################
ENTRYPOINT ["/curl"]
