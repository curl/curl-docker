###############################################################
#
# Copyright (C) 2019 Jamese Fuller <jim.fuller@webcomposite.com>
#
# SPDX-License-Identifier: MIT

###############################################################
FROM nixos/nix

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
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable
RUN nix-channel --update && nix-env --upgrade nix && nix-env -i openssl bash
COPY default.nix /usr/local/lib/
COPY builder.sh /usr/local/lib/

RUN mkdir /src
COPY "curl"  "/src/curl"
WORKDIR "/src/curl"

RUN nix-build /usr/local/lib/default.nix --run true


###############################################################
#FROM nixos/nix

###############################################################
# define docker labels
###############################################################
LABEL Maintainer="James Fuller <jim.fuller@webcomposite.com>"
LABEL docker.cmd="docker run -it curl/curl-nixos http://www.google.com"


###############################################################
# install curl built from builder
###############################################################
#COPY --from=builder "/nixos/usr/local/lib/libcurl.so.4.5.0" "/usr/lib/libcurl.so.4.5.0"
#COPY --from=builder "/nixos/usr/local/lib/libcurl.so.4" "/usr/lib/libcurl.so.4"
#COPY --from=builder "/nixos/usr/local/lib/libcurl.so" "/usr/lib/libcurl.so"
#COPY --from=builder "/nixos/usr/local/lib/libcurl.la" "/usr/lib64/libcurl.la"
#COPY --from=builder "/nixos/usr/local/lib/libcurl.a" "/usr/lib64/libcurl.a"
#COPY --from=builder "/nixos/usr/local/bin/curl" "/usr/bin/curl"

###############################################################
# copy and set entrypoint
###############################################################
COPY "scripts/docker-entrypoint.sh" "/docker-entrypoint.sh"
ENTRYPOINT [ "/bin/sh" ]


