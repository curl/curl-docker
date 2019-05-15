# nixos

## Using Images

### getting docker images

```
$ docker pull curl/curl-nixos:latest
```

### running docker images

```
$ docker run -it curl/curl-nixos:latest --version
```


## Image design

1. builder stage builds curl
2. create base centos image
    * scrub curl from environment
    * copy build artifacts from #1
    
There is a difference in that build deps are defined in default.nix
and installed with nix.
