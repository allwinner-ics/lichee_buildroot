
KDIR = $(BUILD_DIR)/kernel-header/linux-2.6.36-android
CFLAG = -static -O2 -I$(KDIR)/include -I$(KDIR)/arch/arm/mach-sun4i/include

.PHONY: all install
all:
	echo $(BUILD_DIR)
	$(CC) $(CFLAG) -static -O2 -o td td.c
	$(CC) $(CFLAG) -static -O2 -o sw_ctl sw_ctl.c
	$(CC) $(CFLAG) -static -O2 -o mxc622x_test mxc622x_test.c

clear:
	rm -rf *.o

install:
	cp -f td sw_ctl mxc622x_test $(DESTDIR)/bin

.PHONY: clean
clean: 
	rm -rf *.o


