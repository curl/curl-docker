###############################################################
#
# Copyright (C) 2019 James Fuller <jim.fuller@webcomposite.com>
#
# SPDX-License-Identifier: MIT
#
###############################################################
FROM registry.hub.docker.com/library/centos:latest AS builder

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
RUN echo "NETWORKING=yes" > /etc/sysconfig/network \
    && yum -y update \
    && yum -y install make autoconf automake build-essential openssl-devel libnghttp2-devel libssh2-1-devel groff libtool \
    && yum clean all

RUN mkdir /src
COPY "curl"  "/src/curl"
WORKDIR /src/curl

RUN ./buildconf && \
    autoreconf -vif && \
    ./configure ${CURL_CONFIGURE_OPTION} \
    && make \
    && make DESTDIR="/centos/" install

###############################################################
FROM registry.hub.docker.com/library/centos:latest

###############################################################
# define docker labels
###############################################################
LABEL Maintainer="James Fuller <jim.fuller@webcomposite.com>"
LABEL Name="curl"
LABEL Version="${LABEL_VERSION}"
LABEL docker.cmd="docker run -it curl/curl-centos http://curl.haxx.se"

###############################################################
# remove curl
###############################################################
RUN rpm -e --nodeps curl

###############################################################
# install curl built from builder
###############################################################
COPY --from=builder "/centos/usr/local/lib/libcurl.la" "/usr/lib64/libcurl.la"
COPY --from=builder "/centos/usr//local/lib/libcurl.a" "/usr/lib64/libcurl.a"
COPY --from=builder "/centos/usr/local/bin/curl" "/usr/bin/curl"

###############################################################
# copy and set entrypoint
###############################################################
COPY "scripts/docker-entrypoint.sh" "/docker-entrypoint.sh"
ENTRYPOINT [ "/docker-entrypoint.sh" ]
