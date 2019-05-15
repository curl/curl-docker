###############################################################
#
# Copyright (C) 2019 Olliver Schinagl <oliver@schinagl.nl>
#
# SPDX-License-Identifier: MIT

# For Alpine, latest is actually the latest stable
# hadolint ignore=DL3007
###############################################################
FROM registry.hub.docker.com/library/alpine:latest AS builder

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
# We want the latest stable version from the repo
# hadolint ignore=DL3018
RUN \
    apk add --no-cache \
       autoconf \
       automake \
       build-base \
       curl-dev \
       groff \
       libtool \
    && \
    rm -rf "/var/cache/apk/"*

RUN mkdir /src
COPY "curl"  "/src/curl"
WORKDIR "/src/curl"

RUN ./buildconf && \
    autoreconf -vif && \
    ./configure ${CURL_CONFIGURE_OPTION} \
    && make \
    && make DESTDIR="/alpine/" install

###############################################################
# For Alpine, latest is actually the latest stable
# hadolint ignore=DL3007
FROM registry.hub.docker.com/library/alpine:latest

###############################################################
# define docker labels
###############################################################
LABEL Maintainer="Olliver Schinagl <oliver@schinagl.nl>"
LABEL Name="curl"
LABEL Version="${LABEL_VERSION}"
LABEL docker.cmd="docker run -it curl/curl-alpine http://www.google.com"

###############################################################
# remove curl
###############################################################
RUN \
    apk add --no-cache \
        curl \
    && \
    rm -rf "/var/cache/apk/"* && \
    for curlfile in $(apk info -L curl libcurl); do \
        if [ -f "/${curlfile}" ]; then \
            rm "/${curlfile:?}"; \
        fi \
    done

###############################################################
# install curl built from builder
###############################################################
COPY --from=builder "/alpine/usr/local/lib/libcurl.la" "/usr/lib/libcurl.la"
COPY --from=builder "/alpine/usr/local/lib/libcurl.a" "/usr/lib/libcurl.a"
COPY --from=builder "/alpine/usr/local/bin/curl" "/usr/bin/curl"

###############################################################
# copy and set entrypoint
###############################################################
COPY "scripts/docker-entrypoint.sh" "/docker-entrypoint.sh"
ENTRYPOINT [ "/docker-entrypoint.sh" ]
