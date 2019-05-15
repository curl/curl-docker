#!/bin/bash
# test needs to be in its own shell script to keep travis happy
../../bin/container-structure-test test --image curl/curl-alpine --config "test-container.yml"
echo "docker run --rm -it curl/curl-alpine:latest -S http://httpbin.org/get"
docker run --rm -it curl/curl-alpine:latest -S http://httpbin.org/get
