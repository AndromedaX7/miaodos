AS=as
LD=ld 
OBJCOPY=objcopy
QEMU=qemu-system-i386
LDFLAGS += -Ttext 0

.PHONY:clean all  run
all:boot


bootsect:bootsect.s
	$(AS) -n -g -o bootsect.o bootsect.s
	$(LD) $(LDFLAGS) -o bootsect bootsect.o
	cp -f  bootsect bootsect.sym
	$(OBJCOPY) -R.pdr -R.comment -R.note -S -O binary bootsect

demo:demo.s
	$(AS) -n -g -o demo.o demo.s
	$(LD) $(LDFLAGS) -o demo demo.o
	cp -f demo demo.sym
	$(OBJCOPY) -R.pdr -R.comment -R.note -S -O binary demo

boot:bootsect demo
	dd if=bootsect of=boot.img bs=512 count=1
	dd if=demo of=boot.img bs=512 seek=1 count=4

clean:
	- rm bootsect demo
	- rm *.o
	- rm *.sym
	- rm boot.img

run:boot
	@$(QEMU) -boot a -fda boot.img

run_debug:boot
	@$(QEMU) -boot a -fda boot.img -S -s
