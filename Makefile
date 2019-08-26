#***************************************************************************
# set options
#***************************************************************************

export LATEST_RELEASE_REDIRECT = $(shell curl -s https://github.com/curl/curl/releases/latest -w'%{redirect_url}\n' -o /dev/null)

export LATEST_RELEASE_TAG = $(shell basename $(LATEST_RELEASE_REDIRECT))
export LATEST_RELEASE_VERSION = $(shell echo $(LATEST_RELEASE_REDIRECT)| cut -d'-' -f 2)

# set curl configure options
export CONFIGURE_BUILD_OPTS=-"--enable-static --disable-shared --disable-ldap --enable-ipv6 --enable-unix-sockets --with-ssl"

# set docker build options used when building docker images
export DOCKER_BUILD_OPTS=--compress --squash

# set docker build args used when building docker images
export DOCKER_BUILD_ARGS =--build-arg CURL_CONFIGURE_OPTION=${configure_build_options} \
    --build-arg CURL_RELEASE_TAG=${LATEST_RELEASE_TAG} \
    --build-arg CURL_RELEASE_VERSION=${LATEST_RELEASE_VERSION} \
    --build-arg CURL_GIT_REPO=https://github.com/curl/curl.git \
    --label Name=curl --label Version=1.0.0 \
    --label se.haxx.curl=curl \
    --label se.haxx.curl.version=${LATEST_RELEASE_VERSION} \
    --label se.haxx.curl.release_tag=${LATEST_RELEASE_TAG} \
    --label se.haxx.curl.description="network utility"

#***************************************************************************
# build docker images
#***************************************************************************
.build: .build-alpine
.build-alpine:
	cd alpine/latest;make build;

#***************************************************************************
# test docker images
#***************************************************************************
.test: .test-alpine
.test-alpine:
	cd alpine/latest;make test

#***************************************************************************
# push docker images to hub.docker.com
#***************************************************************************
.push-registry: .push-registry-alpine
.push-registry-alpine:
	cd alpine/latest;make push-registry

#***************************************************************************
# security scan docker images
#***************************************************************************
.scan:
	cd alpine/latest;make scan

#***************************************************************************
# run lint checker on Dockerfiles
#***************************************************************************
.lint:
	cd alpine/latest;make lint

#***************************************************************************
# remove junk
#***************************************************************************
.clean: .clean-alpine
	rm -Rf bin
	rm -Rf curl
	rm -Rf curl*.tar.gz
.clean-alpine:
	cd alpine/latest;make clean

#***************************************************************************
# setup (download curl and test deps)
#
#     note - docker build context means we have to copy curl src
#***************************************************************************
.setup: .clean
	./setup.sh
	mv curl alpine/latest/curl

#***************************************************************************
# setup, build and test docker images
#***************************************************************************
all: setup build test

build: .build
test: .test
push: .push-registry
scan: .scan
lint: .lint
clean: .clean
setup: .setup
