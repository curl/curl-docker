# alpine

## Using Images

### getting docker images

```
$ docker pull curl/curl-alpine:latest
```

### running docker images

```
$ docker run -it curl/curl-alpine:latest --version
```


## Image design

1. builder stage builds curl
2. create base alpine image
    * scrub curl from environment
    * copy build artifacts from #1
    
