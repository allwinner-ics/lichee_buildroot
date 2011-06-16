#!/bin/sh


rm -rf output/target/etc/init.d/S*
echo "mount -t devtmpfs none /dev" >> output/target/etc/init.d/rcS
echo "mknod /dev/mali c 247 0"  >> output/target/etc/init.d/rcS


