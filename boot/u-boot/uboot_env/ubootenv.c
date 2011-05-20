#include "ubootenv.h"
#include "autogen.h"

#define CONFIG_BOOTDELAY	   1
#define CONFIG_LOADADDR		   0x81000000
#ifdef NFSBOOT
	#define CONFIG_BOOTCOMMAND		"run nfs_boot"
	#define CONFIG_AUTOBOOT_PROMPT 	"autoboot from nfs in %d seconds\n"
#elif defined NANDBOOT
	#define CONFIG_BOOTCOMMAND		"run nand_boot"
	#define CONFIG_AUTOBOOT_PROMPT 	"autoboot from nand in %d seconds\n"
#else
	#error "***************No boot type specified!***********************"
#endif

#define CONFIG_EXTRA_ENV_SETTINGS			\
	"nfs_boot=run nfsarg;nfs;bootm;echo\0"				\
	"nfsarg=setenv bootargs mem=${memsize} initrd=${initrdaddr},${initrdsize} rw console=${consdev},${consrate} ${dbg} ${other}\0"	\
	"nand_boot=run nandarg;bootm;echo\0"				\
	"nandarg=setenv bootargs mem=${memsize} initrd=${initrdaddr},${initrdsize} rw console=${consdev},${consrate} ${dbg} ${other}\0"	\
	"ipmask=255.255.255.0\0"				\
	"memsize=128M\0"						\
	"kgdbdev=ttyS3\0"						\
	"consdev=ttyS0\0"						\
	"consrate=115200\0"					\
	"stdin=eserial0\0"					\
	"stdout=eserial0\0"					\
	"stderr=eserial0\0"					\
	"initrdaddr=0x82b00000\0"			\
	"initrdsize=0xc00000\0"				\
	"kdbg=\0"


env_t environment = {
	(('S'<<24)|('o'<<16)|('f'<<8)|('t')),	/* CRC Sum */
#ifdef CFG_REDUNDAND_ENVIRONMENT
	1,		/* Flags: valid */
#endif
	{
#if defined(CONFIG_BOOTARGS)
	"bootargs="	CONFIG_BOOTARGS			"\0"
#endif
#if defined(CONFIG_BOOTCOMMAND)
	"bootcmd="	CONFIG_BOOTCOMMAND		"\0"
#endif
#if defined(CONFIG_RAMBOOTCOMMAND)
	"ramboot="	CONFIG_RAMBOOTCOMMAND		"\0"
#endif
#if defined(CONFIG_NFSBOOTCOMMAND)
	"nfsboot="	CONFIG_NFSBOOTCOMMAND		"\0"
#endif
#if defined(CONFIG_BOOTDELAY) && (CONFIG_BOOTDELAY >= 0)
	"bootdelay="	MK_STR(CONFIG_BOOTDELAY)	"\0"
#endif
#if defined(CONFIG_BAUDRATE) && (CONFIG_BAUDRATE >= 0)
	"baudrate="	MK_STR(CONFIG_BAUDRATE)		"\0"
#endif
#ifdef	CONFIG_LOADS_ECHO
	"loads_echo="	MK_STR(CONFIG_LOADS_ECHO)	"\0"
#endif
#ifdef	CONFIG_ETHADDR
	"ethaddr="	MK_STR(CONFIG_ETHADDR)		"\0"
#endif
#ifdef	CONFIG_ETH1ADDR
	"eth1addr="	MK_STR(CONFIG_ETH1ADDR)		"\0"
#endif
#ifdef	CONFIG_ETH2ADDR
	"eth2addr="	MK_STR(CONFIG_ETH2ADDR)		"\0"
#endif
#ifdef	CONFIG_ETH3ADDR
	"eth3addr="	MK_STR(CONFIG_ETH3ADDR)		"\0"
#endif
#ifdef	CONFIG_ETHPRIME
	"ethprime="	CONFIG_ETHPRIME			"\0"
#endif
#ifdef	CONFIG_IPADDR
	"ipaddr="	MK_STR(CONFIG_IPADDR)		"\0"
#endif
#ifdef	CONFIG_SERVERIP
	"serverip="	MK_STR(CONFIG_SERVERIP)		"\0"
#endif
#ifdef	CFG_AUTOLOAD
	"autoload="	CFG_AUTOLOAD			"\0"
#endif
#ifdef	CONFIG_ROOTPATH
	"rootpath="	MK_STR(CONFIG_ROOTPATH)		"\0"
#endif
#ifdef	CONFIG_GATEWAYIP
	"gatewayip="	MK_STR(CONFIG_GATEWAYIP)	"\0"
#endif
#ifdef	CONFIG_NETMASK
	"netmask="	MK_STR(CONFIG_NETMASK)		"\0"
#endif
#ifdef	CONFIG_HOSTNAME
	"hostname="	MK_STR(CONFIG_HOSTNAME)		"\0"
#endif
#ifdef	CONFIG_BOOTFILE
	"bootfile="	MK_STR(CONFIG_BOOTFILE)		"\0"
#endif
#ifdef	CONFIG_LOADADDR
	"loadaddr="	MK_STR(CONFIG_LOADADDR)		"\0"
#endif
#ifdef	CONFIG_PREBOOT
	"preboot="	CONFIG_PREBOOT			"\0"
#endif
#ifdef	CONFIG_CLOCKS_IN_MHZ
	"clocks_in_mhz=" "1"				"\0"
#endif
#if defined(CONFIG_PCI_BOOTDELAY) && (CONFIG_PCI_BOOTDELAY > 0)
	"pcidelay="	MK_STR(CONFIG_PCI_BOOTDELAY)	"\0"
#endif
#ifdef  CONFIG_EXTRA_ENV_SETTINGS
	CONFIG_EXTRA_ENV_SETTINGS
#endif
	"\0"		/* Term. env_t.data with 2 NULs */
	}
};

