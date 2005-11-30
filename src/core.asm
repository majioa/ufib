; File
;  core.asm
; Purpose:     MCF548x core file
        include defines.inc


__IMM           equ     $10000000
__MMU           equ     $00040000
__MMU_SIZE      equ     65536           //64K
__ROM0          equ     $00050000
__ROM1          equ     $00060000
__SRAM0         equ     $00070000
__SRAM1         equ     $00080000
__SDRAM         equ     $00000000
__SDRAM_SIZE    equ     $00800000       //8M
__EXT_SRAM      equ     $FE400000
__EXT_SRAM_SIZE equ     131073          //128K

__HEAP_START    equ     $400
__HEAP_END      equ     256*1024+__HEAP_START
__SP_END        equ     __HEAP_END
__SP_INIT       equ     8*8+__SP_END

SRAM0_SIZE      equ     $0


        xref    _VECTOR_TABLE
        xdef    start
        xref    _main
        xdef    __SRAM0


	;вх
	;d0 - настройки процессора
	;d1 - настройки паняти
start:
        ; Задание регистра таблицы векторов VBR
        move.l  #_VECTOR_TABLE, d2
        movec   d2, vbr

        ; Начальная установка MMU
        jsr     _mcf_mmu_init


        move.l  d1, d3
        andi.l  #CFG1_SRAM0SZ_MASK, d3
	beq	_mcf_ram1_check
	; Настройка досбупа к СОЗУ0 по шине данных
        move.l  #__SRAM0|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
        movec   d2, rambar0
        move.l  #__SRAM0, a2
	; Получение размера СОЗУ0 из системных настроек d1
        move.l	#CFG1_SRAM0SZ_SHIFT, d4
        asl.l	d4, d3
	mov3q.l	#1, d2
        asl.l   d3, d2
        ; Сброс данных СОЗУ0
        jsr     _mcf_ram_init
	move.l	d2, (SRAM0_SIZE,a2)

_mcf_ram1_check:
        move.l  d1, d3
        andi.l  #CFG1_SRAM1SZ_MASK, d3
	beq	_mcf_rom0_check
	; Настройка досбупа к СОЗУ1 по шине данных
        move.l  #__SRAM1|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
        movec   d2, rambar1
        move.l  #__SRAM1, a0
	; Получение размера СОЗУ1 из системных настроек d1
        asl.l	#CFG1_SRAM1SZ_SHIFT, d3
	mov3q.l	#1, d2
        asl.l   d3, d2
        ; Сброс данных СОЗУ1
        jsr     _mcf_ram_init

_mcf_rom0_check:
        move.l  d1, d3
        andi.l  #CFG1_ROM0SZ_MASK, d3
	beq	_mcf_cache_check
	; Настройка доступа к ПЗУ0 по шине данных
        move.l  #__ROM0|RAMBAR_AS_CPU|RAMBAR_AS_SC|RAMBAR_AS_UC|RAMBAR_V, d2
        movec   d2, rombar0
        move.l  #__ROM0, a0
	; Получение размера ПЗУ0 из системных настроек d1
        move.l	#CFG1_ROM0SZ_SHIFT, d4
        asl.l	d4, d3
	mov3q.l	#1, d2
        asl.l   d3, d2
	move.l	d2, a2
        ; Сброс данных ПЗУ0
        jsr     _mcf_ram_init

_mcf_cache_check:
        ;* Отключаем кэш CACR *
	move.l  #CACR_DCINVA|CACR_BEC|CACR_BCINVA|CACR_ICINVA, d2
        movec   d2, cacr

        ;* Отключаем кэш ACRs *
        clr.l  	d2
        movec   d2, acr0
        movec   d2, acr1
        movec   d2, acr2
        movec   d2, acr3

	; Начальная установка регистра периферии
        move.l  #__IMM|RAMBAR_V, d2
        movec   d2, mbar

	; Установка указателя на стек!
	move.l  #__SRAM0-4, d0
	add.l	(SRAM0_SIZE,a2), d0
	move.l  d0, sp

        jsr     _mcf_siu_debug_init
        jsr     _mcf_gpio_init
        jsr     _mcf_timer_init
        jsr     _mcf_fb_init
        jsr     _mcf_edge_init
        jsr     _mcf_usb_init
        jsr     _mcf_siu_ints_init

	;FPU
	clr.l	d2
	fmove.l	d2, fpcr

        jsr     _mcf_ipl_init

        jsr     _main
        nop
loop:
        nop
        nop
        nop
        nop
        bra     loop

        halt


;*******************************************************************************
;* This routines changes the IPL to the value passed into the routine.         *
;* It also returns the old IPL value back.                                     *
;*******************************************************************************
_asm_set_ipl:
        ;(sp) == 7 is disables interrupts
        ;d0 = ipl
        link    a6, #-8         ;sp = sp - 8
        movem.l d6-d7, (sp)

        move.w  sr, d7          ;сохранение sr

        move.l  d7, d1          ;prepare return value
        andi.l  #$0700, d1      ;mask out IPL
        lsr.l   #8, d1          ;IPL

;       move.l  8(A6),D6        ;get argument
        andi.l  #$07, d0        ;least significant three bits
        lsl.l   #8,d0           ;move over to make mask

        andi.l  #$0000F8FF, d7  ;zero out current IPL
        or.l    d0,d7           ;place new IPL in sr
        move.w  d7, sr

        movem.l (SP),D6-D7
        lea     8(SP),SP
        unlk    A6
        move.l  d1, d0
        rts

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*  Начальная установка MMU 						       *
;*******************************************************************************
; d0, a0 - разрушены
_mcf_mmu_init:
        move.l  #__MMU+RAMBAR_V, d0
        movec   d0, mmubar
        mov3q.l #2, (MMUCR,a0)  ;Virtmode off, tlb supervisor
        nop
        rts

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
;*  SRAM initialization to zero                                		       *
;*******************************************************************************
_mcf_ram_init:
        ;in
        ;a2 - адрес блока СОЗУ0
	;d2 - размер блока СОЗУ0
	move.l	a2, d4		;сохраняем a2
	move.l	d2, d3		;сохраняем d2
	asr.l	#2, d2		;настраиваем счётчик на счёт по двойным словам
.loop:
        clr.l   (a2)+           ;очищаем двойное слово в СОЗУ0
        subq.l  #1, d2          ;декрементируем значение счётчика
        bne.b   .loop
	move.l	d3, d2		;восстанавливаем d2
	move.l	d4, a2		;восстанавливаем a2
        rts

;******************************************************************************
;******************************************************************************
;******************************************************************************
;******************************************************************************
;*  SIM - Debug                                                               *
;******************************************************************************
_mcf_siu_debug_init:
        ;*in: a0 - pointer to imm*
        clr.l   d0
        move.l  d0, (SBCR,a0)           ;Disable breakpoint
        move.l  d0, (SECSACR,a0)        ;Disable the SEC Sequential Access
        move.l  #$b, d0
        move.l  d0, (RSR,a0)            ;Clear system Reset signals
        rts

;******************************************************************************
;*  SIM - Interrupts                                                          *
;******************************************************************************
_mcf_siu_ints_init:
        move.w  SR, d1          ;storing SR
        move.l  d1, d0
        ori.l   #$0700,d0       ;mask out IPL
        move.w  d0, SR
        move.l  #$ffffffff, d0
        move.l  d0, (IMRH,a0)   ;GPT enabling ints
        lsl.l   #1, d0
        move.l  d0, (IMRL,a0)   ;enabling IRQ1-3 ints
        move.w  d1, SR          ;restoring SR
        clr.l   d0
        move.l  d0, (INTFRCH,a0)
        move.l  d0, (INTFRCL,a0)
        rts

;************************************************************************
;*  Timers                                                              *
;************************************************************************
_mcf_timer_init:
        move.l  #TIMER_GMS_ICT_RAISE|TIMER_GMS_COUNT_ENABLED|TIMER_GMS_CONT_OPER|TIMER_GMS_INT_ENABLED|TIMER_GMS_TMS_DISABLED, d0
;       move.l  #$a84000, d0
        move.l  d0, (GMS0,a0)   ;disable timer0, set timer0 input mode
        move.l  d0, (GMS1,a0)   ;disable timer1, set timer1 input mode
        move.l  d0, (GMS2,a0)   ;disable timer2, set timer2 input mode
        move.l  d0, (GMS3,a0)  ;disable timer3, set timer3 input mode
        move.l  #1, d0
        move.l  d0, (GCIR0,a0)  ;Set prescaler0 to 1 and zerous counter
        move.l  d0, (GCIR1,a0)  ;Set prescaler1 to 1 and zerous counter
        move.l  d0, (GCIR2,a0)  ;Set prescaler2 to 1 and zerous counter
        move.l  d0, (GCIR3,a0)  ;Set prescaler3 to 1 and zerous counter
        clr.l   d0
        move.l  d0, (GPWM0,a0)  ;Setoff PWM0 output val
        move.l  d0, (GPWM1,a0)  ;Setoff PWM1 output val
        move.l  d0, (GPWM2,a0)  ;Setoff PWM2 output val
        move.l  d0, (GPWM3,a0)  ;Setoff PWM3 output val
        move.b  d0, (ICR59,a0)  ;setting level and priority of GPT0 to 0
        move.b  d0, (ICR60,a0)  ;setting level and priority of GPT1 to 0
        move.b  d0, (ICR61,a0)  ;setting level and priority of GPT2 to 0
        move.b  d0, (ICR62,a0)  ;setting level and priority of GPT3 to 0

        rts

;TIMER_GMS_ICT_FALL

;TIMER_GMS_TMS_IN

;********************************************************************************
;*  FlexBus - This routine initializes ChipSelects to setup peripherals         *
;********************************************************************************
_mcf_fb_init:
        clr.l   d0
        move.l  d0, (CSAR0,a0)
        move.l  d0, (CSAR1,a0)
        move.l  d0, (CSMR1,a0)  ;disable CS1
        move.l  d0, (CSCR1,a0)
        move.l  d0, (CSAR2,a0)
        move.l  d0, (CSMR2,a0)  ;disable CS2
        move.l  d0, (CSCR2,a0)
        move.l  d0, (CSAR3,a0)
        move.l  d0, (CSMR3,a0)  ;disable CS3
        move.l  d0, (CSCR3,a0)
        move.l  d0, (CSAR4,a0)
        move.l  d0, (CSMR4,a0)  ;disable CS4
        move.l  d0, (CSCR4,a0)
        move.l  d0, (CSAR5,a0)
        move.l  d0, (CSMR5,a0)  ;disable CS5
        move.l  d0, (CSCR5,a0)
        move.l  #%100000001, d0
        move.l  d0, (CSMR0,a0)
        move.l  #%11111100101111111111110101000000, d0
        move.l  d0, (CSCR0,a0)  ;AA=1, SWS=63, WS=63, port 8 bits


        rts


;************************************************************
;*  GPIO                                                    *
;************************************************************
_mcf_gpio_init:

        move.b  #%11111111, d0
        move.b  d0, (PDDR_FBCTL,a0)     ;conf all pins as output
        move.b  d0, (PDDR_FEC0H,a0)
        move.b  d0, (PDDR_FEC0L,a0)
        move.b  d0, (PDDR_FEC1H,a0)
        move.b  d0, (PDDR_FEC1L,a0)
        move.b  d0, (PDDR_PSC3PSC2,a0)
        move.b  d0, (PDDR_PSC1PSC0,a0)
        lsr     #1, d0
        move.b  d0, (PDDR_DSPI,a0)      ;conf all pins as output
        move.b  #%00111110, d0
        move.b  d0, (PDDR_FBCS,a0)      ;conf all pins as output
        lsr     #1, d0
        move.b  d0, (PDDR_PCIBG,a0)
        move.b  d0, (PDDR_PCIBR,a0)
        lsr     #1, d0
        move.b  d0, (PDDR_DMA,a0)       ;conf all pins as output
        move.b  d0, (PAR_DMA,a0)        ;conf all pins as GPIO
        clr.w   d0
        move.b  d0, (PAR_PSC3,a0)       ;conf all pins as GPIO
        move.b  d0, (PAR_PSC2,a0)       ;conf all pins as GPIO
        move.b  d0, (PAR_PSC1,a0)       ;conf all pins as GPIO
        move.b  d0, (PAR_PSC0,a0)       ;conf all pins as GPIO
        move.w  d0, (PAR_DSPI,a0)       ;conf all pins as GPIO
        move.w  d0, (PAR_FBCTL,a0)      ;conf all pins as GPIO
        move.b  d0, (PAR_FBCS,a0)       ;conf all pins as GPIO
        move.b  #4, d0
        move.b  d0, (PAR_DMA,a0)        ;set IRC1, all other pins as GPIO
        move.w  #%11, d0
        move.w  d0, (PAR_FECI2CIRQ,a0)  ;set IRC5,6, all other pins as GPIO
        move.w  #%0, d0
        move.w  d0, (PAR_PCIBG,a0)      ;conf all pins as GPIO
        move.w  #%1010101010, d0
        move.w  d0, (PAR_PCIBR,a0)      ;set IRC4, TIMERs 0-3, all other pins as GPIO
        move.b  #100100, d0
        move.b  d0, (PAR_TIMER,a0)      ;set IRC2,3
        rts


;********************************************************************************
;*  Edge                                                                        *
;********************************************************************************
_mcf_edge_init:
        move.w  #%0101010101010100, d0
        move.w  d0, (EPPAR,a0);rising edge triggered inter
        move.b  #%11111000, d0
        move.b  d0, (EPDDR,a0)  ;configure 1-2 ports as input, 3-7 as output
        move.b  #%11111000, d0
        move.b  d0, (EPIER,a0)  ;1-2 ports interrupts enbled, 3-7 disabled
;       move.b  #%11111111, d0
;       move.b  d0, EPDR        ;ports data output
;       move.b  #%11111111, d0
;       move.b  d0, EPFR        ;clearing edge triggered bits
        rts

;********************************************************************************
;*  USB                                                                         *
;********************************************************************************
_mcf_usb_init:
        add.l   #$b000, a0
        move.l  #%101101, d0
        move.l  d0, (USBCR,a0)  ;set priority to performance, device RAM access
        move.l  #%11111111, d0
        move.l  d0, (USBIMR,a0) ;masking of all USB interrupts
;       move.b  #%11111111, d0
        move.b  d0, (USBAIMR,a0)        ;masking of all app USB interrupts
;       move.b  #%11111111, d0
        move.b  d0, (CFGR,a0)   ;??
        move.b  #%11100000, d0
        move.b  d0, (CFGAR,a0)  ;1v100000, v - remote wakeup enabled
        move.b  #%10, d0
        move.b  d0, (SPEEDR,a0) ;10 - full speed enabled
        move.b  #0, d0
        move.b  d0, (EPTNR,a0)  ;1 transaction for all endpoints
        move.w  #0, d0
        move.w  d0, (IFR0,a0)   ;confreg0
        move.w  #%11111100000000, d0
        move.w  d0, (IFR0,a0)   ;confreg31
        move.w  #0, d0
        move.w  d0, (IFR0,a0)   ;disable overflow

        move.b  #0, d0
        move.b  d0, (EP0ACR,a0) ;set to interrupt control
        move.b  #3, d0
        move.b  d0, (EP1INACR,a0)
        move.b  d0, (EP1OUTACR,a0)
        move.b  d0, (EP2INACR,a0)
        move.b  d0, (EP2OUTACR,a0)
        move.b  d0, (EP3INACR,a0)
        move.b  d0, (EP3OUTACR,a0)
        move.b  d0, (EP4INACR,a0)
        move.b  d0, (EP4OUTACR,a0)
        move.b  d0, (EP5INACR,a0)
        move.b  d0, (EP5OUTACR,a0)
        move.b  d0, (EP6INACR,a0)
        move.b  d0, (EP6OUTACR,a0)
        move.w  #%100000000, d0
        move.w  d0, (EP0MPSR,a0)       ;set 0 add transactions, packetsize = 512
;       move.w  #0, d0
        move.w  d0, (EP1INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP1OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP2INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP2OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP3INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP3OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP4INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP4OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP5INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP5OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP6INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP6OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512
        move.b  #%00000010, d0
        move.b  d0, (EP0SR,a0)  ;set status: clr ints, active
        move.b  #%00000000, d0
        move.b  d0, (EP1INSR,a0)        ;set status: clr ints
        move.b  d0, (EP1OUTSR,a0)       ;set status: clr ints
        move.b  d0, (EP2INSR,a0)        ;set status: clr ints
        move.b  d0, (EP2OUTSR,a0)       ;set status: clr ints
        move.b  d0, (EP3INSR,a0)        ;set status: clr ints
        move.b  d0, (EP3OUTSR,a0)       ;set status: clr ints
        move.b  d0, (EP4INSR,a0)        ;set status: clr ints
        move.b  d0, (EP4OUTSR,a0)       ;set status: clr ints
        move.b  d0, (EP5INSR,a0)        ;set status: clr ints
        move.b  d0, (EP5OUTSR,a0)       ;set status: clr ints
        move.b  d0, (EP6INSR,a0);set status: clr ints
        move.b  d0, (EP6OUTSR,a0)       ;set status: clr ints
        move.b  #%10000000, d0
        move.b  d0, (BMRTR,a0)  ;dir: device to host, type: std, rec: device
        ;SETUP transaction
        move.b  #0, d0
        move.b  d0, (BRTR,a0)
        move.b  d0, (WVALUER,a0)
        move.b  d0, (WINDEXR,a0)
        move.b  d0, (WLENGTHR,a0)
        move.b  #%11, d0
        move.b  d0, (EP0STAT,a0)        ;flush and reset FIFO
        move.l  #%111110001, d0
        move.l  d0, (EP0IMR,a0) ;enable FIFO transfer complete
;       move.l  EP0IR, d0
        move.l  #$200, d0
        move.l  d0, (EP0FRCFGR,a0)      ;zero base and 512 byte size FIFO
        move.l  #%1000000000000000000000000000, d0
        move.l  d0, (EP0FCR,a0)
        move.l  #%100, d0
        move.l  d0, (EP0FAR,a0) ;alarm at 4 bytes
        sub.l   #$b000, a0

        rts


        boundary


