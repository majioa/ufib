; ****************************UFIB on MCF5485********************************

	; Simple extended code test for cfasm

	; -- origin
;	org	 $78000000

	; -- set cpu types. The types available are 5206, 5206e, 5272, 5307 and 5407
	;    Only cpu types with the mac unit will assemble this correctly.
;	 cpu	 5206e
	cpu	5485

	; -- sample structure. The zero value after the test1 is optional, as zero
	;    is a default. This value prefixes the first value in the structure.
      structure test1,0
	fixed	ts_value1
	float	ts_value2
	ulong	ts_value3
	label	ts_sizeof

_main
	fadd
	rts
	; -- use the boundary command to issue special segment code between
	;    the end of code and the start of data. This is used to prevent
	;    the look ahead function of the instruction cache obtaining
	;    invalid data and a possible lockup.
; --------------------------------------------------------------------------
	boundary
; --------------------------------------------------------------------------
