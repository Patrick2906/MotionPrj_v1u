   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 123 void EXTI_DeInit(void)
  32                     ; 124 {
  34                     .text:	section	.text,new
  35  0000               _EXTI_DeInit:
  39                     ; 125   EXTI->CR1 = EXTI_CR1_RESET_VALUE;
  41  0000 725f50a0      	clr	20640
  42                     ; 126   EXTI->CR2 = EXTI_CR2_RESET_VALUE;
  44  0004 725f50a1      	clr	20641
  45                     ; 127   EXTI->CR3 = EXTI_CR3_RESET_VALUE;
  47  0008 725f50a2      	clr	20642
  48                     ; 128   EXTI->CR4 = EXTI_CR4_RESET_VALUE;
  50  000c 725f50aa      	clr	20650
  51                     ; 129   EXTI->SR1 = 0xFF; /* Setting SR1 bits in order to clear flags */
  53  0010 35ff50a3      	mov	20643,#255
  54                     ; 130   EXTI->SR2 = 0xFF; /* Setting SR2 bits in order to clear flags */
  56  0014 35ff50a4      	mov	20644,#255
  57                     ; 131   EXTI->CONF1 = EXTI_CONF1_RESET_VALUE;
  59  0018 725f50a5      	clr	20645
  60                     ; 132   EXTI->CONF2 = EXTI_CONF2_RESET_VALUE;
  62  001c 725f50ab      	clr	20651
  63                     ; 133 }
  66  0020 81            	ret
 212                     ; 160 void EXTI_SetPinSensitivity(EXTI_Pin_TypeDef EXTI_Pin, EXTI_Trigger_TypeDef EXTI_Trigger)
 212                     ; 161 {
 213                     .text:	section	.text,new
 214  0000               _EXTI_SetPinSensitivity:
 216  0000 89            	pushw	x
 217       00000000      OFST:	set	0
 220                     ; 164   assert_param(IS_EXTI_PINNUM(EXTI_Pin));
 222                     ; 165   assert_param(IS_EXTI_TRIGGER(EXTI_Trigger));
 224                     ; 168   switch (EXTI_Pin)
 226  0001 9e            	ld	a,xh
 228                     ; 202     default:
 228                     ; 203       break;
 229  0002 4d            	tnz	a
 230  0003 272f          	jreq	L12
 231  0005 a002          	sub	a,#2
 232  0007 274a          	jreq	L32
 233  0009 a002          	sub	a,#2
 234  000b 2765          	jreq	L52
 235  000d a002          	sub	a,#2
 236  000f 2603cc0091    	jreq	L72
 237  0014 a00a          	sub	a,#10
 238  0016 2603          	jrne	L05
 239  0018 cc00ae        	jp	L13
 240  001b               L05:
 241  001b a002          	sub	a,#2
 242  001d 2603          	jrne	L25
 243  001f cc00cd        	jp	L33
 244  0022               L25:
 245  0022 a002          	sub	a,#2
 246  0024 2603          	jrne	L45
 247  0026 cc00ec        	jp	L53
 248  0029               L45:
 249  0029 a002          	sub	a,#2
 250  002b 2603          	jrne	L65
 251  002d cc010b        	jp	L73
 252  0030               L65:
 253  0030 ac280128      	jpf	L721
 254  0034               L12:
 255                     ; 170     case EXTI_Pin_0:
 255                     ; 171       EXTI->CR1 &=  (uint8_t)(~EXTI_CR1_P0IS);
 257  0034 c650a0        	ld	a,20640
 258  0037 a4fc          	and	a,#252
 259  0039 c750a0        	ld	20640,a
 260                     ; 172       EXTI->CR1 |= (uint8_t)((uint8_t)(EXTI_Trigger) << EXTI_Pin);
 262  003c 7b01          	ld	a,(OFST+1,sp)
 263  003e 5f            	clrw	x
 264  003f 97            	ld	xl,a
 265  0040 7b02          	ld	a,(OFST+2,sp)
 266  0042 5d            	tnzw	x
 267  0043 2704          	jreq	L01
 268  0045               L21:
 269  0045 48            	sll	a
 270  0046 5a            	decw	x
 271  0047 26fc          	jrne	L21
 272  0049               L01:
 273  0049 ca50a0        	or	a,20640
 274  004c c750a0        	ld	20640,a
 275                     ; 173       break;
 277  004f ac280128      	jpf	L721
 278  0053               L32:
 279                     ; 174     case EXTI_Pin_1:
 279                     ; 175       EXTI->CR1 &=  (uint8_t)(~EXTI_CR1_P1IS);
 281  0053 c650a0        	ld	a,20640
 282  0056 a4f3          	and	a,#243
 283  0058 c750a0        	ld	20640,a
 284                     ; 176       EXTI->CR1 |= (uint8_t)((uint8_t)(EXTI_Trigger) << EXTI_Pin);
 286  005b 7b01          	ld	a,(OFST+1,sp)
 287  005d 5f            	clrw	x
 288  005e 97            	ld	xl,a
 289  005f 7b02          	ld	a,(OFST+2,sp)
 290  0061 5d            	tnzw	x
 291  0062 2704          	jreq	L41
 292  0064               L61:
 293  0064 48            	sll	a
 294  0065 5a            	decw	x
 295  0066 26fc          	jrne	L61
 296  0068               L41:
 297  0068 ca50a0        	or	a,20640
 298  006b c750a0        	ld	20640,a
 299                     ; 177       break;
 301  006e ac280128      	jpf	L721
 302  0072               L52:
 303                     ; 178     case EXTI_Pin_2:
 303                     ; 179       EXTI->CR1 &=  (uint8_t)(~EXTI_CR1_P2IS);
 305  0072 c650a0        	ld	a,20640
 306  0075 a4cf          	and	a,#207
 307  0077 c750a0        	ld	20640,a
 308                     ; 180       EXTI->CR1 |= (uint8_t)((uint8_t)(EXTI_Trigger) << EXTI_Pin);
 310  007a 7b01          	ld	a,(OFST+1,sp)
 311  007c 5f            	clrw	x
 312  007d 97            	ld	xl,a
 313  007e 7b02          	ld	a,(OFST+2,sp)
 314  0080 5d            	tnzw	x
 315  0081 2704          	jreq	L02
 316  0083               L22:
 317  0083 48            	sll	a
 318  0084 5a            	decw	x
 319  0085 26fc          	jrne	L22
 320  0087               L02:
 321  0087 ca50a0        	or	a,20640
 322  008a c750a0        	ld	20640,a
 323                     ; 181       break;
 325  008d ac280128      	jpf	L721
 326  0091               L72:
 327                     ; 182     case EXTI_Pin_3:
 327                     ; 183       EXTI->CR1 &=  (uint8_t)(~EXTI_CR1_P3IS);
 329  0091 c650a0        	ld	a,20640
 330  0094 a43f          	and	a,#63
 331  0096 c750a0        	ld	20640,a
 332                     ; 184       EXTI->CR1 |= (uint8_t)((uint8_t)(EXTI_Trigger) << EXTI_Pin);
 334  0099 7b01          	ld	a,(OFST+1,sp)
 335  009b 5f            	clrw	x
 336  009c 97            	ld	xl,a
 337  009d 7b02          	ld	a,(OFST+2,sp)
 338  009f 5d            	tnzw	x
 339  00a0 2704          	jreq	L42
 340  00a2               L62:
 341  00a2 48            	sll	a
 342  00a3 5a            	decw	x
 343  00a4 26fc          	jrne	L62
 344  00a6               L42:
 345  00a6 ca50a0        	or	a,20640
 346  00a9 c750a0        	ld	20640,a
 347                     ; 185       break;
 349  00ac 207a          	jra	L721
 350  00ae               L13:
 351                     ; 186     case EXTI_Pin_4:
 351                     ; 187       EXTI->CR2 &=  (uint8_t)(~EXTI_CR2_P4IS);
 353  00ae c650a1        	ld	a,20641
 354  00b1 a4fc          	and	a,#252
 355  00b3 c750a1        	ld	20641,a
 356                     ; 188       EXTI->CR2 |= (uint8_t)((uint8_t)(EXTI_Trigger) << ((uint8_t)EXTI_Pin & (uint8_t)0xEF));
 358  00b6 7b01          	ld	a,(OFST+1,sp)
 359  00b8 a4ef          	and	a,#239
 360  00ba 5f            	clrw	x
 361  00bb 97            	ld	xl,a
 362  00bc 7b02          	ld	a,(OFST+2,sp)
 363  00be 5d            	tnzw	x
 364  00bf 2704          	jreq	L03
 365  00c1               L23:
 366  00c1 48            	sll	a
 367  00c2 5a            	decw	x
 368  00c3 26fc          	jrne	L23
 369  00c5               L03:
 370  00c5 ca50a1        	or	a,20641
 371  00c8 c750a1        	ld	20641,a
 372                     ; 189       break;
 374  00cb 205b          	jra	L721
 375  00cd               L33:
 376                     ; 190     case EXTI_Pin_5:
 376                     ; 191       EXTI->CR2 &=  (uint8_t)(~EXTI_CR2_P5IS);
 378  00cd c650a1        	ld	a,20641
 379  00d0 a4f3          	and	a,#243
 380  00d2 c750a1        	ld	20641,a
 381                     ; 192       EXTI->CR2 |= (uint8_t)((uint8_t)(EXTI_Trigger) << ((uint8_t)EXTI_Pin & (uint8_t)0xEF));
 383  00d5 7b01          	ld	a,(OFST+1,sp)
 384  00d7 a4ef          	and	a,#239
 385  00d9 5f            	clrw	x
 386  00da 97            	ld	xl,a
 387  00db 7b02          	ld	a,(OFST+2,sp)
 388  00dd 5d            	tnzw	x
 389  00de 2704          	jreq	L43
 390  00e0               L63:
 391  00e0 48            	sll	a
 392  00e1 5a            	decw	x
 393  00e2 26fc          	jrne	L63
 394  00e4               L43:
 395  00e4 ca50a1        	or	a,20641
 396  00e7 c750a1        	ld	20641,a
 397                     ; 193       break;
 399  00ea 203c          	jra	L721
 400  00ec               L53:
 401                     ; 194     case EXTI_Pin_6:
 401                     ; 195       EXTI->CR2 &=  (uint8_t)(~EXTI_CR2_P6IS);
 403  00ec c650a1        	ld	a,20641
 404  00ef a4cf          	and	a,#207
 405  00f1 c750a1        	ld	20641,a
 406                     ; 196       EXTI->CR2 |= (uint8_t)((uint8_t)(EXTI_Trigger) << ((uint8_t)EXTI_Pin & (uint8_t)0xEF));
 408  00f4 7b01          	ld	a,(OFST+1,sp)
 409  00f6 a4ef          	and	a,#239
 410  00f8 5f            	clrw	x
 411  00f9 97            	ld	xl,a
 412  00fa 7b02          	ld	a,(OFST+2,sp)
 413  00fc 5d            	tnzw	x
 414  00fd 2704          	jreq	L04
 415  00ff               L24:
 416  00ff 48            	sll	a
 417  0100 5a            	decw	x
 418  0101 26fc          	jrne	L24
 419  0103               L04:
 420  0103 ca50a1        	or	a,20641
 421  0106 c750a1        	ld	20641,a
 422                     ; 197       break;
 424  0109 201d          	jra	L721
 425  010b               L73:
 426                     ; 198     case EXTI_Pin_7:
 426                     ; 199       EXTI->CR2 &=  (uint8_t)(~EXTI_CR2_P7IS);
 428  010b c650a1        	ld	a,20641
 429  010e a43f          	and	a,#63
 430  0110 c750a1        	ld	20641,a
 431                     ; 200       EXTI->CR2 |= (uint8_t)((uint8_t)(EXTI_Trigger) << ((uint8_t)EXTI_Pin & (uint8_t)0xEF));
 433  0113 7b01          	ld	a,(OFST+1,sp)
 434  0115 a4ef          	and	a,#239
 435  0117 5f            	clrw	x
 436  0118 97            	ld	xl,a
 437  0119 7b02          	ld	a,(OFST+2,sp)
 438  011b 5d            	tnzw	x
 439  011c 2704          	jreq	L44
 440  011e               L64:
 441  011e 48            	sll	a
 442  011f 5a            	decw	x
 443  0120 26fc          	jrne	L64
 444  0122               L44:
 445  0122 ca50a1        	or	a,20641
 446  0125 c750a1        	ld	20641,a
 447                     ; 201       break;
 449  0128               L14:
 450                     ; 202     default:
 450                     ; 203       break;
 452  0128               L721:
 453                     ; 205 }
 456  0128 85            	popw	x
 457  0129 81            	ret
 540                     ; 219 void EXTI_SelectPort(EXTI_Port_TypeDef EXTI_Port)
 540                     ; 220 {
 541                     .text:	section	.text,new
 542  0000               _EXTI_SelectPort:
 544  0000 88            	push	a
 545       00000000      OFST:	set	0
 548                     ; 222   assert_param(IS_EXTI_PORT(EXTI_Port));
 550                     ; 224   if (EXTI_Port == EXTI_Port_B)
 552  0001 4d            	tnz	a
 553  0002 2606          	jrne	L761
 554                     ; 227     EXTI->CONF2 &= (uint8_t) (~EXTI_CONF2_PGBS);
 556  0004 721b50ab      	bres	20651,#5
 558  0008 2034          	jra	L171
 559  000a               L761:
 560                     ; 229   else if (EXTI_Port == EXTI_Port_D)
 562  000a 7b01          	ld	a,(OFST+1,sp)
 563  000c a102          	cp	a,#2
 564  000e 2606          	jrne	L371
 565                     ; 232     EXTI->CONF2 &= (uint8_t) (~EXTI_CONF2_PHDS);
 567  0010 721d50ab      	bres	20651,#6
 569  0014 2028          	jra	L171
 570  0016               L371:
 571                     ; 234   else if (EXTI_Port == EXTI_Port_E)
 573  0016 7b01          	ld	a,(OFST+1,sp)
 574  0018 a104          	cp	a,#4
 575  001a 2606          	jrne	L771
 576                     ; 237     EXTI->CONF1 &= (uint8_t) (~EXTI_CONF1_PFES);
 578  001c 721f50a5      	bres	20645,#7
 580  0020 201c          	jra	L171
 581  0022               L771:
 582                     ; 239   else if (EXTI_Port == EXTI_Port_F)
 584  0022 7b01          	ld	a,(OFST+1,sp)
 585  0024 a106          	cp	a,#6
 586  0026 2606          	jrne	L302
 587                     ; 242     EXTI->CONF1 |= (uint8_t) (EXTI_CONF1_PFES);
 589  0028 721e50a5      	bset	20645,#7
 591  002c 2010          	jra	L171
 592  002e               L302:
 593                     ; 244   else if (EXTI_Port == EXTI_Port_G)
 595  002e 7b01          	ld	a,(OFST+1,sp)
 596  0030 a110          	cp	a,#16
 597  0032 2606          	jrne	L702
 598                     ; 247     EXTI->CONF2 |= (uint8_t) (EXTI_CONF2_PGBS);
 600  0034 721a50ab      	bset	20651,#5
 602  0038 2004          	jra	L171
 603  003a               L702:
 604                     ; 252     EXTI->CONF2 |= (uint8_t) (EXTI_CONF2_PHDS);
 606  003a 721c50ab      	bset	20651,#6
 607  003e               L171:
 608                     ; 254 }
 611  003e 84            	pop	a
 612  003f 81            	ret
 780                     ; 280 void EXTI_SetHalfPortSelection(EXTI_HalfPort_TypeDef EXTI_HalfPort,
 780                     ; 281                                FunctionalState NewState)
 780                     ; 282 {
 781                     .text:	section	.text,new
 782  0000               _EXTI_SetHalfPortSelection:
 784  0000 89            	pushw	x
 785       00000000      OFST:	set	0
 788                     ; 284   assert_param(IS_EXTI_HALFPORT(EXTI_HalfPort));
 790                     ; 285   assert_param(IS_FUNCTIONAL_STATE(NewState));
 792                     ; 287   if ((EXTI_HalfPort & 0x80) == 0x00)
 794  0001 9e            	ld	a,xh
 795  0002 a580          	bcp	a,#128
 796  0004 2619          	jrne	L103
 797                     ; 289     if (NewState != DISABLE)
 799  0006 0d02          	tnz	(OFST+2,sp)
 800  0008 270a          	jreq	L303
 801                     ; 292       EXTI->CONF1 |= (uint8_t)EXTI_HalfPort;
 803  000a c650a5        	ld	a,20645
 804  000d 1a01          	or	a,(OFST+1,sp)
 805  000f c750a5        	ld	20645,a
 807  0012 2026          	jra	L703
 808  0014               L303:
 809                     ; 297       EXTI->CONF1 &= (uint8_t)(~(uint8_t)EXTI_HalfPort);
 811  0014 7b01          	ld	a,(OFST+1,sp)
 812  0016 43            	cpl	a
 813  0017 c450a5        	and	a,20645
 814  001a c750a5        	ld	20645,a
 815  001d 201b          	jra	L703
 816  001f               L103:
 817                     ; 302     if (NewState != DISABLE)
 819  001f 0d02          	tnz	(OFST+2,sp)
 820  0021 270c          	jreq	L113
 821                     ; 305       EXTI->CONF2 |= (uint8_t)(EXTI_HalfPort & (uint8_t)0x7F);
 823  0023 7b01          	ld	a,(OFST+1,sp)
 824  0025 a47f          	and	a,#127
 825  0027 ca50ab        	or	a,20651
 826  002a c750ab        	ld	20651,a
 828  002d 200b          	jra	L703
 829  002f               L113:
 830                     ; 310       EXTI->CONF2 &= (uint8_t)(~(uint8_t) (EXTI_HalfPort & (uint8_t)0x7F));
 832  002f 7b01          	ld	a,(OFST+1,sp)
 833  0031 a47f          	and	a,#127
 834  0033 43            	cpl	a
 835  0034 c450ab        	and	a,20651
 836  0037 c750ab        	ld	20651,a
 837  003a               L703:
 838                     ; 313 }
 841  003a 85            	popw	x
 842  003b 81            	ret
 888                     ; 338 void EXTI_SetPortSensitivity(EXTI_Port_TypeDef EXTI_Port,
 888                     ; 339                              EXTI_Trigger_TypeDef EXTI_Trigger)
 888                     ; 340 {
 889                     .text:	section	.text,new
 890  0000               _EXTI_SetPortSensitivity:
 892  0000 89            	pushw	x
 893       00000000      OFST:	set	0
 896                     ; 342   assert_param(IS_EXTI_PORT(EXTI_Port));
 898                     ; 343   assert_param(IS_EXTI_TRIGGER(EXTI_Trigger));
 900                     ; 346   if ((EXTI_Port & 0xF0) == 0x00)
 902  0001 9e            	ld	a,xh
 903  0002 a5f0          	bcp	a,#240
 904  0004 2629          	jrne	L733
 905                     ; 349     EXTI->CR3 &= (uint8_t) (~(uint8_t)((uint8_t)0x03 << EXTI_Port));
 907  0006 7b01          	ld	a,(OFST+1,sp)
 908  0008 5f            	clrw	x
 909  0009 97            	ld	xl,a
 910  000a a603          	ld	a,#3
 911  000c 5d            	tnzw	x
 912  000d 2704          	jreq	L66
 913  000f               L07:
 914  000f 48            	sll	a
 915  0010 5a            	decw	x
 916  0011 26fc          	jrne	L07
 917  0013               L66:
 918  0013 43            	cpl	a
 919  0014 c450a2        	and	a,20642
 920  0017 c750a2        	ld	20642,a
 921                     ; 351     EXTI->CR3 |= (uint8_t)((uint8_t)(EXTI_Trigger) << EXTI_Port);
 923  001a 7b01          	ld	a,(OFST+1,sp)
 924  001c 5f            	clrw	x
 925  001d 97            	ld	xl,a
 926  001e 7b02          	ld	a,(OFST+2,sp)
 927  0020 5d            	tnzw	x
 928  0021 2704          	jreq	L27
 929  0023               L47:
 930  0023 48            	sll	a
 931  0024 5a            	decw	x
 932  0025 26fc          	jrne	L47
 933  0027               L27:
 934  0027 ca50a2        	or	a,20642
 935  002a c750a2        	ld	20642,a
 937  002d 202b          	jra	L143
 938  002f               L733:
 939                     ; 356     EXTI->CR4 &= (uint8_t) (~(uint8_t)((uint8_t)0x03 << (EXTI_Port & 0x0F)));
 941  002f 7b01          	ld	a,(OFST+1,sp)
 942  0031 a40f          	and	a,#15
 943  0033 5f            	clrw	x
 944  0034 97            	ld	xl,a
 945  0035 a603          	ld	a,#3
 946  0037 5d            	tnzw	x
 947  0038 2704          	jreq	L67
 948  003a               L001:
 949  003a 48            	sll	a
 950  003b 5a            	decw	x
 951  003c 26fc          	jrne	L001
 952  003e               L67:
 953  003e 43            	cpl	a
 954  003f c450aa        	and	a,20650
 955  0042 c750aa        	ld	20650,a
 956                     ; 358     EXTI->CR4 |= (uint8_t)(EXTI_Trigger << (EXTI_Port & 0x0F));
 958  0045 7b01          	ld	a,(OFST+1,sp)
 959  0047 a40f          	and	a,#15
 960  0049 5f            	clrw	x
 961  004a 97            	ld	xl,a
 962  004b 7b02          	ld	a,(OFST+2,sp)
 963  004d 5d            	tnzw	x
 964  004e 2704          	jreq	L201
 965  0050               L401:
 966  0050 48            	sll	a
 967  0051 5a            	decw	x
 968  0052 26fc          	jrne	L401
 969  0054               L201:
 970  0054 ca50aa        	or	a,20650
 971  0057 c750aa        	ld	20650,a
 972  005a               L143:
 973                     ; 360 }
 976  005a 85            	popw	x
 977  005b 81            	ret
1023                     ; 376 EXTI_Trigger_TypeDef EXTI_GetPinSensitivity(EXTI_Pin_TypeDef EXTI_Pin)
1023                     ; 377 {
1024                     .text:	section	.text,new
1025  0000               _EXTI_GetPinSensitivity:
1027  0000 88            	push	a
1028       00000001      OFST:	set	1
1031                     ; 378   uint8_t value = 0;
1033  0001 0f01          	clr	(OFST+0,sp)
1034                     ; 381   assert_param(IS_EXTI_PINNUM(EXTI_Pin));
1036                     ; 383   switch (EXTI_Pin)
1039                     ; 409     default:
1039                     ; 410       break;
1040  0003 4d            	tnz	a
1041  0004 271e          	jreq	L343
1042  0006 a002          	sub	a,#2
1043  0008 2723          	jreq	L543
1044  000a a002          	sub	a,#2
1045  000c 272a          	jreq	L743
1046  000e a002          	sub	a,#2
1047  0010 2732          	jreq	L153
1048  0012 a00a          	sub	a,#10
1049  0014 273c          	jreq	L353
1050  0016 a002          	sub	a,#2
1051  0018 2741          	jreq	L553
1052  001a a002          	sub	a,#2
1053  001c 2748          	jreq	L753
1054  001e a002          	sub	a,#2
1055  0020 2750          	jreq	L163
1056  0022 205a          	jra	L114
1057  0024               L343:
1058                     ; 385     case EXTI_Pin_0:
1058                     ; 386       value = (uint8_t)(EXTI->CR1 & EXTI_CR1_P0IS);
1060  0024 c650a0        	ld	a,20640
1061  0027 a403          	and	a,#3
1062  0029 6b01          	ld	(OFST+0,sp),a
1063                     ; 387       break;
1065  002b 2051          	jra	L114
1066  002d               L543:
1067                     ; 388     case EXTI_Pin_1:
1067                     ; 389       value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_P1IS) >> EXTI_Pin_1);
1069  002d c650a0        	ld	a,20640
1070  0030 a40c          	and	a,#12
1071  0032 44            	srl	a
1072  0033 44            	srl	a
1073  0034 6b01          	ld	(OFST+0,sp),a
1074                     ; 390       break;
1076  0036 2046          	jra	L114
1077  0038               L743:
1078                     ; 391     case EXTI_Pin_2:
1078                     ; 392       value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_P2IS) >> EXTI_Pin_2);
1080  0038 c650a0        	ld	a,20640
1081  003b a430          	and	a,#48
1082  003d 4e            	swap	a
1083  003e a40f          	and	a,#15
1084  0040 6b01          	ld	(OFST+0,sp),a
1085                     ; 393       break;
1087  0042 203a          	jra	L114
1088  0044               L153:
1089                     ; 394     case EXTI_Pin_3:
1089                     ; 395       value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_P3IS) >> EXTI_Pin_3);
1091  0044 c650a0        	ld	a,20640
1092  0047 a4c0          	and	a,#192
1093  0049 4e            	swap	a
1094  004a 44            	srl	a
1095  004b 44            	srl	a
1096  004c a403          	and	a,#3
1097  004e 6b01          	ld	(OFST+0,sp),a
1098                     ; 396       break;
1100  0050 202c          	jra	L114
1101  0052               L353:
1102                     ; 397     case EXTI_Pin_4:
1102                     ; 398       value = (uint8_t)(EXTI->CR2 & EXTI_CR2_P4IS);
1104  0052 c650a1        	ld	a,20641
1105  0055 a403          	and	a,#3
1106  0057 6b01          	ld	(OFST+0,sp),a
1107                     ; 399       break;
1109  0059 2023          	jra	L114
1110  005b               L553:
1111                     ; 400     case EXTI_Pin_5:
1111                     ; 401       value = (uint8_t)((uint8_t)(EXTI->CR2 & EXTI_CR2_P5IS) >> ((uint8_t)EXTI_Pin_5 & (uint8_t)0x0F));
1113  005b c650a1        	ld	a,20641
1114  005e a40c          	and	a,#12
1115  0060 44            	srl	a
1116  0061 44            	srl	a
1117  0062 6b01          	ld	(OFST+0,sp),a
1118                     ; 402       break;
1120  0064 2018          	jra	L114
1121  0066               L753:
1122                     ; 403     case EXTI_Pin_6:
1122                     ; 404       value = (uint8_t)((uint8_t)(EXTI->CR2 & EXTI_CR2_P6IS) >> ((uint8_t)EXTI_Pin_6 & (uint8_t)0x0F));
1124  0066 c650a1        	ld	a,20641
1125  0069 a430          	and	a,#48
1126  006b 4e            	swap	a
1127  006c a40f          	and	a,#15
1128  006e 6b01          	ld	(OFST+0,sp),a
1129                     ; 405       break;
1131  0070 200c          	jra	L114
1132  0072               L163:
1133                     ; 406     case EXTI_Pin_7:
1133                     ; 407       value = (uint8_t)((uint8_t)(EXTI->CR2 & EXTI_CR2_P7IS) >> ((uint8_t)EXTI_Pin_7 & (uint8_t)0x0F));
1135  0072 c650a1        	ld	a,20641
1136  0075 a4c0          	and	a,#192
1137  0077 4e            	swap	a
1138  0078 44            	srl	a
1139  0079 44            	srl	a
1140  007a a403          	and	a,#3
1141  007c 6b01          	ld	(OFST+0,sp),a
1142                     ; 408       break;
1144  007e               L363:
1145                     ; 409     default:
1145                     ; 410       break;
1147  007e               L114:
1148                     ; 412   return((EXTI_Trigger_TypeDef)value);
1150  007e 7b01          	ld	a,(OFST+0,sp)
1153  0080 5b01          	addw	sp,#1
1154  0082 81            	ret
1200                     ; 427 EXTI_Trigger_TypeDef EXTI_GetPortSensitivity(EXTI_Port_TypeDef EXTI_Port)
1200                     ; 428 {
1201                     .text:	section	.text,new
1202  0000               _EXTI_GetPortSensitivity:
1204  0000 88            	push	a
1205  0001 88            	push	a
1206       00000001      OFST:	set	1
1209                     ; 429   uint8_t portsensitivity = 0;
1211  0002 0f01          	clr	(OFST+0,sp)
1212                     ; 432   assert_param(IS_EXTI_PORT(EXTI_Port));
1214                     ; 435   if ((EXTI_Port & 0xF0) == 0x00)
1216  0004 a5f0          	bcp	a,#240
1217  0006 2614          	jrne	L534
1218                     ; 438     portsensitivity = (uint8_t)((uint8_t)0x03 & (uint8_t)(EXTI->CR3 >> EXTI_Port));
1220  0008 7b02          	ld	a,(OFST+1,sp)
1221  000a 5f            	clrw	x
1222  000b 97            	ld	xl,a
1223  000c c650a2        	ld	a,20642
1224  000f 5d            	tnzw	x
1225  0010 2704          	jreq	L211
1226  0012               L411:
1227  0012 44            	srl	a
1228  0013 5a            	decw	x
1229  0014 26fc          	jrne	L411
1230  0016               L211:
1231  0016 a403          	and	a,#3
1232  0018 6b01          	ld	(OFST+0,sp),a
1234  001a 2014          	jra	L734
1235  001c               L534:
1236                     ; 444     portsensitivity = (uint8_t)((uint8_t)0x03 & (uint8_t)(EXTI->CR4 >> (EXTI_Port & 0x0F)));
1238  001c 7b02          	ld	a,(OFST+1,sp)
1239  001e a40f          	and	a,#15
1240  0020 5f            	clrw	x
1241  0021 97            	ld	xl,a
1242  0022 c650aa        	ld	a,20650
1243  0025 5d            	tnzw	x
1244  0026 2704          	jreq	L611
1245  0028               L021:
1246  0028 44            	srl	a
1247  0029 5a            	decw	x
1248  002a 26fc          	jrne	L021
1249  002c               L611:
1250  002c a403          	and	a,#3
1251  002e 6b01          	ld	(OFST+0,sp),a
1252  0030               L734:
1253                     ; 447   return((EXTI_Trigger_TypeDef)portsensitivity);
1255  0030 7b01          	ld	a,(OFST+0,sp)
1258  0032 85            	popw	x
1259  0033 81            	ret
1429                     ; 487 ITStatus EXTI_GetITStatus(EXTI_IT_TypeDef EXTI_IT)
1429                     ; 488 {
1430                     .text:	section	.text,new
1431  0000               _EXTI_GetITStatus:
1433  0000 89            	pushw	x
1434  0001 88            	push	a
1435       00000001      OFST:	set	1
1438                     ; 489   ITStatus status = RESET;
1440  0002 0f01          	clr	(OFST+0,sp)
1441                     ; 491   assert_param(IS_EXTI_ITPENDINGBIT(EXTI_IT));
1443                     ; 493   if (((uint16_t)EXTI_IT & (uint16_t)0xFF00) == 0x0100)
1445  0004 01            	rrwa	x,a
1446  0005 9f            	ld	a,xl
1447  0006 a4ff          	and	a,#255
1448  0008 97            	ld	xl,a
1449  0009 4f            	clr	a
1450  000a 02            	rlwa	x,a
1451  000b a30100        	cpw	x,#256
1452  000e 260b          	jrne	L335
1453                     ; 495     status = (ITStatus)(EXTI->SR2 & (uint8_t)((uint16_t)EXTI_IT & (uint16_t)0x00FF));
1455  0010 7b03          	ld	a,(OFST+2,sp)
1456  0012 a4ff          	and	a,#255
1457  0014 c450a4        	and	a,20644
1458  0017 6b01          	ld	(OFST+0,sp),a
1460  0019 2009          	jra	L535
1461  001b               L335:
1462                     ; 499     status = (ITStatus)(EXTI->SR1 & ((uint8_t)((uint16_t)EXTI_IT & (uint16_t)0x00FF)));
1464  001b 7b03          	ld	a,(OFST+2,sp)
1465  001d a4ff          	and	a,#255
1466  001f c450a3        	and	a,20643
1467  0022 6b01          	ld	(OFST+0,sp),a
1468  0024               L535:
1469                     ; 501   return((ITStatus)status);
1471  0024 7b01          	ld	a,(OFST+0,sp)
1474  0026 5b03          	addw	sp,#3
1475  0028 81            	ret
1520                     ; 524 void EXTI_ClearITPendingBit(EXTI_IT_TypeDef EXTI_IT)
1520                     ; 525 {
1521                     .text:	section	.text,new
1522  0000               _EXTI_ClearITPendingBit:
1524  0000 89            	pushw	x
1525  0001 89            	pushw	x
1526       00000002      OFST:	set	2
1529                     ; 526   uint16_t tempvalue = 0;
1531  0002 5f            	clrw	x
1532  0003 1f01          	ldw	(OFST-1,sp),x
1533                     ; 529   assert_param(IS_EXTI_ITPENDINGBIT(EXTI_IT));
1535                     ; 531   tempvalue = ((uint16_t)EXTI_IT & (uint16_t)0xFF00);
1537  0005 7b03          	ld	a,(OFST+1,sp)
1538  0007 97            	ld	xl,a
1539  0008 7b04          	ld	a,(OFST+2,sp)
1540  000a 9f            	ld	a,xl
1541  000b a4ff          	and	a,#255
1542  000d 97            	ld	xl,a
1543  000e 4f            	clr	a
1544  000f 02            	rlwa	x,a
1545  0010 1f01          	ldw	(OFST-1,sp),x
1546  0012 01            	rrwa	x,a
1547                     ; 533   if ( tempvalue == 0x0100)
1549  0013 1e01          	ldw	x,(OFST-1,sp)
1550  0015 a30100        	cpw	x,#256
1551  0018 2609          	jrne	L165
1552                     ; 535     EXTI->SR2 = (uint8_t)((uint16_t)EXTI_IT & (uint16_t)0x00FF);
1554  001a 7b04          	ld	a,(OFST+2,sp)
1555  001c a4ff          	and	a,#255
1556  001e c750a4        	ld	20644,a
1558  0021 2005          	jra	L365
1559  0023               L165:
1560                     ; 539     EXTI->SR1 = (uint8_t) (EXTI_IT);
1562  0023 7b04          	ld	a,(OFST+2,sp)
1563  0025 c750a3        	ld	20643,a
1564  0028               L365:
1565                     ; 541 }
1568  0028 5b04          	addw	sp,#4
1569  002a 81            	ret
1582                     	xdef	_EXTI_ClearITPendingBit
1583                     	xdef	_EXTI_GetITStatus
1584                     	xdef	_EXTI_GetPortSensitivity
1585                     	xdef	_EXTI_GetPinSensitivity
1586                     	xdef	_EXTI_SetPortSensitivity
1587                     	xdef	_EXTI_SetHalfPortSelection
1588                     	xdef	_EXTI_SelectPort
1589                     	xdef	_EXTI_SetPinSensitivity
1590                     	xdef	_EXTI_DeInit
1609                     	end
