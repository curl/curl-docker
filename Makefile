#***************************************************************************
# set options
#***************************************************************************

export LATEST_RELEASE_VERSION=7_83_1
export LATEST_RELEASE_TAG=curl-${LATEST_RELEASE_VERSION}
export DOCKER_CLI_EXPERIMENTAL=enabled

# set curl configure options
export CONFIGURE_BUILD_OPTS=" --enable-static --disable-ldap --enable-ipv6 --enable-unix-sockets --with-ssl --with-libssh2 --with-nghttp2=/usr \
--prefix=/usr/local"

# set docker build options used when building docker images
export DOCKER_BUILD_OPTS=--no-cache --compress

# set docker build args used when building docker images
export DOCKER_BUILD_ARGS= --build-arg CURL_CONFIGURE_OPTION=${CONFIGURE_BUILD_OPTS} \
    --build-arg CURL_RELEASE_TAG=${LATEST_RELEASE_TAG} \
    --build-arg CURL_RELEASE_VERSION=${LATEST_RELEASE_VERSION} \
    --build-arg CURL_GIT_REPO=https://github.com/curl/curl.git \
    --label Name=curl --label Version=1.0.0 \
    --label se.haxx.curl=curl \
    --label se.haxx.curl.version=${LATEST_RELEASE_VERSION} \
    --label se.haxx.curl.release_tag=${LATEST_RELEASE_TAG} \
    --label se.haxx.curl.description="network utility"

export DOCKER_MULTI_ARCH=linux/arm,linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386

#***************************************************************************
# build docker images
#***************************************************************************
.build: .build-alpine
.build-alpine:
	cd alpine/latest;make build;

#***************************************************************************
# build and push multiarch docker images
#***************************************************************************
.multibuild: .multibuild-alpine
.multibuild-alpine:
	cd alpine/latest;make multibuild;

#***************************************************************************
# build test image
#***************************************************************************
.buildtest: .buildtest-alpine
.buildtest-alpine:
	cd alpine/latest;make buildtest;

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
multibuild: .multibuild
buildtest: .buildtest
test: .test
push: .push-registry
scan: .scan
lint: .lint
clean: .clean
setup: .setup
