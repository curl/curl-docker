#***************************************************************************
# set options
#***************************************************************************
# set curl configure options
export configure_build_options=-"-enable-static --disable-shared --disable-ldap --enable-ipv6 --enable-unix-sockets"

# set docker build options used when building docker images
export docker_build_options=--compress --squash

# set docker build args used when building docker images
export docker_build_args =--build-arg CURL_CONFIGURE_OPTION=${configure_build_options} \
    --build-arg CURL_RELEASE_TAG=latest \
    --build-arg CURL_GIT_REPO=https://github.com/curl/curl.git \
    --label Name=curl --label Version=1.0.0 \
    --label se.haxx.curl=curl --label se.haxx.curl.version=1 --label se.haxx.curl.release_tag=1 \
    --label se.haxx.curl.description="network utility"

#***************************************************************************
# build docker images
#***************************************************************************
.build: .build-centos .build-alpine .build-debian
.build-centos:
	cd centos/latest;make build;
.build-alpine:
	cd alpine/latest;make build;
.build-debian:
	cd debian/latest;make build;
.build-nixos:
	cd nixos/latest;make build;

#***************************************************************************
# test docker images
#***************************************************************************
.test: .test-centos .test-alpine .test-debian
.test-centos:
	cd centos/latest;make test
.test-alpine:
	cd alpine/latest;make test
.test-debian:
	cd debian/latest;make test
.test-nixos:
	cd nixos/latest;make test

#***************************************************************************
# push docker images to hub.docker.com
#***************************************************************************
.push-registry: .push-registry-centos .push-registry-alpine .push-registry-debian
.push-centos:
	cd centos/latest;make push-registry
.push-alpine:
	cd alpine/latest;make push-registry
.push-nixos:
	cd nixos/latest;make push-registry

#***************************************************************************
# security scan docker images
#***************************************************************************
.scan:
	cd centos/latest;make scan
	cd alpine/latest;make scan
	cd debian/latest;make scan
	cd nixos/latest;make scan

#***************************************************************************
# run lint checker on Dockerfiles
#***************************************************************************
.lint:
	cd centos/latest;make lint
	cd alpine/latest;make lint
	cd debian/latest;make lint
	cd nixos/latest;make lint

#***************************************************************************
# remove junk
#***************************************************************************
.clean: .clean-centos .clean-alpine .clean-debian .clean-nixos
	rm -Rf bin
	rm -Rf curl
	rm -Rf curl*.tar.gz
.clean-centos:
	cd centos/latest;make clean
.clean-alpine:
	cd alpine/latest;make clean
.clean-debian:
	cd debian/latest;make clean
.clean-nixos:
	cd nixos/latest;make clean

#***************************************************************************
# setup (download curl and test deps
#
#     note - docker build context means we have to copy curl src
#***************************************************************************
.setup: .clean
	./setup.sh
	cp -Rf curl centos/latest/curl
	cp -Rf scripts centos/latest/scripts

	cp -Rf curl alpine/latest/curl
	cp -Rf scripts alpine/latest/scripts

	cp -Rf curl debian/latest/curl
	cp -Rf scripts debian/latest/scripts

	cp -Rf curl nixos/latest/curl
	cp -Rf scripts nixos/latest/scripts

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
