#!/bin/bash
# test needs to be in its own shell script to keep travis happy
../../bin/container-structure-test test --image curl/curl-debian --config "test-container.yml"
echo "docker run --rm -it curl/curl-debian:latest -S http://httpbin.org/get"
docker run --rm -it curl/curl-debian:latest -S http://httpbin.org/get
