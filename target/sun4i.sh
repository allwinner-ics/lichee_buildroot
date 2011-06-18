#!/bin/sh

#rm -rf output/target/etc/init.d/S*

cat > output/target/etc/init.d/rcS << EOF
#!/bin/sh

mount -t devtmpfs none /dev
mknod /dev/mali c 246 0
hostname sun4i

EOF

touch output/target/etc/init.d/auto_config_network

cat > output/target/etc/init.d/auto_config_network << EOF
#!/bin/sh

MAC_ADDR="\`uuidgen |awk -F- '{print \$5}'|sed 's/../&:/g'|sed 's/\(.\)$//' |cut -b3-17\`"

ifconfig eth0 hw ether "48\$MAC_ADDR"
ifconfig lo 127.0.0.1
udhcpc

EOF

chmod +x output/target/etc/init.d/auto_config_network
(cd target/skel/ && tar -c *) |tar -C output/target/ -xv


