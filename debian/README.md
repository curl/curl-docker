# debian

## Using Images

### getting docker images

```
$ docker pull curl/curl-debian:latest
```

### running docker images

```
$ docker run -it curl/curl-debian:latest --version
```


## Image design

1. builder stage builds curl
2. create base debian image
    * scrub curl from environment
    * copy build artifacts from #1
    
