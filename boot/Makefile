AS=as
LD=ld 
OBJCOPY=objcopy
QEMU=qemu-system-i386
LDFLAGS += -Ttext 0

.PHONY:clean all  run
all:bootsect


bootsect:bootsect.s
	@$(AS) -n -g -o bootsect.o bootsect.s
	@$(LD) $(LDFLAGS) -o bootsect bootsect.o
	@cp -f  bootsect bootsect.sym
	@$(OBJCOPY) -R.pdr -R.comment -R.note -S -O binary bootsect
	@dd if=bootsect of=boot.img bs=512

clean:
	- rm bootsect 
	- rm bootsect.o
	- rm bootsect.sym
	- rm boot.img

run:bootsect
	@$(QEMU) -boot a -fda boot.img