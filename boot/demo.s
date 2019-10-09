.code16
.text
.equ DEMOSEG,0x9020
.equ LEN,54

show_text:
   mov $DEMOSEG,%ax
   mov %ax,%es
   mov $0x03,%ah
   xor %bh,%bh
   int $0x10

    mov $0x000a,%bx
    mov $LEN,%cx
    mov $msg,%bp
    mov $0x1301,%ax
    int $0x10

loop_forever:jmp loop_forever

msg:
    .byte 13, 10
	.ascii "You've successfully load the floppy data into RAM"
	.byte 13, 10, 13, 10



#	mov $DEMOSEG, %ax
#	mov %ax, %es
#	mov $0x03, %ah
#	xor %bh, %bh
#	int $0x10					# these two line read the cursor position

#	mov $0x000a, %bx			# Set video parameter
#	mov $0x1301, %ax
#	mov $LEN, %cx
#	mov $msg, %bp
#	int $0x10
#
#loop_forever:
#	jmp loop_forever

#msg:
	#.byte 13, 10
	#.ascii "You've successfully load the floppy data into RAM"
	#.byte 13, 10, 13, 10
