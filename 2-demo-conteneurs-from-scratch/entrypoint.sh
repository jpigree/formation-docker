#!/bin/bash

ARGS="$@"
if [[ "$#" -eq 0 ]]
then
    ARGS="/bin/bash"
fi

hostname ubuntu
chroot rootfs $ARGS
