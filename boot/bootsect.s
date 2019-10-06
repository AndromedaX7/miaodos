.code16
.global _start,begtext,begdata,begbss,endtext,enddata,endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text
.equ BOOTSEG,0x07c0
ljmp $BOOTSEG,$_start

_start:
    mov $BOOTSEG,%ax
    mov %ax,%es
    mov $0x03,%ah
    xor %bh,%bh
    int $0x10

    mov $msg1,%bp
    mov $7,%cx
    mov $0x1301,%ax
    mov $0x0001,%bx
    int $0x10

msg1:
.byte 13,10
.ascii "12345"
.byte 13,10,13,10

.org 508

boot_dev:
    .word 0x301
boot_flag:
    .word 0xaa55
