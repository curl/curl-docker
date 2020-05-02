[![Build Status](https://travis-ci.org/curl/curl-docker.svg?branch=master)](https://travis-ci.org/curl/curl-docker)

# Curl Docker Images repository

This repository defines the official curl docker image.

* [alpine](alpine/)

which are published to [hub.docker.com](https://hub.docker.com/r/curlimages/curl).


__note__ - requires latest docker to be installed and available

## Using Images

### get docker image

```
$ docker pull curlimages/curl:...insert tag...
```

### run docker image

```
$ docker run -it curlimages/curl:...insert tag... --version
```

### building and testing images

To build and test curl docker image
```
$ make all
```
which runs the setup (clean), build and test targets.

### scanning images

Security scan of resultant docker image
```
$ make scan
```
which uses trivis, anchore-engine, lynis and clamav.

One can also run lint checker on dockerfiles
```
$ make lint
```

## Image design

* initial stage, build curl and then copy over to clean base image
* build static curl
* attempt to be idiomatic across image(s)

### Other

* [thanks](docs/THANKS) to contributors
    * Daniel Stenberg 
    * Max Dymond
    * Olliver Schinagl
      

