; File
;  core.asm
; Purpose:     MCF548x core file
	include defines.inc


__IMM		equ	$10000000
__MMU		equ	$00070000
__MMU_SIZE	equ	65536		//64K
__ROM		equ	$00080000
__ROM_SIZE	equ	65536		//64K
__SRAM0		equ	$00090000
__SRAM0_SIZE	equ	4096		//4K
__SRAM1		equ	$00091000
__SRAM1_SIZE	equ	4096		//4K
__SDRAM		equ	$00000000
__SDRAM_SIZE	equ	$00800000	//8M
__EXT_SRAM	equ	$FE400000
__EXT_SRAM_SIZE	equ	131073		//128K

__HEAP_START	equ	$400
__HEAP_END	equ	256*1024+__HEAP_START
__SP_END	equ	__HEAP_END
__SP_INIT	equ	8*8+__SP_END



	xref	_VECTOR_TABLE
	xdef	start
;	xref	__CORE_SRAM0
;	xref	__CORE_SRAM1
;	xref	__CORE_SRAM1_SIZE
	xref	_main
;	xref __SP_INIT
	xdef	__SRAM0


start:
	move.w	#$2700,SR

	move.l	#_VECTOR_TABLE,D0
	movec	D0,VBR
	move.l	#__MMU+$1,d0
	movec	D0,MMUBAR
	jsr	_mcf5307_mmu_init	

	;* Initialize RAMBAR0, RAM wide 32K *
	move.l	#__SRAM0+$35, D0
	movec	D0, RAMBAR0
	move.l	#__SRAM0, A0
	jsr	_mcf5307_ram_init

	;* Initialize RAMBAR1, RAM wide 32K *
	move.l	#__SRAM1+$35, D0
	movec	D0, RAMBAR1
	move.l	#__SRAM1, A0
	jsr	_mcf5307_ram_init

	;* Initialize ROMBAR *
	move.l	#__ROM+$21, D0
	movec	D0,ROMBAR0
;	movec	d0,ROMBAR1

	;* Initialize CACR *
	move.l	#0, D0
	movec	D0,CACR

	;* Initialize ACRs *
	move.l	#0, D0
	movec	D0,ACR0
	move.l	#$40000000, D0
	movec	D0,ACR1
	move.l	#$80000000, D0
	movec	D0,ACR2
	move.l	#$c0000000, D0
	movec	D0,ACR3



	move.l	#__IMM+$1,d0
	movec	d0, MBAR

;	;* Initialize RAM to zero *
;	lea.l	RAMBASE,A0
;	move.l	#1024,D0
;ram_zero_loop:
;	clr.l	(A0)+
;	subq.l	#1,D0
;	bne.b	ram_zero_loop

;	;* Initialize RAMBAR0 - locate it on the data bus *
;	move.l	#__CORE_SRAM0,D0
;	add.l	#$21,D0
;	movec	D0,RAMBAR0

;	;* Initialize RAMBAR1 - locate it on the data bus *
;	move.l	#__CORE_SRAM1,D0
;	add.l	#$21,D0
;	movec	D0,RAMBAR1

;	;* Point Stack Pointer into Core SRAM temporarily *
;	move.l	#RAMBASE+RAMSIZE,D0
;	move.l	#__CORE_SRAM1,D0
;	add.l	#__CORE_SRAM1_SIZE,D0
;	move.l	D0,SP

	;* Invalidate the data, instruction, and branch caches *
	;* Turn on the branch cache *
;	move.l	#$010C0100,d0
;	movec	d0,cacr


;	move.l	#__SRAM+__SRAM_SIZE-$100,sp
;	move.l	#__IMM,-(sp)


	jsr	_mcf5307_siu_debug_init	
	jsr	_mcf5307_mmu_init
	jsr	_mcf5307_gpio_init
	jsr	_mcf5307_ram_init
	jsr	_mcf5307_timer_init
	jsr	_mcf5307_fb_init
	jsr	_mcf5307_edge_init
	jsr	_mcf5307_usb_init
	jsr	_mcf5307_siu_ints_init	
;	lea	4(sp),sp

	;* Relocate Stack Pointer *
	move.l	#__SP_INIT,SP
	nop	; sync

	jsr	_main
	nop
loop:
	nop
	nop
	nop
	nop
	bra	loop

	halt


;************************************************************
;************************************************************
;************************************************************
; *	 Routine to cleanly flush the cache, pushing all lines and
; *	 invalidating them.  This must be done to change the cache when
; *	 we have been operating in copyback mode (i.e. writes to a copyback
; *	 region are probably resident in the cache and not in the main store).
; *
_cpu_cache_flush:
	nop			;synchronize - flush store buffer
	moveq.l #0,D0		;init way counter
	moveq.l #0,D1		;init set counter
	move.l	D0,A0		;init An

flushloop:
	dc.w	$F4E8	 	;cpushl bc,(A0) -- push cache line
	cpushl	bc,(A0)		;push cache line

	add.l	#$0010,A0	;increment setindex by 1
	addq.l	#1,D1		;increment set counter
	cmpi.l	#512,D1 	;are sets for this line done?
	bne	flushloop

	moveq.l #0,D1		;set counter to zero again
	addq.l	#1,D0		;increment to next line
	move.l	D0,A0		;set 0, line d0 into a0 as per cpushl
	cmpi.l	#4,D0
	bne	flushloop

	rts

;************************************************************
; *	 Routine to disable the cache completely	    *
;************************************************************
_cpu_cache_disable:

	move.l	#$7,-(SP)		;Disable interrupts (set IPL = 7)
	jsr	_asm_set_ipl
	lea.l	4(SP),SP
	move.l	D0,D1

	jsr	_cpu_cache_flush	;flush the cache completely

	clr.l	D0
	movec	D0,ACR0 		;ACR0 off
	movec	D0,ACR1 		;ACR1 off
	movec	D0,ACR2 		;ACR2 off
	movec	D0,ACR3 		;ACR3 off

	move.l	#$01000100,D0		;Invalidate and disable cache
	movec	D0,CACR

	move.l	D1,-(SP)		;Restore interrupt level
	jsr	_asm_set_ipl
	lea.l	4(SP),SP

	rts

;************************************************************
;* This routines changes the IPL to the value passed into the routine.
;* It also returns the old IPL value back.                  *
;************************************************************
_asm_set_ipl:
	;(sp) == 7 is disables interrupts
	;d0 = ipl
	link	A6,#-8		;sp = sp - 8
	movem.l D6-D7,(SP)

	move.w	SR,D7		;current sr


	move.l	D7,D1		;prepare return value
	andi.l	#$0700,D1	;mask out IPL
	lsr.l	#8,D1		;IPL

;	move.l	8(A6),D6	;get argument
	andi.l	#$07, d0	;least significant three bits
	lsl.l	#8,d0		;move over to make mask

	andi.l	#$0000F8FF,D7	;zero out current IPL
	or.l	d0,d7		;place new IPL in sr
	move.w	D7,SR

	movem.l (SP),D6-D7
	lea	8(SP),SP
	unlk	A6
	move.l	d1, d0
	rts

;********************************************************************
;********************************************************************
;********************************************************************
;************************************************************************
;*  MMU initialization                                                  *
;************************************************************************
_mcf5307_mmu_init:
	mov3q.l	#2, (MMUCR,a0)	;Virtmode off, tlb supervisor
	nop
	rts

;************************************************************
;************************************************************
;************************************************************

;************************************************************
;*  SRAM initialization                                     *
;************************************************************

_mcf5307_ram_init:
	;in
	;A0 - address of SRAM 
;	lea.l RAMBASE,A0 	;load pointer to SRAM
	move.l #1024,D0 	;load loop counter into D0
.loop:
	clr.l	(A0)+ 		;clear 4 bytes of SRAM
	subq.l	#1,D0		;decrement loop counter
	bne.b	.loop
	rts

;******************************************************************************
;******************************************************************************
;******************************************************************************

;******************************************************************************
;*  SIM - Debug                                                               *
;******************************************************************************
_mcf5307_siu_debug_init:
	;*in: a0 - pointer to imm*
	clr.l	d0
	move.l	d0, (SBCR,a0)		;Disable breakpoint
	move.l	d0, (SECSACR,a0)	;Disable the SEC Sequential Access 
	move.l	#$b, d0
	move.l	d0, (RSR,a0)		;Clear system Reset signals
	rts

;******************************************************************************
;*  SIM - Interrupts                                                          *
;******************************************************************************
_mcf5307_siu_ints_init:
	move.w	SR, d1		;storing SR
	move.l	d1, d0
	ori.l	#$0700,d0	;mask out IPL
	move.w	d0, SR
	move.l	#$ffffffff, d0
	move.l	d0, (IMRH,a0)	;GPT enabling ints 
	lsl.l	#1, d0
	move.l	d0, (IMRL,a0)	;enabling IRQ1-3 ints
	move.w	d1, SR		;restoring SR
	clr.l	d0
	move.l	d0, (INTFRCH,a0)
	move.l	d0, (INTFRCL,a0)
	rts

;************************************************************************
;*  Timers                                                              *
;************************************************************************
_mcf5307_timer_init:
	move.l	#TIMER_GMS_ICT_RAISE|TIMER_GMS_COUNT_ENABLED|TIMER_GMS_CONT_OPER|TIMER_GMS_INT_ENABLED|TIMER_GMS_TMS_DISABLED, d0
;	move.l	#$a84000, d0
	move.l	d0, (GMS0,a0)	;disable timer0, set timer0 input mode
	move.l	d0, (GMS1,a0)	;disable timer1, set timer1 input mode
	move.l	d0, (GMS2,a0)	;disable timer2, set timer2 input mode
	move.l	d0, (GMS3,a0)	;disable timer3, set timer3 input mode
	move.l	#1, d0
	move.l	d0, (GCIR0,a0)	;Set prescaler0 to 1 and zerous counter
	move.l	d0, (GCIR1,a0)	;Set prescaler1 to 1 and zerous counter
	move.l	d0, (GCIR2,a0)	;Set prescaler2 to 1 and zerous counter
	move.l	d0, (GCIR3,a0)	;Set prescaler3 to 1 and zerous counter
	clr.l	d0
	move.l	d0, (GPWM0,a0)	;Setoff PWM0 output val
	move.l	d0, (GPWM1,a0)	;Setoff PWM1 output val
	move.l	d0, (GPWM2,a0)	;Setoff PWM2 output val
	move.l	d0, (GPWM3,a0)	;Setoff PWM3 output val
	move.b	d0, (ICR59,a0)	;setting level and priority of GPT0 to 0
	move.b	d0, (ICR60,a0)	;setting level and priority of GPT1 to 0
	move.b	d0, (ICR61,a0)	;setting level and priority of GPT2 to 0
	move.b	d0, (ICR62,a0)	;setting level and priority of GPT3 to 0

	rts

;TIMER_GMS_ICT_FALL

;TIMER_GMS_TMS_IN

;********************************************************************************
;*  FlexBus - This routine initializes ChipSelects to setup peripherals		*
;********************************************************************************
_mcf5307_fb_init:
	clr.l	d0
	move.l	d0, (CSAR0,a0)
	move.l	d0, (CSAR1,a0)
	move.l	d0, (CSMR1,a0)	;disable CS1
	move.l	d0, (CSCR1,a0)
	move.l	d0, (CSAR2,a0)
	move.l	d0, (CSMR2,a0)	;disable CS2
	move.l	d0, (CSCR2,a0)
	move.l	d0, (CSAR3,a0)
	move.l	d0, (CSMR3,a0)	;disable CS3
	move.l	d0, (CSCR3,a0)
	move.l	d0, (CSAR4,a0)
	move.l	d0, (CSMR4,a0)	;disable CS4
	move.l	d0, (CSCR4,a0)
	move.l	d0, (CSAR5,a0)
	move.l	d0, (CSMR5,a0)	;disable CS5
	move.l	d0, (CSCR5,a0)
	move.l	#%100000001, d0
	move.l	d0, (CSMR0,a0)
	move.l	#%11111100101111111111110101000000, d0
	move.l	d0, (CSCR0,a0)	;AA=1, SWS=63, WS=63, port 8 bits


	rts


;************************************************************
;*  GPIO						    *
;************************************************************
_mcf5307_gpio_init:

	move.b	#%11111111, d0
	move.b	d0, (PDDR_FBCTL,a0)	;conf all pins as output
	move.b	d0, (PDDR_FEC0H,a0)
	move.b	d0, (PDDR_FEC0L,a0)
	move.b	d0, (PDDR_FEC1H,a0)
	move.b	d0, (PDDR_FEC1L,a0)
	move.b	d0, (PDDR_PSC3PSC2,a0)
	move.b	d0, (PDDR_PSC1PSC0,a0)
	lsr	#1, d0
	move.b	d0, (PDDR_DSPI,a0)	;conf all pins as output
	move.b	#%00111110, d0
	move.b	d0, (PDDR_FBCS,a0)	;conf all pins as output
	lsr	#1, d0
	move.b	d0, (PDDR_PCIBG,a0)
	move.b	d0, (PDDR_PCIBR,a0)
	lsr	#1, d0
	move.b	d0, (PDDR_DMA,a0)	;conf all pins as output
	move.b	d0, (PAR_DMA,a0)	;conf all pins as GPIO
	clr.w	d0
	move.b	d0, (PAR_PSC3,a0)	;conf all pins as GPIO
	move.b	d0, (PAR_PSC2,a0)	;conf all pins as GPIO
	move.b	d0, (PAR_PSC1,a0)	;conf all pins as GPIO
	move.b	d0, (PAR_PSC0,a0)	;conf all pins as GPIO
	move.w	d0, (PAR_DSPI,a0)	;conf all pins as GPIO
	move.w	d0, (PAR_FBCTL,a0)	;conf all pins as GPIO
	move.b	d0, (PAR_FBCS,a0)	;conf all pins as GPIO
	move.b	#4, d0
	move.b	d0, (PAR_DMA,a0)	;set IRC1, all other pins as GPIO
	move.w	#%11, d0
	move.w	d0, (PAR_FECI2CIRQ,a0)	;set IRC5,6, all other pins as GPIO
	move.w	#%0, d0
	move.w	d0, (PAR_PCIBG,a0)	;conf all pins as GPIO
	move.w	#%1010101010, d0
	move.w	d0, (PAR_PCIBR,a0)	;set IRC4, TIMERs 0-3, all other pins as GPIO
	move.b	#100100, d0
	move.b	d0, (PAR_TIMER,a0)	;set IRC2,3
	rts


;********************************************************************************
;*  Edge									*
;********************************************************************************
_mcf5307_edge_init:
	move.w	#%0101010101010100, d0
	move.w	d0, (EPPAR,a0);rising edge triggered inter
	move.b	#%11111000, d0
	move.b	d0, (EPDDR,a0)	;configure 1-2 ports as input, 3-7 as output
	move.b	#%11111000, d0
	move.b	d0, (EPIER,a0)	;1-2 ports interrupts enbled, 3-7 disabled
;	move.b	#%11111111, d0
;	move.b	d0, EPDR	;ports data output
;	move.b	#%11111111, d0
;	move.b	d0, EPFR	;clearing edge triggered bits
	rts

;********************************************************************************
;*  USB										*
;********************************************************************************
_mcf5307_usb_init:
	add.l	#$b000, a0
	move.l	#%101101, d0
	move.l	d0, (USBCR,a0)	;set priority to performance, device RAM access
	move.l	#%11111111, d0
	move.l	d0, (USBIMR,a0)	;masking of all USB interrupts
;	move.b	#%11111111, d0
	move.b	d0, (USBAIMR,a0)	;masking of all app USB interrupts
;	move.b	#%11111111, d0
	move.b	d0, (CFGR,a0)	;??
	move.b	#%11100000, d0
	move.b	d0, (CFGAR,a0)	;1v100000, v - remote wakeup enabled
	move.b	#%10, d0
	move.b	d0, (SPEEDR,a0)	;10 - full speed enabled
	move.b	#0, d0
	move.b	d0, (EPTNR,a0)	;1 transaction for all endpoints
	move.w	#0, d0
	move.w	d0, (IFR0,a0)	;confreg0
	move.w	#%11111100000000, d0
	move.w	d0, (IFR0,a0)	;confreg31
	move.w	#0, d0
	move.w	d0, (IFR0,a0)	;disable overflow

	move.b	#0, d0
	move.b	d0, (EP0ACR,a0)	;set to interrupt control
	move.b	#3, d0
	move.b	d0, (EP1INACR,a0)
	move.b	d0, (EP1OUTACR,a0)
	move.b	d0, (EP2INACR,a0)
	move.b	d0, (EP2OUTACR,a0)
	move.b	d0, (EP3INACR,a0)
	move.b	d0, (EP3OUTACR,a0)
	move.b	d0, (EP4INACR,a0)
	move.b	d0, (EP4OUTACR,a0)
	move.b	d0, (EP5INACR,a0)
	move.b	d0, (EP5OUTACR,a0)
	move.b	d0, (EP6INACR,a0)
	move.b	d0, (EP6OUTACR,a0)
	move.w	#%100000000, d0
	move.w	d0, (EP0MPSR,a0)	;set 0 add transactions, packetsize = 512
;	move.w	#0, d0
	move.w	d0, (EP1INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP1OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP2INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP2OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP3INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP3OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP4INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP4OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP5INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP5OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP6INMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.w	d0, (EP6OUTMPSR,a0)	;set 0 add transactions, packetsize = 512
	move.b	#%00000010, d0
	move.b	d0, (EP0SR,a0)	;set status: clr ints, active 
	move.b	#%00000000, d0
	move.b	d0, (EP1INSR,a0)	;set status: clr ints
	move.b	d0, (EP1OUTSR,a0)	;set status: clr ints
	move.b	d0, (EP2INSR,a0)	;set status: clr ints
	move.b	d0, (EP2OUTSR,a0)	;set status: clr ints
	move.b	d0, (EP3INSR,a0)	;set status: clr ints
	move.b	d0, (EP3OUTSR,a0)	;set status: clr ints
	move.b	d0, (EP4INSR,a0)	;set status: clr ints
	move.b	d0, (EP4OUTSR,a0)	;set status: clr ints
	move.b	d0, (EP5INSR,a0)	;set status: clr ints
	move.b	d0, (EP5OUTSR,a0)	;set status: clr ints
	move.b	d0, (EP6INSR,a0);set status: clr ints
	move.b	d0, (EP6OUTSR,a0)	;set status: clr ints
	move.b	#%10000000, d0
	move.b	d0, (BMRTR,a0)	;dir: device to host, type: std, rec: device
	;SETUP transaction
	move.b	#0, d0
	move.b	d0, (BRTR,a0)
	move.b	d0, (WVALUER,a0)
	move.b	d0, (WINDEXR,a0)
	move.b	d0, (WLENGTHR,a0)
	move.b	#%11, d0
	move.b	d0, (EP0STAT,a0)	;flush and reset FIFO
	move.l	#%111110001, d0
	move.l	d0, (EP0IMR,a0)	;enable FIFO transfer complete
;	move.l	EP0IR, d0	
	move.l	#$200, d0
	move.l	d0, (EP0FRCFGR,a0)	;zero base and 512 byte size FIFO
	move.l	#%1000000000000000000000000000, d0
	move.l	d0, (EP0FCR,a0)
	move.l	#%100, d0
	move.l	d0, (EP0FAR,a0)	;alarm at 4 bytes
	sub.l	#$b000, a0

	rts


	boundary


