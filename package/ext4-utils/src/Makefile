#CC=gcc

CFLAGS=-I. -I/home/benn/A10-lite/lichee/buildroot/output/staging/usr/include/

make_ext4fsobj=make_ext4fs.o make_ext4fs_main.o ext4_utils.o allocate.o backed_block.o output_file.o \
contents.o extent.o indirect.o uuid.o sha1.o sparse_crc32.o
simg2imgobj=simg2img.o sparse_crc32.o
all : simg2img make_ext4fs
 .PHONY : all
simg2img:$(simg2imgobj)
	$(CC)  $(simg2imgobj) $(CFLAGS) $(LDFLAGS)  -o $@ 
make_ext4fs:$(make_ext4fsobj)
	$(CC)  $(make_ext4fsobj) $(CFLAGS) $(LDFLAGS)  -o $@ -lz
%.o: %.c  
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< 

clean:
	@rm -rf *.o simg2img make_ext4fs

install:
	cp simg2img make_ext4fs mkuserimg.sh $(DESTDIR)/usr/bin/


