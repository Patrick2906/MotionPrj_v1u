   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 188                     ; 141 void I2C_DeInit(I2C_TypeDef* I2Cx)
 188                     ; 142 {
 190                     .text:	section	.text,new
 191  0000               _I2C_DeInit:
 195                     ; 143   I2Cx->CR1 = I2C_CR1_RESET_VALUE;
 197  0000 7f            	clr	(x)
 198                     ; 144   I2Cx->CR2 = I2C_CR2_RESET_VALUE;
 200  0001 6f01          	clr	(1,x)
 201                     ; 145   I2Cx->FREQR = I2C_FREQR_RESET_VALUE;
 203  0003 6f02          	clr	(2,x)
 204                     ; 146   I2Cx->OARL = I2C_OARL_RESET_VALUE;
 206  0005 6f03          	clr	(3,x)
 207                     ; 147   I2Cx->OARH = I2C_OARH_RESET_VALUE;
 209  0007 6f04          	clr	(4,x)
 210                     ; 148   I2Cx->OAR2 = I2C_OAR2_RESET_VALUE;
 212  0009 6f05          	clr	(5,x)
 213                     ; 149   I2Cx->ITR = I2C_ITR_RESET_VALUE;
 215  000b 6f0a          	clr	(10,x)
 216                     ; 150   I2Cx->CCRL = I2C_CCRL_RESET_VALUE;
 218  000d 6f0b          	clr	(11,x)
 219                     ; 151   I2Cx->CCRH = I2C_CCRH_RESET_VALUE;
 221  000f 6f0c          	clr	(12,x)
 222                     ; 152   I2Cx->TRISER = I2C_TRISER_RESET_VALUE;
 224  0011 a602          	ld	a,#2
 225  0013 e70d          	ld	(13,x),a
 226                     ; 153 }
 229  0015 81            	ret
 453                     .const:	section	.text
 454  0000               L01:
 455  0000 000f4240      	dc.l	1000000
 456  0004               L21:
 457  0004 000186a1      	dc.l	100001
 458  0008               L41:
 459  0008 00000004      	dc.l	4
 460                     ; 184 void I2C_Init(I2C_TypeDef* I2Cx, uint32_t OutputClockFrequency, uint16_t OwnAddress,
 460                     ; 185               I2C_Mode_TypeDef I2C_Mode, I2C_DutyCycle_TypeDef I2C_DutyCycle,
 460                     ; 186               I2C_Ack_TypeDef I2C_Ack, I2C_AcknowledgedAddress_TypeDef I2C_AcknowledgedAddress)
 460                     ; 187 {
 461                     .text:	section	.text,new
 462  0000               _I2C_Init:
 464  0000 89            	pushw	x
 465  0001 520c          	subw	sp,#12
 466       0000000c      OFST:	set	12
 469                     ; 188   uint32_t result = 0x0004;
 471  0003 96            	ldw	x,sp
 472  0004 1c0009        	addw	x,#OFST-3
 473  0007 cd0000        	call	c_ltor
 475                     ; 189   uint16_t tmpval = 0;
 477  000a 1e05          	ldw	x,(OFST-7,sp)
 478                     ; 190   uint8_t tmpccrh = 0;
 480  000c 0f07          	clr	(OFST-5,sp)
 481                     ; 191   uint8_t input_clock = 0;
 483  000e 7b08          	ld	a,(OFST-4,sp)
 484  0010 97            	ld	xl,a
 485                     ; 194   assert_param(IS_I2C_MODE(I2C_Mode));
 487                     ; 195   assert_param(IS_I2C_ACK_STATE(I2C_Ack));
 489                     ; 196   assert_param(IS_I2C_ACKNOWLEDGE_ADDRESS(I2C_AcknowledgedAddress));
 491                     ; 197   assert_param(IS_I2C_DUTY_CYCLE(I2C_DutyCycle));
 493                     ; 198   assert_param(IS_I2C_OWN_ADDRESS(OwnAddress));
 495                     ; 199   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ(OutputClockFrequency));
 497                     ; 203   input_clock = (uint8_t) (CLK_GetClockFreq() / 1000000);
 499  0011 cd0000        	call	_CLK_GetClockFreq
 501  0014 ae0000        	ldw	x,#L01
 502  0017 cd0000        	call	c_ludv
 504  001a b603          	ld	a,c_lreg+3
 505  001c 6b08          	ld	(OFST-4,sp),a
 506                     ; 207   I2Cx->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 508  001e 1e0d          	ldw	x,(OFST+1,sp)
 509  0020 e602          	ld	a,(2,x)
 510  0022 a4c0          	and	a,#192
 511  0024 e702          	ld	(2,x),a
 512                     ; 209   I2Cx->FREQR |= input_clock;
 514  0026 1e0d          	ldw	x,(OFST+1,sp)
 515  0028 e602          	ld	a,(2,x)
 516  002a 1a08          	or	a,(OFST-4,sp)
 517  002c e702          	ld	(2,x),a
 518                     ; 213   I2Cx->CR1 &= (uint8_t)(~I2C_CR1_PE);
 520  002e 1e0d          	ldw	x,(OFST+1,sp)
 521  0030 f6            	ld	a,(x)
 522  0031 a4fe          	and	a,#254
 523  0033 f7            	ld	(x),a
 524                     ; 216   I2Cx->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 526  0034 1e0d          	ldw	x,(OFST+1,sp)
 527  0036 e60c          	ld	a,(12,x)
 528  0038 a430          	and	a,#48
 529  003a e70c          	ld	(12,x),a
 530                     ; 217   I2Cx->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 532  003c 1e0d          	ldw	x,(OFST+1,sp)
 533  003e 6f0b          	clr	(11,x)
 534                     ; 220   if (OutputClockFrequency > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 536  0040 96            	ldw	x,sp
 537  0041 1c0011        	addw	x,#OFST+5
 538  0044 cd0000        	call	c_ltor
 540  0047 ae0004        	ldw	x,#L21
 541  004a cd0000        	call	c_lcmp
 543  004d 2403          	jruge	L02
 544  004f cc00ed        	jp	L362
 545  0052               L02:
 546                     ; 223     tmpccrh = I2C_CCRH_FS;
 548  0052 a680          	ld	a,#128
 549  0054 6b07          	ld	(OFST-5,sp),a
 550                     ; 225     if (I2C_DutyCycle == I2C_DutyCycle_2)
 552  0056 0d18          	tnz	(OFST+12,sp)
 553  0058 2633          	jrne	L562
 554                     ; 228       result = (uint32_t) ((input_clock * 1000000) / (OutputClockFrequency * 3));
 556  005a 96            	ldw	x,sp
 557  005b 1c0011        	addw	x,#OFST+5
 558  005e cd0000        	call	c_ltor
 560  0061 a603          	ld	a,#3
 561  0063 cd0000        	call	c_smul
 563  0066 96            	ldw	x,sp
 564  0067 1c0001        	addw	x,#OFST-11
 565  006a cd0000        	call	c_rtol
 567  006d 7b08          	ld	a,(OFST-4,sp)
 568  006f b703          	ld	c_lreg+3,a
 569  0071 3f02          	clr	c_lreg+2
 570  0073 3f01          	clr	c_lreg+1
 571  0075 3f00          	clr	c_lreg
 572  0077 ae0000        	ldw	x,#L01
 573  007a cd0000        	call	c_lmul
 575  007d 96            	ldw	x,sp
 576  007e 1c0001        	addw	x,#OFST-11
 577  0081 cd0000        	call	c_ludv
 579  0084 96            	ldw	x,sp
 580  0085 1c0009        	addw	x,#OFST-3
 581  0088 cd0000        	call	c_rtol
 584  008b 2037          	jra	L762
 585  008d               L562:
 586                     ; 233       result = (uint32_t) ((input_clock * 1000000) / (OutputClockFrequency * 25));
 588  008d 96            	ldw	x,sp
 589  008e 1c0011        	addw	x,#OFST+5
 590  0091 cd0000        	call	c_ltor
 592  0094 a619          	ld	a,#25
 593  0096 cd0000        	call	c_smul
 595  0099 96            	ldw	x,sp
 596  009a 1c0001        	addw	x,#OFST-11
 597  009d cd0000        	call	c_rtol
 599  00a0 7b08          	ld	a,(OFST-4,sp)
 600  00a2 b703          	ld	c_lreg+3,a
 601  00a4 3f02          	clr	c_lreg+2
 602  00a6 3f01          	clr	c_lreg+1
 603  00a8 3f00          	clr	c_lreg
 604  00aa ae0000        	ldw	x,#L01
 605  00ad cd0000        	call	c_lmul
 607  00b0 96            	ldw	x,sp
 608  00b1 1c0001        	addw	x,#OFST-11
 609  00b4 cd0000        	call	c_ludv
 611  00b7 96            	ldw	x,sp
 612  00b8 1c0009        	addw	x,#OFST-3
 613  00bb cd0000        	call	c_rtol
 615                     ; 235       tmpccrh |= I2C_CCRH_DUTY;
 617  00be 7b07          	ld	a,(OFST-5,sp)
 618  00c0 aa40          	or	a,#64
 619  00c2 6b07          	ld	(OFST-5,sp),a
 620  00c4               L762:
 621                     ; 239     if (result < (uint16_t)0x01)
 623  00c4 96            	ldw	x,sp
 624  00c5 1c0009        	addw	x,#OFST-3
 625  00c8 cd0000        	call	c_lzmp
 627  00cb 260a          	jrne	L172
 628                     ; 242       result = (uint16_t)0x0001;
 630  00cd ae0001        	ldw	x,#1
 631  00d0 1f0b          	ldw	(OFST-1,sp),x
 632  00d2 ae0000        	ldw	x,#0
 633  00d5 1f09          	ldw	(OFST-3,sp),x
 634  00d7               L172:
 635                     ; 248     tmpval = ((input_clock * 3) / 10) + 1;
 637  00d7 7b08          	ld	a,(OFST-4,sp)
 638  00d9 97            	ld	xl,a
 639  00da a603          	ld	a,#3
 640  00dc 42            	mul	x,a
 641  00dd a60a          	ld	a,#10
 642  00df cd0000        	call	c_sdivx
 644  00e2 5c            	incw	x
 645  00e3 1f05          	ldw	(OFST-7,sp),x
 646                     ; 249     I2Cx->TRISER = (uint8_t)tmpval;
 648  00e5 7b06          	ld	a,(OFST-6,sp)
 649  00e7 1e0d          	ldw	x,(OFST+1,sp)
 650  00e9 e70d          	ld	(13,x),a
 652  00eb 2059          	jra	L372
 653  00ed               L362:
 654                     ; 256     result = (uint16_t)((input_clock * 1000000) / (OutputClockFrequency << (uint8_t)1));
 656  00ed 96            	ldw	x,sp
 657  00ee 1c0011        	addw	x,#OFST+5
 658  00f1 cd0000        	call	c_ltor
 660  00f4 3803          	sll	c_lreg+3
 661  00f6 3902          	rlc	c_lreg+2
 662  00f8 3901          	rlc	c_lreg+1
 663  00fa 3900          	rlc	c_lreg
 664  00fc 96            	ldw	x,sp
 665  00fd 1c0001        	addw	x,#OFST-11
 666  0100 cd0000        	call	c_rtol
 668  0103 7b08          	ld	a,(OFST-4,sp)
 669  0105 b703          	ld	c_lreg+3,a
 670  0107 3f02          	clr	c_lreg+2
 671  0109 3f01          	clr	c_lreg+1
 672  010b 3f00          	clr	c_lreg
 673  010d ae0000        	ldw	x,#L01
 674  0110 cd0000        	call	c_lmul
 676  0113 96            	ldw	x,sp
 677  0114 1c0001        	addw	x,#OFST-11
 678  0117 cd0000        	call	c_ludv
 680  011a be02          	ldw	x,c_lreg+2
 681  011c cd0000        	call	c_uitolx
 683  011f 96            	ldw	x,sp
 684  0120 1c0009        	addw	x,#OFST-3
 685  0123 cd0000        	call	c_rtol
 687                     ; 259     if (result < (uint16_t)0x0004)
 689  0126 96            	ldw	x,sp
 690  0127 1c0009        	addw	x,#OFST-3
 691  012a cd0000        	call	c_ltor
 693  012d ae0008        	ldw	x,#L41
 694  0130 cd0000        	call	c_lcmp
 696  0133 240a          	jruge	L572
 697                     ; 262       result = (uint16_t)0x0004;
 699  0135 ae0004        	ldw	x,#4
 700  0138 1f0b          	ldw	(OFST-1,sp),x
 701  013a ae0000        	ldw	x,#0
 702  013d 1f09          	ldw	(OFST-3,sp),x
 703  013f               L572:
 704                     ; 268     I2Cx->TRISER = (uint8_t)((uint8_t)input_clock + (uint8_t)1);
 706  013f 7b08          	ld	a,(OFST-4,sp)
 707  0141 4c            	inc	a
 708  0142 1e0d          	ldw	x,(OFST+1,sp)
 709  0144 e70d          	ld	(13,x),a
 710  0146               L372:
 711                     ; 273   I2Cx->CCRL = (uint8_t)result;
 713  0146 7b0c          	ld	a,(OFST+0,sp)
 714  0148 1e0d          	ldw	x,(OFST+1,sp)
 715  014a e70b          	ld	(11,x),a
 716                     ; 274   I2Cx->CCRH = (uint8_t)((uint8_t)((uint8_t)((uint8_t)result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 718  014c 7b07          	ld	a,(OFST-5,sp)
 719  014e 1e0d          	ldw	x,(OFST+1,sp)
 720  0150 e70c          	ld	(12,x),a
 721                     ; 277   I2Cx->CR1 |= (uint8_t)(I2C_CR1_PE | I2C_Mode);
 723  0152 1e0d          	ldw	x,(OFST+1,sp)
 724  0154 7b17          	ld	a,(OFST+11,sp)
 725  0156 aa01          	or	a,#1
 726  0158 fa            	or	a,(x)
 727  0159 f7            	ld	(x),a
 728                     ; 280   I2Cx->CR2 |= (uint8_t)I2C_Ack;
 730  015a 1e0d          	ldw	x,(OFST+1,sp)
 731  015c e601          	ld	a,(1,x)
 732  015e 1a19          	or	a,(OFST+13,sp)
 733  0160 e701          	ld	(1,x),a
 734                     ; 283   I2Cx->OARL = (uint8_t)(OwnAddress);
 736  0162 7b16          	ld	a,(OFST+10,sp)
 737  0164 1e0d          	ldw	x,(OFST+1,sp)
 738  0166 e703          	ld	(3,x),a
 739                     ; 284   I2Cx->OARH = (uint8_t)((uint8_t)(I2C_AcknowledgedAddress | I2C_OARH_ADDCONF ) | \
 739                     ; 285                          (uint8_t)((uint16_t)( (uint16_t)OwnAddress &  (uint16_t)0x0300) >> 7));
 741  0168 7b15          	ld	a,(OFST+9,sp)
 742  016a 97            	ld	xl,a
 743  016b 7b16          	ld	a,(OFST+10,sp)
 744  016d 9f            	ld	a,xl
 745  016e a403          	and	a,#3
 746  0170 97            	ld	xl,a
 747  0171 4f            	clr	a
 748  0172 02            	rlwa	x,a
 749  0173 a607          	ld	a,#7
 750  0175               L61:
 751  0175 54            	srlw	x
 752  0176 4a            	dec	a
 753  0177 26fc          	jrne	L61
 754  0179 9f            	ld	a,xl
 755  017a 6b04          	ld	(OFST-8,sp),a
 756  017c 7b1a          	ld	a,(OFST+14,sp)
 757  017e aa40          	or	a,#64
 758  0180 1a04          	or	a,(OFST-8,sp)
 759  0182 1e0d          	ldw	x,(OFST+1,sp)
 760  0184 e704          	ld	(4,x),a
 761                     ; 286 }
 764  0186 5b0e          	addw	sp,#14
 765  0188 81            	ret
 832                     ; 295 void I2C_Cmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
 832                     ; 296 {
 833                     .text:	section	.text,new
 834  0000               _I2C_Cmd:
 836  0000 89            	pushw	x
 837       00000000      OFST:	set	0
 840                     ; 299   assert_param(IS_FUNCTIONAL_STATE(NewState));
 842                     ; 301   if (NewState != DISABLE)
 844  0001 0d05          	tnz	(OFST+5,sp)
 845  0003 2706          	jreq	L333
 846                     ; 304     I2Cx->CR1 |= I2C_CR1_PE;
 848  0005 f6            	ld	a,(x)
 849  0006 aa01          	or	a,#1
 850  0008 f7            	ld	(x),a
 852  0009 2006          	jra	L533
 853  000b               L333:
 854                     ; 309     I2Cx->CR1 &= (uint8_t)(~I2C_CR1_PE);
 856  000b 1e01          	ldw	x,(OFST+1,sp)
 857  000d f6            	ld	a,(x)
 858  000e a4fe          	and	a,#254
 859  0010 f7            	ld	(x),a
 860  0011               L533:
 861                     ; 311 }
 864  0011 85            	popw	x
 865  0012 81            	ret
 912                     ; 320 void I2C_GeneralCallCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
 912                     ; 321 {
 913                     .text:	section	.text,new
 914  0000               _I2C_GeneralCallCmd:
 916  0000 89            	pushw	x
 917       00000000      OFST:	set	0
 920                     ; 324   assert_param(IS_FUNCTIONAL_STATE(NewState));
 922                     ; 326   if (NewState != DISABLE)
 924  0001 0d05          	tnz	(OFST+5,sp)
 925  0003 2706          	jreq	L363
 926                     ; 329     I2Cx->CR1 |= I2C_CR1_ENGC;
 928  0005 f6            	ld	a,(x)
 929  0006 aa40          	or	a,#64
 930  0008 f7            	ld	(x),a
 932  0009 2006          	jra	L563
 933  000b               L363:
 934                     ; 334     I2Cx->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 936  000b 1e01          	ldw	x,(OFST+1,sp)
 937  000d f6            	ld	a,(x)
 938  000e a4bf          	and	a,#191
 939  0010 f7            	ld	(x),a
 940  0011               L563:
 941                     ; 336 }
 944  0011 85            	popw	x
 945  0012 81            	ret
 992                     ; 347 void I2C_GenerateSTART(I2C_TypeDef* I2Cx, FunctionalState NewState)
 992                     ; 348 {
 993                     .text:	section	.text,new
 994  0000               _I2C_GenerateSTART:
 996  0000 89            	pushw	x
 997       00000000      OFST:	set	0
1000                     ; 351   assert_param(IS_FUNCTIONAL_STATE(NewState));
1002                     ; 353   if (NewState != DISABLE)
1004  0001 0d05          	tnz	(OFST+5,sp)
1005  0003 2708          	jreq	L314
1006                     ; 356     I2Cx->CR2 |= I2C_CR2_START;
1008  0005 e601          	ld	a,(1,x)
1009  0007 aa01          	or	a,#1
1010  0009 e701          	ld	(1,x),a
1012  000b 2008          	jra	L514
1013  000d               L314:
1014                     ; 361     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_START);
1016  000d 1e01          	ldw	x,(OFST+1,sp)
1017  000f e601          	ld	a,(1,x)
1018  0011 a4fe          	and	a,#254
1019  0013 e701          	ld	(1,x),a
1020  0015               L514:
1021                     ; 363 }
1024  0015 85            	popw	x
1025  0016 81            	ret
1072                     ; 372 void I2C_GenerateSTOP(I2C_TypeDef* I2Cx, FunctionalState NewState)
1072                     ; 373 {
1073                     .text:	section	.text,new
1074  0000               _I2C_GenerateSTOP:
1076  0000 89            	pushw	x
1077       00000000      OFST:	set	0
1080                     ; 376   assert_param(IS_FUNCTIONAL_STATE(NewState));
1082                     ; 378   if (NewState != DISABLE)
1084  0001 0d05          	tnz	(OFST+5,sp)
1085  0003 2708          	jreq	L344
1086                     ; 381     I2Cx->CR2 |= I2C_CR2_STOP;
1088  0005 e601          	ld	a,(1,x)
1089  0007 aa02          	or	a,#2
1090  0009 e701          	ld	(1,x),a
1092  000b 2008          	jra	L544
1093  000d               L344:
1094                     ; 386     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_STOP);
1096  000d 1e01          	ldw	x,(OFST+1,sp)
1097  000f e601          	ld	a,(1,x)
1098  0011 a4fd          	and	a,#253
1099  0013 e701          	ld	(1,x),a
1100  0015               L544:
1101                     ; 388 }
1104  0015 85            	popw	x
1105  0016 81            	ret
1153                     ; 397 void I2C_SoftwareResetCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
1153                     ; 398 {
1154                     .text:	section	.text,new
1155  0000               _I2C_SoftwareResetCmd:
1157  0000 89            	pushw	x
1158       00000000      OFST:	set	0
1161                     ; 400   assert_param(IS_FUNCTIONAL_STATE(NewState));
1163                     ; 402   if (NewState != DISABLE)
1165  0001 0d05          	tnz	(OFST+5,sp)
1166  0003 2708          	jreq	L374
1167                     ; 405     I2Cx->CR2 |= I2C_CR2_SWRST;
1169  0005 e601          	ld	a,(1,x)
1170  0007 aa80          	or	a,#128
1171  0009 e701          	ld	(1,x),a
1173  000b 2008          	jra	L574
1174  000d               L374:
1175                     ; 410     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
1177  000d 1e01          	ldw	x,(OFST+1,sp)
1178  000f e601          	ld	a,(1,x)
1179  0011 a47f          	and	a,#127
1180  0013 e701          	ld	(1,x),a
1181  0015               L574:
1182                     ; 412 }
1185  0015 85            	popw	x
1186  0016 81            	ret
1234                     ; 421 void I2C_StretchClockCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
1234                     ; 422 {
1235                     .text:	section	.text,new
1236  0000               _I2C_StretchClockCmd:
1238  0000 89            	pushw	x
1239       00000000      OFST:	set	0
1242                     ; 424   assert_param(IS_FUNCTIONAL_STATE(NewState));
1244                     ; 426   if (NewState != DISABLE)
1246  0001 0d05          	tnz	(OFST+5,sp)
1247  0003 2706          	jreq	L325
1248                     ; 429     I2Cx->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
1250  0005 f6            	ld	a,(x)
1251  0006 a47f          	and	a,#127
1252  0008 f7            	ld	(x),a
1254  0009 2006          	jra	L525
1255  000b               L325:
1256                     ; 435     I2Cx->CR1 |= I2C_CR1_NOSTRETCH;
1258  000b 1e01          	ldw	x,(OFST+1,sp)
1259  000d f6            	ld	a,(x)
1260  000e aa80          	or	a,#128
1261  0010 f7            	ld	(x),a
1262  0011               L525:
1263                     ; 437 }
1266  0011 85            	popw	x
1267  0012 81            	ret
1314                     ; 446 void I2C_ARPCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
1314                     ; 447 {
1315                     .text:	section	.text,new
1316  0000               _I2C_ARPCmd:
1318  0000 89            	pushw	x
1319       00000000      OFST:	set	0
1322                     ; 449   assert_param(IS_FUNCTIONAL_STATE(NewState));
1324                     ; 451   if (NewState != DISABLE)
1326  0001 0d05          	tnz	(OFST+5,sp)
1327  0003 2706          	jreq	L355
1328                     ; 454     I2Cx->CR1 |= I2C_CR1_ARP;
1330  0005 f6            	ld	a,(x)
1331  0006 aa10          	or	a,#16
1332  0008 f7            	ld	(x),a
1334  0009 2006          	jra	L555
1335  000b               L355:
1336                     ; 460     I2Cx->CR1 &= (uint8_t)(~I2C_CR1_ARP);
1338  000b 1e01          	ldw	x,(OFST+1,sp)
1339  000d f6            	ld	a,(x)
1340  000e a4ef          	and	a,#239
1341  0010 f7            	ld	(x),a
1342  0011               L555:
1343                     ; 462 }
1346  0011 85            	popw	x
1347  0012 81            	ret
1395                     ; 471 void I2C_AcknowledgeConfig(I2C_TypeDef* I2Cx, FunctionalState NewState)
1395                     ; 472 {
1396                     .text:	section	.text,new
1397  0000               _I2C_AcknowledgeConfig:
1399  0000 89            	pushw	x
1400       00000000      OFST:	set	0
1403                     ; 474   assert_param(IS_FUNCTIONAL_STATE(NewState));
1405                     ; 476   if (NewState != DISABLE)
1407  0001 0d05          	tnz	(OFST+5,sp)
1408  0003 2708          	jreq	L306
1409                     ; 479     I2Cx->CR2 |= I2C_CR2_ACK;
1411  0005 e601          	ld	a,(1,x)
1412  0007 aa04          	or	a,#4
1413  0009 e701          	ld	(1,x),a
1415  000b 2008          	jra	L506
1416  000d               L306:
1417                     ; 484     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_ACK);
1419  000d 1e01          	ldw	x,(OFST+1,sp)
1420  000f e601          	ld	a,(1,x)
1421  0011 a4fb          	and	a,#251
1422  0013 e701          	ld	(1,x),a
1423  0015               L506:
1424                     ; 486 }
1427  0015 85            	popw	x
1428  0016 81            	ret
1484                     ; 494 void I2C_OwnAddress2Config(I2C_TypeDef* I2Cx, uint8_t Address)
1484                     ; 495 {
1485                     .text:	section	.text,new
1486  0000               _I2C_OwnAddress2Config:
1488  0000 89            	pushw	x
1489  0001 88            	push	a
1490       00000001      OFST:	set	1
1493                     ; 496   uint8_t tmpreg = 0;
1495  0002 0f01          	clr	(OFST+0,sp)
1496                     ; 499   tmpreg = I2Cx->OAR2;
1498  0004 e605          	ld	a,(5,x)
1499  0006 6b01          	ld	(OFST+0,sp),a
1500                     ; 502   tmpreg &= (uint8_t)(~I2C_OAR2_ADD2);
1502  0008 7b01          	ld	a,(OFST+0,sp)
1503  000a a401          	and	a,#1
1504  000c 6b01          	ld	(OFST+0,sp),a
1505                     ; 505   tmpreg |= (uint8_t) ((uint8_t)Address & (uint8_t)0xFE);
1507  000e 7b06          	ld	a,(OFST+5,sp)
1508  0010 a4fe          	and	a,#254
1509  0012 1a01          	or	a,(OFST+0,sp)
1510  0014 6b01          	ld	(OFST+0,sp),a
1511                     ; 508   I2Cx->OAR2 = tmpreg;
1513  0016 7b01          	ld	a,(OFST+0,sp)
1514  0018 1e02          	ldw	x,(OFST+1,sp)
1515  001a e705          	ld	(5,x),a
1516                     ; 509 }
1519  001c 5b03          	addw	sp,#3
1520  001e 81            	ret
1567                     ; 518 void I2C_DualAddressCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
1567                     ; 519 {
1568                     .text:	section	.text,new
1569  0000               _I2C_DualAddressCmd:
1571  0000 89            	pushw	x
1572       00000000      OFST:	set	0
1575                     ; 521   assert_param(IS_FUNCTIONAL_STATE(NewState));
1577                     ; 523   if (NewState != DISABLE)
1579  0001 0d05          	tnz	(OFST+5,sp)
1580  0003 2708          	jreq	L366
1581                     ; 526     I2Cx->OAR2 |= I2C_OAR2_ENDUAL;
1583  0005 e605          	ld	a,(5,x)
1584  0007 aa01          	or	a,#1
1585  0009 e705          	ld	(5,x),a
1587  000b 2008          	jra	L566
1588  000d               L366:
1589                     ; 531     I2Cx->OAR2 &= (uint8_t)(~I2C_OAR2_ENDUAL);
1591  000d 1e01          	ldw	x,(OFST+1,sp)
1592  000f e605          	ld	a,(5,x)
1593  0011 a4fe          	and	a,#254
1594  0013 e705          	ld	(5,x),a
1595  0015               L566:
1596                     ; 533 }
1599  0015 85            	popw	x
1600  0016 81            	ret
1670                     ; 545 void I2C_AckPositionConfig(I2C_TypeDef* I2Cx, I2C_AckPosition_TypeDef I2C_AckPosition)
1670                     ; 546 {
1671                     .text:	section	.text,new
1672  0000               _I2C_AckPositionConfig:
1674  0000 89            	pushw	x
1675       00000000      OFST:	set	0
1678                     ; 548   assert_param(IS_I2C_ACK_POSITION(I2C_AckPosition));
1680                     ; 551   I2Cx->CR2 &= (uint8_t)(~I2C_CR2_POS);
1682  0001 e601          	ld	a,(1,x)
1683  0003 a4f7          	and	a,#247
1684  0005 e701          	ld	(1,x),a
1685                     ; 553   I2Cx->CR2 |= (uint8_t)I2C_AckPosition;
1687  0007 e601          	ld	a,(1,x)
1688  0009 1a05          	or	a,(OFST+5,sp)
1689  000b e701          	ld	(1,x),a
1690                     ; 554 }
1693  000d 85            	popw	x
1694  000e 81            	ret
1763                     ; 565 void I2C_SMBusAlertConfig(I2C_TypeDef* I2Cx, I2C_SMBusAlert_TypeDef I2C_SMBusAlert)
1763                     ; 566 {
1764                     .text:	section	.text,new
1765  0000               _I2C_SMBusAlertConfig:
1767  0000 89            	pushw	x
1768       00000000      OFST:	set	0
1771                     ; 569   assert_param(IS_I2C_SMBUS_ALERT(I2C_SMBusAlert));
1773                     ; 571   if (I2C_SMBusAlert != I2C_SMBusAlert_High)
1775  0001 0d05          	tnz	(OFST+5,sp)
1776  0003 2708          	jreq	L757
1777                     ; 574     I2Cx->CR2 |= (uint8_t)I2C_CR2_ALERT;
1779  0005 e601          	ld	a,(1,x)
1780  0007 aa20          	or	a,#32
1781  0009 e701          	ld	(1,x),a
1783  000b 2008          	jra	L167
1784  000d               L757:
1785                     ; 579     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_ALERT);
1787  000d 1e01          	ldw	x,(OFST+1,sp)
1788  000f e601          	ld	a,(1,x)
1789  0011 a4df          	and	a,#223
1790  0013 e701          	ld	(1,x),a
1791  0015               L167:
1792                     ; 581 }
1795  0015 85            	popw	x
1796  0016 81            	ret
1844                     ; 592 void I2C_FastModeDutyCycleConfig(I2C_TypeDef* I2Cx, I2C_DutyCycle_TypeDef I2C_DutyCycle)
1844                     ; 593 {
1845                     .text:	section	.text,new
1846  0000               _I2C_FastModeDutyCycleConfig:
1848  0000 89            	pushw	x
1849       00000000      OFST:	set	0
1852                     ; 596   assert_param(IS_I2C_DUTY_CYCLE(I2C_DutyCycle));
1854                     ; 598   if (I2C_DutyCycle == I2C_DutyCycle_16_9)
1856  0001 7b05          	ld	a,(OFST+5,sp)
1857  0003 a140          	cp	a,#64
1858  0005 2608          	jrne	L7001
1859                     ; 601     I2Cx->CCRH |= I2C_CCRH_DUTY;
1861  0007 e60c          	ld	a,(12,x)
1862  0009 aa40          	or	a,#64
1863  000b e70c          	ld	(12,x),a
1865  000d 2008          	jra	L1101
1866  000f               L7001:
1867                     ; 606     I2Cx->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1869  000f 1e01          	ldw	x,(OFST+1,sp)
1870  0011 e60c          	ld	a,(12,x)
1871  0013 a4bf          	and	a,#191
1872  0015 e70c          	ld	(12,x),a
1873  0017               L1101:
1874                     ; 608 }
1877  0017 85            	popw	x
1878  0018 81            	ret
1957                     ; 621 void I2C_Send7bitAddress(I2C_TypeDef* I2Cx, uint8_t Address, I2C_Direction_TypeDef I2C_Direction)
1957                     ; 622 {
1958                     .text:	section	.text,new
1959  0000               _I2C_Send7bitAddress:
1961  0000 89            	pushw	x
1962       00000000      OFST:	set	0
1965                     ; 624   assert_param(IS_I2C_ADDRESS(Address));
1967                     ; 625   assert_param(IS_I2C_DIRECTION(I2C_Direction));
1969                     ; 628   if (I2C_Direction != I2C_Direction_Transmitter)
1971  0001 0d06          	tnz	(OFST+6,sp)
1972  0003 2708          	jreq	L3501
1973                     ; 631     Address |= OAR1_ADD0_Set;
1975  0005 7b05          	ld	a,(OFST+5,sp)
1976  0007 aa01          	or	a,#1
1977  0009 6b05          	ld	(OFST+5,sp),a
1979  000b 2006          	jra	L5501
1980  000d               L3501:
1981                     ; 636     Address &= OAR1_ADD0_Reset;
1983  000d 7b05          	ld	a,(OFST+5,sp)
1984  000f a4fe          	and	a,#254
1985  0011 6b05          	ld	(OFST+5,sp),a
1986  0013               L5501:
1987                     ; 639   I2Cx->DR = Address;
1989  0013 7b05          	ld	a,(OFST+5,sp)
1990  0015 1e01          	ldw	x,(OFST+1,sp)
1991  0017 e706          	ld	(6,x),a
1992                     ; 640 }
1995  0019 85            	popw	x
1996  001a 81            	ret
2042                     ; 664 void I2C_SendData(I2C_TypeDef* I2Cx, uint8_t Data)
2042                     ; 665 {
2043                     .text:	section	.text,new
2044  0000               _I2C_SendData:
2046  0000 89            	pushw	x
2047       00000000      OFST:	set	0
2050                     ; 667   I2Cx->DR = Data;
2052  0001 7b05          	ld	a,(OFST+5,sp)
2053  0003 1e01          	ldw	x,(OFST+1,sp)
2054  0005 e706          	ld	(6,x),a
2055                     ; 668 }
2058  0007 85            	popw	x
2059  0008 81            	ret
2096                     ; 676 uint8_t I2C_ReceiveData(I2C_TypeDef* I2Cx)
2096                     ; 677 {
2097                     .text:	section	.text,new
2098  0000               _I2C_ReceiveData:
2102                     ; 679   return ((uint8_t)I2Cx->DR);
2104  0000 e606          	ld	a,(6,x)
2107  0002 81            	ret
2154                     ; 705 void I2C_TransmitPEC(I2C_TypeDef* I2Cx, FunctionalState NewState)
2154                     ; 706 {
2155                     .text:	section	.text,new
2156  0000               _I2C_TransmitPEC:
2158  0000 89            	pushw	x
2159       00000000      OFST:	set	0
2162                     ; 708   assert_param(IS_FUNCTIONAL_STATE(NewState));
2164                     ; 710   if (NewState != DISABLE)
2166  0001 0d05          	tnz	(OFST+5,sp)
2167  0003 2708          	jreq	L7411
2168                     ; 713     I2Cx->CR2 |= I2C_CR2_PEC;
2170  0005 e601          	ld	a,(1,x)
2171  0007 aa10          	or	a,#16
2172  0009 e701          	ld	(1,x),a
2174  000b 2008          	jra	L1511
2175  000d               L7411:
2176                     ; 718     I2Cx->CR2 &= (uint8_t)(~I2C_CR2_PEC);
2178  000d 1e01          	ldw	x,(OFST+1,sp)
2179  000f e601          	ld	a,(1,x)
2180  0011 a4ef          	and	a,#239
2181  0013 e701          	ld	(1,x),a
2182  0015               L1511:
2183                     ; 720 }
2186  0015 85            	popw	x
2187  0016 81            	ret
2234                     ; 729 void I2C_CalculatePEC(I2C_TypeDef* I2Cx, FunctionalState NewState)
2234                     ; 730 {
2235                     .text:	section	.text,new
2236  0000               _I2C_CalculatePEC:
2238  0000 89            	pushw	x
2239       00000000      OFST:	set	0
2242                     ; 732   assert_param(IS_FUNCTIONAL_STATE(NewState));
2244                     ; 734   if (NewState != DISABLE)
2246  0001 0d05          	tnz	(OFST+5,sp)
2247  0003 2706          	jreq	L7711
2248                     ; 737     I2Cx->CR1 |= I2C_CR1_ENPEC;
2250  0005 f6            	ld	a,(x)
2251  0006 aa20          	or	a,#32
2252  0008 f7            	ld	(x),a
2254  0009 2006          	jra	L1021
2255  000b               L7711:
2256                     ; 742     I2Cx->CR1 &= (uint8_t)(~I2C_CR1_ENPEC);
2258  000b 1e01          	ldw	x,(OFST+1,sp)
2259  000d f6            	ld	a,(x)
2260  000e a4df          	and	a,#223
2261  0010 f7            	ld	(x),a
2262  0011               L1021:
2263                     ; 744 }
2266  0011 85            	popw	x
2267  0012 81            	ret
2337                     ; 755 void I2C_PECPositionConfig(I2C_TypeDef* I2Cx, I2C_PECPosition_TypeDef I2C_PECPosition)
2337                     ; 756 {
2338                     .text:	section	.text,new
2339  0000               _I2C_PECPositionConfig:
2341  0000 89            	pushw	x
2342       00000000      OFST:	set	0
2345                     ; 758   assert_param(IS_I2C_PEC_POSITION(I2C_PECPosition));
2347                     ; 761   I2Cx->CR2 &= (uint8_t)(~I2C_CR2_POS);
2349  0001 e601          	ld	a,(1,x)
2350  0003 a4f7          	and	a,#247
2351  0005 e701          	ld	(1,x),a
2352                     ; 763   I2Cx->CR2 |= (uint8_t)I2C_PECPosition;
2354  0007 e601          	ld	a,(1,x)
2355  0009 1a05          	or	a,(OFST+5,sp)
2356  000b e701          	ld	(1,x),a
2357                     ; 764 }
2360  000d 85            	popw	x
2361  000e 81            	ret
2398                     ; 772 uint8_t I2C_GetPEC(I2C_TypeDef* I2Cx)
2398                     ; 773 {
2399                     .text:	section	.text,new
2400  0000               _I2C_GetPEC:
2404                     ; 775   return (I2Cx->PECR);
2406  0000 e60e          	ld	a,(14,x)
2409  0002 81            	ret
2456                     ; 803 void I2C_DMACmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
2456                     ; 804 {
2457                     .text:	section	.text,new
2458  0000               _I2C_DMACmd:
2460  0000 89            	pushw	x
2461       00000000      OFST:	set	0
2464                     ; 806   assert_param(IS_FUNCTIONAL_STATE(NewState));
2466                     ; 808   if (NewState != DISABLE)
2468  0001 0d05          	tnz	(OFST+5,sp)
2469  0003 2708          	jreq	L3031
2470                     ; 811     I2Cx->ITR |= I2C_ITR_DMAEN;
2472  0005 e60a          	ld	a,(10,x)
2473  0007 aa08          	or	a,#8
2474  0009 e70a          	ld	(10,x),a
2476  000b 2008          	jra	L5031
2477  000d               L3031:
2478                     ; 816     I2Cx->ITR &= (uint8_t)(~I2C_ITR_DMAEN);
2480  000d 1e01          	ldw	x,(OFST+1,sp)
2481  000f e60a          	ld	a,(10,x)
2482  0011 a4f7          	and	a,#247
2483  0013 e70a          	ld	(10,x),a
2484  0015               L5031:
2485                     ; 818 }
2488  0015 85            	popw	x
2489  0016 81            	ret
2537                     ; 827 void I2C_DMALastTransferCmd(I2C_TypeDef* I2Cx, FunctionalState NewState)
2537                     ; 828 {
2538                     .text:	section	.text,new
2539  0000               _I2C_DMALastTransferCmd:
2541  0000 89            	pushw	x
2542       00000000      OFST:	set	0
2545                     ; 830   assert_param(IS_FUNCTIONAL_STATE(NewState));
2547                     ; 832   if (NewState != DISABLE)
2549  0001 0d05          	tnz	(OFST+5,sp)
2550  0003 2708          	jreq	L3331
2551                     ; 835     I2Cx->ITR |= I2C_ITR_LAST;
2553  0005 e60a          	ld	a,(10,x)
2554  0007 aa10          	or	a,#16
2555  0009 e70a          	ld	(10,x),a
2557  000b 2008          	jra	L5331
2558  000d               L3331:
2559                     ; 840     I2Cx->ITR &= (uint8_t)(~I2C_ITR_LAST);
2561  000d 1e01          	ldw	x,(OFST+1,sp)
2562  000f e60a          	ld	a,(10,x)
2563  0011 a4ef          	and	a,#239
2564  0013 e70a          	ld	(10,x),a
2565  0015               L5331:
2566                     ; 842 }
2569  0015 85            	popw	x
2570  0016 81            	ret
2759                     ; 954 void I2C_ITConfig(I2C_TypeDef* I2Cx, I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
2759                     ; 955 {
2760                     .text:	section	.text,new
2761  0000               _I2C_ITConfig:
2763  0000 89            	pushw	x
2764       00000000      OFST:	set	0
2767                     ; 957   assert_param(IS_I2C_CONFIG_IT(I2C_IT));
2769                     ; 958   assert_param(IS_FUNCTIONAL_STATE(NewState));
2771                     ; 960   if (NewState != DISABLE)
2773  0001 0d07          	tnz	(OFST+7,sp)
2774  0003 2708          	jreq	L7341
2775                     ; 963     I2Cx->ITR |= (uint8_t)I2C_IT;
2777  0005 e60a          	ld	a,(10,x)
2778  0007 1a06          	or	a,(OFST+6,sp)
2779  0009 e70a          	ld	(10,x),a
2781  000b 2009          	jra	L1441
2782  000d               L7341:
2783                     ; 968     I2Cx->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
2785  000d 1e01          	ldw	x,(OFST+1,sp)
2786  000f 7b06          	ld	a,(OFST+6,sp)
2787  0011 43            	cpl	a
2788  0012 e40a          	and	a,(10,x)
2789  0014 e70a          	ld	(10,x),a
2790  0016               L1441:
2791                     ; 970 }
2794  0016 85            	popw	x
2795  0017 81            	ret
2956                     ; 994 uint8_t I2C_ReadRegister(I2C_TypeDef* I2Cx, I2C_Register_TypeDef I2C_Register)
2956                     ; 995 {
2957                     .text:	section	.text,new
2958  0000               _I2C_ReadRegister:
2960  0000 89            	pushw	x
2961  0001 5204          	subw	sp,#4
2962       00000004      OFST:	set	4
2965                     ; 996   __IO uint16_t tmp = 0;
2967  0003 5f            	clrw	x
2968  0004 1f03          	ldw	(OFST-1,sp),x
2969                     ; 998   assert_param(IS_I2C_REGISTER(I2C_Register));
2971                     ; 1000   tmp = (uint16_t) I2Cx;
2973  0006 1e05          	ldw	x,(OFST+1,sp)
2974  0008 1f03          	ldw	(OFST-1,sp),x
2975                     ; 1001   tmp += I2C_Register;
2977  000a 7b09          	ld	a,(OFST+5,sp)
2978  000c 5f            	clrw	x
2979  000d 97            	ld	xl,a
2980  000e 1f01          	ldw	(OFST-3,sp),x
2981  0010 1e03          	ldw	x,(OFST-1,sp)
2982  0012 72fb01        	addw	x,(OFST-3,sp)
2983  0015 1f03          	ldw	(OFST-1,sp),x
2984                     ; 1004   return (*(__IO uint8_t *) tmp);
2986  0017 1e03          	ldw	x,(OFST-1,sp)
2987  0019 f6            	ld	a,(x)
2990  001a 5b06          	addw	sp,#6
2991  001c 81            	ret
3245                     ; 1044 ErrorStatus I2C_CheckEvent(I2C_TypeDef* I2Cx, I2C_Event_TypeDef I2C_Event)
3245                     ; 1045 {
3246                     .text:	section	.text,new
3247  0000               _I2C_CheckEvent:
3249  0000 89            	pushw	x
3250  0001 5206          	subw	sp,#6
3251       00000006      OFST:	set	6
3254                     ; 1046   __IO uint16_t lastevent = 0x00;
3256  0003 5f            	clrw	x
3257  0004 1f04          	ldw	(OFST-2,sp),x
3258                     ; 1047   uint8_t flag1 = 0x00 ;
3260  0006 7b03          	ld	a,(OFST-3,sp)
3261  0008 97            	ld	xl,a
3262                     ; 1048   uint8_t flag2 = 0x00;
3264  0009 7b06          	ld	a,(OFST+0,sp)
3265  000b 97            	ld	xl,a
3266                     ; 1049   ErrorStatus status = ERROR;
3268  000c 7b06          	ld	a,(OFST+0,sp)
3269  000e 97            	ld	xl,a
3270                     ; 1052   assert_param(IS_I2C_EVENT(I2C_Event));
3272                     ; 1054   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
3274  000f 1e0b          	ldw	x,(OFST+5,sp)
3275  0011 a30004        	cpw	x,#4
3276  0014 260c          	jrne	L5561
3277                     ; 1056     lastevent = I2Cx->SR2 & I2C_SR2_AF;
3279  0016 1e07          	ldw	x,(OFST+1,sp)
3280  0018 e608          	ld	a,(8,x)
3281  001a a404          	and	a,#4
3282  001c 5f            	clrw	x
3283  001d 97            	ld	xl,a
3284  001e 1f04          	ldw	(OFST-2,sp),x
3286  0020 2021          	jra	L7561
3287  0022               L5561:
3288                     ; 1060     flag1 = I2Cx->SR1;
3290  0022 1e07          	ldw	x,(OFST+1,sp)
3291  0024 e607          	ld	a,(7,x)
3292  0026 6b03          	ld	(OFST-3,sp),a
3293                     ; 1061     flag2 = I2Cx->SR3;
3295  0028 1e07          	ldw	x,(OFST+1,sp)
3296  002a e609          	ld	a,(9,x)
3297  002c 6b06          	ld	(OFST+0,sp),a
3298                     ; 1062     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
3300  002e 7b03          	ld	a,(OFST-3,sp)
3301  0030 5f            	clrw	x
3302  0031 97            	ld	xl,a
3303  0032 1f01          	ldw	(OFST-5,sp),x
3304  0034 7b06          	ld	a,(OFST+0,sp)
3305  0036 5f            	clrw	x
3306  0037 97            	ld	xl,a
3307  0038 4f            	clr	a
3308  0039 02            	rlwa	x,a
3309  003a 01            	rrwa	x,a
3310  003b 1a02          	or	a,(OFST-4,sp)
3311  003d 01            	rrwa	x,a
3312  003e 1a01          	or	a,(OFST-5,sp)
3313  0040 01            	rrwa	x,a
3314  0041 1f04          	ldw	(OFST-2,sp),x
3315  0043               L7561:
3316                     ; 1065   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
3318  0043 1e04          	ldw	x,(OFST-2,sp)
3319  0045 01            	rrwa	x,a
3320  0046 140c          	and	a,(OFST+6,sp)
3321  0048 01            	rrwa	x,a
3322  0049 140b          	and	a,(OFST+5,sp)
3323  004b 01            	rrwa	x,a
3324  004c 130b          	cpw	x,(OFST+5,sp)
3325  004e 2606          	jrne	L1661
3326                     ; 1068     status = SUCCESS;
3328  0050 a601          	ld	a,#1
3329  0052 6b06          	ld	(OFST+0,sp),a
3331  0054 2002          	jra	L3661
3332  0056               L1661:
3333                     ; 1073     status = ERROR;
3335  0056 0f06          	clr	(OFST+0,sp)
3336  0058               L3661:
3337                     ; 1077   return status;
3339  0058 7b06          	ld	a,(OFST+0,sp)
3342  005a 5b08          	addw	sp,#8
3343  005c 81            	ret
3408                     ; 1095 I2C_Event_TypeDef I2C_GetLastEvent(I2C_TypeDef* I2Cx)
3408                     ; 1096 {
3409                     .text:	section	.text,new
3410  0000               _I2C_GetLastEvent:
3412  0000 89            	pushw	x
3413  0001 5206          	subw	sp,#6
3414       00000006      OFST:	set	6
3417                     ; 1097   __IO uint16_t lastevent = 0;
3419  0003 5f            	clrw	x
3420  0004 1f05          	ldw	(OFST-1,sp),x
3421                     ; 1098   uint16_t flag1 = 0;
3423  0006 1e01          	ldw	x,(OFST-5,sp)
3424                     ; 1099   uint16_t flag2 = 0;
3426  0008 1e03          	ldw	x,(OFST-3,sp)
3427                     ; 1101   if ((I2Cx->SR2 & I2C_SR2_AF) != 0x00)
3429  000a 1e07          	ldw	x,(OFST+1,sp)
3430  000c e608          	ld	a,(8,x)
3431  000e a504          	bcp	a,#4
3432  0010 2707          	jreq	L1271
3433                     ; 1103     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
3435  0012 ae0004        	ldw	x,#4
3436  0015 1f05          	ldw	(OFST-1,sp),x
3438  0017 201d          	jra	L3271
3439  0019               L1271:
3440                     ; 1108     flag1 = I2Cx->SR1;
3442  0019 1e07          	ldw	x,(OFST+1,sp)
3443  001b e607          	ld	a,(7,x)
3444  001d 5f            	clrw	x
3445  001e 97            	ld	xl,a
3446  001f 1f01          	ldw	(OFST-5,sp),x
3447                     ; 1109     flag2 = I2Cx->SR3;
3449  0021 1e07          	ldw	x,(OFST+1,sp)
3450  0023 e609          	ld	a,(9,x)
3451  0025 5f            	clrw	x
3452  0026 97            	ld	xl,a
3453  0027 1f03          	ldw	(OFST-3,sp),x
3454                     ; 1112     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
3456  0029 1e03          	ldw	x,(OFST-3,sp)
3457  002b 4f            	clr	a
3458  002c 02            	rlwa	x,a
3459  002d 01            	rrwa	x,a
3460  002e 1a02          	or	a,(OFST-4,sp)
3461  0030 01            	rrwa	x,a
3462  0031 1a01          	or	a,(OFST-5,sp)
3463  0033 01            	rrwa	x,a
3464  0034 1f05          	ldw	(OFST-1,sp),x
3465  0036               L3271:
3466                     ; 1115   return (I2C_Event_TypeDef)lastevent;
3468  0036 1e05          	ldw	x,(OFST-1,sp)
3471  0038 5b08          	addw	sp,#8
3472  003a 81            	ret
3729                     ; 1152 FlagStatus I2C_GetFlagStatus(I2C_TypeDef* I2Cx, I2C_FLAG_TypeDef I2C_FLAG)
3729                     ; 1153 {
3730                     .text:	section	.text,new
3731  0000               _I2C_GetFlagStatus:
3733  0000 89            	pushw	x
3734  0001 89            	pushw	x
3735       00000002      OFST:	set	2
3738                     ; 1154   uint8_t tempreg = 0;
3740  0002 0f02          	clr	(OFST+0,sp)
3741                     ; 1155   uint8_t regindex = 0;
3743  0004 7b01          	ld	a,(OFST-1,sp)
3744  0006 97            	ld	xl,a
3745                     ; 1156   FlagStatus bitstatus = RESET;
3747  0007 7b02          	ld	a,(OFST+0,sp)
3748  0009 97            	ld	xl,a
3749                     ; 1159   assert_param(IS_I2C_GET_FLAG(I2C_FLAG));
3751                     ; 1162   regindex = (uint8_t)((uint16_t)I2C_FLAG >> 8);
3753  000a 7b07          	ld	a,(OFST+5,sp)
3754  000c 6b01          	ld	(OFST-1,sp),a
3755                     ; 1164   switch (regindex)
3757  000e 7b01          	ld	a,(OFST-1,sp)
3759                     ; 1181     default:
3759                     ; 1182       break;
3760  0010 4a            	dec	a
3761  0011 2708          	jreq	L5271
3762  0013 4a            	dec	a
3763  0014 270d          	jreq	L7271
3764  0016 4a            	dec	a
3765  0017 2712          	jreq	L1371
3766  0019 2016          	jra	L7602
3767  001b               L5271:
3768                     ; 1167     case 0x01:
3768                     ; 1168       tempreg = (uint8_t)I2Cx->SR1;
3770  001b 1e03          	ldw	x,(OFST+1,sp)
3771  001d e607          	ld	a,(7,x)
3772  001f 6b02          	ld	(OFST+0,sp),a
3773                     ; 1169       break;
3775  0021 200e          	jra	L7602
3776  0023               L7271:
3777                     ; 1172     case 0x02:
3777                     ; 1173       tempreg = (uint8_t)I2Cx->SR2;
3779  0023 1e03          	ldw	x,(OFST+1,sp)
3780  0025 e608          	ld	a,(8,x)
3781  0027 6b02          	ld	(OFST+0,sp),a
3782                     ; 1174       break;
3784  0029 2006          	jra	L7602
3785  002b               L1371:
3786                     ; 1177     case 0x03:
3786                     ; 1178       tempreg = (uint8_t)I2Cx->SR3;
3788  002b 1e03          	ldw	x,(OFST+1,sp)
3789  002d e609          	ld	a,(9,x)
3790  002f 6b02          	ld	(OFST+0,sp),a
3791                     ; 1179       break;
3793  0031               L3371:
3794                     ; 1181     default:
3794                     ; 1182       break;
3796  0031               L7602:
3797                     ; 1186   if ((tempreg & (uint8_t)I2C_FLAG ) != 0)
3799  0031 7b08          	ld	a,(OFST+6,sp)
3800  0033 1502          	bcp	a,(OFST+0,sp)
3801  0035 2706          	jreq	L1702
3802                     ; 1189     bitstatus = SET;
3804  0037 a601          	ld	a,#1
3805  0039 6b02          	ld	(OFST+0,sp),a
3807  003b 2002          	jra	L3702
3808  003d               L1702:
3809                     ; 1194     bitstatus = RESET;
3811  003d 0f02          	clr	(OFST+0,sp)
3812  003f               L3702:
3813                     ; 1197   return bitstatus;
3815  003f 7b02          	ld	a,(OFST+0,sp)
3818  0041 5b04          	addw	sp,#4
3819  0043 81            	ret
3875                     ; 1229 void I2C_ClearFlag(I2C_TypeDef* I2Cx, I2C_FLAG_TypeDef I2C_FLAG)
3875                     ; 1230 {
3876                     .text:	section	.text,new
3877  0000               _I2C_ClearFlag:
3879  0000 89            	pushw	x
3880  0001 89            	pushw	x
3881       00000002      OFST:	set	2
3884                     ; 1231   uint16_t flagpos = 0;
3886  0002 5f            	clrw	x
3887  0003 1f01          	ldw	(OFST-1,sp),x
3888                     ; 1233   assert_param(IS_I2C_CLEAR_FLAG(I2C_FLAG));
3890                     ; 1236   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
3892  0005 7b07          	ld	a,(OFST+5,sp)
3893  0007 97            	ld	xl,a
3894  0008 7b08          	ld	a,(OFST+6,sp)
3895  000a a4ff          	and	a,#255
3896  000c 5f            	clrw	x
3897  000d 02            	rlwa	x,a
3898  000e 1f01          	ldw	(OFST-1,sp),x
3899  0010 01            	rrwa	x,a
3900                     ; 1238   I2Cx->SR2 = (uint8_t)((uint16_t)(~flagpos));
3902  0011 7b02          	ld	a,(OFST+0,sp)
3903  0013 43            	cpl	a
3904  0014 1e03          	ldw	x,(OFST+1,sp)
3905  0016 e708          	ld	(8,x),a
3906                     ; 1239 }
3909  0018 5b04          	addw	sp,#4
3910  001a 81            	ret
3986                     ; 1264 ITStatus I2C_GetITStatus(I2C_TypeDef* I2Cx, I2C_IT_TypeDef I2C_IT)
3986                     ; 1265 {
3987                     .text:	section	.text,new
3988  0000               _I2C_GetITStatus:
3990  0000 89            	pushw	x
3991  0001 5204          	subw	sp,#4
3992       00000004      OFST:	set	4
3995                     ; 1266   ITStatus bitstatus = RESET;
3997  0003 7b04          	ld	a,(OFST+0,sp)
3998  0005 97            	ld	xl,a
3999                     ; 1267   __IO uint8_t enablestatus = 0;
4001  0006 0f03          	clr	(OFST-1,sp)
4002                     ; 1268   uint16_t tempregister = 0;
4004  0008 1e01          	ldw	x,(OFST-3,sp)
4005                     ; 1271   assert_param(IS_I2C_GET_IT(I2C_IT));
4007                     ; 1273   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_IT & ITEN_Mask)) >> 8);
4009  000a 7b09          	ld	a,(OFST+5,sp)
4010  000c 97            	ld	xl,a
4011  000d 7b0a          	ld	a,(OFST+6,sp)
4012  000f 9f            	ld	a,xl
4013  0010 a407          	and	a,#7
4014  0012 97            	ld	xl,a
4015  0013 4f            	clr	a
4016  0014 02            	rlwa	x,a
4017  0015 4f            	clr	a
4018  0016 01            	rrwa	x,a
4019  0017 9f            	ld	a,xl
4020  0018 5f            	clrw	x
4021  0019 97            	ld	xl,a
4022  001a 1f01          	ldw	(OFST-3,sp),x
4023                     ; 1276   enablestatus = (uint8_t)(I2Cx->ITR & ( uint8_t)tempregister);
4025  001c 1e05          	ldw	x,(OFST+1,sp)
4026  001e e60a          	ld	a,(10,x)
4027  0020 1402          	and	a,(OFST-2,sp)
4028  0022 6b03          	ld	(OFST-1,sp),a
4029                     ; 1278   if ((uint16_t)((uint16_t)I2C_IT & REGISTER_Mask) == REGISTER_SR1_Index)
4031  0024 7b09          	ld	a,(OFST+5,sp)
4032  0026 97            	ld	xl,a
4033  0027 7b0a          	ld	a,(OFST+6,sp)
4034  0029 9f            	ld	a,xl
4035  002a a430          	and	a,#48
4036  002c 97            	ld	xl,a
4037  002d 4f            	clr	a
4038  002e 02            	rlwa	x,a
4039  002f a30100        	cpw	x,#256
4040  0032 2616          	jrne	L5612
4041                     ; 1281     if (((I2Cx->SR1 & (uint8_t)I2C_IT) != RESET) && enablestatus)
4043  0034 1e05          	ldw	x,(OFST+1,sp)
4044  0036 e607          	ld	a,(7,x)
4045  0038 150a          	bcp	a,(OFST+6,sp)
4046  003a 270a          	jreq	L7612
4048  003c 0d03          	tnz	(OFST-1,sp)
4049  003e 2706          	jreq	L7612
4050                     ; 1284       bitstatus = SET;
4052  0040 a601          	ld	a,#1
4053  0042 6b04          	ld	(OFST+0,sp),a
4055  0044 2018          	jra	L3712
4056  0046               L7612:
4057                     ; 1289       bitstatus = RESET;
4059  0046 0f04          	clr	(OFST+0,sp)
4060  0048 2014          	jra	L3712
4061  004a               L5612:
4062                     ; 1295     if (((I2Cx->SR2 & (uint8_t)I2C_IT) != RESET) && enablestatus)
4064  004a 1e05          	ldw	x,(OFST+1,sp)
4065  004c e608          	ld	a,(8,x)
4066  004e 150a          	bcp	a,(OFST+6,sp)
4067  0050 270a          	jreq	L5712
4069  0052 0d03          	tnz	(OFST-1,sp)
4070  0054 2706          	jreq	L5712
4071                     ; 1298       bitstatus = SET;
4073  0056 a601          	ld	a,#1
4074  0058 6b04          	ld	(OFST+0,sp),a
4076  005a 2002          	jra	L3712
4077  005c               L5712:
4078                     ; 1303       bitstatus = RESET;
4080  005c 0f04          	clr	(OFST+0,sp)
4081  005e               L3712:
4082                     ; 1307   return  bitstatus;
4084  005e 7b04          	ld	a,(OFST+0,sp)
4087  0060 5b06          	addw	sp,#6
4088  0062 81            	ret
4145                     ; 1340 void I2C_ClearITPendingBit(I2C_TypeDef* I2Cx, I2C_IT_TypeDef I2C_IT)
4145                     ; 1341 {
4146                     .text:	section	.text,new
4147  0000               _I2C_ClearITPendingBit:
4149  0000 89            	pushw	x
4150  0001 89            	pushw	x
4151       00000002      OFST:	set	2
4154                     ; 1342   uint16_t flagpos = 0;
4156  0002 5f            	clrw	x
4157  0003 1f01          	ldw	(OFST-1,sp),x
4158                     ; 1345   assert_param(IS_I2C_CLEAR_IT(I2C_IT));
4160                     ; 1348   flagpos = (uint16_t)I2C_IT & FLAG_Mask;
4162  0005 7b07          	ld	a,(OFST+5,sp)
4163  0007 97            	ld	xl,a
4164  0008 7b08          	ld	a,(OFST+6,sp)
4165  000a a4ff          	and	a,#255
4166  000c 5f            	clrw	x
4167  000d 02            	rlwa	x,a
4168  000e 1f01          	ldw	(OFST-1,sp),x
4169  0010 01            	rrwa	x,a
4170                     ; 1351   I2Cx->SR2 = (uint8_t)((uint16_t)~flagpos);
4172  0011 7b02          	ld	a,(OFST+0,sp)
4173  0013 43            	cpl	a
4174  0014 1e03          	ldw	x,(OFST+1,sp)
4175  0016 e708          	ld	(8,x),a
4176                     ; 1352 }
4179  0018 5b04          	addw	sp,#4
4180  001a 81            	ret
4193                     	xdef	_I2C_ClearITPendingBit
4194                     	xdef	_I2C_GetITStatus
4195                     	xdef	_I2C_ClearFlag
4196                     	xdef	_I2C_GetFlagStatus
4197                     	xdef	_I2C_GetLastEvent
4198                     	xdef	_I2C_CheckEvent
4199                     	xdef	_I2C_ReadRegister
4200                     	xdef	_I2C_ITConfig
4201                     	xdef	_I2C_DMALastTransferCmd
4202                     	xdef	_I2C_DMACmd
4203                     	xdef	_I2C_CalculatePEC
4204                     	xdef	_I2C_TransmitPEC
4205                     	xdef	_I2C_GetPEC
4206                     	xdef	_I2C_PECPositionConfig
4207                     	xdef	_I2C_ReceiveData
4208                     	xdef	_I2C_SendData
4209                     	xdef	_I2C_Send7bitAddress
4210                     	xdef	_I2C_SMBusAlertConfig
4211                     	xdef	_I2C_FastModeDutyCycleConfig
4212                     	xdef	_I2C_AckPositionConfig
4213                     	xdef	_I2C_DualAddressCmd
4214                     	xdef	_I2C_OwnAddress2Config
4215                     	xdef	_I2C_AcknowledgeConfig
4216                     	xdef	_I2C_GenerateSTOP
4217                     	xdef	_I2C_GenerateSTART
4218                     	xdef	_I2C_ARPCmd
4219                     	xdef	_I2C_StretchClockCmd
4220                     	xdef	_I2C_SoftwareResetCmd
4221                     	xdef	_I2C_GeneralCallCmd
4222                     	xdef	_I2C_Cmd
4223                     	xdef	_I2C_Init
4224                     	xdef	_I2C_DeInit
4225                     	xref	_CLK_GetClockFreq
4226                     	xref.b	c_lreg
4245                     	xref	c_uitolx
4246                     	xref	c_sdivx
4247                     	xref	c_lzmp
4248                     	xref	c_rtol
4249                     	xref	c_smul
4250                     	xref	c_lmul
4251                     	xref	c_lcmp
4252                     	xref	c_ludv
4253                     	xref	c_ltor
4254                     	end
