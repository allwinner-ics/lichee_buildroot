CROSS_COMPILE	?= arm-none-linux-gnueabi-

LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
OBJCOPY	= $(CROSS_COMPILE)objcopy
CFLAGS  = -fPIC -g -c
ASFLAGS = -c

u-para.bin : u_para.elf u_para.lds
	$(OBJCOPY) -O binary u_para.elf u-para.bin

u_para.elf: ubootenv.o
	$(LD) -o $@ $^ -Tu_para.lds

ubootenv.o : ubootenv.c ubootenv.h autogen.h ./users
	$(CC) -c $< ${BOOTCOMMAND}

autogen.h:
	./autogen.sh

clean:
	rm -f *.o *.bin u_para.elf autogen.h ${USER}_env.h
	
