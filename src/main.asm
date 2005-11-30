;****************************UFIB on MCF5485*****************
	; Simple extended code test for cfasm
	; -- origin
;	org	 $78000000
	; -- set cpu types. The types available are 5206, 5206e, 5272, 5307 and 5407
	;    Only cpu types with the mac unit will assemble this correctly.
	include defines.inc

	xdef	_main

	xdef exception_handler_src1
	xdef exception_handler_src2
	xdef exception_handler_src3
	xdef exception_handler_src4
	xdef exception_handler_src5
	xdef exception_handler_src6
	xdef exception_handler_src7
	xdef exception_handler_src8
	xdef exception_handler_src9
	xdef exception_handler_src10
	xdef exception_handler_src11
	xdef exception_handler_src12
	xdef exception_handler_src13
	xdef exception_handler_src14
	xdef exception_handler_src15
	xdef exception_handler_src16
	xdef exception_handler_src17
	xdef exception_handler_src18
	xdef exception_handler_src19
	xdef exception_handler_src20
	xdef exception_handler_src21
	xdef exception_handler_src22
	xdef exception_handler_src23
	xdef exception_handler_src24
	xdef exception_handler_src25
	xdef exception_handler_src26
	xdef exception_handler_src27
	xdef exception_handler_src28
	xdef exception_handler_src29
	xdef exception_handler_src30
	xdef exception_handler_src31
	xdef exception_handler_src32
	xdef exception_handler_src33
	xdef exception_handler_src34
	xdef exception_handler_src35
	xdef exception_handler_src36
	xdef exception_handler_src37
	xdef exception_handler_src38
	xdef exception_handler_src39
	xdef exception_handler_src40
	xdef exception_handler_src41
	xdef exception_handler_src42
	xdef exception_handler_src43
	xdef exception_handler_src44
	xdef exception_handler_src45
	xdef exception_handler_src46
	xdef exception_handler_src47
	xdef exception_handler_src48
	xdef exception_handler_src49
	xdef exception_handler_src50
	xdef exception_handler_src51
	xdef exception_handler_src52
	xdef exception_handler_src53
	xdef exception_handler_src54
	xdef exception_handler_src55
	xdef exception_handler_src56
	xdef exception_handler_src57
	xdef exception_handler_src58
	xdef exception_handler_src59
	xdef exception_handler_src60
	xdef exception_handler_src61
	xdef exception_handler_src62
	xdef exception_handler_src63
	xref __SRAM0

CAM0	equ	$100
CAM1	equ	$104
CAM2	equ	$108
CAM3	equ	$10c
SYS_SIZE	equ	4
FRM_SIZE	equ	$10
CAM_SIZE	equ	300*4
FRM0	equ	SYS_SIZE
FRM1	equ	SYS_SIZE+FRM_SIZE

	section code,16,C

;есть два буфера кадра и два указателя на эти буферы. пока в один буфер заливается инфа,
;другой  буфер прога передает по USB. потом указатели swap'ятся. и все повторяется.
_main:
	move.l	#__SRAM0, a6
	move.l	#__SRAM0+FRM0, a4
	move.l	#__SRAM0+FRM1, a5
	move.l	#8, d5
	move.l	a4, a6
	move.l	#FRM0+FRM_SIZE*2+CAM_SIZE, d4
frm_init:
	move.l	d4, (CAM0,a6)
	addi.l	#CAM_SIZE, d4
	subq.l	#1, d5
	bne.b	frm_init
frm_rcv:
	btst.b	#0, (a6)
	bne.b	frm_rcv
	bclr.b	#0, (a6)
	move.l	a4, d4
	move.l	a5, a4
	move.l	d4, a5
	move.l	#300, d4
	move.l	a5, a3
	move.l	(USBCR,a0), d4
	bset.b	#1, d4
	move.l	d4, (USBCR,a0)
	move.l	#300, d5
frm_out:
	move.b	(a3)+, d6
	move.b	d6, (DRAMDR,a0)
	subq.l	#1, d5
	bne.b	frm_out
	move.l	(USBCR,a0), d4
	bclr.b	#1, d4
	move.l	d4, (USBCR,a0)
	bra	frm_rcv
;************************************************************
exception_handler_src1:
;button - irq1
	move.l	#1, d0
	or.l	d0, (IMRL,a0)
cycle:
	eori.l	#111110, d0
	move.l	d0, a1
	wddata	$a5
	move.l	#$ffffffff, d0
pause:
	subq.l	#1, d0
	bne.b	pause
	bra	cycle

exception_handler_src2:
;frame - irq2
	bclr.b	#2, (IPRL,a0)	;resets irq2
	btst.b	#1, (a6)	;check active frame
	bne.b	eofrm		;jump if active frame
	bset.b	#1, (a6)	;enable active frame
	clr.w	(2,a6)		;clears row counter
	bclr.b	#3, (IPRL+3,a0) ;resets irq3
	bclr.b	#3, (IMRL+3,a0) ;enables irq3
	bset.b	#3, (EPFR,a0)	;resets irq3 in sevice module
	rte
eofrm:
	bclr.b	#1, (a6)	;disable active frame
	bset.b	#0, (a6)	;runs procesing of frame
	bset.b	#3, (IMRL+3,a0) ;disables irq3
	rte

exception_handler_src3:
;row - irq3
	bclr.b	#3, (EPFR,a0)	;resets irq3
	btst.b	#1, (a6)
	bne.b	eorow
	bset.b	#1, (a6)
;	move.l	#%11111111111111111111111111100000, d0
;	move.b	(EPFR,a0), d1
;	and.l	d0, d1
;	move.b	d0, (EPFR,a0)	;resets irq4
;	and.l	d0, (IPRL,a0)	;resets src4
;	and.l	d0, (IMRL,a0)	;enables irq4
;	move.l	#%10000111111111111111111111111111, d0
;	addq.l	#1, (2,a6)
;	and.l	d0, (IPRH,a0)	;resets src59-62
;	and.l	d0, (IMRH,a0)	;enables src59-62
;	move.l	#%11111111101111111111111111111111, d0
;	and.l	d0, (IPRH,a0)	;resets src59-62
;	and.l	d0, (IMRH,a0)	;enables src59-62
;	move.l	d0, (STCNT0,a0)
	move.l	#735, d0
	move.l	d0, (STCNT0,a0) ;load val slice timer 0
	bset.b	#7, (SCR0,a0) ;run slice timer 0
	addq.l	#1, (2,a6)
	rte
eorow:
	bclr.b	#1, (a6)
	move.l	#%10000, d0
	bset.b	#4, (IMRL+3,a0) ;disables irq4
	move.l	#%01111000000000000000000000000000, d0
	or.l	d0, (IMRH,a0)	;disables src59-62
	rte

exception_handler_src4: ;clk - irq4
exception_handler_src5:
exception_handler_src6:
exception_handler_src7:
exception_handler_src8:
exception_handler_src9:
exception_handler_src10:
exception_handler_src11:
exception_handler_src12:
exception_handler_src13:
exception_handler_src14:
exception_handler_src15:
exception_handler_src16:
exception_handler_src17:
exception_handler_src18:
exception_handler_src19:
exception_handler_src20:
exception_handler_src21:
exception_handler_src22:
exception_handler_src23:
exception_handler_src24:
exception_handler_src25:
exception_handler_src26:
exception_handler_src27:
exception_handler_src28:
exception_handler_src29:
exception_handler_src30:
exception_handler_src31:
exception_handler_src32:
exception_handler_src33:
exception_handler_src34:
exception_handler_src35:
exception_handler_src36:
exception_handler_src37:
exception_handler_src38:
exception_handler_src39:
exception_handler_src40:
exception_handler_src41:
exception_handler_src42:
exception_handler_src43:
exception_handler_src44:
exception_handler_src45:
exception_handler_src46:
exception_handler_src47:
exception_handler_src48:
exception_handler_src49:
exception_handler_src50:
exception_handler_src51:
exception_handler_src52:
exception_handler_src53:
exception_handler_src55:
exception_handler_src56:
exception_handler_src57:
exception_handler_src58:
exception_handler_src63:
;	move.l	SP,A1
;	move.l	A1,-(SP)
;	jsr	exception_handler
;	lea	4(SP),SP
	rte
;пауза "в каждой строке" кадра перед началом заполнением буфера.
;т.е. т.о. мы "пропускаем" черные пиксели с левой стороны кадра.
;вместо N надо че-то написать. Паша этого сделать не успел.
;по-моему должно быть что-то вроде N == 21.
exception_handler_src54:
;slice timer 0 - pause N * 106 ns
	bclr.b	#4, (EPFR,a0)	;resets irq4
	bclr.b	#4, (IPRL+3,a0) ;resets src4
	bclr.b	#4, (IMRL+3,a0) ;enables irq4
;	move.l	#%10000111111111111111111111111111, d0
	move.l	#%10000111111111111111111111111111, d0
	and.l	d0, (IPRH,a0)	;resets src59-62
	and.l	d0, (IMRH,a0)	;enables src59-62
	rte
exception_handler_src59:
;data3 - gpt3
	bset.b	#0, (IMRL+3,a0)
	lea.l	(GMS3,a0), a1
	move.l	(CAM3,a4), a2
	bra	dataprocessing
exception_handler_src60:
;data2 - gpt2
	bset.b	#0, (IMRL+3,a0)
	lea.l	(GMS2,a0), a1
	move.l	(CAM2,a4), a2
	bra	dataprocessing
exception_handler_src61:
;data1 - gpt1
	bset.b	#0, (IMRL+3,a0)
	lea.l	(GMS1,a0), a1
	move.l	(CAM1,a4), a2
	bra	dataprocessing
exception_handler_src62:
;data0 - gpt0
	bset.b	#0, (IMRL+3,a0) ;disable all ints
	lea.l	(GMS0,a0), a1
	move.l	(CAM0,a4), a2
dataprocessing:
	move.l	(a6), d0
	lsl	#2, d0
	move.l	d0, a2
	move.l	($c,a1), d1
	btst.b	#6, (2,a1)
	beq.b	scnd
	move.w	d1, (0,a2)
	bset.b	#7, (2,a1)	;seting fall reaction
	bclr.b	#6, (2,a1)
	bra	store
scnd:
	move.w	d1, (2,a2)
	bset.b	#6, (2,a1)	;seting raise reaction
	bclr.b	#7, (2,a1)
	bclr.b	#7, (1,a1)	;disable GPT-INT
store:
	bclr.b	#0, (IMRL+3,a0) ;enable all ints
	rte


;use the boundary command to issue special segment code between the end of code and the start of data. This is used to prevent the look ahead function of the instruction cache obtaining invalid data and a possible lockup.



