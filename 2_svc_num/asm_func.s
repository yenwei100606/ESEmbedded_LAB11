.syntax unified

.global	read_sp
read_sp:
	mov	r0,	sp
	bx	lr

.global	read_msp
read_msp:
	mrs	r0,	msp
	bx	lr

.global	read_psp
read_psp:
	mrs	r0,	psp
	bx	lr

.global	read_ctrl
read_ctrl:
	mrs	r0,	control
	bx	lr

.global	start_user
start_user:
	movs	lr,	r0
	msr	psp,	r1

	movs	r3,	#0b11
	msr	control,	r3
	isb

	bx	lr

.global	sys_call
sys_call:
	SVC #0x3
	bx lr 

.global sys_call_add
sys_call_add:
     SVC #0xA
	 bx lr 



.type svc_handler, %function
.global svc_handler
svc_handler:
	mov r0, lr
	mrs r1, msp
	b svc_handler_c