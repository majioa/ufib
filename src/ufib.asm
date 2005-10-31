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

;sections sizes and addresses definition
__HEAP_START	equ	$0
__HEAP_SIZE	equ	$40000
__SP_START	equ	__HEAP_START+__HEAP_SIZE
__SP_SIZE	equ	$1000
__SP_INIT	equ	__SP_START+__SP_SIZE


;****************************UFIB on MCF5485*****************
WORD_SIZE	equ	2
//PIXEL_IGNORE	equ	55?
PIXEL_COUNT	equ	2
PIXEL_SIZE	equ	WORD_SIZE
ROW_IGNORE	equ	3
ROW_COUNT	equ	298
ROW_SIZE	equ	PIXEL_COUNT*PIXEL_SIZE
CAM_COUNT	equ	4
CAM_SIZE	equ	ROW_COUNT*ROW_SIZE
FRAME_SIZE	equ	CAM_COUNT*CAM_SIZE


USB_FRAME_SIZE	equ	512

INTL_FRAME	equ	INTL_EP1
INTL_ROW	equ	INTL_EP2
INTL_BUTTON	equ	INTL_EP7
IRQ_FRAME	equ	IRQ_EP1
IRQ_ROW		equ	IRQ_EP2
IRQ_BUTTON	equ	IRQ_EP7


MODE_ALTER_BUFFER	equ	0
BUFFER_ALTERED		equ	0

; sram variables addresses definition
	section bss,4,D

	long	sram0_size
;	long	cam_addr
	long	mode
;	long
;	long
;	long
;	long	frame_pointers
	long	status
	long	cam0
	long	cam1
	long	cam2
	long	cam3
	long	main_bank
	long	alter_bank
;	long	frame_size
	long	free_buffer


	section data,4,D
usb_desc_len	dc.b	0
usb_addr	dc.b	0
data_channels	dc.l	INTH_GPT0|INTH_GPT1|INTH_GPT2|INTH_GPT3


	section code,16,C

_VECTOR_TABLE:
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
vector065 dc.l exception_handler_irq1
vector066 dc.l exception_handler_irq2
vector067 dc.l asm_exception_handler
vector068 dc.l asm_exception_handler
vector069 dc.l asm_exception_handler
vector070 dc.l asm_exception_handler
vector071 dc.l exception_handler_irq7
vector072 dc.l asm_exception_handler
vector073 dc.l asm_exception_handler
vector074 dc.l asm_exception_handler
vector075 dc.l asm_exception_handler
vector076 dc.l asm_exception_handler
vector077 dc.l asm_exception_handler
vector078 dc.l asm_exception_handler
vector079 dc.l exception_handler_usb_ep0
vector080 dc.l asm_exception_handler
vector081 dc.l asm_exception_handler
vector082 dc.l asm_exception_handler
vector083 dc.l asm_exception_handler
vector084 dc.l asm_exception_handler
vector085 dc.l asm_exception_handler
vector086 dc.l exception_handler_usb_general
vector087 dc.l exception_handler_usb_core
vector088 dc.l exception_handler_usb_all
vector089 dc.l asm_exception_handler
vector090 dc.l asm_exception_handler
vector091 dc.l asm_exception_handler
vector092 dc.l asm_exception_handler
vector093 dc.l asm_exception_handler
vector094 dc.l asm_exception_handler
vector095 dc.l asm_exception_handler
vector096 dc.l asm_exception_handler
vector097 dc.l asm_exception_handler
vector098 dc.l asm_exception_handler
vector099 dc.l asm_exception_handler
vector100 dc.l asm_exception_handler
vector101 dc.l asm_exception_handler
vector102 dc.l asm_exception_handler
vector103 dc.l asm_exception_handler
vector104 dc.l asm_exception_handler
vector105 dc.l asm_exception_handler
vector106 dc.l asm_exception_handler
vector107 dc.l asm_exception_handler
vector108 dc.l asm_exception_handler
vector109 dc.l asm_exception_handler
vector110 dc.l asm_exception_handler
vector111 dc.l asm_exception_handler
vector112 dc.l asm_exception_handler
vector113 dc.l asm_exception_handler
vector114 dc.l asm_exception_handler
vector115 dc.l asm_exception_handler
vector116 dc.l asm_exception_handler
vector117 dc.l exception_handler_slt1
vector118 dc.l exception_handler_slt0
vector119 dc.l asm_exception_handler
vector120 dc.l asm_exception_handler
vector121 dc.l asm_exception_handler
vector122 dc.l asm_exception_handler
vector123 dc.l exception_handler_gpt3
vector124 dc.l exception_handler_gpt2
vector125 dc.l exception_handler_gpt1
vector126 dc.l exception_handler_gpt0
vector127 dc.l asm_exception_handler
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

;*******************************************************************************
; Обработка запросов прерываний сигнала кадра		    		       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
;a1 - указатель на область памяти
;a3-a6 - указатели на области памяти данных полученных от камер
exception_handler_irq1:
	; очистка запрса прерывания сигнала кадра
	bclr.b	#INTL_FRAME%8, (IPRL+INTL_FRAME/8,a0)
	; проверка сигнала активности кадра (0 = активный)
	btst.b	#IRQ_FRAME%8, (EPPDR+IRQ_FRAME/8,a0)
	beq.b	.frame_enable_row
	; отключение прерываний строки
	bset.b	#INTL_ROW%8, (IMRL+INTL_ROW/8,a0)
	; смена активного буфера путём инвертирования бита режима
	btst.b	#MODE_ALTER_BUFFER, (mode,a1)
	bne.b	.save_alternate_buffers
	move.l	(main_bank,a1), a3
	bset.b	#BUFFER_ALTERED, (status,a1)
	bra.b	.exit
.save_alternate_buffers:
	move.l	(alter_bank,a1), a3
	bclr.b	#BUFFER_ALTERED, (status,a1)
.exit:
	lea.l	(CAM_SIZE,a3), a4
	lea.l	(CAM_SIZE,a4), a5
	lea.l	(CAM_SIZE,a5), a6
	rte
.frame_enable_row:
	; очистка запроса от irq2 и разрешение прерываний от этого источника
	bclr.b	#INTL_ROW%8, (IPRL+INTL_ROW/8,a0)
	bclr.b	#INTL_ROW%8, (IMRL+INTL_ROW/8,a0)
	rte
;*******************************************************************************
; Обработка запросов прерываний сигнала строки				       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
exception_handler_irq2:
	; очистка запрса прерывания сигнала строки
	bclr.b	#IRQ_ROW%8, (EPFR+IRQ_ROW/8,a0)
	; сброс настройки режима срабатывыания таймеров
	move.l	#~GMS_ICT_MASK, d0
	and.l	d0, (GMS3,a0)
	and.l	d0, (GMS2,a0)
	and.l	d0, (GMS1,a0)
	and.l	d0, (GMS0,a0)
	; проверка сигнала активности строки (0 = активный)
	btst.b	#IRQ_ROW%8, (EPPDR+IRQ_ROW/8,a0)
	beq.b	.enable_slt0
	; загрузка доступных камер
	move.l	(data_channels), d0
	; отключение таймеров общего назначения
	or.l	d0, (IMRH,a0)
	rte
.enable_slt0:
	; запуск slt0
	bset.b	#SCR_RUN, (SCR0,a0)
	; разрешение прерываний от slt0
	bclr.b	#INTH_SLT0%8, (IMRH+INTH_SLT0/8,a0)
	; настройка прерываний от таймеров по фронту
	move.l	#GMS_ICT_RAISE, d0
	or.l	d0, (GMS3,a0)
	or.l	d0, (GMS2,a0)
	or.l	d0, (GMS1,a0)
	or.l	d0, (GMS0,a0)
	; установ индекса камер
	move.l	#(WORD_SIZE<<1|WORD_SIZE<<9|WORD_SIZE<<17|WORD_SIZE<<25), d0
	move.l	d0, (cam0,a1)
	rte
;*******************************************************************************
; Обработка запросов прерываний сигнала кнопки		    		       *
;*******************************************************************************
;a0 - указатель на устройства
exception_handler_irq7:
	; разрешение приёма прерываний кнопки
	bclr.b	#INTL_FRAME%8, (IPRL+INTL_FRAME/8,a0)
	bclr.b	#INTL_FRAME%8, (IMRL+INTL_FRAME/8,a0)
	wddata	$a5
asm_exception_handler:
	rte
;*******************************************************************************
; Обработка запросов прерываний данных камеры 4		    		       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
;a6 - указатель на область памяти данных от камеры 4
exception_handler_gpt3:
	; если камера выключена выходим
	clr.b	d0
	cmp.b	(cam3,a1), d0
	beq.b	.exit
	; считывание значения счётчика таймера 3 и сохранение его в память 
	move.w	(GSR3,a0), d0
	move.w	d0, (a6)+
	; декремент индекса камеры 3
	subq.l	#WORD_SIZE, (cam3,a1)
	; настройка прерываний от таймера 3 по спаду
	move.l	(GMS3,a0), d0
	and.l	#~GMS_ICT_MASK, d0
	or.l	#GMS_ICT_FALL, d0
	move.l	d0, (GMS3,a0)
.exit:
	; очистка ожидания запроса на прерывание от таймера 3
	bclr.b	#INTH_GPT3%8, (IPRH+INTH_GPT3/8,a0)
	; очистка бита срабатывания таймера 3
	bset.b	#GSR_CAPT%8, (GSR3+GSR_CAPT/8,a0)
	rte
;*******************************************************************************
; Обработка запросов прерываний данных камеры 3		    		       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
;a5 - указатель на область памяти данных от камеры 3
exception_handler_gpt2:
	clr.b	d0
	cmp.b	(cam2,a1), d0
	beq.b	.exit
	; считывание значения счётчика таймера 2 и сохранение его в память 
	move.w	(GSR2,a0), d0
	move.w	d0, (a5)+
	; декремент индекса камеры 2
	subq.l	#WORD_SIZE, (cam2,a1)
	; настройка прерываний от таймера 2 по спаду
	move.l	(GMS2,a0), d0
	and.l	#~GMS_ICT_MASK, d0
	or.l	#GMS_ICT_FALL, d0
	move.l	d0, (GMS2,a0)
.exit:
	; очистка ожидания запроса на прерывание от таймера 2
	bclr.b	#INTH_GPT2%8, (IPRH+INTH_GPT2/8,a0)
	; очистка бита срабатывания таймера 2
	bset.b	#GSR_CAPT%8, (GSR2+GSR_CAPT/8,a0)
	rte
;*******************************************************************************
; Обработка запросов прерываний данных камеры 2		    		       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
;a4 - указатель на область памяти данных от камеры 2
exception_handler_gpt1:
	clr.b	d0
	cmp.b	(cam1,a1), d0
	beq.b	.exit
	; считывание значения счётчика таймера 1 и сохранение его в память 
	move.w	(GSR1,a0), d0
	move.w	d0, (a4)+
	; декремент индекса камеры 1
	subq.l	#WORD_SIZE, (cam1,a1)
	; настройка прерываний от таймера 1 по спаду
	move.l	(GMS1,a0), d0
	and.l	#~GMS_ICT_MASK, d0
	or.l	#GMS_ICT_FALL, d0
	move.l	d0, (GMS1,a0)
.exit:
	; очистка ожидания запроса на прерывание от таймера 1
	bclr.b	#INTH_GPT1%8, (IPRH+INTH_GPT1/8,a0)
	; очистка бита срабатывания таймера 1
	bset.b	#GSR_CAPT%8, (GSR1+GSR_CAPT/8,a0)
	rte
;*******************************************************************************
; Обработка запросов прерываний данных камеры 1		    		       *
;*******************************************************************************
;d0 - разрушен
;a0 - указатель на устройства
;a3 - указатель на область памяти данных от камеры 1
exception_handler_gpt0:
	clr.b	d0
	cmp.b	(cam0,a1), d0
	beq.b	.exit
	; считывание значения счётчика таймера 0 и сохранение его в память 
	move.w	(GSR0,a0), d0
	move.w	d0, (a3)+
	; декремент индекса камеры 0
	subq.l	#WORD_SIZE, (cam0,a1)
	; настройка прерываний от таймера 0 по спаду
	move.l	(GMS0,a0), d0
	and.l	#~GMS_ICT_MASK, d0
	or.l	#GMS_ICT_FALL, d0
	move.l	d0, (GMS0,a0)
.exit:
	; очистка ожидания запроса на прерывание от таймера 0
	bclr.b	#INTH_GPT0%8, (IPRH+INTH_GPT0/8,a0)
	; очистка бита срабатывания таймера 0
	bset.b	#GSR_CAPT%8, (GSR0+GSR_CAPT/8,a0)
	rte
;*******************************************************************************
; Обработка запросов прерываний быстрого счётчикаы	    		       *
;*******************************************************************************
;d0 - разрушены
;a0 - указатель на устройства
exception_handler_slt0:
	; очистка запрса прерывания сигнала строки
	bset.b	#SSR_ST, (SSR0,a0)
	; разрешение и очистка запрса прерывания сигналов данных
	move.l	(data_channels), d0
	move.l	d0, (IPRH,a0)
	not.l	d0
	and.l	d0, (IMRH,a0)
	rte

exception_handler_slt1:
exception_handler_usb_ep0:
exception_handler_usb_general:
exception_handler_usb_core:
exception_handler_usb_all:
	rte

;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
	;вх
	;d0 - настройки процессора
	;d1 - настройки паняти
start:
	; Задание регистра таблицы векторов VBR
	move.l	#_VECTOR_TABLE, d2
	movec	d2, vbr

	; Начальная установка MMU
	jsr	_mcf_mmu_init
;*******************************************************************************
;PAR_PSC0	equ	$A4F
	; конфигурация порта PSC0_TXD0 как ВВОН (GPIO)
;	bset	#PAR_TXD0, (PAR_PSC0,a0)
	; конфигурация порта EPDD5 как ВВОН (GPIO)
IRQ5	equ	5
IRQ6	equ	6
IRQ7	equ	7
IRQ4	equ	4
	bset	#IRQ7, (EPDDR,a0)
	bset	#IRQ6, (EPDDR,a0)
	bset	#IRQ5, (EPDDR,a0)
	bset	#IRQ4, (EPDDR,a0)
	; вывод порта EPDD5
	bclr	#IRQ5, (EPDR,a0)
	bset	#IRQ6, (EPDR,a0)
loop5:
	bset	#IRQ7, (EPDR,a0)
	bset	#IRQ4, (EPDR,a0)
	bclr	#IRQ7, (EPDR,a0)
	bclr	#IRQ4, (EPDR,a0)
	bra	loop5
;*******************************************************************************



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
	move.l	d2, (sram0_size,a2)

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
	add.l	(sram0_size,a2), d0
	move.l	d0, sp

	jsr	_mcf_gpio_init
	jsr	_mcf_siu_debug_init
	jsr	_mcf_timer_init
	jsr	_mcf_fb_init
	jsr	_mcf_edge_init
;;	jsr	_mcf_fpu_init
	jsr	_mcf_siu_ints_init
	add.l	#$8000, a1
;;	jsr	_mcf_usb_init

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
;*  SIM - Debug 						      *
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
	move.l	#GMS_ICT_RAISE|GMS_SC|GMS_IEN|GMS_TMS_DIS, d0
	move.l	d0, (GMS0,a0)	;disable timer0, set timer0 input mode
	move.l	d0, (GMS1,a0)	;disable timer1, set timer1 input mode
	move.l	d0, (GMS2,a0)	;disable timer2, set timer2 input mode
	move.l	d0, (GMS3,a0)	;disable timer3, set timer3 input mode

	move.l	#(1<<GCIR_PRE_SHIFT), d0
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

;*******************************************************************************
;* FPU	 								       *
;*******************************************************************************
	clr.l	d2
	fmove.l d2, fpcr
	rts

;*******************************************************************************
;* USB 									       *
;*******************************************************************************
_mcf_usb_init:
	move.l	a0, a1

	;Perform a hard reset or a USB reset (set USBCR[USBRST])
;;	bset.l	#USBCR_RST, (USBCR,a1)
	bset.b	#USBCR_RST, (USBCR,a1)

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
	move.b	d0, (EP1INACR,a0)
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


	;есть два буфера кадра и два указателя на эти буферы. 
	;пока в один буфер заливается инфа, другой буфер прога передает по USB. 
	;потом указатели меняются местами и все повторяется.
	;d6 - временный регистр
	;d7 - регистр, сохраняющий прерыдущий статус
_main:
	; начальные настройки полей
	clr.l	(mode)
	clr.l	(status)
	move.l	#free_buffer, d0
	move.l	d0, (main_bank)
	addi.l	#FRAME_SIZE, d0
	move.l	d0, (alter_bank)

	; цикл ожидания изменения статуса
	move.l	(status), d7
.loop:
	move.l	 (status), d6
	eor.l	 d7, d6
	beq.b	.loop

	; если используется альтернативный буфер, то основной уже заполнен полностью
;;	btst.l	#BUFFER_ALTERED, (status,a1)
	btst.b	#BUFFER_ALTERED, (status,a1)
	beq.b	.load_alter
	move.l	(main_bank), a2
	bra.b	.usb_output
.load_alter:
	move.l	(alter_bank), a2
.usb_output:
	; загружаем количество байт для пересылки по УПШ
	move.l	#FRAME_SIZE, d2
	move.l	#USB_FRAME_SIZE, d3
.usr_packet_output:
	cmp.l	d3, d2
;	bge.b	.usr_normal_packet
;	move.l	d2, d3
;	cmpi.l	#1, d2
;	bne.b	.usr_leave_one_byte
;	bset.b	#EPFCR_WFR, (EP0FCR,a0)
;	bra.b	.usr_normal_packet
;.usr_leave_one_byte:
;	subq.l	#1, d3
;.usr_normal_packet:
;	sub.l	d3, d2
;	bne	.usr_packet_output
	bra	.loop

