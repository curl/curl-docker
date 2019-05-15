#!/bin/bash

cd /src/curl
./buildconf
autoreconf -vif
./configure
make
