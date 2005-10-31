; File
;  core.asm
; Purpose:     MCF548x defines file

        cpu     5485

;************************************************************************
;*                                                                      *
;*  After reset configuration longword 0 bit definition                 *
;*                                                                      *
;************************************************************************
CFG0_DBG_A           equ     $00000000
CFG0_DBG_B           equ     $00000001
CFG0_DBG_C           equ     $00000002
CFG0_DBG_D           equ     $00000003
CFG0_DBG_E           equ     $00000004
CFG0_DBG_PLUS_MOD    equ     $00000008
CFG0_DBG_REV_MASK    equ     $0000000f
CFG0_ISA_A           equ     $00000000
CFG0_ISA_B           equ     $00000010
CFG0_ISA_C           equ     $00000020
CFG0_ISA_PLUS_MOD    equ     $00000080
CFG0_ISA_REV_MASK    equ     $000000f0
CFG0_L2CC            equ     $00000100
CFG0_MMU             equ     $00000800
CFG0_FPU             equ     $00001000
CFG0_EMAC            equ     $00002000
CFG0_DIV             equ     $00004000
CFG0_MAC             equ     $00008000
CFG0_PREV_MASK       equ     $000f0000
CFG0_PREV_SHIFT      equ     16
CFG0_VERSION_CF2     equ     $00200000
CFG0_VERSION_CF3     equ     $00300000
CFG0_VERSION_CF4     equ     $00400000
CFG0_VERSION_CF5     equ     $00500000
CFG0_VERSION_MASK    equ     $00f00000

;************************************************************************
;*                                                                      *
;*  After reset configuration longword 1 bit definition                 *
;*                                                                      *
;************************************************************************
CFG1_ROM1SZ_MASK        equ     $0000000f
CFG1_ROM1SZ_SHIFT       equ     0
CFG1_SRAM1SZ_MASK       equ     $000000f0
CFG1_SRAM1SZ_SHIFT      equ     4
CFG1_DCSZ_MASK          equ     $00000f00
CFG1_DCSZ_SHIFT         equ     8
CFG1_DCAS_MASK          equ     $00003000
CFG1_DCAS_SHIFT         equ     12
CFG1_DCAS_ASSOC         equ     $00000000
CFG1_DCAS_DIRECT        equ     $00001000
CFG1_MBSZ_MASK          equ     $0000c000
CFG1_MBSZ_SHIFT         equ     14
CFG1_MBSZ_32            equ     $00000000
CFG1_MBSZ_64            equ     $00004000
CFG1_ROM0SZ_MASK        equ     $000f0000
CFG1_ROM0SZ_SHIFT       equ     16
CFG1_SRAM0SZ_MASK       equ     $00f00000
CFG1_SRAM0SZ_SHIFT      equ     20
CFG1_ICSZ_MASK          equ     $0f000000
CFG1_ICSZ_SHIFT         equ     24
CFG1_ICAS_MASK          equ     $30000000
CFG1_ICAS_SHIFT         equ     28
CFG1_ICAS_ASSOC         equ     $00000000
CFG1_ICAS_DIRECT        equ     $10000000
CFG1_CLSZ_MASK          equ     $c0000000
CFG1_CLSZ_16            equ     $00000000
CFG1_CLSZ_32            equ     $40000000


;************************************************************************
;*                                                                      *
;*  Memory Manager Unit Supervisor Mode Registers                       *
;*                                                                      *
;************************************************************************

MMUCR   equ ($0)        ;MMU control register (MMUCR)
MMUOR   equ ($4)        ;MMU operation register (MMUOR)
MMUSR   equ ($8)        ;MMU status register (MMUSR)
MMUAR   equ ($10)       ;MMU fault, test, or TLB address register (MMUAR)
MMUTR   equ ($14)       ;MMU read/write TLB tag register (MMUTR)
MMUDR   equ ($18)       ;MMU read/write TLB data register (MMUDR)
MMUUR   equ ($1c)       ;implementation-specific information/control registers
;MMUUR(a)       ($0+a<<2)

;************************************************************************
;*                                                                      *
;*  System Integration Unit Registers                                   *
;*                                                                      *
;************************************************************************

SDRAMDS equ ($4)        ;SDRAM Drive Strength Register
SBCR    equ ($10)       ;System Breakpoint Control Register
CS0CFG0 equ ($20)       ;SDRAM Chip Select 0 Configuration Register
CS0CFG1 equ ($24)       ;SDRAM Chip Select 1 Configuration Register
CS0CFG2 equ ($28)       ;SDRAM Chip Select 2 Configuration Register
CS0CFG3 equ ($2c)       ;SDRAM Chip Select 3 Configuration Register
SECSACR equ ($38)       ;Sequential Access Control Register
RSR     equ ($44)       ;Reset Status Register
JTAGID  equ ($50)       ;JTAG Device Identification Number

GMS0	equ	$800	;GPT Enable and Mode Select Register 0
GCIR0   equ ($804)      ;GPT Counter Input Register 0
GPWM0   equ ($808)      ;GPT PWM Configuration Register 0
GSR0    equ ($80c)      ;GPT Status Register 0
GMS1	equ	$810	;GPT Enable and Mode Select Register 1
GCIR1   equ ($814)      ;GPT Counter Input Register 1
GPWM1   equ ($818)      ;GPT PWM Configuration Register 1
GSR1    equ ($81c)      ;GPT Status Register 1
GMS2	equ	$820	;GPT Enable and Mode Select Register 2
GCIR2   equ ($824)      ;GPT Counter Input Register 2
GPWM2   equ ($828)      ;GPT PWM Configuration Register 2
GSR2    equ ($82c)      ;GPT Status Register 2
GMS3	equ	$830	;GPT Enable and Mode Select Register 3
GCIR3   equ ($834)      ;GPT Counter Input Register 3
GPWM3   equ ($838)      ;GPT PWM Configuration Register 3
GSR3    equ ($83c)      ;GPT Status Register 3

STCNT0  equ ($900)      ;SLT Terminal Count Register 0
SCR0    equ ($904)      ;SLT Control Register 0
SCNT0   equ ($908)      ;SLT Count Value Register 0
SSR0    equ ($90C)      ;SLT Status Register 0
STCNT1  equ ($910)      ;SLT Terminal Count Register 1
SCR1    equ ($914)      ;SLT Control Register 1
SCNT1   equ ($918)      ;SLT Count Value Register 1
SSR1    equ ($91C)      ;SLT Status Register 1

SSR_ST		equ	24	;SLT Status Register 0
SCR_RUN    	equ 	26      ;SLT Control Register 0



IPRH	equ	$700	;Interrupt Pending Register High
IPRL	equ	($704)	;Interrupt Pending Register Low
IMRH    equ ($708)      ;Interrupt Mask Register High
IMRL    equ ($70c)      ;Interrupt Mask Register Low
INTFRCH equ ($710)      ;Interrupt Force Register High
INTFRCL equ ($714)      ;Interrupt Force Register Low
IRLR    equ ($718)      ;Interrupt Request Level Register
IACKLPR equ ($719)      ;Interrupt Acknowledge Level and Priority Register
ICR01   equ ($741)      ;Interrupt Control Register 1
ICR02   equ ($742)      ;Interrupt Control Register 2
ICR03   equ ($743)      ;Interrupt Control Register 3
ICR04   equ ($744)      ;Interrupt Control Register 4
ICR59   equ ($77b)      ;Interrupt Control Register 59
ICR60   equ ($77c)      ;Interrupt Control Register 60
ICR61   equ ($77d)      ;Interrupt Control Register 61
ICR62   equ ($77e)      ;Interrupt Control Register 62
SWIACK  equ ($7e0)      ;Software IACK Register
L1IACK  equ ($7e4)      ;Level 1 IACK Register
L2IACK  equ ($7e4)      ;Level 2 IACK Register
L3IACK  equ ($7e4)      ;Level 3 IACK Register
L4IACK  equ ($7e4)      ;Level 4 IACK Register
L5IACK  equ ($7e4)      ;Level 5 IACK Register
L6IACK  equ ($7e4)      ;Level 6 IACK Register
L7IACK  equ ($7e4)      ;Level 7 IACK Register


EPPAR   equ ($f00)      ;EPORT pin assignment register
EPDDR   equ ($f04)      ;EPORT data direction register
EPIER   equ ($f05)      ;EPORT interrupt enable register
EPDR    equ ($f08)      ;EPORT data register
EPPDR   equ ($f09)      ;EPORT pin data register
EPFR    equ ($f0c)      ;EPORT flag register


PODR_FBCTL      equ ($a00)      ;
PODR_FBCS       equ ($a01)      ;
PODR_DMA        equ ($a02)      ;
PODR_FEC0H      equ ($a04)      ;
PODR_FEC0L      equ ($a05)      ;
PODR_FEC1H      equ ($a06)      ;
PODR_FEC1L      equ ($a07)      ;
PODR_FECI2C     equ ($a08)      ;
PODR_PCIBG      equ ($a09)      ;
PODR_PCIBR      equ ($a0a)      ;
PODR_PSC3PSC2   equ ($a0c)      ;
PODR_PSC1PSC0   equ ($a0d)      ;
PODR_DSPI       equ ($a0e)      ;
PDDR_FBCTL      equ ($a10)      ;
PDDR_FBCS       equ ($a11)      ;

PDDR_DMA        equ ($a12)      ;
PDDR_FEC0H      equ ($a14)      ;
PDDR_FEC0L      equ ($a15)      ;
PDDR_FEC1H      equ ($a16)      ;
PDDR_FEC1L      equ ($a17)      ;
PDDR_FECI2C     equ ($a18)      ;
PDDR_PCIBG      equ ($a19)      ;
PDDR_PCIBR      equ ($a1a)      ;
PDDR_PSC3PSC2   equ ($a1c)      ;
PDDR_PSC1PSC0   equ ($a1d)      ;
PDDR_DSPI       equ ($a1e)      ;
PPDSDR_FBCTL    equ ($a20)      ;
PPDSDR_FBCS     equ ($a21)      ;
PPDSDR_DMA      equ ($a22)      ;
PPDSDR_FEC0H    equ ($a24)      ;
PPDSDR_FEC0L    equ ($a25)      ;
PPDSDR_FEC1H    equ ($a26)      ;
PPDSDR_FEC1L    equ ($a27)      ;
PPDSDR_FECI2C   equ ($a28)      ;
PPDSDR_PCIBG    equ ($a29)      ;
PPDSDR_PCIBR    equ ($a2a)      ;
PPDSDR_PSC3PSC2 equ ($a2c)      ;
PPDSDR_PSC1PSC0 equ ($a2d)      ;
PPDSDR_DSPI     equ ($a2e)      ;
PCLRR_FBCTL     equ ($a30)      ;
PCLRR_FBCS      equ ($a31)      ;
PCLRR_DMA       equ ($a32)      ;
PCLRR_FEC0H     equ ($a34)      ;
PCLRR_FEC0L     equ ($a35)      ;
PCLRR_FEC1H     equ ($a36)      ;
PCLRR_FEC1L     equ ($a37)      ;
PCLRR_FECI2C    equ ($a38)      ;
PCLRR_PCIBG     equ ($a39)      ;
PCLRR_PCIBR     equ ($a3a)      ;
PCLRR_PSC3PSC2  equ ($a3c)      ;
PCLRR_PSC1PSC0  equ ($a3d)      ;
PCLRR_DSPI      equ ($a3e)      ;
PAR_FBCTL       equ ($a40)      ;
PAR_FBCS        equ ($a41)      ;
PAR_DMA         equ ($a42)      ;
PAR_FECI2CIRQ   equ ($a44)      ;
PAR_PCIBG       equ ($a48)      ;
PAR_PCIBR       equ ($a4a)      ;
PAR_PSC3        equ ($a4c)      ;
PAR_PSC2        equ ($a4d)      ;
PAR_PSC1        equ ($a4e)      ;
PAR_PSC0        equ ($a4f)      ;
PAR_DSPI        equ ($a50)      ;
PAR_TIMER       equ ($a52)      ;



CSAR0           equ ($0)        ;Chip-select address register—bank 0
CSMR0           equ ($4)        ;Chip-select mask register—bank 0
CSCR0           equ ($8)        ;Chip-select control register—bank 0
CSAR1           equ ($c)        ;Chip-select address register—bank 1
CSMR1           equ ($10)       ;Chip-select mask register—bank 1
CSCR1           equ ($14)       ;Chip-select control register—bank 1
CSAR2           equ ($18)       ;Chip-select address register—bank 2
CSMR2           equ ($1c)       ;Chip-select mask register—bank 2
CSCR2           equ ($20)       ;Chip-select control register—bank 2
CSAR3           equ ($24)       ;Chip-select address register—bank 3
CSMR3           equ ($28)       ;Chip-select mask register—bank 3
CSCR3           equ ($2c)       ;Chip-select control register—bank 3
CSAR4           equ ($30)       ;Chip-select address register—bank 4
CSMR4           equ ($34)       ;Chip-select mask register—bank 4
CSCR4           equ ($38)       ;Chip-select control register—bank 4
CSAR5           equ ($3c)       ;Chip-select address register—bank 5
CSMR5           equ ($40)       ;Chip-select mask register—bank 5
CSCR5           equ ($44)       ;Chip-select control register—bank 5



USBAISR         equ ($0000)     ;Application interrupt status register
USBAIMR         equ ($0001)     ;Application interrupt mask register
EPINFO          equ ($0003)     ;Endpoint info register
CFGR            equ ($0004)     ;Configuration value register
CFGAR           equ ($0005)     ;Configuration attribute register
SPEEDR          equ ($0006)     ;Device speed register
FRMNUMR         equ ($000c)     ;USB frame number register
EPTNR           equ ($0010)     ;Endpoint transaction number register
IFUR            equ ($0014)     ;Application interface update register
IFR0            equ ($0040)     ;Configuration interface registers 0
IFR31           equ ($007c)     ;Configuration interface registers 31
PPCNT           equ ($0080)     ;USB packet passed count register
DPCNT           equ ($0082)     ;USB dropped packet counter register
CRCECNT         equ ($0084)     ;USB CCR error counter register
BSECNT          equ ($0086)     ;USB bitstuffing error counter register
PIDECNT         equ ($0088)     ;USB PID error counter register
FRMECNT         equ ($008a)     ;USB framing error counter register
TXPCNT          equ ($008c)     ;USB transmitted packet counter register
CNTOVR          equ ($008e)     ;USB counter overflow register
EP0ACR          equ ($0100)     ;EP0 attribute control register
EP0MPSR         equ ($0102)     ;EP0 max packet size register
EP0IFR          equ ($0104)     ;EP0 interface number register
EP0SR           equ ($0105)     ;EP0 status register
BMRTR           equ ($0106)   	;bmRequest type register
BRTR            equ ($0107)     ;bRequest type register
WVALUER         equ ($0108)     ;wValue register
WINDEXR         equ ($010a)     ;wIndex register
WLENGTHR        equ ($010c)     ;wLength register
EP1OUTACR       equ ($010c)     ;EP1 OUT attribute control register
EP1OUTMPSR      equ ($010c)     ;EP1 OUT max packet size register
EP1OUTIFR  	equ ($010c)     ;EP1 OUT interface number register
EP1OUTSR        equ ($010c)     ;EP1 OUT status register
EP1OUTSFR       equ ($010c)     ;EP1 OUT sync frame register
EP1INACR        equ ($010c)     ;EP1 IN attribute control register
EP1INMPSR       equ ($010c)     ;EP1 IN max packet size register
EP1INIFR        equ ($010c)     ;EP1 IN interface number register
EP1INSR         equ ($010c)     ;EP1 IN status register
EP2OUTACR       equ ($010c)     ;EP2 OUT attribute control register
EP2OUTMPSR      equ ($010c)     ;EP2 OUT max packet size register
EP2OUTIFR       equ ($010c)     ;EP2 OUT interface number register
EP2OUTSR        equ ($010c)     ;EP2 OUT status register
EP2OUTSFR       equ ($010c)     ;EP2 OUT sync frame register
EP2INACR        equ ($010c)     ;EP2 IN attribute control register
EP2INMPSR       equ ($010c)     ;EP2 IN max packet size register
EP2INIFR        equ ($010c)     ;EP2 IN interface number register
EP2INSR         equ ($010c)     ;EP2 IN status register
EP3OUTACR       equ ($010c)     ;EP3 OUT attribute control register
EP3OUTMPSR      equ ($010c)     ;EP3 OUT max packet size register
EP3OUTIFR       equ ($010c)     ;EP3 OUT interface number register
EP3OUTSR        equ ($010c)     ;EP3 OUT status register
EP3OUTSFR       equ ($010c)     ;EP3 OUT sync frame register
EP3INACR        equ ($010c)     ;EP3 IN attribute control register
EP3INMPSR       equ ($010c)     ;EP3 IN max packet size register
EP3INIFR        equ ($010c)     ;EP3 IN interface number register
EP3INSR         equ ($010c)     ;EP3 IN status register
EP4OUTACR       equ ($010c)     ;EP4 OUT attribute control register
EP4OUTMPSR      equ ($010c)     ;EP4 OUT max packet size register
EP4OUTIFR       equ ($010c)     ;EP4 OUT interface number register
EP4OUTSR        equ ($010c)     ;EP4 OUT status register
EP4OUTSFR       equ ($010c)     ;EP4 OUT sync frame register
EP4INACR        equ ($010c)     ;EP4 IN attribute control register
EP4INMPSR       equ ($010c)     ;EP4 IN max packet size register
EP4INIFR        equ ($010c)     ;EP4 IN interface number register
EP4INSR         equ ($010c)     ;EP4 IN status register
EP5OUTACR       equ ($010c)     ;EP5 OUT attribute control register
EP5OUTMPSR      equ ($010c)     ;EP5 OUT max packet size register
EP5OUTIFR       equ ($010c)     ;EP5 OUT interface number register
EP5OUTSR        equ ($010c)     ;EP5 OUT status register
EP5OUTSFR       equ ($010c)     ;EP5 OUT sync frame register
EP5INACR        equ ($010c)     ;EP5 IN attribute control register
EP5INMPSR       equ ($010c)     ;EP5 IN max packet size register
EP5INIFR        equ ($010c)     ;EP5 IN interface number register
EP5INSR         equ ($010c)     ;EP5 IN status register
EP6OUTACR       equ ($010c)     ;EP6 OUT attribute control register
EP6OUTMPSR      equ ($010c)     ;EP6 OUT max packet size register
EP6OUTIFR       equ ($010c)     ;EP6 OUT interface number register
EP6OUTSR        equ ($010c)     ;EP6 OUT status register
EP6OUTSFR       equ ($010c)     ;EP6 OUT sync frame register
EP6INACR        equ ($010c)     ;EP6 IN attribute control register
EP6INMPSR       equ ($010c)     ;EP6 IN max packet size register
EP6INIFR        equ ($010c)     ;EP6 IN interface number register
EP6INSR         equ ($010c)     ;EP6 IN status register

USBSR           equ ($3400)     ;USB status register
USBCR           equ ($3404)     ;USB control register
DRAMCR          equ ($3408)     ;USB descriptor RAM control register
DRAMDR          equ ($340c)     ;USB descriptor RAM data register
USBISR          equ ($3410)     ;USB interrupt status register
USBIMR          equ ($3414)     ;USB interrupt mask register
EP0STAT         equ ($3440)     ;EP0 status and control register
EP0ISR          equ ($3444)     ;EP0 interrupt status register
EP0IMR          equ ($3448)     ;EP0 interrupt mask register
EP0FRCFGR       equ ($344c)     ;EP0 FIFO RAM configuration register
EP0FDR          equ ($3450)     ;EP0 FIFO data register
EP0FSR          equ ($3454)     ;EP0 FIFO status register
EP0FCR          equ ($3458)     ;EP0 FIFO control registe
EP0FAR          equ ($345c)     ;EP0 FIFO alarm register
EP0FRP          equ ($3460)     ;EP0 FIFO read pointer
EP0FWP          equ ($3464)     ;EP0 FIFO read pointer
EP0LRFP         equ ($3468)     ;EP0 last read frame pointer
EP0LWFP         equ ($346c)     ;EP0 last write frame pointer
EP1STAT         equ ($3470)     ;EP1 status and control register
EP1ISR          equ ($3474)     ;EP1 interrupt status register
EP1IMR          equ ($3478)     ;EP1 interrupt mask register
EP1FRCFGR       equ ($347c)     ;EP1 FIFO RAM configuration register
EP1FDR          equ ($3480)     ;EP1 FIFO data register
EP1FSR          equ ($3484)     ;EP1 FIFO status register
EP1FCR          equ ($3488)     ;EP1 FIFO control registe
EP1FAR          equ ($348c)     ;EP1 FIFO alarm register
EP1FRP          equ ($3490)     ;EP1 FIFO read pointer
EP1FWP          equ ($3494)     ;EP1 FIFO read pointer
EP1LRFP         equ ($3498)     ;EP1 last read frame pointer
EP1LWFP         equ ($349c)     ;EP1 last write frame pointer3

EP2STAT         equ ($34a0)     ;EP2 status and control register
EP2ISR          equ ($34a4)     ;EP2 interrupt status register
EP2IMR          equ ($34a8)     ;EP2 interrupt mask register
EP2FRCFGR       equ ($34ac)     ;EP2 FIFO RAM configuration register
EP2FDR          equ ($34b0)     ;EP2 FIFO data register
EP2FSR          equ ($34b4)     ;EP2 FIFO status register
EP2FCR          equ ($34b8)     ;EP2 FIFO control registe
EP2FAR          equ ($34bc)     ;EP2 FIFO alarm register
EP2FRP          equ ($34c0)     ;EP2 FIFO read pointer
EP2FWP          equ ($34c4)     ;EP2 FIFO read pointer
EP2LRFP         equ ($34c8)     ;EP2 last read frame pointer
EP2LWFP         equ ($34cc)     ;EP2 last write frame pointer

EP3STAT         equ ($34d0)     ;EP3 status and control register
EP3ISR          equ ($34d4)     ;EP3 interrupt status register
EP3IMR          equ ($34d8)     ;EP3 interrupt mask register
EP3FRCFGR       equ ($34dc)     ;EP3 FIFO RAM configuration register
EP3FDR          equ ($34e0)     ;EP3 FIFO data register
EP3FSR          equ ($34e4)     ;EP3 FIFO status register
EP3FCR          equ ($34e8)     ;EP3 FIFO control registe
EP3FAR          equ ($34ec)     ;EP3 FIFO alarm register
EP3FRP          equ ($34f0)     ;EP3 FIFO read pointer
EP3FWP          equ ($34f4)     ;EP3 FIFO read pointer
EP3LRFP         equ ($34f8)     ;EP3 last read frame pointer
EP3LWFP         equ ($34fc)     ;EP3 last write frame pointer

EP4STAT         equ ($3500)     ;EP4 status and control register
EP4ISR          equ ($3504)     ;EP4 interrupt status register
EP4IMR          equ ($3508)     ;EP4 interrupt mask register
EP4FRCFGR       equ ($350c)     ;EP4 FIFO RAM configuration register
EP4FDR          equ ($3510)     ;EP4 FIFO data register
EP4FSR          equ ($3514)     ;EP4 FIFO status register
EP4FCR          equ ($3518)     ;EP4 FIFO control registe
EP4FAR          equ ($351c)     ;EP4 FIFO alarm register
EP4FRP          equ ($3520)     ;EP4 FIFO read pointer
EP4FWP          equ ($3524)     ;EP4 FIFO read pointer
EP4LRFP         equ ($3528)     ;EP4 last read frame pointer
EP4LWFP         equ ($352c)     ;EP4 last write frame pointer

EP5STAT         equ ($3530)     ;EP5 status and control register
EP5ISR          equ ($3534)     ;EP5 interrupt status register
EP5IMR          equ ($3538)     ;EP5 interrupt mask register
EP5FRCFGR       equ ($353c)     ;EP5 FIFO RAM configuration register
EP5FDR          equ ($3540)     ;EP5 FIFO data register
EP5FSR          equ ($3544)     ;EP5 FIFO status register
EP5FCR          equ ($0548)     ;EP5 FIFO control registe
EP5FAR          equ ($354c)     ;EP5 FIFO alarm register
EP5FRP          equ ($3550)     ;EP5 FIFO read pointer
EP5FWP          equ ($3554)     ;EP5 FIFO read pointer
EP5LRFP         equ ($3558)     ;EP5 last read frame pointer
EP5LWFP         equ ($355c)     ;EP5 last write frame pointer

EP6STAT         equ ($3560)     ;EP6 status and control register
EP6ISR          equ ($3564)     ;EP6 interrupt status register
EP6IMR          equ ($3568)     ;EP6 interrupt mask register
EP6FRCFGR       equ ($356c)     ;EP6 FIFO RAM configuration register
EP6FDR          equ ($3570)     ;EP6 FIFO data register
EP6FSR          equ ($3574)     ;EP6 FIFO status register
EP6FCR          equ ($3578)     ;EP6 FIFO control registe
EP6FAR          equ ($357c)     ;EP6 FIFO alarm register
EP6FRP          equ ($3580)     ;EP6 FIFO read pointer
EP6FWP          equ ($3584)     ;EP6 FIFO read pointer
EP6LRFP         equ ($3588)     ;EP6 last read frame pointer
EP6LWFP         equ ($358c)     ;EP6 last write frame pointer



;************************************************************************
;*                                                                      *
;*  Values for USB registers                                            *
;*                                                                      *
;************************************************************************

;************************************************************************
;*  Value for for EPFCR registers					*
;************************************************************************
EPFCR_WFR	equ	29	;Write end of frame

;************************************************************************
;*  Value for for USBCR registers					*
;************************************************************************
USBCR_RST	equ	2	;USB reset bit




;************************************************************************
;*                                                                      *
;*  Integer Unit User Mode Registers                                    *
;*      (except the SR which contains the CCR)                          *
;*                                                                      *
;************************************************************************

SR_T       equ  ($8000)     ;Trace Enable                 *
SR_S       equ  ($2000)     ;Supervisor/User State        *
SR_M       equ  ($1000)     ;Master/Interrupt State       *
;SR_IPM(a)  equ (((a)&0700)<<8) ;Interrupt Priority Mask   *
SR_P       equ  ($0080)     ;Branch Prediction Forward    *
SR_X       equ  ($0010)     ;Extend Condition Code        *
SR_N       equ  ($0008)     ;Negative Condition Code      *
SR_Z       equ  ($0004)     ;Zero Condition Code          *
SR_V       equ  ($0002)     ;Overflow Condition Code      *
SR_C       equ  ($0001)     ;Carry Condition Code         *


;************************************************************************
;*                                                                      *
;*  MAC Unit User Mode Registers                              *
;*                                                                      *
;************************************************************************

MAC_MACSR_OMC   equ     ($80)
MAC_MACSR_SUPER equ     ($40)
MAC_MACSR_N     equ     ($08)  ;Negative Condition Code      *
MAC_MACSR_Z     equ     ($04)  ;Zero Condition Code          *
MAC_MACSR_V     equ     ($02)  ;Overflow Condition Code      *
MAC_MACSR_C     equ     ($01)  ;Carry Condition Code         *


;************************************************************************
;*                                                                      *
;*  Supervisor Mode Registers (SR is grouped with User because of CCR)  *
;*                                                                      *
;************************************************************************

CACR_DEC        equ     ($80000000)    ;Data Cache Enable
CACR_DW         equ     ($40000000)    ;Data Write Protect
CACR_DESB       equ     ($20000000)    ;Enable data store buffer
CACR_DDPI       equ     ($10000000)    ;Disable data CPUSHL invalidation
CACR_DHLCK      equ     ($08000000)    ;1/2 Data cache lock mode
CACR_DDCM_MASK  equ     ($06000000)    ;Default data cache mode
CACR_DDCM_WRTHR equ     ($00000000)    ;Cacheable, writethrough
CACR_DDCM_CPBCK equ     ($02000000)    ;Cacheable, copyback
CACR_DDCM_INHPR equ     ($04000000)    ;Cache-Inhibited, precise
CACR_DDCM_INHIM equ     ($06000000)    ;Cache-Inhibited, imprecise
CACR_DCINVA     equ     ($01000000)    ;Data cache invalidate all
CACR_DDSP       equ     ($00800000)    ;Data supervisor protect
CACR_BEC        equ     ($00080000)    ;Branch cache enable
CACR_BCINVA     equ     ($00040000)    ;Branch cache invalidate all
CACR_IEC        equ     ($00008000)    ;Instruction cache enable
CACR_DNFB       equ     ($00002000)    ;Default noncacheable fill buffer
CACR_IDPI       equ     ($00001000)    ;Disable instruction CPUSHL invalidation
CACR_IHLCK      equ     ($00000800)    ;1/2 Instruction cache lock mode
CACR_IDCM       equ     ($00000400)    ;Default instruction cache mode
CACR_ICINVA     equ     ($00000100)    ;Instruction cache invalidate all
CACR_IDSP       equ     ($00000080)    ;Instruction supervisor protect
CACR_EUSP       equ     ($00000020)    ;Enable user stack pointer USP
CACR_DF         equ     ($00000010)    ;Disable FPU


ACR_AB_MASK     equ     ($ff000000)    ;Address base
ACR_AM_MASK     equ     ($00ff0000)    ;Address mask
ACR_E           equ     ($00008000)    ;Enable
ACR_S_MASK      equ     ($00006000)    ;User mode access
ACR_S_USER      equ     ($00000000)    ;User mode access
ACR_S_SUPER     equ     ($00002000)    ;Supervisor mode access
ACR_S_IGNORE    equ     ($00004000)    ;Ignore mode access
ACR_AMM         equ     ($00000400)    ;Address mask mode
ACR_CM_MASK     equ     ($00000060)    ;Cache mode
ACR_CM_WRTHR    equ     ($00000000)    ;Cacheable, writethrough
ACR_CM_CPBCK    equ     ($00000020)    ;Cacheable, copyback
ACR_CM_INHPR    equ     ($00000040)    ;Cache-Inhibited, precise
ACR_CM_INHIM    equ     ($00000060)    ;Cache-Inhibited, imprecise
ACR_SP          equ     ($00000008)    ;Supervisor protect
ACR_W           equ     ($00000004)    ;Write protect

;VBR_BASE(a)     equ    ((a)&$FFF00000)        ;Vector Base Address      *

;RAMBAR_BASE(a)  equ    ((a)&$FFFFFE00)        ;Base Address             *
RAMBAR_WP       equ     ($00000100)    ;Write Protect                    *
RAMBAR_AS_CPU   equ     ($00000020)    ;CPU Space/Interrupt acknowledge  *
RAMBAR_AS_SC    equ     ($00000010)    ;Supervisor Code                  *
RAMBAR_AS_SD    equ     ($00000008)    ;Supervisor Data                  *
RAMBAR_AS_UC    equ     ($00000004)    ;User Code                        *
RAMBAR_AS_UD    equ     ($00000002)    ;User Data                        *
RAMBAR_V        equ     ($00000001)    ;Valid                            *

;MBAR_BASE(a)    equ    ((a)&$FFFFFC00)        ;Base Address             *
MBAR_WP         equ     ($00000200)    ;Write Protect                    *
MBAR_SC         equ     ($00000010)    ;Mask Supervisor Code Space       *
MBAR_SD         equ     ($00000008)    ;Mask Supervisor Data Space       *
MBAR_UC         equ     ($00000004)    ;Mask User Code Space             *
MBAR_UD         equ     ($00000002)    ;Mask User Data Space             *
MBAR_V          equ     ($00000001)    ;Valid                            *


;************************************************************************
;*                                                                      *
;*  System Integration Registers                                        *
;*                                                                      *
;************************************************************************

SIM_RSR_HRST            equ     ($80)  ;Hard or System Reset             *
SIM_RSR_SWTR            equ     ($20)  ;Software Watchdog Timer Reset    *

SIM_SYPCR_SWE           equ     ($80)  ;Software Watchdog Enable         *
SIM_SYPCR_SWRI          equ     ($40)  ;SW Reset/Interrupt Select        *
SIM_SYPCR_SWT_2_9       equ     ($00)  ;SW Timeout: 2^9  / Sys Freq      *
SIM_SYPCR_SWT_2_11      equ     ($08)  ;SW Timeout: 2^11 / Sys Freq      *
SIM_SYPCR_SWT_2_13      equ     ($10)  ;SW Timeout: 2^13 / Sys Freq      *
SIM_SYPCR_SWT_2_15      equ     ($18)  ;SW Timeout: 2^15 / Sys Freq      *
SIM_SYPCR_SWT_2_18      equ     ($20)  ;SW Timeout: 2^18 / Sys Freq      *
SIM_SYPCR_SWT_2_20      equ     ($28)  ;SW Timeout: 2^20 / Sys Freq      *
SIM_SYPCR_SWT_2_22      equ     ($30)  ;SW Timeout: 2^22 / Sys Freq      *
SIM_SYPCR_SWT_2_24      equ     ($38)  ;SW Timeout: 2^24 / Sys Freq      *
SIM_SYPCR_SWTA          equ     ($04)  ;SW Transfer Acknowledge Enable   *
SIM_SYPCR_SWTAVAL       equ     ($02)  ;SW Transfer Acknowledge Valid    *

SIM_SWSR_55             equ     ($55)          ;Write $55 to SWSR        *
SIM_SWSR_AA             equ     ($aa)          ;Write $AA to SWSR        *

SIM_PAR_ADDR31          equ     ($8000)        ;Assign Pin as ADDR31     *
SIM_PAR_ADDR30          equ     ($4000)        ;Assign Pin as ADDR30     *
SIM_PAR_ADDR29          equ     ($2000)        ;Assign Pin as ADDR29     *
SIM_PAR_ADDR28          equ     ($1000)        ;Assign Pin as ADDR28     *
SIM_PAR_ADDR27          equ     ($0800)        ;Assign Pin as ADDR27     *
SIM_PAR_ADDR26          equ     ($0400)        ;Assign Pin as ADDR26     *
SIM_PAR_ADDR25          equ     ($0200)        ;Assign Pin as ADDR25     *
SIM_PAR_ADDR24          equ     ($0100)        ;Assign Pin as ADDR24     *
SIM_PAR_XTIP            equ     ($0080)        ;Assign Pin as XTIP       *
SIM_PAR_DREQ0           equ     ($0040)        ;Assign Pin as DREQ0      *
SIM_PAR_DREQ1           equ     ($0020)        ;Assign Pin as DREQ1      *
SIM_PAR_TM2             equ     ($0010)        ;Assign Pin as TM2        *
SIM_PAR_TM1             equ     ($0008)        ;Assign Pin as TM1        *
SIM_PAR_TM0             equ     ($0004)        ;Assign Pin as TM0        *
SIM_PAR_TT1             equ     ($0002)        ;Assign Pin as TT1        *
SIM_PAR_TT0             equ     ($0001)        ;Assign Pin as TT0        *

SIM_IRQPAR_2            equ     ($80)  ;IRQ[5] pin to Int IL 4, not 5    *
SIM_IRQPAR_1            equ     ($20)  ;IRQ[3] pin to Int IL 6, not 3    *
SIM_IRQPAR_0            equ     ($10)  ;IRQ[1] pin to Int IL 2, not 1    *

SIM_PLLCR_ENBSTOP       equ     ($80)  ;Enable CPU STOP Instruction      *
;SIM_PLLCR_PLLIPL(a)     equ    (((a)&$07)<<4) ;PLL Wake-up IPL          *

;SIM_MPARK_PARK(a)       equ    (((a)&$03)<<6) ;Default Bus Master       *
SIM_MPARK_E2MCTRL       equ     ($20)          ;EBus to MBus Arbitration *
SIM_MPARK_EARBCTRL      equ     ($10)          ;SBus to EBus Arbitration *
SIM_MPARK_SHOWDATA      equ     ($08)          ;Show SBus on EBus        *

;*******************************************************************************
;* Êîíòðîëëåð ïðåðûâàíèé						       *
;*******************************************************************************

INTL_EP1	equ     1	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 1
INTL_EP2	equ     2	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 2
INTL_EP3	equ     3	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 3
INTL_EP4	equ     4	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 4
INTL_EP5	equ     5	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 5
INTL_EP6	equ     6	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 6
INTL_EP7	equ     7	; âíåøíèé çàïðîñ ïðåðûâàíèÿ 7
INTL_EP0ISR	equ	15
INTL_EP1ISR	equ	16
INTL_EP2ISR	equ	17
INTL_EP3ISR	equ	18
INTL_EP4ISR	equ	19
INTL_EP5ISR	equ	20
INTL_EP6ISR	equ	21
INTL_USBISR	equ	22
INTL_USBAISR	equ	23
INTL_USBALL	equ	24
INTL_RFOF_TFUF	equ	25
INTL_RFOF	equ	26
INTL_RFDF	equ	27
INTL_TFUF	equ	28
INTL_TCF	equ	29
INTL_TFFF	equ	30
INTL_EOQF	equ	31
INTH_PSC0	equ	0
INTH_PSC1	equ	1
INTH_PSC2	equ	2
INTH_PSC3	equ	3
INTH_TIMERS	equ	4	;Interrupt from common timers
INTH_SEC	equ	5
INTH_FEC0	equ	6
INTH_FEC1	equ	7
INTH_I2C	equ	8
INTH_PCIARB	equ	9
INTH_CBPCI	equ	10
INTH_XLBPCI	equ	11
INTH_XLBARB	equ	15
INTH_DMA	equ	16
INTH_CAN0ERROR	equ	17
INTH_CAN0BUSOFF	equ	18
INTH_CAN0MBOR	equ	19
INTH_SLT0	equ	21
INTH_SLT1	equ	22
INTH_CAN1ERROR	equ	23
INTH_CAN1BUSOFF	equ	24
INTH_CAN1MBOR	equ	25
INTH_GPT0	equ	27
INTH_GPT1	equ	28
INTH_GPT2	equ	29
INTH_GPT3	equ	30

;*******************************************************************************
;* Êîíòðîëëåð âíåøíèõ ïðåðûâàíèé					       *
;*******************************************************************************
IRQ_EP1		equ	1
IRQ_EP2		equ	2
IRQ_EP3		equ	3
IRQ_EP4		equ	4
IRQ_EP5		equ	5
IRQ_EP6		equ	6
IRQ_EP7		equ	7

;*******************************************************************************
;*  Reset status Register bit definitions                                                      *
;*******************************************************************************
RSR_RSTJTG	equ	($8)
RSR_RSTWD	equ	($2)
RSR_RST		equ	($1)


;************************************************************************
;*                                                                      *
;*  Chip Select Registers                                         *
;*                                                                      *
;************************************************************************

;***********************************************************************
;*                                                                     *
;*  These definitions only exists in the CSMR for Banks 0 and 1        *
;*                                                                     *
;***********************************************************************

CS_CSMR_MASK_4G         equ     ($FFFF0000)    ;Set Bank to 4G          *
CS_CSMR_MASK_2G         equ     ($7FFF0000)    ;Set Bank to 2G          *
CS_CSMR_MASK_1G         equ     ($3FFF0000)    ;Set Bank to 1G          *
CS_CSMR_MASK_1024M      equ     ($3FFF0000)    ;Set Bank to 1024M       *
CS_CSMR_MASK_512M       equ     ($1FFF0000)    ;Set Bank to 512M        *
CS_CSMR_MASK_256M       equ     ($0FFF0000)    ;Set Bank to 256M        *
CS_CSMR_MASK_128M       equ     ($07FF0000)    ;Set Bank to 128M        *
CS_CSMR_MASK_64M        equ     ($03FF0000)    ;Set Bank to 64M         *
CS_CSMR_MASK_32M        equ     ($01FF0000)    ;Set Bank to 32M         *
CS_CSMR_MASK_16M        equ     ($00FF0000)    ;Set Bank to 16M         *
CS_CSMR_MASK_8M         equ     ($007F0000)    ;Set Bank to 8M          *
CS_CSMR_MASK_4M         equ     ($003F0000)    ;Set Bank to 4M          *
CS_CSMR_MASK_2M         equ     ($001F0000)    ;Set Bank to 2M          *
CS_CSMR_MASK_1M         equ     ($000F0000)    ;Set Bank to 1M          *
CS_CSMR_MASK_1024K      equ     ($000F0000)    ;Set Bank to 1024K       *
CS_CSMR_MASK_512K       equ     ($00070000)    ;Set Bank to 512K        *
CS_CSMR_MASK_256K       equ     ($00030000)    ;Set Bank to 256K        *
CS_CSMR_MASK_128K       equ     ($00010000)    ;Set Bank to 128K        *
CS_CSMR_MASK_64K        equ     ($00000000)    ;Set Bank to 64K         *
CS_CSMR_CPU             equ     ($00000020)    ;CPU and IACK Cycle Mask *

;***********************************************************************
;*                                                                     *
;*  The following definitions exist for all Banks 0-7                  *
;*                                                                     *
;***********************************************************************

;CS_CSAR(a)              equ    (((a)&$FFFF0000)>>16)  ;Base Address    *
;CS_CSBAR(a)             equ    (((a)&$FF000000)>>24)  ;Base for CS2-7  *

CS_CSMR_WP              equ     ($00000100)    ;Write Protect           *
CS_CSMR_AM              equ     ($00000040)    ;Alternate Master Mask   *
CS_CSMR_SC              equ     ($00000010)    ;Supervisor Code Mask    *
CS_CSMR_SD              equ     ($00000008)    ;Supervisor Data Mask    *
CS_CSMR_UC              equ     ($00000004)    ;User Code Mask          *
CS_CSMR_UD              equ     ($00000002)    ;User Data Mask          *
CS_CSMR_V               equ     ($00000001)    ;Valid Register          *

;CS_CSCR_WS(a)           equ    (((a)&$0F)<<10) ;Wait States            *
CS_CSCR_AA              equ     ($0100)        ;Auto Acknowledge Enable *
CS_CSCR_PS_8            equ     ($0040)        ;Port Size:   8-bit      *
CS_CSCR_PS_16           equ     ($0080)        ;Port Size:  16-bit      *
CS_CSCR_PS_32           equ     ($0000)        ;Port Size:  32-bit      *
CS_CSCR_BEM             equ     ($0020)        ;Byte Module Enable      *
CS_CSCR_BSTR            equ     ($0010)        ;Burst Read Enable       *
CS_CSCR_BSTW            equ     ($0008)        ;Burst Write Enable      *


;************************************************************************
;*                                                                      *
;*  DRAM Registers                                                      *
;*                                                                      *
;************************************************************************

;***********************************************************************
;*                                                                     *
;*  Controls used by both Synchronous and Asynchronous DRAM            *
;*                                                                     *
;***********************************************************************

DRAMC_DCR_SO            equ     ($8000)        ;Synchronous Operation        *
DRAMC_DCR_NAM           equ     ($2000)        ;No Address Multiplexing      *
;DRAMC_DCR_RC(a)         equ    ((a)&$01FF)    ;Refresh Count                *

;DRAMC_DACR_BASE(a)      equ    ((a)&$FFFC0000) ;Base Address                *
DRAMC_DACR_RE           equ     ($00008000)    ;Refresh Enable               *
DRAMC_DACR_PS_32        equ     ($00000000)    ;Port Size:  32-bit           *
DRAMC_DACR_PS_8         equ     ($00000010)    ;Port Size:   8-bit           *
DRAMC_DACR_PS_16        equ     ($00000020)    ;Port Size:  16-bit           *

DRAMC_DCMR_MASK_4G      equ     ($FFFC0000)    ;DRAM Size of 4G              *
DRAMC_DCMR_MASK_2G      equ     ($7FFC0000)    ;DRAM Size of 2G              *
DRAMC_DCMR_MASK_1G      equ     ($3FFC0000)    ;DRAM Size of 1G              *
DRAMC_DCMR_MASK_1024M   equ     ($3FFC0000)    ;DRAM Size of 1024M           *
DRAMC_DCMR_MASK_512M    equ       ($1FFC0000)    ;DRAM Size of 512M            *
DRAMC_DCMR_MASK_256M    equ     ($0FFC0000)    ;DRAM Size of 256M            *
DRAMC_DCMR_MASK_128M    equ     ($07FC0000)    ;DRAM Size of 128M            *
DRAMC_DCMR_MASK_64M     equ     ($03FC0000)    ;DRAM Size of 64M             *
DRAMC_DCMR_MASK_32M     equ     ($01FC0000)    ;DRAM Size of 32M             *
DRAMC_DCMR_MASK_16M     equ     ($00FC0000)    ;DRAM Size of 16M             *
DRAMC_DCMR_MASK_8M      equ     ($007C0000)    ;DRAM Size of 8M              *
DRAMC_DCMR_MASK_4M      equ     ($003C0000)    ;DRAM Size of 4M              *
DRAMC_DCMR_MASK_2M      equ     ($001C0000)    ;DRAM Size of 2M              *
DRAMC_DCMR_MASK_1M      equ     ($000C0000)    ;DRAM Size of 1M              *
DRAMC_DCMR_MASK_1024K   equ     ($00040000)    ;DRAM Size of 1024K           *
DRAMC_DCMR_MASK_256K    equ     ($00000000)    ;DRAM Size of 512K            *
DRAMC_DCMR_WP           equ     ($00000100)    ;Write Protect                *
DRAMC_DCMR_CPU          equ     ($00000040)    ;CPU Space Ignored            *
DRAMC_DCMR_AM           equ     ($00000020)    ;Alternate Master Ignored     *
DRAMC_DCMR_SC           equ     ($00000010)    ;Supervisor Code Ignored      *
DRAMC_DCMR_SD           equ     ($00000008)    ;Supervisor Data Ignored      *
DRAMC_DCMR_UC           equ     ($00000004)    ;User Code Ignored            *
DRAMC_DCMR_UD           equ     ($00000002)    ;User Data Ignored            *
DRAMC_DCMR_V            equ     ($00000001)    ;Valid Register               *

;***********************************************************************
;*                                                                     *
;*  Controls used only by Asynchronous DRAM                            *
;*                                                                     *
;***********************************************************************

DRAMC_DCR_RRA_2         equ     ($0000) ;Refresh RAS Asserted 2 Clocks       *
DRAMC_DCR_RRA_3         equ     ($0800) ;Refresh RAS Asserted 3 Clocks       *
DRAMC_DCR_RRA_4         equ     ($1000) ;Refresh RAS Asserted 4 Clocks       *
DRAMC_DCR_RRA_5         equ     ($1800) ;Refresh RAS Asserted 5 Clocks       *
DRAMC_DCR_RRP_1         equ     ($0000) ;Refresh RAS Precharged 3 Clks       *
DRAMC_DCR_RRP_2         equ     ($0200) ;Refresh RAS Precharged 3 Clks       *
DRAMC_DCR_RRP_3           equ   ($0400) ;Refresh RAS Precharged 3 Clks       *
DRAMC_DCR_RRP_4         equ     ($0600) ;Refresh RAS Precharged 3 Clks       *

DRAMC_DACR_CAS_1        equ     ($00000000)    ;CAS Active 1 Clock           *
DRAMC_DACR_CAS_2        equ     ($00001000)    ;CAS Active 2 Clocks          *
DRAMC_DACR_CAS_3        equ     ($00002000)    ;CAS Active 3 Clocks          *
DRAMC_DACR_CAS_4        equ     ($00003000)    ;CAS Active 4 Clocks          *
DRAMC_DACR_RP_1         equ     ($00000000)    ;RAS Precharge 1 Clock        *
DRAMC_DACR_RP_2         equ     ($00000400)    ;RAS Precharge 2 Clocks       *
DRAMC_DACR_RP_3         equ     ($00000800)    ;RAS Precharge 3 Clocks       *
DRAMC_DACR_RP_4         equ     ($00000C00)    ;RAS Precharge 4 Clocks       *
DRAMC_DACR_RNCN         equ     ($00000200)    ;RAS Negate to CAS Negate     *
DRAMC_DACR_RCD_1        equ     ($00000000)    ;1 Clock Between RAS and CAS  *
DRAMC_DACR_RCD_2        equ     ($00000100)    ;2 Clocks Between RAS and CAS *
DRAMC_DACR_EDO          equ     ($00000040)    ;Extended Data Out            *
DRAMC_DACR_PM_OFF       equ     ($00000000)    ;No Page Mode                 *
DRAMC_DACR_PM_BURST     equ     ($00000004)    ;Page Mode on Burst Only      *
DRAMC_DACR_PM_ON        equ     ($0000000C)    ;Continuous Page Mode         *

;***********************************************************************
;*                                                                     *
;*  Controls used only by Synchronous DRAM                             *
;*                                                                     *
;***********************************************************************

DRAMC_DCR_COC           equ     ($1000) ;Command on Clock Enable             *
DRAMC_DCR_IS            equ     ($0800) ;Initiate Self Refresh Command       *
DRAMC_DCR_RTIM_3        equ     ($0000) ;3 Clocks Between REF and ACTV Cmds  *
DRAMC_DCR_RTIM_6        equ     ($0200) ;6 Clocks Between REF and ACTV Cmds  *
DRAMC_DCR_RTIM_9        equ     ($0400) ;9 Clocks Between REF and ACTV Cmds  *

DRAMC_DACR_CASL_1       equ     ($00000000) ;1 Clock From CAS to Data        *
DRAMC_DACR_CASL_2       equ     ($00001000) ;2 Clock From CAS to Data        *
DRAMC_DACR_CASL_3       equ     ($00002000) ;3 Clock From CAS to Data        *
;DRAMC_DACR_CBM(a)       equ    (((a)&$00000007)<<8) ;Command and Bank Mux   *
DRAMC_DACR_IMRS         equ     ($00000040) ;Initiate Mode Register Set Cmd  *
DRAMC_DACR_IP           equ     ($00000008) ;Initiate Precharge All Command  *
DRAMC_DACR_PM           equ     ($00000004) ;Continuous Page Mode            *


;*******************************************************************************
;*  General purpose timer registers                                            *
;*******************************************************************************
GMS_OCPW_MASK		equ     ($ff000000)
GMS_OCPW		equ     24
GMS_OCT_FORCE_LOW	equ     ($00000000) ;Disable Capture Event
GMS_OCT_HIGH		equ     ($00000010) ;Capture on Rising Edge
GMS_OCT_LOW		equ     ($00000020) ;Capture on Falling Edge
GMS_OCT_TOGGLE		equ     ($00000030) ;Capture on Any Edge
GMS_ICT_ANY		equ     ($00000000) ;Disable Capture Event
GMS_ICT_RAISE		equ     ($00000001) ;Capture on Rising Edge
GMS_ICT_FALL		equ     ($00000002) ;Capture on Falling Edge
GMS_ICT_PULSE		equ     ($00000003) ;Capture on Any Edge
GMS_ICT_MASK		equ     ($00000003) ;Capture on Any Edge
GMS_WDEN		equ     15
GMS_CE			equ     12
GMS_SC			equ     10
GMS_OD			equ     9
GMS_IEN			equ     8
GMS_GPIO		equ     4
GMS_GPIO_IN		equ     ($00000000)
GMS_GPIO_OUT		equ     ($00000020)
GMS_GPIO_ZOUT		equ     ($00000030)
GMS_TMS			equ     0
GMS_TMS_DIS		equ     ($00000000)
GMS_TMS_IN		equ     ($00000001)
GMS_TMS_OUT		equ     ($00000002)
GMS_TMS_PWM		equ     ($00000003)
GMS_TMS_GPIO		equ     ($00000004)
GCIR_PRE_MASK		equ	($ffff0000)
GCIR_PRE_SHIFT		equ	16
GCIR_CNT_MASK		equ	($0000ffff)
GCIR_CNT_SHIFT		equ	0
GPWM_WIDTH_MASK		equ	($ffff0000)
GPWM_WIDTH_SHIFT	equ	16
GPWM_PWMOP		equ	($00000100)
GPWM_LOAD		equ	($00000001)
GSR_CAPTURE_MASK	equ	($ffff0000)
GSR_CAPTURE		equ	16
GSR_OVF_MASK		equ	($00007000)
GSR_OVF			equ	12
GSR_PIN			equ	($00000100)
GSR_TEXP		equ	($00000008)
GSR_PWMP		equ	($00000004)
GSR_COMP		equ	($00000002)
GSR_CAPT		equ	($00000001)


;*******************************************************************************
;*  Chip select registers                                                      *
;*******************************************************************************
CSAR_BA_MASK		equ	($ffff0000)
CSMR_BAM_MASK		equ	($ffff0000)
CSMR_WP			equ	($00000100)
CSMR_V			equ	($00000001)
CSCR_SWS_MASK		equ	($fc000000)
CSCR_SWS_SHIFT		equ	26
CSCR_SWSEN		equ	($00800000)
CSCR_ASET_MASK		equ	($00300000)
CSCR_ASET_SHIFT		equ	20
CSCR_RDAH_MASK		equ	($000c0000)
CSCR_RDAH_SHIFT		equ	18
CSCR_WRAH_MASK		equ	($00030000)
CSCR_WRAH_SHIFT		equ	16
CSCR_WS_MASK		equ	($0000fc00)
CSCR_WS_SHIFT		equ	10
CSCR_AA			equ	($00000100)
CSCR_PS_MASK		equ	($000000c0)
CSCR_PS_SHIFT		equ	6
CSCR_BEM		equ	($00000020)
CSCR_BSTR		equ	($00000010)
CSCR_BSTW		equ	($00000008)


EPPAR_EPPA1_MASK	equ	($000c)
EPPAR_EPPA1_LEVEL	equ	($0000)
EPPAR_EPPA1_RISE	equ	($0004)
EPPAR_EPPA1_FALL	equ	($0008)
EPPAR_EPPA1_BOTH	equ	($000c)
EPPAR_EPPA2_MASK	equ	($0030)
EPPAR_EPPA2_LEVEL	equ	($0000)
EPPAR_EPPA2_RISE	equ	($0010)
EPPAR_EPPA2_FALL	equ	($0020)
EPPAR_EPPA2_BOTH	equ	($0030)
EPPAR_EPPA3_MASK	equ	($00c0)
EPPAR_EPPA3_LEVEL	equ	($0000)
EPPAR_EPPA3_RISE	equ	($0040)
EPPAR_EPPA3_FALL	equ	($0080)
EPPAR_EPPA3_BOTH	equ	($00c0)
EPPAR_EPPA4_MASK	equ	($0300)
EPPAR_EPPA4_LEVEL	equ	($0000)
EPPAR_EPPA4_RISE	equ	($0100)
EPPAR_EPPA4_FALL	equ	($0200)
EPPAR_EPPA4_BOTH	equ	($0300)
EPPAR_EPPA5_MASK	equ	($0c00)
EPPAR_EPPA5_LEVEL	equ	($0000)
EPPAR_EPPA5_RISE	equ	($0400)
EPPAR_EPPA5_FALL	equ	($0800)
EPPAR_EPPA5_BOTH	equ	($0c00)
EPPAR_EPPA6_MASK	equ	($3000)
EPPAR_EPPA6_LEVEL	equ	($0000)
EPPAR_EPPA6_RISE	equ	($1000)
EPPAR_EPPA6_FALL	equ	($2000)
EPPAR_EPPA6_BOTH	equ	($3000)
EPPAR_EPPA7_MASK	equ	($c000)
EPPAR_EPPA7_LEVEL	equ	($0000)
EPPAR_EPPA7_RISE	equ	($4000)
EPPAR_EPPA7_FALL	equ	($8000)
EPPAR_EPPA7_BOTH	equ	($c000)
EPDDR_IN1		equ	($00)
EPDDR_OUT1		equ	($02)
EPDDR_IN2		equ	($00)
EPDDR_OUT2		equ	($04)
EPDDR_IN3		equ	($00)
EPDDR_OUT3		equ	($08)
EPDDR_IN4		equ	($00)
EPDDR_OUT4		equ	($10)
EPDDR_IN5		equ	($00)
EPDDR_OUT5		equ	($20)
EPDDR_IN6		equ	($00)
EPDDR_OUT6		equ	($40)
EPDDR_IN7		equ	($00)
EPDDR_OUT7		equ	($80)
EPIER_INT1		equ	($02)
EPIER_INT2		equ	($04)
EPIER_INT3		equ	($08)
EPIER_INT4		equ	($10)
EPIER_INT5		equ	($20)
EPIER_INT6		equ	($40)
EPIER_INT7		equ	($80)
EPDR_EPD1		equ	($02)
EPDR_EPD2		equ	($04)
EPDR_EPD3		equ	($08)
EPDR_EPD4		equ	($10)
EPDR_EPD5		equ	($20)
EPDR_EPD6		equ	($40)
EPDR_EPD7		equ	($80)
EPPDR_EPPD1		equ	($02)
EPPDR_EPPD2		equ	($04)
EPPDR_EPPD3		equ	($08)
EPPDR_EPPD4		equ	($10)
EPPDR_EPPD5		equ	($20)
EPPDR_EPPD6		equ	($40)
EPPDR_EPPD7		equ	($80)
EPFR_EPF1		equ	($02)
EPFR_EPF2		equ	($04)
EPFR_EPF3		equ	($08)
EPFR_EPF4		equ	($10)
EPFR_EPF5		equ	($20)
EPFR_EPF6		equ	($40)
EPFR_EPF7		equ	($80)

;* GPIO *
PAR_TIMER_TOUT2		equ	($01)
PAR_TIMER_TOUT3		equ	($08)
FPSC1PSC00		equ	($01)
FPSC1PSC01		equ	($02)
fPSC1PSC02		equ	($04)
FPSC1PSC03		equ	($08)
FPSC1PSC04		equ	($10)
FPSC1PSC05		equ	($20)
FPSC1PSC06		equ	($40)
FPSC1PSC07		equ	($80)
FPCIBG4			equ	($10)
FPCIBR4			equ	($10)


;* USB *
DRAMCR_DSIZE_MASK	equ	($00)
DRAMCR_DSIZE_SHIFT	equ	($00)
DRAMCR_DADR_MASK	equ	($00)

;*******************************************************************************
;*                                                                             *
;*  UART Registers                                                             *
;* Several UART registers contain overlapped information for receiving (reads) *
;* and transmitting (writes).  To see the programming process, please refer    *
;* to the User's manual.                                                       *
;*                                                                             *
;*******************************************************************************

;***********************************************************************
;*                                                                     *
;*  In the first register, UMR1 is for reads and UMR2 is for writes.   *
;*                                                                     *
;***********************************************************************

UART_UMR1_RXRTS                 equ     ($80)  ;Receive Request-to-Send *
UART_UMR1_RXIRQ                 equ     ($40)  ;Receive Interrupt Select     *
UART_UMR1_ERR                   equ     ($20)  ;Error Mode                   *
UART_UMR1_PM_MULTI_ADDR         equ     ($1C)  ;Parity: Multidrop Adr Char   *
UART_UMR1_PM_MULTI_DATA         equ     ($18)  ;Parity: Multidrop Data Char  *
UART_UMR1_PM_NONE               equ     ($10)  ;Parity: None                 *
UART_UMR1_PM_FORCE_HI           equ     ($0C)  ;Parity: Force High           *
UART_UMR1_PM_FORCE_LO           equ     ($08)  ;Parity: Force Low            *
UART_UMR1_PM_ODD                equ     ($04)  ;Parity: Odd Parity           *
UART_UMR1_PM_EVEN               equ     ($00)  ;Parity: Even Parity          *
UART_UMR1_BC_5                  equ     ($00)  ;5 Bits Per Character         *
UART_UMR1_BC_6                  equ     ($01)  ;6 Bits Per Character         *
UART_UMR1_BC_7                  equ     ($02)  ;7 Bits Per Character         *
UART_UMR1_BC_8                  equ     ($03)  ;8 Bits Per Character         *

UART_UMR2_CM_NORMAL             equ     ($00)  ;Normal Channel Mode          *
UART_UMR2_CM_ECHO               equ     ($40)  ;Automatic Echo Channel Mode  *
UART_UMR2_CM_LOCAL_LOOP         equ     ($80)  ;Local Loopback Channel Mode  *
UART_UMR2_CM_REMOTE_LOOP        equ     ($C0)  ;Remote Loopback Channel Mode *
UART_UMR2_TXRTS                 equ     ($20)  ;Transmitter Ready-to-Send    *
UART_UMR2_TXCTS                 equ     ($10)  ;Transmitter Clear-to-Send    *
UART_UMR2_STOP_BITS_2           equ     ($0F)  ;2 Stop Bits                  *
;UART_UMR2_STOP_BITS(a)          equ    ((a)&$0f)      ;Stop Bit Length      *

;***********************************************************************
;*                                                                     *
;*  In this next register, USR is for reads and UCSR is for writes.    *
;*                                                                     *
;***********************************************************************

UART_USR_RB                     equ     ($80)  ;Received Break               *
UART_USR_FE                     equ     ($40)  ;Framing Error                *
UART_USR_PE                     equ     ($20)  ;Parity Error                 *
UART_USR_OE                     equ     ($10)  ;Overrun Error                *
UART_USR_TXEMP                  equ     ($08)  ;Transmitter Empty            *
UART_USR_TXRDY                  equ     ($04)  ;Transmitter Ready            *
UART_USR_FFULL                  equ     ($02)  ;FIFO Full                    *
UART_USR_RXRDY                  equ     ($01)  ;Receiver Ready               *

UART_UCSR_9600_BPS              equ     ($BB)  ;9600 Baud w/ 3.6864 MHz clk  *
;UART_UCSR_RCS(a)                equ    (((a)&$0f)<<4) ;Receiver Clk Select  *
;UART_UCSR_TCS(a)                equ    ((a)&$0f) ;Transmitter Clock Select  *

;***********************************************************************
;*                                                                     *
;*  In this next register, there is only UCR is for writes.            *
;*                                                                     *
;***********************************************************************

UART_UCR_NONE                   equ     ($00)  ;No Command                   *
UART_UCR_STOP_BREAK             equ     ($70)  ;Stop Break                   *
UART_UCR_START_BREAK            equ     ($60)  ;Start Break                  *
UART_UCR_RESET_BKCHGINT         equ     ($50)  ;Reset Break-Change Interrupt *
UART_UCR_RESET_ERROR            equ     ($40)  ;Reset Error Status           *
UART_UCR_RESET_TX               equ     ($30)  ;Reset Transmitter            *
UART_UCR_RESET_RX               equ     ($20)  ;Reset Receiver               *
UART_UCR_RESET_MR               equ     ($10)  ;Reset Mode Register Pointer  *
UART_UCR_TX_DISABLED            equ     ($08)  ;Transmitter Disabled         *
UART_UCR_TX_ENABLED             equ     ($04)  ;Transmitter Enabled          *
UART_UCR_RX_DISABLED            equ     ($02)  ;Receiver Disabled            *
UART_UCR_RX_ENABLED             equ     ($01)  ;Receiver Enabled             *

;***********************************************************************
;*                                                                     *
;*  In this next register, UIPCR is for reads and UACR is for writes.  *
;*                                                                     *
;***********************************************************************

UART_UIPCR_COS                  equ     ($10)  ;Change-of-State at IPx input *
UART_UIPCR_CTS                  equ     ($01)  ;Current State of CTS pin     *

UART_UACR_BRG                   equ     ($80)  ;Set 2 of Baud Rate Generator *
UART_UACR_CTMS_TIMER            equ     ($60)  ;Timer Mode and Source Select *
;                                                        ;Must set this mode and src   *
UART_UACR_IEC                   equ     ($01)  ;Input Enable Control         *

;***********************************************************************
;*                                                                     *
;*  In this next register, UISR is for reads and UIMR is for writes.   *
;*                                                                     *
;***********************************************************************

UART_UISR_COS                   equ     ($80)  ;Change-of-State at CTS input *
UART_UISR_DB                    equ     ($04)  ;Receiver Has Detected Break  *
UART_UISR_RXRDY                 equ     ($02)  ;Receiver Ready or FIFO Full  *
UART_UISR_TXRDY                 equ     ($01)  ;Transmitter Ready            *

UART_UIMR_COS                   equ     ($80)  ;Enable Change-of-State Intpt *
UART_UIMR_DB                    equ     ($04)  ;Enable Delta Break Interrupt *
UART_UIMR_FFULL                 equ     ($02)  ;Enable FIFO Full Interrupt   *
UART_UIMR_TXRDY                 equ     ($01)  ;Enable Transmitter Rdy Intpt *

;*******************************************************************************
;*                                                                             *
;*  The last few registers can only be accessed as a read or write register.   *
;*                                                                             *
;*******************************************************************************

UART_UIP_CTS                    equ     ($01) ;Current State of CTS Input    *

UART_UOP_RTS                    equ     ($01) ;Sets All Bits on OP Bit Set   *
UART_UOP0_RTS                   equ     ($01) ;Clears All Bits on OP Bit Rst *


;************************************************************************
;*                                                                      *
;*  Parallel Port Registers                                             *
;*                                                                      *
;************************************************************************

PPORT_PADDR_15  equ     ($8000)        ;Bit 15 General I/O Output    *
PPORT_PADDR_14  equ     ($4000)        ;Bit 14 General I/O Output    *
PPORT_PADDR_13  equ     ($2000)        ;Bit 13 General I/O Output    *
PPORT_PADDR_12  equ     ($1000)        ;Bit 12 General I/O Output    *
PPORT_PADDR_11  equ     ($0800)        ;Bit 11 General I/O Output    *
PPORT_PADDR_10  equ     ($0400)        ;Bit 10 General I/O Output    *
PPORT_PADDR_9   equ     ($0200)        ;Bit  9 General I/O Output    *
PPORT_PADDR_8   equ     ($0100)        ;Bit  8 General I/O Output    *
PPORT_PADDR_7   equ     ($0080)        ;Bit  7 General I/O Output    *
PPORT_PADDR_6   equ     ($0040)        ;Bit  6 General I/O Output    *
PPORT_PADDR_5   equ     ($0020)        ;Bit  5 General I/O Output    *
PPORT_PADDR_4   equ     ($0010)        ;Bit  4 General I/O Output    *
PPORT_PADDR_3   equ     ($0008)        ;Bit  3 General I/O Output    *
PPORT_PADDR_2   equ     ($0004)        ;Bit  2 General I/O Output    *
PPORT_PADDR_1   equ     ($0002)        ;Bit  1 General I/O Output    *
PPORT_PADDR_0   equ     ($0001)        ;Bit  0 General I/O Output    *

PPORT_PADAT_15  equ       ($8000)        ;Bit 15 Current Status        *
PPORT_PADAT_14  equ     ($4000)        ;Bit 14 Current Status        *
PPORT_PADAT_13  equ     ($2000)        ;Bit 13 Current Status        *
PPORT_PADAT_12  equ     ($1000)        ;Bit 12 Current Status        *
PPORT_PADAT_11  equ     ($0800)        ;Bit 11 Current Status        *
PPORT_PADAT_10  equ     ($0400)        ;Bit 10 Current Status        *
PPORT_PADAT_9   equ     ($0200)        ;Bit  9 Current Status        *
PPORT_PADAT_8   equ     ($0100)        ;Bit  8 Current Status        *
PPORT_PADAT_7   equ     ($0080)        ;Bit  7 Current Status        *
PPORT_PADAT_6   equ     ($0040)        ;Bit  6 Current Status        *
PPORT_PADAT_5   equ     ($0020)        ;Bit  5 Current Status        *
PPORT_PADAT_4   equ     ($0010)        ;Bit  4 Current Status        *
PPORT_PADAT_3   equ     ($0008)        ;Bit  3 Current Status        *
PPORT_PADAT_2   equ     ($0004)        ;Bit  2 Current Status        *
PPORT_PADAT_1   equ     ($0002)        ;Bit  1 Current Status        *
PPORT_PADAT_0   equ     ($0001)        ;Bit  0 Current Status        *

;MBUS_MADR_ADDR(a)       equ    (((a)&$FE)<<$01) ;Slave Address     *

;MBUS_MFDR_MBC(a)        equ    ((a)&$3F)      ;M-Bus Clock Rate     *

MBUS_MBCR_MEN           equ     ($80)  ;M-Bus Enable                 *
MBUS_MBCR_MIEN          equ     ($40)  ;M-Bus Interrupt Enable       *
MBUS_MBCR_MSTA          equ     ($20)  ;Master/Slave Mode Select Bit *
MBUS_MBCR_MTX           equ     ($10)  ;Transmit/Rcv Mode Select Bit *
MBUS_MBCR_TXAK          equ     ($08)  ;Transmit Acknowledge Enable  *
MBUS_MBCR_RSTA          equ     ($04)  ;Repeat Start                 *

MBUS_MBSR_MCF           equ     ($80)  ;Data Transfer Complete       *
MBUS_MBSR_MAAS          equ     ($40)  ;Addressed as a Slave         *
MBUS_MBSR_MBB           equ     ($20)  ;Bus Busy                     *
MBUS_MBSR_MAL           equ     ($10)  ;Arbitration Lost             *
MBUS_MBSR_SRW           equ     ($04)  ;Slave Transmit               *
MBUS_MBSR_MIF           equ     ($02)  ;M-Bus Interrupt              *
MBUS_MBSR_RXAK          equ     ($01)  ;No Acknowledge Received      *


;************************************************************************
;*                                                                      *
;*  DMA Registers                                                       *
;*                                                                      *
************************************************************************


DMA_DCR_INT             equ     ($8000) ;Interrupt on Completion     *
DMA_DCR_EEXT            equ     ($4000) ;Enable External Request     *
DMA_DCR_CS              equ     ($2000) ;Cycle Steal                 *
DMA_DCR_AA              equ     ($1000) ;Auto Align                  *
DMA_DCR_BWC_DMA         equ     ($0000) ;Bandwidth: DMA Priority     *
DMA_DCR_BWC_512         equ     ($0200) ;Bandwidth:   512 Bytes      *
DMA_DCR_BWC_1024        equ     ($0400) ;Bandwidth:  1024 Bytes      *
DMA_DCR_BWC_2048        equ     ($0600) ;Bandwidth:  2048 Bytes      *
DMA_DCR_BWC_4096        equ     ($0800) ;Bandwidth:  4096 Bytes      *
DMA_DCR_BWC_8192        equ     ($0a00) ;Bandwidth:  8192 Bytes      *
DMA_DCR_BWC_16384       equ     ($0c00) ;Bandwidth: 16384 Bytes      *
DMA_DCR_BWC_32768       equ     ($0e00) ;Bandwidth: 32768 Bytes      *
DMA_DCR_SAA             equ     ($0100) ;Single Address Access       *
DMA_DCR_SRW             equ     ($0080) ;Forces MRW Signal High      *
DMA_DCR_SINC            equ     ($0040) ;Source Increment            *
DMA_DCR_SSIZE_LONG      equ     ($0000) ;Source Size:  Longword      *
DMA_DCR_SSIZE_BYTE      equ     ($0010) ;Source Size:  Byte          *
DMA_DCR_SSIZE_WORD      equ     ($0020) ;Source Size:  Word          *
DMA_DCR_SSIZE_LINE      equ     ($0030) ;Source Size:  Line          *
DMA_DCR_DINC            equ     ($0008) ;Destination Increment       *
DMA_DCR_DSIZE_LONG      equ     ($0000) ;Destination Size:  Longword *
DMA_DCR_DSIZE_BYTE      equ     ($0002) ;Destination Size:  Byte     *
DMA_DCR_DSIZE_WORD      equ     ($0004) ;Destination Size:  Word     *
DMA_DCR_START           equ     ($0001) ;Start Transfer              *

DMA_DSR_CE              equ     ($40)  ;Configuration Error          *
DMA_DSR_BES             equ     ($20)  ;Bus Error on Source          *
DMA_DSR_BED             equ     ($10)  ;Bus Error on Destination     *
DMA_DSR_REQ             equ     ($04)  ;Request                      *
DMA_DSR_BSY             equ     ($02)  ;Busy                         *
DMA_DSR_DONE            equ     ($01)  ;Transaction Done             *


