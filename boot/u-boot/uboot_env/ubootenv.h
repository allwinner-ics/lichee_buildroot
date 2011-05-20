#ifndef __UBOOTENV_H__
#define __UBOOTENV_H__

#define ENV_SIZE (CFG_ENV_SIZE - ENV_HEADER_SIZE)

typedef	struct environment_s {
	unsigned long	crc;		/* CRC32 over data bytes	*/
#ifdef CFG_REDUNDAND_ENVIRONMENT
	unsigned char	flags;		/* active/obsolete flags	*/
#endif
	unsigned char	data[4096]; /* Environment data		*/
} env_t;

/*
 * Macros to transform values
 * into environment strings.
 */
#define XMK_STR(x)	#x
#define MK_STR(x)	XMK_STR(x)


#endif
