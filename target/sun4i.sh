#!/bin/sh

#rm -rf output/target/etc/init.d/S*

cat > output/target/etc/init.d/rcS << EOF
#!/bin/sh

mount -t devtmpfs none /dev
mknod /dev/mali c 246 0
hostname sun4i

EOF






