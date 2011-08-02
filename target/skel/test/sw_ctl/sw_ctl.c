#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/ioctl.h>

#include "sw_sys.h"

struct sw_script_para para;

void show_help()
{
	printf("Options: f:m:s:x:h\n");
}

int main(int argc, char *argv[])
{
	int opt=-1, fd=-1;
	int cmd;
	char *file=NULL, *main=NULL, *sub=NULL;

	while ((opt = getopt(argc, argv, "f:m:s:x:h")) != -1) {
		switch (opt) {
		case 'f':
			file =optarg;
			break;
		case 'm':
			main = optarg;
			break;
		case 's':
			sub = optarg;
			break;
		case 'x':
			cmd =atoi(optarg);
			break;
		case 'h':
		default:
			show_help();
			return 0;
		}
	}

	printf("%s: %s.%s\n", file, main, sub);
	fd = open(file, O_RDWR);

	//perror("open");

	memset(&para, 0, sizeof(para));

	strcpy(para.main_name, main);
	strcpy(para.sub_name, sub);

	ioctl(fd, cmd, &para);
	//perror("ioctl");

	if (cmd == 3) {
		printf("%d\n", para.data);
	} else if (cmd == 4) {
		printf("%s\n", para.buf);
	}


	return 0;
}
