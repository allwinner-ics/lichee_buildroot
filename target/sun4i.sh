#!/bin/sh

#rm -rf output/target/etc/init.d/S*
echo "#!/bin/sh" > output/target/etc/init.d/rcS
echo "mount -t devtmpfs none /dev" >> output/target/etc/init.d/rcS
echo "mknod /dev/mali c 246 0"  >> output/target/etc/init.d/rcS


