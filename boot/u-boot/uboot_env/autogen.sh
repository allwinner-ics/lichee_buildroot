#! /bin/sh

LINUXTOOLS_DIR=${ELDK_DIR}/linuxtools

AUTO_GEN_H=${USER}_env.h

eval $(awk 'BEGIN {FS="\n";RS="";OFS="\n";ORS="\n\n";} $1 ~ "'"${USER}"'" {print "MAC_ADDR="$2}' users)
MAC_ADDR=$(echo $MAC_ADDR | cut -d '=' -f2)
eval $(cat users | awk 'BEGIN {FS="\n";RS="";OFS="\n";ORS="\n\n";} $1 ~ "'"${USER}"'" {print "CLIENT_IP="$3}')
CLIENT_IP=$(echo $CLIENT_IP | cut -d '=' -f2)
eval $(cat users | awk 'BEGIN {FS="\n";RS="";OFS="\n";ORS="\n\n";} $1 ~ "'"${USER}"'" {print "SERV_IP="$4}')
SERV_IP=$(echo $SERV_IP | cut -d '=' -f2)

if [ ! -f ${USER}_env.h ]; then

cat > ${AUTO_GEN_H} << EOF
#ifndef __AUTO_GEN_H__
#define __AUTO_GEN_H__

#define CONFIG_BOOTFILE		   "${BOOT_ROOT}/eGON/bootfs/linux/uImage"
#define CONFIG_ETHADDR		   ${MAC_ADDR}
#define CONFIG_IPADDR		   ${CLIENT_IP}
#define CONFIG_SERVERIP		   ${SERV_IP}

	
#endif

EOF

rm -f autogen.h
fi


if [ ! -h autogen.h ]; then
	ln -s ${USER}_env.h autogen.h
fi
