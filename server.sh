#!/bin/bash

docker run -it --rm --gpus all \
  -v /tmp/.rdbox.X11-unix:/tmp/.X11-unix \
  -v /home/ubuntu/.ssh:/etc/secret-volume \
  --net=host \
  --name vgl-server rdbox/vgl-server:v0.0.1