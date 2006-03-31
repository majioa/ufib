;*******************************************************************************
; File:    usb.asm
; Purpose: MCF548x usb driver
;*******************************************************************************
        include defines.inc

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

	;usb_init()
	;usb_connected = 1;
	;if(usb_connected = 0)
	;switch():
	;case usb_resume(); 
	;case usb_suspemd();
	;case usb_reset();
	;case usb_sof();
	;case usb_endpoint_interrupt()

_mcf_usb_init:
	;pll_set_div(PLL_24)
	;pll_enable();
	;usb_enable();
	;usb_detach();
	;delay5()
	;usb_attach();
	;delay5()
	;usb_configure_endpoint(0, CONTROL|MSK_EPEN);
	;usb_reset_endpoint(0);
	;usb_enable_ep_int(0);
	;usb_configuration_nb = 0;
	rts
	
_mcf_usb_resume:
	;usb_connected = 1;
	;usb_clear_suspend_clock();
	;usb_clear_suspend();
	;usb_clear_resume();
	;usb_clear_sof();
	rts

_mcf_usb_suspend:
	;usb_connected = 0;
	;usb_clear_suspend();
	;usb_set_suspend_clock();
	rts
	
_mcf_usb_reset:
	;usb_clear_reset();
	rts
	
_mcf_usb_sof:
	;usb_clear_sof();
	rts

_mcf_usb_endpoint_irq:
	;usb_select_ep(EP_CONTROL);
	;if(usb_setup_received())
	;usb_enumeration_process();
	jsr	_mcf_usb_enumeration

	rts

_mcf_usb_enumeration:
	;usb_select_ep(0)
	;usb_read_request();
	;read 1 and 2 bytes from FIFO0 - request
	;switch request
	;usb_get_status_device
	;usb_get_status_interface
	;usb_get_status_endpoint
	;usb_set_address
	;usb_get_descriptor - hardware
	;usb_get_configuration
	;usb_set_configuration
	;stall
	;L_ usb_clear_tx_setup()
	;L_ usb_set_stall_request()
	;L_ while(!usb_stall_sent())
	;L_ usb_clear_stall_request()
	;L_ usb_clear_stalled()
	;L_ usb_clear_dir()

	rts

_mcf_usb_irq:
	rte

        boundary
