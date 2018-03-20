#!/bin/bash

if [[ "$(uname -m)" != arm* ]]; then
    docker run --rm --privileged multiarch/qemu-user-static:register --reset
fi

sudo bash -c '''
losetup -D
for i in $(seq 0 5); do
    dd if=/dev/zero of=virtualfs$i bs=1024 count=30720
    losetup /dev/loop$i virtualfs$i
    losetup -d /dev/loop$i
    rm virtualfs$i
done
'''
