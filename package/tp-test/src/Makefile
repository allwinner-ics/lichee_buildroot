LINUX_DIR=/work/android/android-2.6.36/common/include
CFLAGS += -static -I$(LINUX_DIR) 
CFLAGS += -O0

.PHONY: all install
all: input-test

input-test:
	$(CC) $(CFLAGS) -o input-test input-test.c

install:
	install input-test $(DESTDIR)/bin

.PHONY: clean

