#!/usr/bin/env bash

set -ex

docker build . -t autoformat
docker run -it --rm autoformat #csharp 6.0
