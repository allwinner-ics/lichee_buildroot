#!/bin/sh


rm -rf output/target/etc/init.d/S*
echo "mknod /dev/mali c 247 0"  >> output/target/etc/init.d/rcS


