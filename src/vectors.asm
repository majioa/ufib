	xref exception_handler_src1
	xref exception_handler_src2
	xref exception_handler_src3
	xref exception_handler_src4
	xref exception_handler_src5
	xref exception_handler_src6
	xref exception_handler_src7
	xref exception_handler_src8
	xref exception_handler_src9
	xref exception_handler_src10
	xref exception_handler_src11
	xref exception_handler_src12
	xref exception_handler_src13
	xref exception_handler_src14
	xref exception_handler_src15
	xref exception_handler_src16
	xref exception_handler_src17
	xref exception_handler_src18
	xref exception_handler_src19
	xref exception_handler_src20
	xref exception_handler_src21
	xref exception_handler_src22
	xref exception_handler_src23
	xref exception_handler_src24
	xref exception_handler_src25
	xref exception_handler_src26
	xref exception_handler_src27
	xref exception_handler_src28
	xref exception_handler_src29
	xref exception_handler_src30
	xref exception_handler_src31
	xref exception_handler_src32
	xref exception_handler_src33
	xref exception_handler_src34
	xref exception_handler_src35
	xref exception_handler_src36
	xref exception_handler_src37
	xref exception_handler_src38
	xref exception_handler_src39
	xref exception_handler_src40
	xref exception_handler_src41
	xref exception_handler_src42
	xref exception_handler_src43
	xref exception_handler_src44
	xref exception_handler_src45
	xref exception_handler_src46
	xref exception_handler_src47
	xref exception_handler_src48
	xref exception_handler_src49
	xref exception_handler_src50
	xref exception_handler_src51
	xref exception_handler_src52
	xref exception_handler_src53
	xref exception_handler_src54
	xref exception_handler_src55
	xref exception_handler_src56
	xref exception_handler_src57
	xref exception_handler_src58
	xref exception_handler_src59
	xref exception_handler_src60
	xref exception_handler_src61
	xref exception_handler_src62
	xref exception_handler_src63

	xref __SP_INIT
	xref start
	xdef _VECTOR_TABLE


	boundary
;	section  data
; Exception vector Table

_VECTOR_TABLE:
;        org 0
        dc.l __SP_INIT                ;Initial SP
        dc.l start                    ;Initial PC
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

	boundary
;************************************************************
; ;This routine is the lowest-level exception handler	    *
;************************************************************

asm_exception_handler:

	rte

	boundary
