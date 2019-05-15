# centos

## Using Images

### getting docker images

```
$ docker pull curl/curl-centos:latest
```

### running docker images

```
$ docker run -it curl/curl-centos:latest --version
```


## Image design

1. builder stage builds curl
2. create base centos image
    * scrub curl from environment
    * copy build artifacts from #1
    
