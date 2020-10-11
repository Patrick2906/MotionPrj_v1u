   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  80                     ; 4 void RTC_SetWakeupPeriod(bool bMode)  //true: For low battery mode; false: for PIR recheck
  80                     ; 5 {
  82                     .text:	section	.text,new
  83  0000               _RTC_SetWakeupPeriod:
  85  0000 89            	pushw	x
  86       00000002      OFST:	set	2
  89                     ; 6 	u16 T=bMode?((nLowBatTime+1)*2):(nPirHoldTime+1);
  91  0001 4d            	tnz	a
  92  0002 2709          	jreq	L6
  93  0004 b600          	ld	a,_nLowBatTime
  94  0006 5f            	clrw	x
  95  0007 97            	ld	xl,a
  96  0008 58            	sllw	x
  97  0009 5c            	incw	x
  98  000a 5c            	incw	x
  99  000b 2005          	jra	L01
 100  000d               L6:
 101  000d b600          	ld	a,_nPirHoldTime
 102  000f 5f            	clrw	x
 103  0010 97            	ld	xl,a
 104  0011 5c            	incw	x
 105  0012               L01:
 106  0012 1f01          	ldw	(OFST-1,sp),x
 107                     ; 7 	RTC_WakeUpClockConfig(RTC_WakeUpClock_RTCCLK_Div16);
 109  0014 4f            	clr	a
 110  0015 cd0000        	call	_RTC_WakeUpClockConfig
 112                     ; 8 	RTC_ITConfig(RTC_IT_WUT, ENABLE);
 114  0018 4b01          	push	#1
 115  001a ae0040        	ldw	x,#64
 116  001d cd0000        	call	_RTC_ITConfig
 118  0020 84            	pop	a
 119                     ; 10   RTC_WakeUpCmd(DISABLE);
 121  0021 4f            	clr	a
 122  0022 cd0000        	call	_RTC_WakeUpCmd
 124                     ; 11   RTC_SetWakeUpCounter(75*T);  //wakeup 150/s
 126  0025 1e01          	ldw	x,(OFST-1,sp)
 127  0027 90ae004b      	ldw	y,#75
 128  002b cd0000        	call	c_imul
 130  002e cd0000        	call	_RTC_SetWakeUpCounter
 132                     ; 12   RTC_WakeUpCmd(ENABLE);
 134  0031 a601          	ld	a,#1
 135  0033 cd0000        	call	_RTC_WakeUpCmd
 137                     ; 13 }
 140  0036 85            	popw	x
 141  0037 81            	ret
 181                     ; 15 void Lux_SendCmd(u8 cmd)  //no dedicated INT enable/disable which needs the caller to do it
 181                     ; 16 {
 182                     .text:	section	.text,new
 183  0000               _Lux_SendCmd:
 185  0000 88            	push	a
 186       00000000      OFST:	set	0
 189  0001               L36:
 190                     ; 17 	while(I2C_GetFlagStatus(I2C1, I2C_FLAG_BUSY));
 192  0001 ae0302        	ldw	x,#770
 193  0004 89            	pushw	x
 194  0005 ae5210        	ldw	x,#21008
 195  0008 cd0000        	call	_I2C_GetFlagStatus
 197  000b 85            	popw	x
 198  000c 4d            	tnz	a
 199  000d 26f2          	jrne	L36
 200                     ; 19 	I2C_GenerateSTART(I2C1, ENABLE);
 202  000f 4b01          	push	#1
 203  0011 ae5210        	ldw	x,#21008
 204  0014 cd0000        	call	_I2C_GenerateSTART
 206  0017 84            	pop	a
 208  0018               L17:
 209                     ; 20 	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_MODE_SELECT));/*EV5,主模式*/
 211  0018 ae0301        	ldw	x,#769
 212  001b 89            	pushw	x
 213  001c ae5210        	ldw	x,#21008
 214  001f cd0000        	call	_I2C_CheckEvent
 216  0022 85            	popw	x
 217  0023 4d            	tnz	a
 218  0024 27f2          	jreq	L17
 219                     ; 21 	I2C_Send7bitAddress(I2C1, LUX_I2CAdd, I2C_Direction_Transmitter);
 221  0026 4b00          	push	#0
 222  0028 4b46          	push	#70
 223  002a ae5210        	ldw	x,#21008
 224  002d cd0000        	call	_I2C_Send7bitAddress
 226  0030 85            	popw	x
 228  0031               L77:
 229                     ; 22 	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
 231  0031 ae0782        	ldw	x,#1922
 232  0034 89            	pushw	x
 233  0035 ae5210        	ldw	x,#21008
 234  0038 cd0000        	call	_I2C_CheckEvent
 236  003b 85            	popw	x
 237  003c 4d            	tnz	a
 238  003d 27f2          	jreq	L77
 239                     ; 23 	I2C_SendData(I2C1, cmd);
 241  003f 7b01          	ld	a,(OFST+1,sp)
 242  0041 88            	push	a
 243  0042 ae5210        	ldw	x,#21008
 244  0045 cd0000        	call	_I2C_SendData
 246  0048 84            	pop	a
 248  0049               L501:
 249                     ; 24 	while (!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
 251  0049 ae0784        	ldw	x,#1924
 252  004c 89            	pushw	x
 253  004d ae5210        	ldw	x,#21008
 254  0050 cd0000        	call	_I2C_CheckEvent
 256  0053 85            	popw	x
 257  0054 4d            	tnz	a
 258  0055 27f2          	jreq	L501
 259                     ; 25 	I2C_GenerateSTOP(I2C1, ENABLE);
 261  0057 4b01          	push	#1
 262  0059 ae5210        	ldw	x,#21008
 263  005c cd0000        	call	_I2C_GenerateSTOP
 265  005f 84            	pop	a
 266                     ; 26 }
 269  0060 84            	pop	a
 270  0061 81            	ret
 307                     ; 28 void Lux_SetMTreg()  //nLuxLevel:1..8
 307                     ; 29 {
 308                     .text:	section	.text,new
 309  0000               _Lux_SetMTreg:
 311  0000 88            	push	a
 312       00000001      OFST:	set	1
 315                     ; 30 	u8 nLevel=(nLuxLevel-1)<<2;
 317  0001 b600          	ld	a,_nLuxLevel
 318  0003 48            	sll	a
 319  0004 48            	sll	a
 320  0005 a004          	sub	a,#4
 321  0007 6b01          	ld	(OFST+0,sp),a
 322                     ; 32 	Lux_SendCmd(LUX_I2CCmd_PowerDown);
 324  0009 4f            	clr	a
 325  000a cd0000        	call	_Lux_SendCmd
 327                     ; 33 	TD_Delay01ms(5);
 329  000d a605          	ld	a,#5
 330  000f cd0000        	call	_TD_Delay01ms
 332                     ; 34 	Lux_SendCmd(LUX_I2CCmd_MTregH+nLevel);  //LUX_I2CCmd_MTregL needn't be done, always 0
 334  0012 7b01          	ld	a,(OFST+0,sp)
 335  0014 ab40          	add	a,#64
 336  0016 cd0000        	call	_Lux_SendCmd
 338                     ; 35 	TD_Delay01ms(5);
 340  0019 a605          	ld	a,#5
 341  001b cd0000        	call	_TD_Delay01ms
 343                     ; 36 	Lux_SendCmd(LUX_I2CCmd_PowerOn);
 345  001e a601          	ld	a,#1
 346  0020 cd0000        	call	_Lux_SendCmd
 348                     ; 38 }
 351  0023 84            	pop	a
 352  0024 81            	ret
 403                     ; 40 u16 Lux_GetReading(u8 cmd)
 403                     ; 41 {
 404                     .text:	section	.text,new
 405  0000               _Lux_GetReading:
 407  0000 5203          	subw	sp,#3
 408       00000003      OFST:	set	3
 411                     ; 42 	u16 d2b=0;
 413  0002 5f            	clrw	x
 414  0003 1f02          	ldw	(OFST-1,sp),x
 415                     ; 44 	Lux_SendCmd(cmd);
 417  0005 cd0000        	call	_Lux_SendCmd
 419                     ; 45 	TD_Delay01ms(5);
 421  0008 a605          	ld	a,#5
 422  000a cd0000        	call	_TD_Delay01ms
 424                     ; 47 	I2C_GenerateSTART(I2C1, ENABLE);
 426  000d 4b01          	push	#1
 427  000f ae5210        	ldw	x,#21008
 428  0012 cd0000        	call	_I2C_GenerateSTART
 430  0015 84            	pop	a
 432  0016               L351:
 433                     ; 48 	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_MODE_SELECT));/*EV5,主模式*/
 435  0016 ae0301        	ldw	x,#769
 436  0019 89            	pushw	x
 437  001a ae5210        	ldw	x,#21008
 438  001d cd0000        	call	_I2C_CheckEvent
 440  0020 85            	popw	x
 441  0021 4d            	tnz	a
 442  0022 27f2          	jreq	L351
 443                     ; 49 	I2C_Send7bitAddress(I2C1, LUX_I2CAdd, I2C_Direction_Receiver);
 445  0024 4b01          	push	#1
 446  0026 4b46          	push	#70
 447  0028 ae5210        	ldw	x,#21008
 448  002b cd0000        	call	_I2C_Send7bitAddress
 450  002e 85            	popw	x
 452  002f               L161:
 453                     ; 50 	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
 455  002f ae0302        	ldw	x,#770
 456  0032 89            	pushw	x
 457  0033 ae5210        	ldw	x,#21008
 458  0036 cd0000        	call	_I2C_CheckEvent
 460  0039 85            	popw	x
 461  003a 4d            	tnz	a
 462  003b 27f2          	jreq	L161
 464  003d               L761:
 465                     ; 51 	while(!I2C_CheckEvent(I2C1,I2C_EVENT_MASTER_BYTE_RECEIVED));
 467  003d ae0340        	ldw	x,#832
 468  0040 89            	pushw	x
 469  0041 ae5210        	ldw	x,#21008
 470  0044 cd0000        	call	_I2C_CheckEvent
 472  0047 85            	popw	x
 473  0048 4d            	tnz	a
 474  0049 27f2          	jreq	L761
 475                     ; 52 	d2b=I2C_ReceiveData(I2C1);
 477  004b ae5210        	ldw	x,#21008
 478  004e cd0000        	call	_I2C_ReceiveData
 480  0051 5f            	clrw	x
 481  0052 97            	ld	xl,a
 482  0053 1f02          	ldw	(OFST-1,sp),x
 483                     ; 53 	I2C_AcknowledgeConfig(I2C1,ENABLE);
 485  0055 4b01          	push	#1
 486  0057 ae5210        	ldw	x,#21008
 487  005a cd0000        	call	_I2C_AcknowledgeConfig
 489  005d 84            	pop	a
 491  005e               L571:
 492                     ; 54 	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_BYTE_RECEIVED));
 494  005e ae0340        	ldw	x,#832
 495  0061 89            	pushw	x
 496  0062 ae5210        	ldw	x,#21008
 497  0065 cd0000        	call	_I2C_CheckEvent
 499  0068 85            	popw	x
 500  0069 4d            	tnz	a
 501  006a 27f2          	jreq	L571
 502                     ; 55 	d2b=(d2b<<8)+I2C_ReceiveData(I2C1);
 504  006c ae5210        	ldw	x,#21008
 505  006f cd0000        	call	_I2C_ReceiveData
 507  0072 6b01          	ld	(OFST-2,sp),a
 508  0074 1e02          	ldw	x,(OFST-1,sp)
 509  0076 4f            	clr	a
 510  0077 02            	rlwa	x,a
 511  0078 01            	rrwa	x,a
 512  0079 1b01          	add	a,(OFST-2,sp)
 513  007b 2401          	jrnc	L02
 514  007d 5c            	incw	x
 515  007e               L02:
 516  007e 02            	rlwa	x,a
 517  007f 1f02          	ldw	(OFST-1,sp),x
 518  0081 01            	rrwa	x,a
 519                     ; 56 	I2C_AcknowledgeConfig(I2C1,ENABLE);
 521  0082 4b01          	push	#1
 522  0084 ae5210        	ldw	x,#21008
 523  0087 cd0000        	call	_I2C_AcknowledgeConfig
 525  008a 84            	pop	a
 526                     ; 57 	I2C_GenerateSTOP(I2C1, ENABLE);
 528  008b 4b01          	push	#1
 529  008d ae5210        	ldw	x,#21008
 530  0090 cd0000        	call	_I2C_GenerateSTOP
 532  0093 84            	pop	a
 533                     ; 60 	return d2b;
 535  0094 1e02          	ldw	x,(OFST-1,sp)
 538  0096 5b03          	addw	sp,#3
 539  0098 81            	ret
 608                     ; 64 void Pir_GetConfig(void)  //using global nPirLevel
 608                     ; 65 {
 609                     .text:	section	.text,new
 610  0000               _Pir_GetConfig:
 612  0000 5208          	subw	sp,#8
 613       00000008      OFST:	set	8
 616                     ; 67 	u8 nPirHoldTimeReg=0;
 618  0002 0f01          	clr	(OFST-7,sp)
 619                     ; 68 	nPirLevel=0;
 621  0004 3f00          	clr	_nPirLevel
 622                     ; 71 	oPinPirDoci;
 624  0006 4be0          	push	#224
 625  0008 4b80          	push	#128
 626  000a ae5005        	ldw	x,#20485
 627  000d cd0000        	call	_GPIO_Init
 629  0010 85            	popw	x
 630                     ; 72 	clrPinPirDoci;
 633  0011 4b80          	push	#128
 634  0013 ae5005        	ldw	x,#20485
 635  0016 cd0000        	call	_GPIO_ResetBits
 637  0019 84            	pop	a
 638                     ; 74 	setPinPirDoci;  //start a reading
 640  001a 4b80          	push	#128
 641  001c ae5005        	ldw	x,#20485
 642  001f cd0000        	call	_GPIO_SetBits
 644  0022 84            	pop	a
 645                     ; 75 	TD_Delay01ms(1);
 647  0023 a601          	ld	a,#1
 648  0025 cd0000        	call	_TD_Delay01ms
 650                     ; 76 	bytePir[0]=0;
 652  0028 0f02          	clr	(OFST-6,sp)
 653                     ; 77 	for(i=0;i<7;i++) //b39..b33)
 655  002a 0f07          	clr	(OFST-1,sp)
 656  002c               L332:
 657                     ; 79 		oPinPirDoci;
 659  002c 4be0          	push	#224
 660  002e 4b80          	push	#128
 661  0030 ae5005        	ldw	x,#20485
 662  0033 cd0000        	call	_GPIO_Init
 664  0036 85            	popw	x
 665                     ; 80 		clrPinPirDoci;
 668  0037 4b80          	push	#128
 669  0039 ae5005        	ldw	x,#20485
 670  003c cd0000        	call	_GPIO_ResetBits
 672  003f 84            	pop	a
 673                     ; 81 		setPinPirDoci;
 675  0040 4b80          	push	#128
 676  0042 ae5005        	ldw	x,#20485
 677  0045 cd0000        	call	_GPIO_SetBits
 679  0048 84            	pop	a
 680                     ; 82 		iPinPirDoci;
 682  0049 4b00          	push	#0
 683  004b 4b80          	push	#128
 684  004d ae5005        	ldw	x,#20485
 685  0050 cd0000        	call	_GPIO_Init
 687  0053 85            	popw	x
 690  0054 0f08          	clr	(OFST+0,sp)
 691  0056               L142:
 692                     ; 83 		TD_Delay();
 695  0056 0c08          	inc	(OFST+0,sp)
 698  0058 7b08          	ld	a,(OFST+0,sp)
 699  005a a128          	cp	a,#40
 700  005c 25f8          	jrult	L142
 701                     ; 84 		if(getPinPirDoci!=RESET)
 704  005e 4b80          	push	#128
 705  0060 ae5005        	ldw	x,#20485
 706  0063 cd0000        	call	_GPIO_ReadInputDataBit
 708  0066 5b01          	addw	sp,#1
 709  0068 4d            	tnz	a
 710  0069 2711          	jreq	L742
 711                     ; 85 			bytePir[0]|=(0x80>>i);
 713  006b 7b07          	ld	a,(OFST-1,sp)
 714  006d 5f            	clrw	x
 715  006e 97            	ld	xl,a
 716  006f a680          	ld	a,#128
 717  0071 5d            	tnzw	x
 718  0072 2704          	jreq	L42
 719  0074               L62:
 720  0074 44            	srl	a
 721  0075 5a            	decw	x
 722  0076 26fc          	jrne	L62
 723  0078               L42:
 724  0078 1a02          	or	a,(OFST-6,sp)
 725  007a 6b02          	ld	(OFST-6,sp),a
 726  007c               L742:
 727                     ; 77 	for(i=0;i<7;i++) //b39..b33)
 729  007c 0c07          	inc	(OFST-1,sp)
 732  007e 7b07          	ld	a,(OFST-1,sp)
 733  0080 a107          	cp	a,#7
 734  0082 25a8          	jrult	L332
 735                     ; 87 	bytePir[0]=bytePir[0]>>1;  //7bits shift right to aligh low 7bits
 737  0084 0402          	srl	(OFST-6,sp)
 738                     ; 88 	bytePir[1]=0;
 740  0086 0f03          	clr	(OFST-5,sp)
 741                     ; 89 	for(i=0;i<8;i++) //b32..b25)
 743  0088 0f07          	clr	(OFST-1,sp)
 744  008a               L152:
 745                     ; 91 		oPinPirDoci;
 747  008a 4be0          	push	#224
 748  008c 4b80          	push	#128
 749  008e ae5005        	ldw	x,#20485
 750  0091 cd0000        	call	_GPIO_Init
 752  0094 85            	popw	x
 753                     ; 92 		clrPinPirDoci;
 756  0095 4b80          	push	#128
 757  0097 ae5005        	ldw	x,#20485
 758  009a cd0000        	call	_GPIO_ResetBits
 760  009d 84            	pop	a
 761                     ; 93 		setPinPirDoci;
 763  009e 4b80          	push	#128
 764  00a0 ae5005        	ldw	x,#20485
 765  00a3 cd0000        	call	_GPIO_SetBits
 767  00a6 84            	pop	a
 768                     ; 94 		iPinPirDoci;
 770  00a7 4b00          	push	#0
 771  00a9 4b80          	push	#128
 772  00ab ae5005        	ldw	x,#20485
 773  00ae cd0000        	call	_GPIO_Init
 775  00b1 85            	popw	x
 778  00b2 0f08          	clr	(OFST+0,sp)
 779  00b4               L752:
 780                     ; 95 		TD_Delay();
 783  00b4 0c08          	inc	(OFST+0,sp)
 786  00b6 7b08          	ld	a,(OFST+0,sp)
 787  00b8 a128          	cp	a,#40
 788  00ba 25f8          	jrult	L752
 789                     ; 96 		if(getPinPirDoci!=RESET)
 792  00bc 4b80          	push	#128
 793  00be ae5005        	ldw	x,#20485
 794  00c1 cd0000        	call	_GPIO_ReadInputDataBit
 796  00c4 5b01          	addw	sp,#1
 797  00c6 4d            	tnz	a
 798  00c7 2711          	jreq	L562
 799                     ; 97 			bytePir[1]|=(0x80>>i);
 801  00c9 7b07          	ld	a,(OFST-1,sp)
 802  00cb 5f            	clrw	x
 803  00cc 97            	ld	xl,a
 804  00cd a680          	ld	a,#128
 805  00cf 5d            	tnzw	x
 806  00d0 2704          	jreq	L03
 807  00d2               L23:
 808  00d2 44            	srl	a
 809  00d3 5a            	decw	x
 810  00d4 26fc          	jrne	L23
 811  00d6               L03:
 812  00d6 1a03          	or	a,(OFST-5,sp)
 813  00d8 6b03          	ld	(OFST-5,sp),a
 814  00da               L562:
 815                     ; 89 	for(i=0;i<8;i++) //b32..b25)
 817  00da 0c07          	inc	(OFST-1,sp)
 820  00dc 7b07          	ld	a,(OFST-1,sp)
 821  00de a108          	cp	a,#8
 822  00e0 25a8          	jrult	L152
 823                     ; 100 	for(i=0;i<3;i++) //b24..22 nPirLevel (b24..b17) UPPER 3bits
 825  00e2 0f07          	clr	(OFST-1,sp)
 826  00e4               L762:
 827                     ; 102 		oPinPirDoci;
 829  00e4 4be0          	push	#224
 830  00e6 4b80          	push	#128
 831  00e8 ae5005        	ldw	x,#20485
 832  00eb cd0000        	call	_GPIO_Init
 834  00ee 85            	popw	x
 835                     ; 103 		clrPinPirDoci;
 838  00ef 4b80          	push	#128
 839  00f1 ae5005        	ldw	x,#20485
 840  00f4 cd0000        	call	_GPIO_ResetBits
 842  00f7 84            	pop	a
 843                     ; 104 		setPinPirDoci;
 845  00f8 4b80          	push	#128
 846  00fa ae5005        	ldw	x,#20485
 847  00fd cd0000        	call	_GPIO_SetBits
 849  0100 84            	pop	a
 850                     ; 105 		iPinPirDoci;
 852  0101 4b00          	push	#0
 853  0103 4b80          	push	#128
 854  0105 ae5005        	ldw	x,#20485
 855  0108 cd0000        	call	_GPIO_Init
 857  010b 85            	popw	x
 860  010c 0f08          	clr	(OFST+0,sp)
 861  010e               L572:
 862                     ; 106 		TD_Delay();
 865  010e 0c08          	inc	(OFST+0,sp)
 868  0110 7b08          	ld	a,(OFST+0,sp)
 869  0112 a128          	cp	a,#40
 870  0114 25f8          	jrult	L572
 871                     ; 107 		if(getPinPirDoci!=RESET)
 874  0116 4b80          	push	#128
 875  0118 ae5005        	ldw	x,#20485
 876  011b cd0000        	call	_GPIO_ReadInputDataBit
 878  011e 5b01          	addw	sp,#1
 879  0120 4d            	tnz	a
 880  0121 2711          	jreq	L303
 881                     ; 108 			nPirLevel|=(0x4>>i);
 883  0123 7b07          	ld	a,(OFST-1,sp)
 884  0125 5f            	clrw	x
 885  0126 97            	ld	xl,a
 886  0127 a604          	ld	a,#4
 887  0129 5d            	tnzw	x
 888  012a 2704          	jreq	L43
 889  012c               L63:
 890  012c 44            	srl	a
 891  012d 5a            	decw	x
 892  012e 26fc          	jrne	L63
 893  0130               L43:
 894  0130 ba00          	or	a,_nPirLevel
 895  0132 b700          	ld	_nPirLevel,a
 896  0134               L303:
 897                     ; 100 	for(i=0;i<3;i++) //b24..22 nPirLevel (b24..b17) UPPER 3bits
 899  0134 0c07          	inc	(OFST-1,sp)
 902  0136 7b07          	ld	a,(OFST-1,sp)
 903  0138 a103          	cp	a,#3
 904  013a 25a8          	jrult	L762
 905                     ; 110 	bytePir[2]=0;
 907  013c 0f04          	clr	(OFST-4,sp)
 908                     ; 111 	for(i=0;i<5;i++) //b21..17 nPirLevel LOWER 5bits=00000
 910  013e 0f07          	clr	(OFST-1,sp)
 911  0140               L503:
 912                     ; 113 		oPinPirDoci;
 914  0140 4be0          	push	#224
 915  0142 4b80          	push	#128
 916  0144 ae5005        	ldw	x,#20485
 917  0147 cd0000        	call	_GPIO_Init
 919  014a 85            	popw	x
 920                     ; 114 		clrPinPirDoci;
 923  014b 4b80          	push	#128
 924  014d ae5005        	ldw	x,#20485
 925  0150 cd0000        	call	_GPIO_ResetBits
 927  0153 84            	pop	a
 928                     ; 115 		setPinPirDoci;
 930  0154 4b80          	push	#128
 931  0156 ae5005        	ldw	x,#20485
 932  0159 cd0000        	call	_GPIO_SetBits
 934  015c 84            	pop	a
 935                     ; 116 		iPinPirDoci;
 937  015d 4b00          	push	#0
 938  015f 4b80          	push	#128
 939  0161 ae5005        	ldw	x,#20485
 940  0164 cd0000        	call	_GPIO_Init
 942  0167 85            	popw	x
 945  0168 0f08          	clr	(OFST+0,sp)
 946  016a               L313:
 947                     ; 117 		TD_Delay();
 950  016a 0c08          	inc	(OFST+0,sp)
 953  016c 7b08          	ld	a,(OFST+0,sp)
 954  016e a128          	cp	a,#40
 955  0170 25f8          	jrult	L313
 956                     ; 118 		if(getPinPirDoci!=RESET)
 959  0172 4b80          	push	#128
 960  0174 ae5005        	ldw	x,#20485
 961  0177 cd0000        	call	_GPIO_ReadInputDataBit
 963  017a 5b01          	addw	sp,#1
 964  017c 4d            	tnz	a
 965  017d 2711          	jreq	L123
 966                     ; 119 			bytePir[2]|=(0x80>>i);
 968  017f 7b07          	ld	a,(OFST-1,sp)
 969  0181 5f            	clrw	x
 970  0182 97            	ld	xl,a
 971  0183 a680          	ld	a,#128
 972  0185 5d            	tnzw	x
 973  0186 2704          	jreq	L04
 974  0188               L24:
 975  0188 44            	srl	a
 976  0189 5a            	decw	x
 977  018a 26fc          	jrne	L24
 978  018c               L04:
 979  018c 1a04          	or	a,(OFST-4,sp)
 980  018e 6b04          	ld	(OFST-4,sp),a
 981  0190               L123:
 982                     ; 111 	for(i=0;i<5;i++) //b21..17 nPirLevel LOWER 5bits=00000
 984  0190 0c07          	inc	(OFST-1,sp)
 987  0192 7b07          	ld	a,(OFST-1,sp)
 988  0194 a105          	cp	a,#5
 989  0196 25a8          	jrult	L503
 990                     ; 121 	for(i=0;i<4;i++) //nPirHoldTimeReg 4bits  b16..13
 992  0198 0f07          	clr	(OFST-1,sp)
 993  019a               L323:
 994                     ; 123 		oPinPirDoci;
 996  019a 4be0          	push	#224
 997  019c 4b80          	push	#128
 998  019e ae5005        	ldw	x,#20485
 999  01a1 cd0000        	call	_GPIO_Init
1001  01a4 85            	popw	x
1002                     ; 124 		clrPinPirDoci;
1005  01a5 4b80          	push	#128
1006  01a7 ae5005        	ldw	x,#20485
1007  01aa cd0000        	call	_GPIO_ResetBits
1009  01ad 84            	pop	a
1010                     ; 125 		setPinPirDoci;
1012  01ae 4b80          	push	#128
1013  01b0 ae5005        	ldw	x,#20485
1014  01b3 cd0000        	call	_GPIO_SetBits
1016  01b6 84            	pop	a
1017                     ; 126 		iPinPirDoci;
1019  01b7 4b00          	push	#0
1020  01b9 4b80          	push	#128
1021  01bb ae5005        	ldw	x,#20485
1022  01be cd0000        	call	_GPIO_Init
1024  01c1 85            	popw	x
1027  01c2 0f08          	clr	(OFST+0,sp)
1028  01c4               L133:
1029                     ; 127 		TD_Delay();
1032  01c4 0c08          	inc	(OFST+0,sp)
1035  01c6 7b08          	ld	a,(OFST+0,sp)
1036  01c8 a128          	cp	a,#40
1037  01ca 25f8          	jrult	L133
1038                     ; 128 		if(getPinPirDoci!=RESET)
1041  01cc 4b80          	push	#128
1042  01ce ae5005        	ldw	x,#20485
1043  01d1 cd0000        	call	_GPIO_ReadInputDataBit
1045  01d4 5b01          	addw	sp,#1
1046  01d6 4d            	tnz	a
1047  01d7 2711          	jreq	L733
1048                     ; 129 			nPirHoldTimeReg|=(0x8>>i);
1050  01d9 7b07          	ld	a,(OFST-1,sp)
1051  01db 5f            	clrw	x
1052  01dc 97            	ld	xl,a
1053  01dd a608          	ld	a,#8
1054  01df 5d            	tnzw	x
1055  01e0 2704          	jreq	L44
1056  01e2               L64:
1057  01e2 44            	srl	a
1058  01e3 5a            	decw	x
1059  01e4 26fc          	jrne	L64
1060  01e6               L44:
1061  01e6 1a01          	or	a,(OFST-7,sp)
1062  01e8 6b01          	ld	(OFST-7,sp),a
1063  01ea               L733:
1064                     ; 121 	for(i=0;i<4;i++) //nPirHoldTimeReg 4bits  b16..13
1066  01ea 0c07          	inc	(OFST-1,sp)
1069  01ec 7b07          	ld	a,(OFST-1,sp)
1070  01ee a104          	cp	a,#4
1071  01f0 25a8          	jrult	L323
1072                     ; 133 	bytePir[3]=0;
1074  01f2 0f05          	clr	(OFST-3,sp)
1075                     ; 134 	for(i=0;i<4;i++) //b12..9
1077  01f4 0f07          	clr	(OFST-1,sp)
1078  01f6               L143:
1079                     ; 136 		oPinPirDoci;
1081  01f6 4be0          	push	#224
1082  01f8 4b80          	push	#128
1083  01fa ae5005        	ldw	x,#20485
1084  01fd cd0000        	call	_GPIO_Init
1086  0200 85            	popw	x
1087                     ; 137 		clrPinPirDoci;
1090  0201 4b80          	push	#128
1091  0203 ae5005        	ldw	x,#20485
1092  0206 cd0000        	call	_GPIO_ResetBits
1094  0209 84            	pop	a
1095                     ; 138 		setPinPirDoci;
1097  020a 4b80          	push	#128
1098  020c ae5005        	ldw	x,#20485
1099  020f cd0000        	call	_GPIO_SetBits
1101  0212 84            	pop	a
1102                     ; 139 		iPinPirDoci;
1104  0213 4b00          	push	#0
1105  0215 4b80          	push	#128
1106  0217 ae5005        	ldw	x,#20485
1107  021a cd0000        	call	_GPIO_Init
1109  021d 85            	popw	x
1112  021e 0f08          	clr	(OFST+0,sp)
1113  0220               L743:
1114                     ; 140 		TD_Delay();
1117  0220 0c08          	inc	(OFST+0,sp)
1120  0222 7b08          	ld	a,(OFST+0,sp)
1121  0224 a128          	cp	a,#40
1122  0226 25f8          	jrult	L743
1123                     ; 141 		if(getPinPirDoci!=RESET)
1126  0228 4b80          	push	#128
1127  022a ae5005        	ldw	x,#20485
1128  022d cd0000        	call	_GPIO_ReadInputDataBit
1130  0230 5b01          	addw	sp,#1
1131  0232 4d            	tnz	a
1132  0233 2711          	jreq	L553
1133                     ; 142 			bytePir[3]|=(0x8>>i);
1135  0235 7b07          	ld	a,(OFST-1,sp)
1136  0237 5f            	clrw	x
1137  0238 97            	ld	xl,a
1138  0239 a608          	ld	a,#8
1139  023b 5d            	tnzw	x
1140  023c 2704          	jreq	L05
1141  023e               L25:
1142  023e 44            	srl	a
1143  023f 5a            	decw	x
1144  0240 26fc          	jrne	L25
1145  0242               L05:
1146  0242 1a05          	or	a,(OFST-3,sp)
1147  0244 6b05          	ld	(OFST-3,sp),a
1148  0246               L553:
1149                     ; 134 	for(i=0;i<4;i++) //b12..9
1151  0246 0c07          	inc	(OFST-1,sp)
1154  0248 7b07          	ld	a,(OFST-1,sp)
1155  024a a104          	cp	a,#4
1156  024c 25a8          	jrult	L143
1157                     ; 144 	bytePir[4]=0;
1159  024e 0f06          	clr	(OFST-2,sp)
1160                     ; 145 	for(i=0;i<8;i++) //b8..1
1162  0250 0f07          	clr	(OFST-1,sp)
1163  0252               L753:
1164                     ; 147 		oPinPirDoci;
1166  0252 4be0          	push	#224
1167  0254 4b80          	push	#128
1168  0256 ae5005        	ldw	x,#20485
1169  0259 cd0000        	call	_GPIO_Init
1171  025c 85            	popw	x
1172                     ; 148 		clrPinPirDoci;
1175  025d 4b80          	push	#128
1176  025f ae5005        	ldw	x,#20485
1177  0262 cd0000        	call	_GPIO_ResetBits
1179  0265 84            	pop	a
1180                     ; 149 		setPinPirDoci;
1182  0266 4b80          	push	#128
1183  0268 ae5005        	ldw	x,#20485
1184  026b cd0000        	call	_GPIO_SetBits
1186  026e 84            	pop	a
1187                     ; 150 		iPinPirDoci;
1189  026f 4b00          	push	#0
1190  0271 4b80          	push	#128
1191  0273 ae5005        	ldw	x,#20485
1192  0276 cd0000        	call	_GPIO_Init
1194  0279 85            	popw	x
1197  027a 0f08          	clr	(OFST+0,sp)
1198  027c               L563:
1199                     ; 151 		TD_Delay();
1202  027c 0c08          	inc	(OFST+0,sp)
1205  027e 7b08          	ld	a,(OFST+0,sp)
1206  0280 a128          	cp	a,#40
1207  0282 25f8          	jrult	L563
1208                     ; 152 		if(getPinPirDoci!=RESET)
1211  0284 4b80          	push	#128
1212  0286 ae5005        	ldw	x,#20485
1213  0289 cd0000        	call	_GPIO_ReadInputDataBit
1215  028c 5b01          	addw	sp,#1
1216  028e 4d            	tnz	a
1217  028f 2711          	jreq	L373
1218                     ; 153 			bytePir[4]|=(0x80>>i);
1220  0291 7b07          	ld	a,(OFST-1,sp)
1221  0293 5f            	clrw	x
1222  0294 97            	ld	xl,a
1223  0295 a680          	ld	a,#128
1224  0297 5d            	tnzw	x
1225  0298 2704          	jreq	L45
1226  029a               L65:
1227  029a 44            	srl	a
1228  029b 5a            	decw	x
1229  029c 26fc          	jrne	L65
1230  029e               L45:
1231  029e 1a06          	or	a,(OFST-2,sp)
1232  02a0 6b06          	ld	(OFST-2,sp),a
1233  02a2               L373:
1234                     ; 145 	for(i=0;i<8;i++) //b8..1
1236  02a2 0c07          	inc	(OFST-1,sp)
1239  02a4 7b07          	ld	a,(OFST-1,sp)
1240  02a6 a108          	cp	a,#8
1241  02a8 25a8          	jrult	L753
1242                     ; 156 	oPinPirDoci;  //give following bits
1244  02aa 4be0          	push	#224
1245  02ac 4b80          	push	#128
1246  02ae ae5005        	ldw	x,#20485
1247  02b1 cd0000        	call	_GPIO_Init
1249  02b4 85            	popw	x
1250                     ; 157 	clrPinPirDoci;
1253  02b5 4b80          	push	#128
1254  02b7 ae5005        	ldw	x,#20485
1255  02ba cd0000        	call	_GPIO_ResetBits
1257  02bd 84            	pop	a
1258                     ; 158 	TD_Delay01ms(2);
1260  02be a602          	ld	a,#2
1261  02c0 cd0000        	call	_TD_Delay01ms
1263                     ; 159 	intPinPirDoci;
1265  02c3 4b20          	push	#32
1266  02c5 4b80          	push	#128
1267  02c7 ae5005        	ldw	x,#20485
1268  02ca cd0000        	call	_GPIO_Init
1270  02cd 85            	popw	x
1271                     ; 160 	nPirLevel=8-nPirLevel;
1274  02ce a608          	ld	a,#8
1275  02d0 b000          	sub	a,_nPirLevel
1276  02d2 b700          	ld	_nPirLevel,a
1277                     ; 161 	nPirHoldTime=nPirHoldTimeReg;
1279  02d4 7b01          	ld	a,(OFST-7,sp)
1280  02d6 b700          	ld	_nPirHoldTime,a
1281                     ; 179 }
1284  02d8 5b08          	addw	sp,#8
1285  02da 81            	ret
1361                     ; 181 void Pir_SetConfig(bool bNormal)  //using global nPirLevel(1..8), nPirHoldTimeReg=0
1361                     ; 182 {
1362                     .text:	section	.text,new
1363  0000               _Pir_SetConfig:
1365  0000 5207          	subw	sp,#7
1366       00000007      OFST:	set	7
1369                     ; 183 	u8 i,nLevel=(8-nPirLevel)<<5;
1371  0002 a608          	ld	a,#8
1372  0004 b000          	sub	a,_nPirLevel
1373  0006 97            	ld	xl,a
1374  0007 a620          	ld	a,#32
1375  0009 42            	mul	x,a
1376  000a 9f            	ld	a,xl
1377  000b 6b03          	ld	(OFST-4,sp),a
1378                     ; 184 	u8 npht=nPirHoldTime;
1380  000d b600          	ld	a,_nPirHoldTime
1381  000f 6b04          	ld	(OFST-3,sp),a
1382                     ; 185 	u16 nremain=DEF_PIRBITS;
1384  0011 ae0380        	ldw	x,#896
1385  0014 1f05          	ldw	(OFST-2,sp),x
1386                     ; 191 	clrPinPirSerin;
1388  0016 4b40          	push	#64
1389  0018 ae5005        	ldw	x,#20485
1390  001b cd0000        	call	_GPIO_ResetBits
1392  001e 84            	pop	a
1393                     ; 192 	TD_Delay01ms(10);
1395  001f a60a          	ld	a,#10
1396  0021 cd0000        	call	_TD_Delay01ms
1398                     ; 193 	for(i=0;i<15;i++) //bypass first 15bits (b39..b25)
1400  0024 0f07          	clr	(OFST+0,sp)
1401  0026               L334:
1402                     ; 195 		setPinPirSerin;
1404  0026 4b40          	push	#64
1405  0028 ae5005        	ldw	x,#20485
1406  002b cd0000        	call	_GPIO_SetBits
1408  002e 84            	pop	a
1409                     ; 196 		TD_Delay01ms(1);//0.5ms>t>0.06ms
1411  002f a601          	ld	a,#1
1412  0031 cd0000        	call	_TD_Delay01ms
1414                     ; 197 		clrPinPirSerin;
1416  0034 4b40          	push	#64
1417  0036 ae5005        	ldw	x,#20485
1418  0039 cd0000        	call	_GPIO_ResetBits
1420  003c 84            	pop	a
1421                     ; 193 	for(i=0;i<15;i++) //bypass first 15bits (b39..b25)
1423  003d 0c07          	inc	(OFST+0,sp)
1426  003f 7b07          	ld	a,(OFST+0,sp)
1427  0041 a10f          	cp	a,#15
1428  0043 25e1          	jrult	L334
1429                     ; 199 	for(i=0;i<8;i++) //nPirLevel 8bits (b24..b17)
1431  0045 0f07          	clr	(OFST+0,sp)
1432  0047               L144:
1433                     ; 201 		setPinPirSerin;
1435  0047 4b40          	push	#64
1436  0049 ae5005        	ldw	x,#20485
1437  004c cd0000        	call	_GPIO_SetBits
1439  004f 84            	pop	a
1440                     ; 202 		if(nLevel&(0x80>>i))	
1442  0050 7b03          	ld	a,(OFST-4,sp)
1443  0052 5f            	clrw	x
1444  0053 97            	ld	xl,a
1445  0054 1f01          	ldw	(OFST-6,sp),x
1446  0056 ae0080        	ldw	x,#128
1447  0059 7b07          	ld	a,(OFST+0,sp)
1448  005b 4d            	tnz	a
1449  005c 2704          	jreq	L26
1450  005e               L46:
1451  005e 57            	sraw	x
1452  005f 4a            	dec	a
1453  0060 26fc          	jrne	L46
1454  0062               L26:
1455  0062 01            	rrwa	x,a
1456  0063 1402          	and	a,(OFST-5,sp)
1457  0065 01            	rrwa	x,a
1458  0066 1401          	and	a,(OFST-6,sp)
1459  0068 01            	rrwa	x,a
1460  0069 a30000        	cpw	x,#0
1461  006c 270b          	jreq	L744
1462                     ; 203 			setPinPirSerin;
1464  006e 4b40          	push	#64
1465  0070 ae5005        	ldw	x,#20485
1466  0073 cd0000        	call	_GPIO_SetBits
1468  0076 84            	pop	a
1470  0077 2009          	jra	L154
1471  0079               L744:
1472                     ; 205 			clrPinPirSerin;
1474  0079 4b40          	push	#64
1475  007b ae5005        	ldw	x,#20485
1476  007e cd0000        	call	_GPIO_ResetBits
1478  0081 84            	pop	a
1479  0082               L154:
1480                     ; 207 		TD_Delay01ms(1);//0.5ms>t>0.06ms
1482  0082 a601          	ld	a,#1
1483  0084 cd0000        	call	_TD_Delay01ms
1485                     ; 208 		clrPinPirSerin;
1487  0087 4b40          	push	#64
1488  0089 ae5005        	ldw	x,#20485
1489  008c cd0000        	call	_GPIO_ResetBits
1491  008f 84            	pop	a
1492                     ; 199 	for(i=0;i<8;i++) //nPirLevel 8bits (b24..b17)
1494  0090 0c07          	inc	(OFST+0,sp)
1497  0092 7b07          	ld	a,(OFST+0,sp)
1498  0094 a108          	cp	a,#8
1499  0096 25af          	jrult	L144
1500                     ; 210 	for(i=0;i<4;i++) //4bits  b16..13
1502  0098 0f07          	clr	(OFST+0,sp)
1503  009a               L354:
1504                     ; 212 		setPinPirSerin;
1506  009a 4b40          	push	#64
1507  009c ae5005        	ldw	x,#20485
1508  009f cd0000        	call	_GPIO_SetBits
1510  00a2 84            	pop	a
1511                     ; 213 		if(npht&(0x8>>i))	
1513  00a3 7b04          	ld	a,(OFST-3,sp)
1514  00a5 5f            	clrw	x
1515  00a6 97            	ld	xl,a
1516  00a7 1f01          	ldw	(OFST-6,sp),x
1517  00a9 ae0008        	ldw	x,#8
1518  00ac 7b07          	ld	a,(OFST+0,sp)
1519  00ae 4d            	tnz	a
1520  00af 2704          	jreq	L66
1521  00b1               L07:
1522  00b1 57            	sraw	x
1523  00b2 4a            	dec	a
1524  00b3 26fc          	jrne	L07
1525  00b5               L66:
1526  00b5 01            	rrwa	x,a
1527  00b6 1402          	and	a,(OFST-5,sp)
1528  00b8 01            	rrwa	x,a
1529  00b9 1401          	and	a,(OFST-6,sp)
1530  00bb 01            	rrwa	x,a
1531  00bc a30000        	cpw	x,#0
1532  00bf 270b          	jreq	L164
1533                     ; 214 			setPinPirSerin;
1535  00c1 4b40          	push	#64
1536  00c3 ae5005        	ldw	x,#20485
1537  00c6 cd0000        	call	_GPIO_SetBits
1539  00c9 84            	pop	a
1541  00ca 2009          	jra	L364
1542  00cc               L164:
1543                     ; 216 			clrPinPirSerin;
1545  00cc 4b40          	push	#64
1546  00ce ae5005        	ldw	x,#20485
1547  00d1 cd0000        	call	_GPIO_ResetBits
1549  00d4 84            	pop	a
1550  00d5               L364:
1551                     ; 218 		TD_Delay01ms(1);//0.5ms>t>0.06ms
1553  00d5 a601          	ld	a,#1
1554  00d7 cd0000        	call	_TD_Delay01ms
1556                     ; 219 		clrPinPirSerin;
1558  00da 4b40          	push	#64
1559  00dc ae5005        	ldw	x,#20485
1560  00df cd0000        	call	_GPIO_ResetBits
1562  00e2 84            	pop	a
1563                     ; 210 	for(i=0;i<4;i++) //4bits  b16..13
1565  00e3 0c07          	inc	(OFST+0,sp)
1568  00e5 7b07          	ld	a,(OFST+0,sp)
1569  00e7 a104          	cp	a,#4
1570  00e9 25af          	jrult	L354
1571                     ; 223 		for(i=0;i<12;i++) // b12..1
1573  00eb 0f07          	clr	(OFST+0,sp)
1574  00ed               L564:
1575                     ; 225 			setPinPirSerin;
1577  00ed 4b40          	push	#64
1578  00ef ae5005        	ldw	x,#20485
1579  00f2 cd0000        	call	_GPIO_SetBits
1581  00f5 84            	pop	a
1582                     ; 226 			if(nremain&(0x800>>i))	
1584  00f6 ae0800        	ldw	x,#2048
1585  00f9 7b07          	ld	a,(OFST+0,sp)
1586  00fb 4d            	tnz	a
1587  00fc 2704          	jreq	L27
1588  00fe               L47:
1589  00fe 57            	sraw	x
1590  00ff 4a            	dec	a
1591  0100 26fc          	jrne	L47
1592  0102               L27:
1593  0102 01            	rrwa	x,a
1594  0103 1406          	and	a,(OFST-1,sp)
1595  0105 01            	rrwa	x,a
1596  0106 1405          	and	a,(OFST-2,sp)
1597  0108 01            	rrwa	x,a
1598  0109 a30000        	cpw	x,#0
1599  010c 270b          	jreq	L374
1600                     ; 227 				setPinPirSerin;
1602  010e 4b40          	push	#64
1603  0110 ae5005        	ldw	x,#20485
1604  0113 cd0000        	call	_GPIO_SetBits
1606  0116 84            	pop	a
1608  0117 2009          	jra	L574
1609  0119               L374:
1610                     ; 229 				clrPinPirSerin;
1612  0119 4b40          	push	#64
1613  011b ae5005        	ldw	x,#20485
1614  011e cd0000        	call	_GPIO_ResetBits
1616  0121 84            	pop	a
1617  0122               L574:
1618                     ; 231 			TD_Delay01ms(1);//0.5ms>t>0.06ms
1620  0122 a601          	ld	a,#1
1621  0124 cd0000        	call	_TD_Delay01ms
1623                     ; 232 			clrPinPirSerin;
1625  0127 4b40          	push	#64
1626  0129 ae5005        	ldw	x,#20485
1627  012c cd0000        	call	_GPIO_ResetBits
1629  012f 84            	pop	a
1630                     ; 223 		for(i=0;i<12;i++) // b12..1
1632  0130 0c07          	inc	(OFST+0,sp)
1635  0132 7b07          	ld	a,(OFST+0,sp)
1636  0134 a10c          	cp	a,#12
1637  0136 25b5          	jrult	L564
1638                     ; 235 	setPinPirSerin;
1640  0138 4b40          	push	#64
1641  013a ae5005        	ldw	x,#20485
1642  013d cd0000        	call	_GPIO_SetBits
1644  0140 84            	pop	a
1645                     ; 236 	TD_Delay01ms(6);//t=0.6ms lock input data without having to input remaining
1647  0141 a606          	ld	a,#6
1648  0143 cd0000        	call	_TD_Delay01ms
1650                     ; 237 	clrPinPirSerin;
1652  0146 4b40          	push	#64
1653  0148 ae5005        	ldw	x,#20485
1654  014b cd0000        	call	_GPIO_ResetBits
1656  014e 84            	pop	a
1657                     ; 239 }
1660  014f 5b07          	addw	sp,#7
1661  0151 81            	ret
1690                     ; 241 void ReadEeprom()
1690                     ; 242 {
1691                     .text:	section	.text,new
1692  0000               _ReadEeprom:
1696                     ; 243 	nPirHoldTime=FLASH_ReadByte(EEPROM_PIRHDTM);
1698  0000 ae1000        	ldw	x,#4096
1699  0003 89            	pushw	x
1700  0004 ae0000        	ldw	x,#0
1701  0007 89            	pushw	x
1702  0008 cd0000        	call	_FLASH_ReadByte
1704  000b 5b04          	addw	sp,#4
1705  000d b700          	ld	_nPirHoldTime,a
1706                     ; 244 	nPirLevel=FLASH_ReadByte(EEPROM_PIRSSLV);
1708  000f ae1001        	ldw	x,#4097
1709  0012 89            	pushw	x
1710  0013 ae0000        	ldw	x,#0
1711  0016 89            	pushw	x
1712  0017 cd0000        	call	_FLASH_ReadByte
1714  001a 5b04          	addw	sp,#4
1715  001c b700          	ld	_nPirLevel,a
1716                     ; 245 	nLuxLevel=FLASH_ReadByte(EEPROM_LUXSSLV);
1718  001e ae1002        	ldw	x,#4098
1719  0021 89            	pushw	x
1720  0022 ae0000        	ldw	x,#0
1721  0025 89            	pushw	x
1722  0026 cd0000        	call	_FLASH_ReadByte
1724  0029 5b04          	addw	sp,#4
1725  002b b700          	ld	_nLuxLevel,a
1726                     ; 246 	nLowBatTime=FLASH_ReadByte(EEPROM_LOWBATTIME);
1728  002d ae1003        	ldw	x,#4099
1729  0030 89            	pushw	x
1730  0031 ae0000        	ldw	x,#0
1731  0034 89            	pushw	x
1732  0035 cd0000        	call	_FLASH_ReadByte
1734  0038 5b04          	addw	sp,#4
1735  003a b700          	ld	_nLowBatTime,a
1736                     ; 248 	if((nPirHoldTime==0)||(nPirHoldTime>MAX_PIRHOLDTIME))
1738  003c 3d00          	tnz	_nPirHoldTime
1739  003e 2706          	jreq	L115
1741  0040 b600          	ld	a,_nPirHoldTime
1742  0042 a110          	cp	a,#16
1743  0044 2513          	jrult	L705
1744  0046               L115:
1745                     ; 250 		nPirHoldTime=DEF_PIRHOLDTIME;
1747  0046 35080000      	mov	_nPirHoldTime,#8
1748                     ; 251 		WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
1750  004a 4b08          	push	#8
1751  004c ae1000        	ldw	x,#4096
1752  004f 89            	pushw	x
1753  0050 ae0000        	ldw	x,#0
1754  0053 89            	pushw	x
1755  0054 cd0000        	call	_WriteEeprom
1757  0057 5b05          	addw	sp,#5
1758  0059               L705:
1759                     ; 253 	if((nPirLevel==0)||(nPirLevel>MAX_PIRLEVEL))
1761  0059 3d00          	tnz	_nPirLevel
1762  005b 2706          	jreq	L515
1764  005d b600          	ld	a,_nPirLevel
1765  005f a109          	cp	a,#9
1766  0061 2513          	jrult	L315
1767  0063               L515:
1768                     ; 255 		nPirLevel=DEF_PIRLEVEL;
1770  0063 35040000      	mov	_nPirLevel,#4
1771                     ; 256 		WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
1773  0067 4b04          	push	#4
1774  0069 ae1001        	ldw	x,#4097
1775  006c 89            	pushw	x
1776  006d ae0000        	ldw	x,#0
1777  0070 89            	pushw	x
1778  0071 cd0000        	call	_WriteEeprom
1780  0074 5b05          	addw	sp,#5
1781  0076               L315:
1782                     ; 258 	if((nLuxLevel==0)||(nLuxLevel>MAX_LUXLEVEL))
1784  0076 3d00          	tnz	_nLuxLevel
1785  0078 2706          	jreq	L125
1787  007a b600          	ld	a,_nLuxLevel
1788  007c a109          	cp	a,#9
1789  007e 2513          	jrult	L715
1790  0080               L125:
1791                     ; 260 		nLuxLevel=DEF_LUXLEVEL;
1793  0080 35040000      	mov	_nLuxLevel,#4
1794                     ; 261 		WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
1796  0084 4b04          	push	#4
1797  0086 ae1002        	ldw	x,#4098
1798  0089 89            	pushw	x
1799  008a ae0000        	ldw	x,#0
1800  008d 89            	pushw	x
1801  008e cd0000        	call	_WriteEeprom
1803  0091 5b05          	addw	sp,#5
1804  0093               L715:
1805                     ; 263 	if((nLowBatTime==0)||(nLowBatTime>MAX_LOWBATTIME))
1807  0093 3d00          	tnz	_nLowBatTime
1808  0095 2706          	jreq	L525
1810  0097 b600          	ld	a,_nLowBatTime
1811  0099 a1ff          	cp	a,#255
1812  009b 2513          	jrult	L325
1813  009d               L525:
1814                     ; 265 		nLowBatTime=DEF_LOWBATTIME;
1816  009d 350a0000      	mov	_nLowBatTime,#10
1817                     ; 266 		WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
1819  00a1 4b0a          	push	#10
1820  00a3 ae1003        	ldw	x,#4099
1821  00a6 89            	pushw	x
1822  00a7 ae0000        	ldw	x,#0
1823  00aa 89            	pushw	x
1824  00ab cd0000        	call	_WriteEeprom
1826  00ae 5b05          	addw	sp,#5
1827  00b0               L325:
1828                     ; 268 }
1831  00b0 81            	ret
1878                     ; 270 void WriteEeprom(u32 addr, u8 data)
1878                     ; 271 {
1879                     .text:	section	.text,new
1880  0000               _WriteEeprom:
1882       00000000      OFST:	set	0
1885                     ; 272   FLASH_Unlock(FLASH_MemType_Data);
1887  0000 a6f7          	ld	a,#247
1888  0002 cd0000        	call	_FLASH_Unlock
1891  0005               L355:
1892                     ; 273   while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET)  ;  /* Wait until Data EEPROM area unlocked flag is set*/
1894  0005 a608          	ld	a,#8
1895  0007 cd0000        	call	_FLASH_GetFlagStatus
1897  000a 4d            	tnz	a
1898  000b 27f8          	jreq	L355
1899                     ; 274 	FLASH_ProgramByte(addr, data);
1901  000d 7b07          	ld	a,(OFST+7,sp)
1902  000f 88            	push	a
1903  0010 1e06          	ldw	x,(OFST+6,sp)
1904  0012 89            	pushw	x
1905  0013 1e06          	ldw	x,(OFST+6,sp)
1906  0015 89            	pushw	x
1907  0016 cd0000        	call	_FLASH_ProgramByte
1909  0019 5b05          	addw	sp,#5
1911  001b               L165:
1912                     ; 275 	while(!(FLASH_GetFlagStatus(FLASH_FLAG_EOP)));
1914  001b a604          	ld	a,#4
1915  001d cd0000        	call	_FLASH_GetFlagStatus
1917  0020 4d            	tnz	a
1918  0021 27f8          	jreq	L165
1919                     ; 276   FLASH_Lock(FLASH_MemType_Data);
1921  0023 a6f7          	ld	a,#247
1922  0025 cd0000        	call	_FLASH_Lock
1924                     ; 277 }
1927  0028 81            	ret
1940                     	xref	_TD_Delay01ms
1941                     	xdef	_WriteEeprom
1942                     	xdef	_ReadEeprom
1943                     	xdef	_Pir_SetConfig
1944                     	xdef	_Pir_GetConfig
1945                     	xdef	_Lux_SendCmd
1946                     	xdef	_Lux_SetMTreg
1947                     	xdef	_Lux_GetReading
1948                     	xdef	_RTC_SetWakeupPeriod
1949                     	xref.b	_nLowBatTime
1950                     	xref.b	_nPirHoldTime
1951                     	xref.b	_nPirLevel
1952                     	xref.b	_nLuxLevel
1953                     	xref	_RTC_ITConfig
1954                     	xref	_RTC_WakeUpCmd
1955                     	xref	_RTC_SetWakeUpCounter
1956                     	xref	_RTC_WakeUpClockConfig
1957                     	xref	_I2C_GetFlagStatus
1958                     	xref	_I2C_CheckEvent
1959                     	xref	_I2C_ReceiveData
1960                     	xref	_I2C_SendData
1961                     	xref	_I2C_Send7bitAddress
1962                     	xref	_I2C_AcknowledgeConfig
1963                     	xref	_I2C_GenerateSTOP
1964                     	xref	_I2C_GenerateSTART
1965                     	xref	_GPIO_ReadInputDataBit
1966                     	xref	_GPIO_ResetBits
1967                     	xref	_GPIO_SetBits
1968                     	xref	_GPIO_Init
1969                     	xref	_FLASH_GetFlagStatus
1970                     	xref	_FLASH_ReadByte
1971                     	xref	_FLASH_ProgramByte
1972                     	xref	_FLASH_Lock
1973                     	xref	_FLASH_Unlock
1992                     	xref	c_imul
1993                     	end
