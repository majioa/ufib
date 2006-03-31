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
        lsl.l	d4, d3
	mov3q.l	#1, d2
        lsl.l   d3, d2
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
        lsl.l	#CFG1_SRAM1SZ_SHIFT, d3
	mov3q.l	#1, d2
        lsl.l   d3, d2
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
        lsl.l	d4, d3
	mov3q.l	#1, d2
        lsl.l   d3, d2
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

        jsr     _mcf_gpio_init
        jsr     _mcf_siu_debug_init
        jsr     _mcf_siu_ints_init
        jsr     _mcf_timer_init
        jsr     _mcf_fb_init
        jsr     _mcf_edge_init
        jsr     _mcf_usb_init

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
	lsr.l	#2, d2		;настраиваем счётчик на счёт по двойным словам
.loop:
        clr.l   (a2)+           ;очищаем двойное слово в СОЗУ0
        subq.l  #1, d2          ;декрементируем значение счётчика
        bne.b   .loop
	move.l	d3, d2		;восстанавливаем d2
	move.l	d4, a2		;восстанавливаем a2
        rts

;******************************************************************************
;*  SIM - Debug                                                               *
;******************************************************************************
_mcf_siu_debug_init:
        ; вх:
	; a0 - указатель на mbar

	; Отключение останова системы по сигналу halt
        clr.l   d0
        move.l  d0, (SBCR,a0)           

	; Очистка системных сигналов сброса
        move.l  #RSR_RSTJTG|RSR_RSTWD|RSR_RST, d0
        move.l  d0, (RSR,a0)            

        rts

;*******************************************************************************
;*  SIM - Настройка контроллера прерываний                                     *
;*******************************************************************************
_mcf_siu_ints_init:
;	move.w  sr, d1          ;storing SR
;	move.l  d1, d0
;	ori.l   #$0700, d0      ;mask out IPL
;	move.w  d0, sr
	
;	move.w  d1, sr          ;restoring SR
	
	; сброс ожидания программных прерываний
	clr.l   d0
	move.l  d0, (INTFRCH,a0)
	move.l  d0, (INTFRCL,a0)

	; общее разрешение прерываний и маскирования прервыний по отдельности
        move.l  #$ffffffff, d0
        move.l  d0, (IMRH,a0)   
        lsl.l   #1, d0
        move.l  d0, (IMRL,a0)

	move.w  sr, d0          ;storing SR
	andi.l	#$fffff8ff, d0      ;unmask IPL
	move.w  d0, sr
 
        rts

;*******************************************************************************
;*  Настройка контроллера таймеров общего назначения                           *
;*******************************************************************************
_mcf_timer_init:
	move.l  #GPT_GMS_ICT_RAISE|GPT_GMS_SC|GPT_GMS_IEN|GPT_GMS_TMS_DIS, d0
	move.l  d0, (GMS0,a0)   ;disable timer0, set timer0 input mode
	move.l  d0, (GMS1,a0)   ;disable timer1, set timer1 input mode
	move.l  d0, (GMS2,a0)   ;disable timer2, set timer2 input mode
	move.l  d0, (GMS3,a0)   ;disable timer3, set timer3 input mode

	move.l	#(1 << GPT_GCIR_PRE_SHIFT), d0
	move.l  d0, (GCIR0,a0)  ;Set prescaler0 to 1 and zerous counter
	move.l  d0, (GCIR1,a0)  ;Set prescaler1 to 1 and zerous counter
	move.l  d0, (GCIR2,a0)  ;Set prescaler2 to 1 and zerous counter
	move.l  d0, (GCIR3,a0)  ;Set prescaler3 to 1 and zerous counter

	mov3q.l	#1, d0
	move.b  d0, (ICR59,a0)  ;setting level and priority of GPT0 to 0
	move.b  d0, (ICR60,a0)  ;setting level and priority of GPT1 to 0
	move.b  d0, (ICR61,a0)  ;setting level and priority of GPT2 to 0
	move.b  d0, (ICR62,a0)  ;setting level and priority of GPT3 to 0

	rts

;*******************************************************************************
;* FlexBus - This routine initializes ChipSelects to setup peripherals         *
;*******************************************************************************
_mcf_fb_init:
	move.l  #CSMR_WP|CSMR_V, d0
        move.l  d0, (CSMR0,a0)

        rts


;************************************************************
;*  GPIO                                                    *
;************************************************************
_mcf_gpio_init:
	;conf FPCIBG4 (TBST) pin as output
	move.b  #FPCIBG4, d0
	move.b  d0, (PDDR_PCIBG,a0)

	;conf FPCIBR4 (IRQ4) pin as output
	move.b  #FPCIBR4, d0
	move.b  d0, (PDDR_PCIBR,a0)

	;conf FPCIBR4 (IRQ4) pin as output
	move.b  #FPSC1PSC00|FPSC1PSC01|FPSC1PSC03, d0
	move.b  d0, (PDDR_PSC1PSC0,a0)

	;Note that GPIO is obtained on the IRQ6 pin by (1) writing a 1
	;to PAR_IRQ6 and (2) disabling the IRQ6 function in the EPORT module
	move.b  #EPDDR_OUT4|EPDDR_OUT5|EPDDR_OUT6|EPDDR_OUT7, d0
	move.l  d0, (EPPDR,a0)

        rts


;*******************************************************************************
;* Edge                                                                        *
;*******************************************************************************
_mcf_edge_init:
	;rising edge triggered inter fopr 1-3 ports setting
        move.w  #EPPAR_EPPA1_RISE|EPPAR_EPPA2_RISE|EPPAR_EPPA3_RISE, d0
        move.w  d0, (EPPAR,a0)

	;1-3 ports interrupts enabled
        move.b  #EPIER_INT1|EPIER_INT2|EPIER_INT3, d0
        move.b  d0, (EPIER,a0)

	rts

;********************************************************************************
;*  USB                                                                         *
;********************************************************************************
_mcf_usb_init:
	lea.l	(#$b000,a0), a1

	;Perform a hard reset or a USB reset (set USBCR[USBRST])
	mov3q.l	#USBCR_RST, d0
        move.l  d0, (USBCR,a1)
	
	;Downloading USB descriptors to the descriptor RAM
	move.l	#(((USB_DESC_LEN & DRAMCR_DSIZE_MASK) << DRAMCR_DSIZE_SHIFT)| \
		(USB_ADDR & DRAMCR_DADR_MASK), d0
	move.l	d0, (DRAMCR,a1)
	move.l	(DRAMDR,a1), d0

	;Program the USB interrupt mask register (USBIMR) to enable interrupts
	;Unmask the RSTSTOP bit
	clr.l	d0
	move.l  d0, (USBIMR,a1)
;	move.b  d0, (USBAIMR,a1)

	;Program the FIFO sizes (EPnFRCFGR) and configure the FIFO RAM
	;according to the application needs (USBCR[RAMSPLIT] bit).
        move.l  #$200, d0
        move.l  d0, (EP0FRCFGR,a0)      ;zero base and 512 byte size FIFO
	
	;Program the FIFO controller registers (EPnFCR, EPnFAR) for each 
	;endpoint, program frame mode, shadow mode, granularity, alarm level,
	;frame size, etc. (EPnFCR). Normally, all endpoints should be 
	;programmed with both frame mode and shadow mode enabled.
        move.l  #%1000000000000000000000000000, d0
        move.l  d0, (EP0FCR,a0)
        move.l  #%100, d0
        move.l  d0, (EP0FAR,a0) ;alarm at 4 bytes
        sub.l   #$b000, a0

	;Program each endpoint's control (EPnSTAT) and interrupt mask (EPnIMR) 
	;registers to support the intended data transfer modes.
        move.b  #%11, d0
        move.b  d0, (EP0STAT,a0)        ;flush and reset FIFO
        move.l  #%111110001, d0
        move.l  d0, (EP0IMR,a0) ;enable FIFO transfer complete

	;Wait for the RSTSTOP interrupt to indicate that reset signalling has 
	;completed and the device is in the DEFAULT state.
.wait:
	move.l	?, d0
	and.l	#RSTSTOP, d0
	beq	.wait

	;Program the type (EP0ACR) and maximum packet size (EP0MPSR) for 
	;the default control endpoint.
        move.b  #0, d0
        move.b  d0, (EP0ACR,a0) ;set to interrupt control
        move.w  #%100000000, d0
        move.w  d0, (EP0MPSR,a0)       ;set 0 add transactions, packetsize = 512

	;Enable the default control endpoint (EP0OUTSR[ACTIVE]).
        move.b  #%00000000, d0
        move.b  d0, (EP1OUTSR,a0)       ;set status: clr ints

	;Program the type (EPn[OUT/IN]ACR) and maximum packet size 
	;(EPn[OUT/IN]MPSR) for each endpoint that will be used in addition
	;to the default control endpoint.
        move.b  #3, d0
        move.b  d0, (EP1INACR,a0)
        move.b  d0, (EP1OUTACR,a0)
        move.w  d0, (EP1INMPSR,a0)     ;set 0 add transactions, packetsize = 512
        move.w  d0, (EP1OUTMPSR,a0)    ;set 0 add transactions, packetsize = 512

	;Enable each endpoint (EPn[OUT/IN]SR[ACTIVE]) that will be used in 
	;addition to the default control endpoint. Note that module 
	;initialization is a time critical process. The USB host will wait 
	;about 100 ms after power-on or a connection event to begin enumerating
	;devices on the bus. This device must have all of the configuration 
	;information available when the host requests it.
        move.b  #%00000000, d0
        move.b  d0, (EP1INSR,a0)        ;set status: clr ints
        move.b  d0, (EP1OUTSR,a0)       ;set status: clr ints

        rts


        boundary


