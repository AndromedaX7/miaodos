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
.equ SETUPSEG,0x9020
.equ INITSEG,0x9000
.equ SETUPLEN,4
.equ SYSSEG,0x1000
.equ ROOT_DEV ,0x301

	ljmp $BOOTSEG,$_start

_start:
	mov $BOOTSEG,%ax
	mov %ax,%ds
	mov $INITSEG,%ax
	mov %ax,%es
	mov $256,%cx
	sub %si,%si
	sub %di,%di
	rep
	movsw
	ljmp $INITSEG,$go
go:
	mov %cs ,%ax
	mov %ax,%ds
	mov %ax,%es
#put stack at 0x9ff00
	mov %ax,%ss
	mov $0xff00,%sp


msg1:	.byte 13,10
	.ascii "hello tokra
	.byte 13,10,13,10"
	.org 508
root_dev:
	.word ROOT_DEV
boot_flag:
	.word 0xAA55

