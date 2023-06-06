***IMPORTANT*** - https://github.com/curl/curl-container supersedes this archived repository






# Curl Docker Images repository

This repository defines the official curl docker image.

* [alpine](alpine/)

which are published to [hub.docker.com](https://hub.docker.com/r/curlimages/curl).


__note__ - requires latest docker to be installed and available

## Contact

If you have problems, questions, ideas or suggestions, please contact [curl-docker team](curl-docker@haxx.se)
or [Jim Fuller](jim.fuller@webcomposite.com) directly.

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

One can also run a lint checker on dockerfiles
```
$ make lint
```

## Image design

* initial stage, build curl and then copy over to clean base image
* build static curl
* attempt to be idiomatic across image(s)
* running as curl_user is an explicit design decision
* multi arch is achieved using buildx support

### Other

* [thanks](docs/THANKS) to contributors
    * Daniel Stenberg 
    * Max Dymond
    * Olliver Schinagl
      

