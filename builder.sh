#!/bin/bash

docker build --build-arg DRIVER_VERSION="${DRIVER_VERSION}" -t rdbox/vgl-server:v0.0.1 -f Dockerfile .