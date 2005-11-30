	include defines.inc

__IMM		equ	$10000000
__MMU		equ	$00040000
__MMU_SIZE	equ	$00010000
__ROM0		equ	$00050000
__ROM1		equ	$00060000
__SRAM0 	equ	$00070000
__SRAM1 	equ	$00080000
__SDRAM 	equ	$00000000
__SDRAM_SIZE	equ	$00800000	//8M
__EXT_SRAM	equ	$FE400000
__EXT_SRAM_SIZE equ	131073		//128K

; sram variables addresses definition
SRAM0_SIZE	equ	$0
USB_DESC_LEN	equ	$00
USB_ADDR	equ	$00

;sections sizes and addresses definition
__HEAP_START	equ	$0
__HEAP_SIZE	equ	$40000
__SP_START	equ	__HEAP_START+__HEAP_SIZE
__SP_SIZE	equ	$1000
__SP_INIT	equ	__SP_START+__SP_SIZE


;****************************UFIB on MCF5485*****************
	; Simple extended code test for cfasm

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

_VECTOR_TABLE:
;	 org 0
	dc.l __SP_INIT		      ;Initial SP
	dc.l start		      ;Initial PC
vector002 dc.l asm_exception_handler  ;Access Error
vector003 dc.l asm_exception_handler  ;Address Error
vector004 dc.l asm_exception_handler  ;Illegal Instruction
vector005 dc.l asm_exception_handler  ;Reserved
vector006 dc.l asm_exception_handler  ;Reserved
vector007 dc.l asm_exception_handler  ;Reserved
vector008 dc.l asm_exception_handler  ;Privilege Violation
vector009 dc.l asm_exception_handler  ;Trace
vector010 dc.l asm_exception_handler  ;Unimplemented A-Line
vector011 dc.l asm_exception_handler  ;Unimplemented F-Line
vector012 dc.l asm_exception_handler  ;Debug Interrupt
vector013 dc.l asm_exception_handler  ;Reserved
vector014 dc.l asm_exception_handler  ;Format Error
vector015 dc.l asm_exception_handler  ;Unitialized Interrupt
vector016 dc.l asm_exception_handler  ;Reserved
vector017 dc.l asm_exception_handler  ;Reserved
vector018 dc.l asm_exception_handler  ;Reserved
vector019 dc.l asm_exception_handler  ;Reserved
vector020 dc.l asm_exception_handler  ;Reserved
vector021 dc.l asm_exception_handler  ;Reserved
vector022 dc.l asm_exception_handler  ;Reserved
vector023 dc.l asm_exception_handler  ;Reserved
vector024 dc.l asm_exception_handler  ;Spurious Interrupt
vector025 dc.l asm_exception_handler  ;Autovector Level 1
vector026 dc.l asm_exception_handler  ;Autovector Level 2
vector027 dc.l asm_exception_handler  ;Autovector Level 3
vector028 dc.l asm_exception_handler  ;Autovector Level 4
vector029 dc.l asm_exception_handler  ;Autovector Level 5
vector030 dc.l asm_exception_handler  ;Autovector Level 6
vector031 dc.l asm_exception_handler  ;Autovector Level 7
vector032 dc.l asm_exception_handler  ;TRAP #0
vector033 dc.l asm_exception_handler  ;TRAP #1
vector034 dc.l asm_exception_handler  ;TRAP #2
vector035 dc.l asm_exception_handler  ;TRAP #3
vector036 dc.l asm_exception_handler  ;TRAP #4
vector037 dc.l asm_exception_handler  ;TRAP #5
vector038 dc.l asm_exception_handler  ;TRAP #6
vector039 dc.l asm_exception_handler  ;TRAP #7
vector040 dc.l asm_exception_handler  ;TRAP #8
vector041 dc.l asm_exception_handler  ;TRAP #9
vector042 dc.l asm_exception_handler  ;TRAP #10
vector043 dc.l asm_exception_handler  ;TRAP #11
vector044 dc.l asm_exception_handler  ;TRAP #12
vector045 dc.l asm_exception_handler  ;TRAP #13
vector046 dc.l asm_exception_handler  ;TRAP #14
vector047 dc.l asm_exception_handler  ;TRAP #15
vector048 dc.l asm_exception_handler  ;Reserved
vector049 dc.l asm_exception_handler  ;Reserved
vector050 dc.l asm_exception_handler  ;Reserved
vector051 dc.l asm_exception_handler  ;Reserved
vector052 dc.l asm_exception_handler  ;Reserved
vector053 dc.l asm_exception_handler  ;Reserved
vector054 dc.l asm_exception_handler  ;Reserved
vector055 dc.l asm_exception_handler  ;Reserved
vector056 dc.l asm_exception_handler  ;Reserved
vector057 dc.l asm_exception_handler  ;Reserved
vector058 dc.l asm_exception_handler  ;Reserved
vector059 dc.l asm_exception_handler  ;Reserved
vector060 dc.l asm_exception_handler  ;Reserved
vector061 dc.l asm_exception_handler  ;Reserved
vector062 dc.l asm_exception_handler  ;Reserved
vector063 dc.l asm_exception_handler  ;Reserved
vector064 dc.l asm_exception_handler
vector065 dc.l exception_handler_src1
vector066 dc.l exception_handler_src2
vector067 dc.l exception_handler_src3
vector068 dc.l exception_handler_src4
vector069 dc.l exception_handler_src5
vector070 dc.l exception_handler_src6
vector071 dc.l exception_handler_src7
vector072 dc.l exception_handler_src8
vector073 dc.l exception_handler_src9
vector074 dc.l exception_handler_src10
vector075 dc.l exception_handler_src11
vector076 dc.l exception_handler_src12
vector077 dc.l exception_handler_src13
vector078 dc.l exception_handler_src14
vector079 dc.l exception_handler_src15
vector080 dc.l exception_handler_src16
vector081 dc.l exception_handler_src17
vector082 dc.l exception_handler_src18
vector083 dc.l exception_handler_src19
vector084 dc.l exception_handler_src20
vector085 dc.l exception_handler_src21
vector086 dc.l exception_handler_src22
vector087 dc.l exception_handler_src23
vector088 dc.l exception_handler_src24
vector089 dc.l exception_handler_src25
vector090 dc.l exception_handler_src26
vector091 dc.l exception_handler_src27
vector092 dc.l exception_handler_src28
vector093 dc.l exception_handler_src29
vector094 dc.l exception_handler_src30
vector095 dc.l exception_handler_src31
vector096 dc.l exception_handler_src32
vector097 dc.l exception_handler_src33
vector098 dc.l exception_handler_src34
vector099 dc.l exception_handler_src35
vector100 dc.l exception_handler_src36
vector101 dc.l exception_handler_src37
vector102 dc.l exception_handler_src38
vector103 dc.l exception_handler_src39
vector104 dc.l exception_handler_src40
vector105 dc.l exception_handler_src41
vector106 dc.l exception_handler_src42
vector107 dc.l exception_handler_src43
vector108 dc.l exception_handler_src44
vector109 dc.l exception_handler_src45
vector110 dc.l exception_handler_src46
vector111 dc.l exception_handler_src47
vector112 dc.l exception_handler_src48
vector113 dc.l exception_handler_src49
vector114 dc.l exception_handler_src50
vector115 dc.l exception_handler_src51
vector116 dc.l exception_handler_src52
vector117 dc.l exception_handler_src53
vector118 dc.l exception_handler_src54
vector119 dc.l exception_handler_src55
vector120 dc.l exception_handler_src56
vector121 dc.l exception_handler_src57
vector122 dc.l exception_handler_src58
vector123 dc.l exception_handler_src59
vector124 dc.l exception_handler_src60
vector125 dc.l exception_handler_src61
vector126 dc.l exception_handler_src62
vector127 dc.l exception_handler_src63
vector128 dc.l asm_exception_handler
vector129 dc.l asm_exception_handler
vector130 dc.l asm_exception_handler
vector131 dc.l asm_exception_handler
vector132 dc.l asm_exception_handler
vector133 dc.l asm_exception_handler
vector134 dc.l asm_exception_handler
vector135 dc.l asm_exception_handler
vector136 dc.l asm_exception_handler
vector137 dc.l asm_exception_handler
vector138 dc.l asm_exception_handler
vector139 dc.l asm_exception_handler
vector140 dc.l asm_exception_handler
vector141 dc.l asm_exception_handler
vector142 dc.l asm_exception_handler
vector143 dc.l asm_exception_handler
vector144 dc.l asm_exception_handler
vector145 dc.l asm_exception_handler
vector146 dc.l asm_exception_handler
vector147 dc.l asm_exception_handler
vector148 dc.l asm_exception_handler
vector149 dc.l asm_exception_handler
vector150 dc.l asm_exception_handler
vector151 dc.l asm_exception_handler
vector152 dc.l asm_exception_handler
vector153 dc.l asm_exception_handler
vector154 dc.l asm_exception_handler
vector155 dc.l asm_exception_handler
vector156 dc.l asm_exception_handler
vector157 dc.l asm_exception_handler
vector158 dc.l asm_exception_handler
vector159 dc.l asm_exception_handler
vector160 dc.l asm_exception_handler
vector161 dc.l asm_exception_handler
vector162 dc.l asm_exception_handler
vector163 dc.l asm_exception_handler
vector164 dc.l asm_exception_handler
vector165 dc.l asm_exception_handler
vector166 dc.l asm_exception_handler
vector167 dc.l asm_exception_handler
vector168 dc.l asm_exception_handler
vector169 dc.l asm_exception_handler
vector170 dc.l asm_exception_handler
vector171 dc.l asm_exception_handler
vector172 dc.l asm_exception_handler
vector173 dc.l asm_exception_handler
vector174 dc.l asm_exception_handler
vector175 dc.l asm_exception_handler
vector176 dc.l asm_exception_handler
vector177 dc.l asm_exception_handler
vector178 dc.l asm_exception_handler
vector179 dc.l asm_exception_handler
vector180 dc.l asm_exception_handler
vector181 dc.l asm_exception_handler
vector182 dc.l asm_exception_handler
vector183 dc.l asm_exception_handler
vector184 dc.l asm_exception_handler
vector185 dc.l asm_exception_handler
vector186 dc.l asm_exception_handler
vector187 dc.l asm_exception_handler
vector188 dc.l asm_exception_handler
vector189 dc.l asm_exception_handler
vector190 dc.l asm_exception_handler
vector191 dc.l asm_exception_handler
vector192 dc.l asm_exception_handler
vector193 dc.l asm_exception_handler
vector194 dc.l asm_exception_handler
vector195 dc.l asm_exception_handler
vector196 dc.l asm_exception_handler
vector197 dc.l asm_exception_handler
vector198 dc.l asm_exception_handler
vector199 dc.l asm_exception_handler
vector200 dc.l asm_exception_handler
vector201 dc.l asm_exception_handler
vector202 dc.l asm_exception_handler
vector203 dc.l asm_exception_handler
vector204 dc.l asm_exception_handler
vector205 dc.l asm_exception_handler
vector206 dc.l asm_exception_handler
vector207 dc.l asm_exception_handler
vector208 dc.l asm_exception_handler
vector209 dc.l asm_exception_handler
vector210 dc.l asm_exception_handler
vector211 dc.l asm_exception_handler
vector212 dc.l asm_exception_handler
vector213 dc.l asm_exception_handler
vector214 dc.l asm_exception_handler
vector215 dc.l asm_exception_handler
vector216 dc.l asm_exception_handler
vector217 dc.l asm_exception_handler
vector218 dc.l asm_exception_handler
vector219 dc.l asm_exception_handler
vector220 dc.l asm_exception_handler
vector221 dc.l asm_exception_handler
vector222 dc.l asm_exception_handler
vector223 dc.l asm_exception_handler
vector224 dc.l asm_exception_handler
vector225 dc.l asm_exception_handler
vector226 dc.l asm_exception_handler
vector227 dc.l asm_exception_handler
vector228 dc.l asm_exception_handler
vector229 dc.l asm_exception_handler
vector230 dc.l asm_exception_handler
vector231 dc.l asm_exception_handler
vector232 dc.l asm_exception_handler
vector233 dc.l asm_exception_handler
vector234 dc.l asm_exception_handler
vector235 dc.l asm_exception_handler
vector236 dc.l asm_exception_handler
vector237 dc.l asm_exception_handler
vector238 dc.l asm_exception_handler
vector239 dc.l asm_exception_handler
vector240 dc.l asm_exception_handler
vector241 dc.l asm_exception_handler
vector242 dc.l asm_exception_handler
vector243 dc.l asm_exception_handler
vector244 dc.l asm_exception_handler
vector245 dc.l asm_exception_handler
vector246 dc.l asm_exception_handler
vector247 dc.l asm_exception_handler
vector248 dc.l asm_exception_handler
vector249 dc.l asm_exception_handler
vector250 dc.l asm_exception_handler
vector251 dc.l asm_exception_handler
vector252 dc.l asm_exception_handler
vector253 dc.l asm_exception_handler
vector254 dc.l asm_exception_handler
vector255 dc.l asm_exception_handler

;************************************************************
; ;This routine is the lowest-level exception handler	    *
;************************************************************

asm_exception_handler:

	rte
	;вх
	;d0 - настройки процессора
	;d1 - настройки паняти
start:
	; Задание регистра таблицы векторов VBR
	move.l	#_VECTOR_TABLE, d2
	movec	d2, vbr

	; Начальная установка MMU
	jsr	_mcf_mmu_init


	move.l	d1, d3
	andi.l	#CFG1_SRAM0SZ_MASK, d3
	beq	_mcf_ram1_check
	; Настройка досбупа к СОЗУ0 по шине данных
	move.l	#__SRAM0|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
	movec	d2, rambar0
	move.l	#__SRAM0, a2
	; Получение размера СОЗУ0 из системных настроек d1
	move.l	#CFG1_SRAM0SZ_SHIFT, d4
	lsl.l	d4, d3
	mov3q.l #1, d2
	lsl.l	d3, d2
	; Сброс данных СОЗУ0
	jsr	_mcf_ram_init
	move.l	d2, (SRAM0_SIZE,a2)

_mcf_ram1_check:
	move.l	d1, d3
	andi.l	#CFG1_SRAM1SZ_MASK, d3
	beq	_mcf_rom0_check
	; Настройка досбупа к СОЗУ1 по шине данных
	move.l	#__SRAM1|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
	movec	d2, rambar1
	move.l	#__SRAM1, a0
	; Получение размера СОЗУ1 из системных настроек d1
	lsl.l	#CFG1_SRAM1SZ_SHIFT, d3
	mov3q.l #1, d2
	lsl.l	d3, d2
	; Сброс данных СОЗУ1
	jsr	_mcf_ram_init

_mcf_rom0_check:
	move.l	d1, d3
	andi.l	#CFG1_ROM0SZ_MASK, d3
	beq	_mcf_cache_check
	; Настройка доступа к ПЗУ0 по шине данных
	move.l	#__ROM0|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
	movec	d2, rombar0
	move.l	#__ROM0, a0
	; Получение размера ПЗУ0 из системных настроек d1
	move.l	#CFG1_ROM0SZ_SHIFT, d4
	lsl.l	d4, d3
	mov3q.l #1, d2
	lsl.l	d3, d2
	move.l	d2, a2
	; Сброс данных ПЗУ0
	jsr	_mcf_ram_init

_mcf_cache_check:
	;* Отключаем кэш CACR *
	move.l	#CACR_DCINVA|CACR_BEC|CACR_BCINVA|CACR_ICINVA, d2
	movec	d2, cacr

	;* Отключаем кэш ACRs *
	clr.l	d2
	movec	d2, acr0
	movec	d2, acr1
	movec	d2, acr2
	movec	d2, acr3

	; Начальная установка регистра периферии
	move.l	#__IMM|RAMBAR_V, d2
	movec	d2, mbar

	; Установка указателя на стек!
	move.l	#__SRAM0-4, d0
	add.l	(SRAM0_SIZE,a2), d0
	move.l	d0, sp

	jsr	_mcf_gpio_init
	jsr	_mcf_siu_debug_init
	jsr	_mcf_timer_init
	jsr	_mcf_fb_init
	jsr	_mcf_edge_init
	jsr	_mcf_usb_init
	jsr	_mcf_siu_ints_init

	;FPU
	clr.l	d2
	fmove.l d2, fpcr


	jsr	_main
	nop
loop:
	nop
	nop
	nop
	nop
	bra	loop

	halt


;*******************************************************************************
;* This routines changes the IPL to the value passed into the routine.	       *
;* It also returns the old IPL value back.				       *
;*******************************************************************************
_asm_set_ipl:
	;(sp) == 7 is disables interrupts
	;d0 = ipl
	link	a6, #-8 	;sp = sp - 8
	movem.l d6-d7, (sp)

	move.w	sr, d7		;сохранение sr

	move.l	d7, d1		;prepare return value
	andi.l	#$0700, d1	;mask out IPL
	lsr.l	#8, d1		;IPL

;	move.l	8(A6),D6	;get argument
	andi.l	#$07, d0	;least significant three bits
	lsl.l	#8,d0		;move over to make mask

	andi.l	#$0000F8FF, d7	;zero out current IPL
	or.l	d0,d7		;place new IPL in sr
	move.w	d7, sr

	movem.l (SP),D6-D7
	lea	8(SP),SP
	unlk	A6
	move.l	d1, d0
	rts

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*  Начальная установка MMU						       *
;*******************************************************************************
; d0, a0 - разрушены
_mcf_mmu_init:
	move.l	#__MMU+RAMBAR_V, d0
	movec	d0, mmubar
	mov3q.l #2, (MMUCR,a0)	;Virtmode off, tlb supervisor
	nop
	rts

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*  SRAM initialization to zero 					       *
;*******************************************************************************
_mcf_ram_init:
	;in
	;a2 - адрес блока СОЗУ0
	;d2 - размер блока СОЗУ0
	move.l	a2, d4		;сохраняем a2
	move.l	d2, d3		;сохраняем d2
	lsr.l	#2, d2		;настраиваем счётчик на счёт по двойным словам
.loop:
	clr.l	(a2)+		;очищаем двойное слово в СОЗУ0
	subq.l	#1, d2		;декрементируем значение счётчика
	bne.b	.loop
	move.l	d3, d2		;восстанавливаем d2
	move.l	d4, a2		;восстанавливаем a2
	rts

;******************************************************************************
;*  SIM - Debug 							      *
;******************************************************************************
_mcf_siu_debug_init:
	; вх:
	; a0 - указатель на mbar

	; Отключение останова системы по сигналу halt
	clr.l	d0
	move.l	d0, (SBCR,a0)

	; Очистка системных сигналов сброса
	move.l	#RSR_RSTJTG|RSR_RSTWD|RSR_RST, d0
	move.l	d0, (RSR,a0)

	rts

;*******************************************************************************
;*  SIM - Настройка контроллера прерываний				       *
;*******************************************************************************
_mcf_siu_ints_init:
;	move.w	sr, d1		;storing SR
;	move.l	d1, d0
;	ori.l	#$0700, d0	;mask out IPL
;	move.w	d0, sr

;	move.w	d1, sr		;restoring SR

	; сброс ожидания программных прерываний
	clr.l	d0
	move.l	d0, (INTFRCH,a0)
	move.l	d0, (INTFRCL,a0)

	; общее разрешение прерываний и маскирования прервыний по отдельности
	move.l	#$ffffffff, d0
	move.l	d0, (IMRH,a0)
	lsl.l	#1, d0
	move.l	d0, (IMRL,a0)

	move.w	sr, d0		;storing SR
	andi.l	#$fffff8ff, d0	    ;unmask IPL
	move.w	d0, sr

	rts

;*******************************************************************************
;*  Настройка контроллера таймеров общего назначения			       *
;*******************************************************************************
_mcf_timer_init:
	move.l	#GPT_GMS_ICT_RAISE|GPT_GMS_SC|GPT_GMS_IEN|GPT_GMS_TMS_DIS, d0
	move.l	d0, (GMS0,a0)	;disable timer0, set timer0 input mode
	move.l	d0, (GMS1,a0)	;disable timer1, set timer1 input mode
	move.l	d0, (GMS2,a0)	;disable timer2, set timer2 input mode
	move.l	d0, (GMS3,a0)	;disable timer3, set timer3 input mode

	move.l	  #(1<<GPT_GCIR_PRE_SHIFT), d0
	move.l	d0, (GCIR0,a0)	;Set prescaler0 to 1 and zerous counter
	move.l	d0, (GCIR1,a0)	;Set prescaler1 to 1 and zerous counter
	move.l	d0, (GCIR2,a0)	;Set prescaler2 to 1 and zerous counter
	move.l	d0, (GCIR3,a0)	;Set prescaler3 to 1 and zerous counter

	mov3q.l #1, d0
	move.b	d0, (ICR59,a0)	;setting level and priority of GPT0 to 0
	move.b	d0, (ICR60,a0)	;setting level and priority of GPT1 to 0
	move.b	d0, (ICR61,a0)	;setting level and priority of GPT2 to 0
	move.b	d0, (ICR62,a0)	;setting level and priority of GPT3 to 0

	rts

;*******************************************************************************
;* FlexBus - This routine initializes ChipSelects to setup peripherals	       *
;*******************************************************************************
_mcf_fb_init:
	move.l	#CSMR_WP|CSMR_V, d0
	move.l	d0, (CSMR0,a0)

	rts


;************************************************************
;*  GPIO						    *
;************************************************************
_mcf_gpio_init:
	;conf FPCIBG4 (TBST) pin as output
	move.b	#FPCIBG4, d0
	move.b	d0, (PDDR_PCIBG,a0)

	;conf FPCIBR4 (IRQ4) pin as output
	move.b	#FPCIBR4, d0
	move.b	d0, (PDDR_PCIBR,a0)

	;conf FPCIBR4 (IRQ4) pin as output
	move.b	#FPSC1PSC00|FPSC1PSC01|FPSC1PSC03, d0
	move.b	  d0, (PDDR_PSC1PSC0,a0)

	;Note that GPIO is obtained on the IRQ6 pin by (1) writing a 1
	;to PAR_IRQ6 and (2) disabling the IRQ6 function in the EPORT module
	move.b	#EPDDR_OUT4|EPDDR_OUT5|EPDDR_OUT6|EPDDR_OUT7, d0
	move.l	d0, (EPPDR,a0)

	rts


;*******************************************************************************
;* Edge 								       *
;*******************************************************************************
_mcf_edge_init:
	;rising edge triggered inter fopr 1-3 ports setting
	move.w	#EPPAR_EPPA1_RISE|EPPAR_EPPA2_RISE|EPPAR_EPPA3_RISE, d0
	move.w	d0, (EPPAR,a0)

	;1-3 ports interrupts enabled
	move.b	#EPIER_INT1|EPIER_INT2|EPIER_INT3, d0
	move.b	d0, (EPIER,a0)

	rts

;********************************************************************************
;*  USB 									*
;********************************************************************************
_mcf_usb_init:
	move.l	a0, a1
	add.l	#$b000, a1

	;Perform a hard reset or a USB reset (set USBCR[USBRST])
	mov3q.l #USBCR_RST, d0
	move.l	d0, (USBCR,a1)

	;Downloading USB descriptors to the descriptor RAM
;	move.l	#(((USB_DESC_LEN&DRAMCR_DSIZE_MASK)<<DRAMCR_DSIZE_SHIFT)|(USB_ADDR&DRAMCR_DADR_MASK), d0
	move.l	#(4&6<<4), d0
	move.l	d0, (DRAMCR,a1)
	move.l	(DRAMDR,a1), d0

	;Program the USB interrupt mask register (USBIMR) to enable interrupts
	;Unmask the RSTSTOP bit
	clr.l	d0
	move.l	d0, (USBIMR,a1)
;	move.b	d0, (USBAIMR,a1)

	;Program the FIFO sizes (EPnFRCFGR) and configure the FIFO RAM
	;according to the application needs (USBCR[RAMSPLIT] bit).
	move.l	#$200, d0
	move.l	d0, (EP0FRCFGR,a0)	;zero base and 512 byte size FIFO

	;Program the FIFO controller registers (EPnFCR, EPnFAR) for each
	;endpoint, program frame mode, shadow mode, granularity, alarm level,
	;frame size, etc. (EPnFCR). Normally, all endpoints should be
	;programmed with both frame mode and shadow mode enabled.
	move.l	#%1000000000000000000000000000, d0
	move.l	d0, (EP0FCR,a0)
	move.l	#%100, d0
	move.l	d0, (EP0FAR,a0) ;alarm at 4 bytes
	sub.l	#$b000, a0

	;Program each endpoint's control (EPnSTAT) and interrupt mask (EPnIMR)
	;registers to support the intended data transfer modes.
	move.b	#%11, d0
	move.b	d0, (EP0STAT,a0)	;flush and reset FIFO
	move.l	#%111110001, d0
	move.l	d0, (EP0IMR,a0) ;enable FIFO transfer complete

	;Wait for the RSTSTOP interrupt to indicate that reset signalling has
	;completed and the device is in the DEFAULT state.
.wait:
;	move.l	?, d0
;	and.l	#RSTSTOP, d0
;	beq	.wait

	;Program the type (EP0ACR) and maximum packet size (EP0MPSR) for
	;the default control endpoint.
	move.b	#0, d0
	move.b	d0, (EP0ACR,a0) ;set to interrupt control
	move.w	#%100000000, d0
	move.w	d0, (EP0MPSR,a0)       ;set 0 add transactions, packetsize = 512

	;Enable the default control endpoint (EP0OUTSR[ACTIVE]).
	move.b	#%00000000, d0
	move.b	d0, (EP1OUTSR,a0)	;set status: clr ints

	;Program the type (EPn[OUT/IN]ACR) and maximum packet size
	;(EPn[OUT/IN]MPSR) for each endpoint that will be used in addition
	;to the default control endpoint.
	move.b	#3, d0
	move.b	    d0, (EP1INACR,a0)
	move.b	d0, (EP1OUTACR,a0)
	move.w	d0, (EP1INMPSR,a0)     ;set 0 add transactions, packetsize = 512
	move.w	d0, (EP1OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512

	;Enable each endpoint (EPn[OUT/IN]SR[ACTIVE]) that will be used in
	;addition to the default control endpoint. Note that module
	;initialization is a time critical process. The USB host will wait
	;about 100 ms after power-on or a connection event to begin enumerating
	;devices on the bus. This device must have all of the configuration
	;information available when the host requests it.
	move.b	#%00000000, d0
	move.b	d0, (EP1INSR,a0)	;set status: clr ints
	move.b	d0, (EP1OUTSR,a0)	;set status: clr ints

	rts






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

