#!/bin/bash
# test needs to be in its own shell script to keep travis happy
../../bin/container-structure-test test --image curl/curl-nixos --config "test-container.yml"
docker run --rm -it curl/curl-nixos:latest -S http://httpbin.org/get
