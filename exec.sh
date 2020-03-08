#!/bin/bash

echo "== start running catapult.tools.health =="

if [ ! -d ./userconfig ]; then
  echo "./userconfig is not found."
  exit 1
fi

docker run \
  --rm \
  -t \
  -v $(pwd)/userconfig:/userconfig/ \
  techbureau/catapult-tools:gcc-0.9.3.1 \
  /usr/catapult/bin/catapult.tools.health --resources /userconfig/
