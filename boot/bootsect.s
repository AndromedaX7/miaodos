.code16
.global _start,begtext,begdata,begbss,endtext,enddata,endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text
.equ SETUPLEN,0x04
.equ ROOT_DEV,0x301
.equ BOOTSEG,0x07c0
.equ INITSEG,0x9000
.equ SETUPSEG,0x9020

.equ DEMOSEG,0x1000

ljmp $BOOTSEG,$_start

_start:
    mov $BOOTSEG,%ax
    mov %ax,%es
    mov $0x03,%ah
    xor %bh,%bh
    int $0x10

    mov $msg1,%bp
    mov $21,%cx
    mov $0x1301,%ax
    mov $0x0007,%bx
    int $0x10

change_bootsect:
    mov $256 ,%cx
    mov $BOOTSEG,%ax
    mov %ax,%ds
    mov $INITSEG,%ax
    mov %ax,%es
    sub %si,%si
    sub %di,%di
    rep movsw
    ljmp $INITSEG,$mov_success

mov_success:
    mov $0x03,%ah
    xor %bh,%bh
    int $0x10

    mov $INITSEG,%ax
    mov %ax,%es
    mov $0x1301,%ax
    mov $24,%cx
    mov $0x0001,%bx
    mov $msg_mov_success,%bp
    int $0x10

load_demo:
    mov $0x0000,%dx     # dl 驱动器，dh 磁头号0进行读取  ch cipanhao cl shanquhao
    mov $0X0002,%cx     # 从二号扇区，0轨道开始读(注意扇区是从1开始编号的)
    mov $SETUPSEG,%ax    # ES:BX 指向装载目的地址
    mov %ax,%es
    mov $0,%bx
    mov $0x02,%ah       # Service 2: Read Disk Sectors
    mov $SETUPLEN,%al       # 读取的扇区数
    int $0x13

    jnc demo_load_ok
    jmp load_demo

demo_load_ok:
    mov $INITSEG,%ax
    mov %ax,%ds
    ljmp $SETUPSEG,$0
load_demo2:
    mov $BOOTSEG,%ax
    mov %ax,%es
    xor %bh,%bh
    mov $0x03,%ah
    int $0x10

    mov $0x1301,%ax
    mov $0x0004,%bx
    mov $10,%cx
    mov $msg_err,%bp
    int $0x10

msg1:
.byte 13,10
.ascii "bootsect loading..."
.byte 13,10,13,10
msg_mov_success:
.byte 13,10
.ascii "move bootsect success!"
.byte 13,10,13,10
msg_err:
.byte 13,10
.ascii "Load err"
.byte 13,10,13,10
.org 508

boot_dev:
    .word 0x301
boot_flag:
    .word 0xaa55
