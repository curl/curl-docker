[![Build Status](https://travis-ci.org/xquery/curl-docker.svg?branch=master)](https://travis-ci.org/xquery/curl-docker)

# Curl Docker Images repository

This repository defines internal & official curl docker images.

* [alpine](alpine/)
* [centos](centos/)
* [debian](debian/)

which are published to hub.docker.com.

__note__ - requires latest docker to be installed and available

## Using Images

### getting docker images

```
$ docker pull curlimages/curl-alpine:latest
```

### running docker images

```
$ docker run -it curlimages/curl-alpine:latest --version
```

### building and testing images

To build and test all curl docker images
```
$ make all
```
which runs the setup (clean), build and test targets.

### scanning images

Security scan of resultant docker images
```
$ make scan
```
which uses anchore-engine, rkhunter, lynis and clamav.

One can also run lint checker on dockerfiles
```
$ make lint
```

## Image design

* initial stage, build curl and then copy over to clean base image
* build static curl
* attempt to be idiomatic across images
    * remove existing curl
    * same set of deps
    * use same entrypoint script

## Other

* [thanks](docs/THANKS) to contributors
