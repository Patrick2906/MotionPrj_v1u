   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _MotionFlags:
   6  0000 0200          	dc.w	512
   7  0002               _MotionFlags2:
   8  0002 0000          	dc.w	0
   9  0004               _strxBuf:
  10  0004 0001          	dc.w	_strBuf
  11  0006               _bCmpEnd:
  12  0006 00            	dc.b	0
  13  0007               _nLuxLevel:
  14  0007 04            	dc.b	4
  15  0008               _nPirLevel:
  16  0008 04            	dc.b	4
  17  0009               _nPirHoldTime:
  18  0009 08            	dc.b	8
  19  000a               _nLowBatTime:
  20  000a 0a            	dc.b	10
  21  000b               _nTCount:
  22  000b 00            	dc.b	0
  23  000c               _nPressed:
  24  000c 00            	dc.b	0
  73                     ; 19 u8 ToChar09AF(u8 nNum)  //nNum=0..15
  73                     ; 20 {
  75                     .text:	section	.text,new
  76  0000               _ToChar09AF:
  78  0000 88            	push	a
  79       00000001      OFST:	set	1
  82                     ; 21 	u8 nChar=(nNum<=9)?(0x30+nNum):(0x41+nNum-10);
  84  0001 a10a          	cp	a,#10
  85  0003 2404          	jruge	L6
  86  0005 ab30          	add	a,#48
  87  0007 2002          	jra	L01
  88  0009               L6:
  89  0009 ab37          	add	a,#55
  90  000b               L01:
  91  000b 6b01          	ld	(OFST+0,sp),a
  92                     ; 22 	return nChar;
  94  000d 7b01          	ld	a,(OFST+0,sp)
  97  000f 5b01          	addw	sp,#1
  98  0011 81            	ret
 141                     ; 25 u8 FromChar09AF(u8 nChar)  //nChar='0'..'9','A'..'F'
 141                     ; 26 {
 142                     .text:	section	.text,new
 143  0000               _FromChar09AF:
 145  0000 88            	push	a
 146       00000001      OFST:	set	1
 149                     ; 27 	u8 nNum=(nChar<='9')?(nChar-0x30):(nChar-0x41+10);
 151  0001 a13a          	cp	a,#58
 152  0003 2404          	jruge	L41
 153  0005 a030          	sub	a,#48
 154  0007 2002          	jra	L61
 155  0009               L41:
 156  0009 a037          	sub	a,#55
 157  000b               L61:
 158  000b 6b01          	ld	(OFST+0,sp),a
 159                     ; 28 	return nNum;
 161  000d 7b01          	ld	a,(OFST+0,sp)
 164  000f 5b01          	addw	sp,#1
 165  0011 81            	ret
 201                     ; 31 u8 putchar (u8 c)
 201                     ; 32 {
 202                     .text:	section	.text,new
 203  0000               _putchar:
 205  0000 88            	push	a
 206       00000000      OFST:	set	0
 209                     ; 33 	disableInterrupts(); 
 212  0001 9b            sim
 216  0002               L57:
 217                     ; 34   while(!(USART1->SR & (1<<6)));
 219  0002 c65230        	ld	a,21040
 220  0005 a540          	bcp	a,#64
 221  0007 27f9          	jreq	L57
 222                     ; 35 	USART1->DR=(u8)c;
 224  0009 7b01          	ld	a,(OFST+1,sp)
 225  000b c75231        	ld	21041,a
 226                     ; 36 	enableInterrupts(); 
 229  000e 9a            rim
 231                     ; 38   return (c);
 234  000f 7b01          	ld	a,(OFST+1,sp)
 237  0011 5b01          	addw	sp,#1
 238  0013 81            	ret
 274                     ; 41 void myputs(u8 *str)
 274                     ; 42 {
 275                     .text:	section	.text,new
 276  0000               _myputs:
 278  0000 89            	pushw	x
 279       00000000      OFST:	set	0
 282  0001 200d          	jra	L121
 283  0003               L711:
 284                     ; 45 		putchar(*str);
 286  0003 1e01          	ldw	x,(OFST+1,sp)
 287  0005 f6            	ld	a,(x)
 288  0006 cd0000        	call	_putchar
 290                     ; 46 		str++;
 292  0009 1e01          	ldw	x,(OFST+1,sp)
 293  000b 1c0001        	addw	x,#1
 294  000e 1f01          	ldw	(OFST+1,sp),x
 295  0010               L121:
 296                     ; 43 	while(*str!=0)
 298  0010 1e01          	ldw	x,(OFST+1,sp)
 299  0012 7d            	tnz	(x)
 300  0013 26ee          	jrne	L711
 301                     ; 48 	putchar(0x0D);
 303  0015 a60d          	ld	a,#13
 304  0017 cd0000        	call	_putchar
 306                     ; 49 	putchar(0x0A);
 308  001a a60a          	ld	a,#10
 309  001c cd0000        	call	_putchar
 311                     ; 50 }
 314  001f 85            	popw	x
 315  0020 81            	ret
 382                     ; 52 bool mystrcmp(u8 *strat,u8 *strstandard)  //return TRUE if strat has same former part of strstandard; bCmpEnd indicates totally match
 382                     ; 53 {
 383                     .text:	section	.text,new
 384  0000               _mystrcmp:
 386  0000 89            	pushw	x
 387       00000000      OFST:	set	0
 390  0001 201e          	jra	L161
 391  0003               L751:
 392                     ; 56 		if(((*strat)!=(u8)(*strstandard))||((*strat)==0))
 394  0003 1e01          	ldw	x,(OFST+1,sp)
 395  0005 f6            	ld	a,(x)
 396  0006 1e05          	ldw	x,(OFST+5,sp)
 397  0008 f1            	cp	a,(x)
 398  0009 2605          	jrne	L761
 400  000b 1e01          	ldw	x,(OFST+1,sp)
 401  000d 7d            	tnz	(x)
 402  000e 2603          	jrne	L561
 403  0010               L761:
 404                     ; 58 			return FALSE;
 406  0010 4f            	clr	a
 408  0011 2021          	jra	L23
 409  0013               L561:
 410                     ; 60 		strstandard++;
 412  0013 1e05          	ldw	x,(OFST+5,sp)
 413  0015 1c0001        	addw	x,#1
 414  0018 1f05          	ldw	(OFST+5,sp),x
 415                     ; 61 		strat++;
 417  001a 1e01          	ldw	x,(OFST+1,sp)
 418  001c 1c0001        	addw	x,#1
 419  001f 1f01          	ldw	(OFST+1,sp),x
 420  0021               L161:
 421                     ; 54 	while((*strstandard)!=0)
 423  0021 1e05          	ldw	x,(OFST+5,sp)
 424  0023 7d            	tnz	(x)
 425  0024 26dd          	jrne	L751
 426                     ; 63 	bCmpEnd=(*strat==0);
 428  0026 1e01          	ldw	x,(OFST+1,sp)
 429  0028 7d            	tnz	(x)
 430  0029 2604          	jrne	L62
 431  002b a601          	ld	a,#1
 432  002d 2001          	jra	L03
 433  002f               L62:
 434  002f 4f            	clr	a
 435  0030               L03:
 436  0030 b706          	ld	_bCmpEnd,a
 437                     ; 64 	return TRUE;
 439  0032 a601          	ld	a,#1
 441  0034               L23:
 443  0034 85            	popw	x
 444  0035 81            	ret
 543                     ; 67 void ParseAtCmd(void) //Processed by visual effect, to be interacted via hyper terminal.
 543                     ; 68 {
 544                     .text:	section	.text,new
 545  0000               _ParseAtCmd:
 547  0000 520d          	subw	sp,#13
 548       0000000d      OFST:	set	13
 551                     ; 71 	bool bGoodCmd=FALSE,bcmdLed=FALSE,bcmdLowBat=FALSE;
 553  0002 0f06          	clr	(OFST-7,sp)
 556  0004 0f03          	clr	(OFST-10,sp)
 559  0006 0f02          	clr	(OFST-11,sp)
 560                     ; 73 	if(MotionFlags&bmCmdEcho)
 562  0008 b600          	ld	a,_MotionFlags
 563  000a a540          	bcp	a,#64
 564  000c 2706          	jreq	L342
 565                     ; 74 		myputs(strAT);
 567  000e ae0013        	ldw	x,#_strAT
 568  0011 cd0000        	call	_myputs
 570  0014               L342:
 571                     ; 75 	MotionFlags&=~bmLedDelay;
 573  0014 72190000      	bres	_MotionFlags,#4
 574                     ; 76 	if(mystrcmp(strAT, "AT"))
 576  0018 ae0075        	ldw	x,#L742
 577  001b 89            	pushw	x
 578  001c ae0013        	ldw	x,#_strAT
 579  001f cd0000        	call	_mystrcmp
 581  0022 85            	popw	x
 582  0023 4d            	tnz	a
 583  0024 2603          	jrne	L04
 584  0026 cc04de        	jp	L542
 585  0029               L04:
 586                     ; 78 		if(bCmpEnd)
 588  0029 3d06          	tnz	_bCmpEnd
 589  002b 270e          	jreq	L152
 590                     ; 80 			myputs(STR_FWVER);
 592  002d ae0065        	ldw	x,#L352
 593  0030 cd0000        	call	_myputs
 595                     ; 85 			bGoodCmd=TRUE;
 597  0033 a601          	ld	a,#1
 598  0035 6b06          	ld	(OFST-7,sp),a
 600  0037 acde04de      	jpf	L542
 601  003b               L152:
 602                     ; 87 		if(mystrcmp(strAT, "ATE"))
 604  003b ae0061        	ldw	x,#L162
 605  003e 89            	pushw	x
 606  003f ae0013        	ldw	x,#_strAT
 607  0042 cd0000        	call	_mystrcmp
 609  0045 85            	popw	x
 610  0046 4d            	tnz	a
 611  0047 271f          	jreq	L752
 612                     ; 89 			if(bCmpEnd)
 614  0049 3d06          	tnz	_bCmpEnd
 615  004b 2603          	jrne	L24
 616  004d cc04de        	jp	L542
 617  0050               L24:
 618                     ; 91 				if(MotionFlags&bmCmdEcho)
 620  0050 b600          	ld	a,_MotionFlags
 621  0052 a540          	bcp	a,#64
 622  0054 2706          	jreq	L562
 623                     ; 92 					MotionFlags&=~bmCmdEcho;
 625  0056 721d0000      	bres	_MotionFlags,#6
 627  005a 2004          	jra	L762
 628  005c               L562:
 629                     ; 94 					MotionFlags|=bmCmdEcho;
 631  005c 721c0000      	bset	_MotionFlags,#6
 632  0060               L762:
 633                     ; 95 				bGoodCmd=TRUE;
 635  0060 a601          	ld	a,#1
 636  0062 6b06          	ld	(OFST-7,sp),a
 637  0064 acde04de      	jpf	L542
 638  0068               L752:
 639                     ; 98 		if(mystrcmp(strAT, "ATSTA"))
 641  0068 ae005b        	ldw	x,#L572
 642  006b 89            	pushw	x
 643  006c ae0013        	ldw	x,#_strAT
 644  006f cd0000        	call	_mystrcmp
 646  0072 85            	popw	x
 647  0073 4d            	tnz	a
 648  0074 2603          	jrne	L44
 649  0076 cc0132        	jp	L372
 650  0079               L44:
 651                     ; 100 			if(bCmpEnd)
 653  0079 3d06          	tnz	_bCmpEnd
 654  007b 2603          	jrne	L64
 655  007d cc04de        	jp	L542
 656  0080               L64:
 657                     ; 102 				byteTxD[0]=0;
 659  0080 0f07          	clr	(OFST-6,sp)
 660                     ; 103 				byteTxD[1]=0;
 662  0082 0f08          	clr	(OFST-5,sp)
 663                     ; 104 				if(MotionFlags2&bm2PirRecheck)
 665  0084 b603          	ld	a,_MotionFlags2+1
 666  0086 a502          	bcp	a,#2
 667  0088 2708          	jreq	L103
 668                     ; 106 					MotionFlags2&=~bm2PirRecheck;
 670  008a 72130003      	bres	_MotionFlags2+1,#1
 671                     ; 107 					byteTxD[0]=1;
 673  008e a601          	ld	a,#1
 674  0090 6b07          	ld	(OFST-6,sp),a
 675  0092               L103:
 676                     ; 109 				if(MotionFlags&bmIntPirStaCmd)
 678  0092 b600          	ld	a,_MotionFlags
 679  0094 a504          	bcp	a,#4
 680  0096 2708          	jreq	L303
 681                     ; 111 					MotionFlags&=~bmIntPirStaCmd;
 683  0098 72150000      	bres	_MotionFlags,#2
 684                     ; 112 					byteTxD[1]=8;
 686  009c a608          	ld	a,#8
 687  009e 6b08          	ld	(OFST-5,sp),a
 688  00a0               L303:
 689                     ; 114 				if(getPinBtn==RESET)
 691  00a0 4b01          	push	#1
 692  00a2 ae5005        	ldw	x,#20485
 693  00a5 cd0000        	call	_GPIO_ReadInputDataBit
 695  00a8 5b01          	addw	sp,#1
 696  00aa 4d            	tnz	a
 697  00ab 262c          	jrne	L503
 698                     ; 116 					if(nPressed>=TIME_LONGPRESS)
 700  00ad b60c          	ld	a,_nPressed
 701  00af a128          	cp	a,#40
 702  00b1 2508          	jrult	L703
 703                     ; 117 						byteTxD[1]+=7;
 705  00b3 7b08          	ld	a,(OFST-5,sp)
 706  00b5 ab07          	add	a,#7
 707  00b7 6b08          	ld	(OFST-5,sp),a
 709  00b9 201e          	jra	L503
 710  00bb               L703:
 711                     ; 119 						if(nPressed>=TIME_MIDPRESS)
 713  00bb b60c          	ld	a,_nPressed
 714  00bd a114          	cp	a,#20
 715  00bf 2508          	jrult	L313
 716                     ; 120 							byteTxD[1]+=5;
 718  00c1 7b08          	ld	a,(OFST-5,sp)
 719  00c3 ab05          	add	a,#5
 720  00c5 6b08          	ld	(OFST-5,sp),a
 722  00c7 2010          	jra	L503
 723  00c9               L313:
 724                     ; 122 							if(nPressed>=TIME_SHORTPRESS)
 726  00c9 b60c          	ld	a,_nPressed
 727  00cb a108          	cp	a,#8
 728  00cd 2508          	jrult	L713
 729                     ; 123 								byteTxD[1]+=3;
 731  00cf 7b08          	ld	a,(OFST-5,sp)
 732  00d1 ab03          	add	a,#3
 733  00d3 6b08          	ld	(OFST-5,sp),a
 735  00d5 2002          	jra	L503
 736  00d7               L713:
 737                     ; 125 									byteTxD[1]+=1;
 739  00d7 0c08          	inc	(OFST-5,sp)
 740  00d9               L503:
 741                     ; 128 				nInt=Lux_GetReading(LUX_I2CCmd_AutoRes);
 743  00d9 a610          	ld	a,#16
 744  00db cd0000        	call	_Lux_GetReading
 746  00de 1f04          	ldw	(OFST-9,sp),x
 747                     ; 129 				byteTxD[0]=ToChar09AF(byteTxD[0]);
 749  00e0 7b07          	ld	a,(OFST-6,sp)
 750  00e2 cd0000        	call	_ToChar09AF
 752  00e5 6b07          	ld	(OFST-6,sp),a
 753                     ; 130 				byteTxD[1]=ToChar09AF(byteTxD[1]);
 755  00e7 7b08          	ld	a,(OFST-5,sp)
 756  00e9 cd0000        	call	_ToChar09AF
 758  00ec 6b08          	ld	(OFST-5,sp),a
 759                     ; 131 				byteTxD[2]=ToChar09AF((nInt>>12)&0x0F);
 761  00ee 1e04          	ldw	x,(OFST-9,sp)
 762  00f0 01            	rrwa	x,a
 763  00f1 4f            	clr	a
 764  00f2 41            	exg	a,xl
 765  00f3 4e            	swap	a
 766  00f4 a40f          	and	a,#15
 767  00f6 02            	rlwa	x,a
 768  00f7 01            	rrwa	x,a
 769  00f8 a40f          	and	a,#15
 770  00fa 5f            	clrw	x
 771  00fb cd0000        	call	_ToChar09AF
 773  00fe 6b09          	ld	(OFST-4,sp),a
 774                     ; 132 				byteTxD[3]=ToChar09AF((nInt>>8)&0x0F);
 776  0100 7b04          	ld	a,(OFST-9,sp)
 777  0102 a40f          	and	a,#15
 778  0104 cd0000        	call	_ToChar09AF
 780  0107 6b0a          	ld	(OFST-3,sp),a
 781                     ; 133 				byteTxD[4]=ToChar09AF((nInt>>4)&0x0F);
 783  0109 1e04          	ldw	x,(OFST-9,sp)
 784  010b 54            	srlw	x
 785  010c 54            	srlw	x
 786  010d 54            	srlw	x
 787  010e 54            	srlw	x
 788  010f 01            	rrwa	x,a
 789  0110 a40f          	and	a,#15
 790  0112 5f            	clrw	x
 791  0113 cd0000        	call	_ToChar09AF
 793  0116 6b0b          	ld	(OFST-2,sp),a
 794                     ; 134 				byteTxD[5]=ToChar09AF(nInt&0x0F);
 796  0118 7b05          	ld	a,(OFST-8,sp)
 797  011a a40f          	and	a,#15
 798  011c cd0000        	call	_ToChar09AF
 800  011f 6b0c          	ld	(OFST-1,sp),a
 801                     ; 135 				byteTxD[6]=0;
 803  0121 0f0d          	clr	(OFST+0,sp)
 804                     ; 137 				myputs(byteTxD);
 806  0123 96            	ldw	x,sp
 807  0124 1c0007        	addw	x,#OFST-6
 808  0127 cd0000        	call	_myputs
 810                     ; 138 				bGoodCmd=TRUE;
 812  012a a601          	ld	a,#1
 813  012c 6b06          	ld	(OFST-7,sp),a
 814  012e acde04de      	jpf	L542
 815  0132               L372:
 816                     ; 141 		if(mystrcmp(strAT, "ATRST"))
 818  0132 ae0055        	ldw	x,#L723
 819  0135 89            	pushw	x
 820  0136 ae0013        	ldw	x,#_strAT
 821  0139 cd0000        	call	_mystrcmp
 823  013c 85            	popw	x
 824  013d 4d            	tnz	a
 825  013e 271d          	jreq	L523
 826                     ; 143 			if(bCmpEnd)
 828  0140 3d06          	tnz	_bCmpEnd
 829  0142 2603          	jrne	L05
 830  0144 cc04de        	jp	L542
 831  0147               L05:
 832                     ; 145 				myputs(STR_FWVER);
 834  0147 ae0065        	ldw	x,#L352
 835  014a cd0000        	call	_myputs
 837                     ; 146 				bGoodCmd=TRUE;
 839  014d a601          	ld	a,#1
 840  014f 6b06          	ld	(OFST-7,sp),a
 841                     ; 147 				WWDG->CR|=0x80;
 843  0151 721e50d3      	bset	20691,#7
 844                     ; 148 				WWDG->CR&=~0x40;
 846  0155 721d50d3      	bres	20691,#6
 847  0159 acde04de      	jpf	L542
 848  015d               L523:
 849                     ; 151 		if(mystrcmp(strAT, "ATDEF"))
 851  015d ae004f        	ldw	x,#L733
 852  0160 89            	pushw	x
 853  0161 ae0013        	ldw	x,#_strAT
 854  0164 cd0000        	call	_mystrcmp
 856  0167 85            	popw	x
 857  0168 4d            	tnz	a
 858  0169 276c          	jreq	L533
 859                     ; 153 			if(bCmpEnd)
 861  016b 3d06          	tnz	_bCmpEnd
 862  016d 2603          	jrne	L25
 863  016f cc04de        	jp	L542
 864  0172               L25:
 865                     ; 155 				nLuxLevel=DEF_LUXLEVEL;
 867  0172 35040007      	mov	_nLuxLevel,#4
 868                     ; 156 				Lux_SetMTreg();
 870  0176 cd0000        	call	_Lux_SetMTreg
 872                     ; 157 				nPirHoldTime=DEF_PIRHOLDTIME;
 874  0179 35080009      	mov	_nPirHoldTime,#8
 875                     ; 158 				nPirLevel=DEF_PIRLEVEL;
 877  017d 35040008      	mov	_nPirLevel,#4
 878                     ; 159 				nLowBatTime=DEF_LOWBATTIME;
 880  0181 350a000a      	mov	_nLowBatTime,#10
 881                     ; 160 				WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
 883  0185 4b08          	push	#8
 884  0187 ae1000        	ldw	x,#4096
 885  018a 89            	pushw	x
 886  018b ae0000        	ldw	x,#0
 887  018e 89            	pushw	x
 888  018f cd0000        	call	_WriteEeprom
 890  0192 5b05          	addw	sp,#5
 891                     ; 161 				WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
 893  0194 3b0008        	push	_nPirLevel
 894  0197 ae1001        	ldw	x,#4097
 895  019a 89            	pushw	x
 896  019b ae0000        	ldw	x,#0
 897  019e 89            	pushw	x
 898  019f cd0000        	call	_WriteEeprom
 900  01a2 5b05          	addw	sp,#5
 901                     ; 162 				WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
 903  01a4 3b0007        	push	_nLuxLevel
 904  01a7 ae1002        	ldw	x,#4098
 905  01aa 89            	pushw	x
 906  01ab ae0000        	ldw	x,#0
 907  01ae 89            	pushw	x
 908  01af cd0000        	call	_WriteEeprom
 910  01b2 5b05          	addw	sp,#5
 911                     ; 163 				WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
 913  01b4 3b000a        	push	_nLowBatTime
 914  01b7 ae1003        	ldw	x,#4099
 915  01ba 89            	pushw	x
 916  01bb ae0000        	ldw	x,#0
 917  01be 89            	pushw	x
 918  01bf cd0000        	call	_WriteEeprom
 920  01c2 5b05          	addw	sp,#5
 921                     ; 164 				Pir_SetConfig(TRUE);
 923  01c4 a601          	ld	a,#1
 924  01c6 cd0000        	call	_Pir_SetConfig
 926                     ; 165 				myputs(STR_FWVER);
 928  01c9 ae0065        	ldw	x,#L352
 929  01cc cd0000        	call	_myputs
 931                     ; 166 				bGoodCmd=TRUE;
 933  01cf a601          	ld	a,#1
 934  01d1 6b06          	ld	(OFST-7,sp),a
 935  01d3 acde04de      	jpf	L542
 936  01d7               L533:
 937                     ; 169 		if(mystrcmp(strAT, "ATLED="))
 939  01d7 ae0048        	ldw	x,#L743
 940  01da 89            	pushw	x
 941  01db ae0013        	ldw	x,#_strAT
 942  01de cd0000        	call	_mystrcmp
 944  01e1 85            	popw	x
 945  01e2 4d            	tnz	a
 946  01e3 2603          	jrne	L45
 947  01e5 cc0307        	jp	L543
 948  01e8               L45:
 949                     ; 171 			if(bCmpEnd||nlenstrAT!=9)
 951  01e8 3d06          	tnz	_bCmpEnd
 952  01ea 2703          	jreq	L65
 953  01ec cc04de        	jp	L542
 954  01ef               L65:
 956  01ef b600          	ld	a,_nlenstrAT
 957  01f1 a109          	cp	a,#9
 958  01f3 2703          	jreq	L06
 959  01f5 cc04de        	jp	L542
 960  01f8               L06:
 961                     ; 175 				bGoodCmd=TRUE;
 963  01f8 a601          	ld	a,#1
 964  01fa 6b06          	ld	(OFST-7,sp),a
 965                     ; 176 				byteTxD[0]=strAT[6];
 967  01fc b619          	ld	a,_strAT+6
 968  01fe 6b07          	ld	(OFST-6,sp),a
 969                     ; 177 				byteTxD[1]=strAT[7];
 971  0200 b61a          	ld	a,_strAT+7
 972  0202 6b08          	ld	(OFST-5,sp),a
 973                     ; 178 				byteTxD[2]=strAT[8];
 975  0204 b61b          	ld	a,_strAT+8
 976  0206 6b09          	ld	(OFST-4,sp),a
 977                     ; 179 				byteTxD[3]=0;
 979  0208 0f0a          	clr	(OFST-3,sp)
 980                     ; 180 				myputs(byteTxD);
 982  020a 96            	ldw	x,sp
 983  020b 1c0007        	addw	x,#OFST-6
 984  020e cd0000        	call	_myputs
 986                     ; 182 				byteTxD[4]=FromChar09AF(strAT[6])&3;
 988  0211 b619          	ld	a,_strAT+6
 989  0213 cd0000        	call	_FromChar09AF
 991  0216 a403          	and	a,#3
 992  0218 6b0b          	ld	(OFST-2,sp),a
 993                     ; 183 				offPinLedGreen;
 995  021a 4b08          	push	#8
 996  021c ae5000        	ldw	x,#20480
 997  021f cd0000        	call	_GPIO_SetBits
 999  0222 84            	pop	a
1000                     ; 184 				switch(byteTxD[4])
1002  0223 7b0b          	ld	a,(OFST-2,sp)
1004                     ; 203 						break;
1005  0225 4d            	tnz	a
1006  0226 270b          	jreq	L171
1007  0228 4a            	dec	a
1008  0229 2712          	jreq	L371
1009  022b 4a            	dec	a
1010  022c 2722          	jreq	L571
1011  022e 4a            	dec	a
1012  022f 271f          	jreq	L571
1013  0231 203a          	jra	L163
1014  0233               L171:
1015                     ; 186 					case 0:
1015                     ; 187 						MotionFlags&=~bmLedGreenFlash;
1017  0233 72110001      	bres	_MotionFlags+1,#0
1018                     ; 188 						MotionFlags&=~bmLedGreen2Hz;
1020  0237 72130001      	bres	_MotionFlags+1,#1
1021                     ; 189 						break;
1023  023b 2030          	jra	L163
1024  023d               L371:
1025                     ; 190 					case 1:
1025                     ; 191 						MotionFlags&=~bmLedGreenFlash;
1027  023d 72110001      	bres	_MotionFlags+1,#0
1028                     ; 192 						MotionFlags&=~bmLedGreen2Hz;
1030  0241 72130001      	bres	_MotionFlags+1,#1
1031                     ; 193 						onPinLedGreen;
1033  0245 4b08          	push	#8
1034  0247 ae5000        	ldw	x,#20480
1035  024a cd0000        	call	_GPIO_ResetBits
1037  024d 84            	pop	a
1038                     ; 194 						break;
1040  024e 201d          	jra	L163
1041  0250               L571:
1042                     ; 195 					case 2:
1042                     ; 196 					case 3:
1042                     ; 197 						onPinLedGreen;
1044  0250 4b08          	push	#8
1045  0252 ae5000        	ldw	x,#20480
1046  0255 cd0000        	call	_GPIO_ResetBits
1048  0258 84            	pop	a
1049                     ; 198 						MotionFlags|=bmLedGreenFlash;
1051  0259 72100001      	bset	_MotionFlags+1,#0
1052                     ; 199 						if(byteTxD[4]==2)
1054  025d 7b0b          	ld	a,(OFST-2,sp)
1055  025f a102          	cp	a,#2
1056  0261 2606          	jrne	L363
1057                     ; 200 							MotionFlags&=~bmLedGreen2Hz;
1059  0263 72130001      	bres	_MotionFlags+1,#1
1061  0267 2004          	jra	L163
1062  0269               L363:
1063                     ; 202 							MotionFlags|=bmLedGreen2Hz;
1065  0269 72120001      	bset	_MotionFlags+1,#1
1066  026d               L163:
1067                     ; 206 				byteTxD[4]=(FromChar09AF(strAT[6])>>2)&3;
1069  026d b619          	ld	a,_strAT+6
1070  026f cd0000        	call	_FromChar09AF
1072  0272 44            	srl	a
1073  0273 44            	srl	a
1074  0274 a403          	and	a,#3
1075  0276 6b0b          	ld	(OFST-2,sp),a
1076                     ; 207 				offPinLedRed;
1078  0278 4b04          	push	#4
1079  027a ae5000        	ldw	x,#20480
1080  027d cd0000        	call	_GPIO_SetBits
1082  0280 84            	pop	a
1083                     ; 208 				switch(byteTxD[4])
1085  0281 7b0b          	ld	a,(OFST-2,sp)
1087                     ; 227 						break;
1088  0283 4d            	tnz	a
1089  0284 270b          	jreq	L771
1090  0286 4a            	dec	a
1091  0287 2712          	jreq	L102
1092  0289 4a            	dec	a
1093  028a 2722          	jreq	L302
1094  028c 4a            	dec	a
1095  028d 271f          	jreq	L302
1096  028f 203a          	jra	L173
1097  0291               L771:
1098                     ; 210 					case 0:
1098                     ; 211 						MotionFlags&=~bmLedRedFlash;
1100  0291 72150001      	bres	_MotionFlags+1,#2
1101                     ; 212 						MotionFlags&=~bmLedRed2Hz;
1103  0295 72170001      	bres	_MotionFlags+1,#3
1104                     ; 213 						break;
1106  0299 2030          	jra	L173
1107  029b               L102:
1108                     ; 214 					case 1:
1108                     ; 215 						MotionFlags&=~bmLedRedFlash;
1110  029b 72150001      	bres	_MotionFlags+1,#2
1111                     ; 216 						MotionFlags&=~bmLedRed2Hz;
1113  029f 72170001      	bres	_MotionFlags+1,#3
1114                     ; 217 						onPinLedRed;
1116  02a3 4b04          	push	#4
1117  02a5 ae5000        	ldw	x,#20480
1118  02a8 cd0000        	call	_GPIO_ResetBits
1120  02ab 84            	pop	a
1121                     ; 218 						break;
1123  02ac 201d          	jra	L173
1124  02ae               L302:
1125                     ; 219 					case 2:
1125                     ; 220 					case 3:
1125                     ; 221 						onPinLedRed;
1127  02ae 4b04          	push	#4
1128  02b0 ae5000        	ldw	x,#20480
1129  02b3 cd0000        	call	_GPIO_ResetBits
1131  02b6 84            	pop	a
1132                     ; 222 						MotionFlags|=bmLedRedFlash;
1134  02b7 72140001      	bset	_MotionFlags+1,#2
1135                     ; 223 						if(byteTxD[4]==2)
1137  02bb 7b0b          	ld	a,(OFST-2,sp)
1138  02bd a102          	cp	a,#2
1139  02bf 2606          	jrne	L373
1140                     ; 224 							MotionFlags&=~bmLedRed2Hz;
1142  02c1 72170001      	bres	_MotionFlags+1,#3
1144  02c5 2004          	jra	L173
1145  02c7               L373:
1146                     ; 226 							MotionFlags|=bmLedRed2Hz;
1148  02c7 72160001      	bset	_MotionFlags+1,#3
1149  02cb               L173:
1150                     ; 229 				if((strAT[6]&0x0F)==0)
1152  02cb b619          	ld	a,_strAT+6
1153  02cd a50f          	bcp	a,#15
1154  02cf 2608          	jrne	L773
1155                     ; 230 					MotionFlags|=bmHalt;
1157  02d1 721e0000      	bset	_MotionFlags,#7
1159  02d5 acde04de      	jpf	L542
1160  02d9               L773:
1161                     ; 233 					nDelayTime=((FromChar09AF(strAT[7])<<4)+(FromChar09AF(strAT[8]))<<2);
1163  02d9 b61b          	ld	a,_strAT+8
1164  02db cd0000        	call	_FromChar09AF
1166  02de 6b01          	ld	(OFST-12,sp),a
1167  02e0 b61a          	ld	a,_strAT+7
1168  02e2 cd0000        	call	_FromChar09AF
1170  02e5 97            	ld	xl,a
1171  02e6 a610          	ld	a,#16
1172  02e8 42            	mul	x,a
1173  02e9 01            	rrwa	x,a
1174  02ea 1b01          	add	a,(OFST-12,sp)
1175  02ec 2401          	jrnc	L63
1176  02ee 5c            	incw	x
1177  02ef               L63:
1178  02ef 02            	rlwa	x,a
1179  02f0 58            	sllw	x
1180  02f1 58            	sllw	x
1181  02f2 bf23          	ldw	_nDelayTime,x
1182                     ; 234 					if(nDelayTime!=0)
1184  02f4 be23          	ldw	x,_nDelayTime
1185  02f6 2603          	jrne	L26
1186  02f8 cc04de        	jp	L542
1187  02fb               L26:
1188                     ; 236 						bcmdLed=TRUE;
1190  02fb a601          	ld	a,#1
1191  02fd 6b03          	ld	(OFST-10,sp),a
1192                     ; 237 						MotionFlags|=bmLedDelay;
1194  02ff 72180000      	bset	_MotionFlags,#4
1195  0303 acde04de      	jpf	L542
1196  0307               L543:
1197                     ; 242 		if(mystrcmp(strAT, "ATPIR"))
1199  0307 ae0042        	ldw	x,#L114
1200  030a 89            	pushw	x
1201  030b ae0013        	ldw	x,#_strAT
1202  030e cd0000        	call	_mystrcmp
1204  0311 85            	popw	x
1205  0312 4d            	tnz	a
1206  0313 2603          	jrne	L46
1207  0315 cc03dd        	jp	L704
1208  0318               L46:
1209                     ; 244 			if(bCmpEnd)
1211  0318 3d06          	tnz	_bCmpEnd
1212  031a 2707          	jreq	L314
1213                     ; 246 				bGoodCmd=TRUE;
1215  031c a601          	ld	a,#1
1216  031e 6b06          	ld	(OFST-7,sp),a
1218  0320 cc03ab        	jra	L514
1219  0323               L314:
1220                     ; 249 				if(mystrcmp(strAT, "ATPIRHDTM="))
1222  0323 ae0037        	ldw	x,#L124
1223  0326 89            	pushw	x
1224  0327 ae0013        	ldw	x,#_strAT
1225  032a cd0000        	call	_mystrcmp
1227  032d 85            	popw	x
1228  032e 4d            	tnz	a
1229  032f 2734          	jreq	L714
1230                     ; 251 					if(bCmpEnd||nlenstrAT!=11)
1232  0331 3d06          	tnz	_bCmpEnd
1233  0333 2676          	jrne	L514
1235  0335 b600          	ld	a,_nlenstrAT
1236  0337 a10b          	cp	a,#11
1237  0339 2670          	jrne	L514
1238                     ; 255 						byteTxD[4]=FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
1240  033b b61d          	ld	a,_strAT+10
1241  033d cd0000        	call	_FromChar09AF
1243  0340 6b0b          	ld	(OFST-2,sp),a
1244                     ; 256 						if(byteTxD[4]!=0)
1246  0342 0d0b          	tnz	(OFST-2,sp)
1247  0344 2765          	jreq	L514
1248                     ; 258 							nPirHoldTime=byteTxD[4];
1250  0346 7b0b          	ld	a,(OFST-2,sp)
1251  0348 b709          	ld	_nPirHoldTime,a
1252                     ; 259 							Pir_SetConfig(TRUE);
1254  034a a601          	ld	a,#1
1255  034c cd0000        	call	_Pir_SetConfig
1257                     ; 260 							WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
1259  034f 3b0009        	push	_nPirHoldTime
1260  0352 ae1000        	ldw	x,#4096
1261  0355 89            	pushw	x
1262  0356 ae0000        	ldw	x,#0
1263  0359 89            	pushw	x
1264  035a cd0000        	call	_WriteEeprom
1266  035d 5b05          	addw	sp,#5
1267                     ; 261 							bGoodCmd=TRUE;
1269  035f a601          	ld	a,#1
1270  0361 6b06          	ld	(OFST-7,sp),a
1271  0363 2046          	jra	L514
1272  0365               L714:
1273                     ; 265 				if(mystrcmp(strAT, "ATPIRSSLV="))
1275  0365 ae002c        	ldw	x,#L734
1276  0368 89            	pushw	x
1277  0369 ae0013        	ldw	x,#_strAT
1278  036c cd0000        	call	_mystrcmp
1280  036f 85            	popw	x
1281  0370 4d            	tnz	a
1282  0371 2738          	jreq	L514
1283                     ; 267 					if(bCmpEnd||nlenstrAT!=11)
1285  0373 3d06          	tnz	_bCmpEnd
1286  0375 2634          	jrne	L514
1288  0377 b600          	ld	a,_nlenstrAT
1289  0379 a10b          	cp	a,#11
1290  037b 262e          	jrne	L514
1291                     ; 271 						byteTxD[4]=FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
1293  037d b61d          	ld	a,_strAT+10
1294  037f cd0000        	call	_FromChar09AF
1296  0382 6b0b          	ld	(OFST-2,sp),a
1297                     ; 272 						if((byteTxD[4]>=1)&&(byteTxD[4]<=8))
1299  0384 0d0b          	tnz	(OFST-2,sp)
1300  0386 2723          	jreq	L514
1302  0388 7b0b          	ld	a,(OFST-2,sp)
1303  038a a109          	cp	a,#9
1304  038c 241d          	jruge	L514
1305                     ; 274 							nPirLevel=byteTxD[4];
1307  038e 7b0b          	ld	a,(OFST-2,sp)
1308  0390 b708          	ld	_nPirLevel,a
1309                     ; 275 							Pir_SetConfig(TRUE);
1311  0392 a601          	ld	a,#1
1312  0394 cd0000        	call	_Pir_SetConfig
1314                     ; 276 							WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
1316  0397 3b0008        	push	_nPirLevel
1317  039a ae1001        	ldw	x,#4097
1318  039d 89            	pushw	x
1319  039e ae0000        	ldw	x,#0
1320  03a1 89            	pushw	x
1321  03a2 cd0000        	call	_WriteEeprom
1323  03a5 5b05          	addw	sp,#5
1324                     ; 277 							bGoodCmd=TRUE;
1326  03a7 a601          	ld	a,#1
1327  03a9 6b06          	ld	(OFST-7,sp),a
1328  03ab               L514:
1329                     ; 282 			if(bGoodCmd)
1331  03ab 0d06          	tnz	(OFST-7,sp)
1332  03ad 2603          	jrne	L66
1333  03af cc04de        	jp	L542
1334  03b2               L66:
1335                     ; 284 				TD_Delay01ms(100);
1337  03b2 a664          	ld	a,#100
1338  03b4 cd0000        	call	_TD_Delay01ms
1340                     ; 285 				Pir_GetConfig();
1342  03b7 cd0000        	call	_Pir_GetConfig
1344                     ; 286 				TD_Delay01ms(100);
1346  03ba a664          	ld	a,#100
1347  03bc cd0000        	call	_TD_Delay01ms
1349                     ; 287 				Pir_GetConfig();
1351  03bf cd0000        	call	_Pir_GetConfig
1353                     ; 288 				byteTxD[0]=ToChar09AF(nPirLevel);
1355  03c2 b608          	ld	a,_nPirLevel
1356  03c4 cd0000        	call	_ToChar09AF
1358  03c7 6b07          	ld	(OFST-6,sp),a
1359                     ; 289 				byteTxD[1]=ToChar09AF(nPirHoldTime);
1361  03c9 b609          	ld	a,_nPirHoldTime
1362  03cb cd0000        	call	_ToChar09AF
1364  03ce 6b08          	ld	(OFST-5,sp),a
1365                     ; 290 				byteTxD[2]=0;
1367  03d0 0f09          	clr	(OFST-4,sp)
1368                     ; 291 				myputs(byteTxD);
1370  03d2 96            	ldw	x,sp
1371  03d3 1c0007        	addw	x,#OFST-6
1372  03d6 cd0000        	call	_myputs
1374  03d9 acde04de      	jpf	L542
1375  03dd               L704:
1376                     ; 294 		if(mystrcmp(strAT, "ATLUX"))
1378  03dd ae0026        	ldw	x,#L754
1379  03e0 89            	pushw	x
1380  03e1 ae0013        	ldw	x,#_strAT
1381  03e4 cd0000        	call	_mystrcmp
1383  03e7 85            	popw	x
1384  03e8 4d            	tnz	a
1385  03e9 2769          	jreq	L554
1386                     ; 296 			if(bCmpEnd)
1388  03eb 3d06          	tnz	_bCmpEnd
1389  03ed 2706          	jreq	L164
1390                     ; 298 				bGoodCmd=TRUE;
1392  03ef a601          	ld	a,#1
1393  03f1 6b06          	ld	(OFST-7,sp),a
1395  03f3 2044          	jra	L364
1396  03f5               L164:
1397                     ; 301 				if(mystrcmp(strAT, "ATLUXSSLV="))
1399  03f5 ae001b        	ldw	x,#L764
1400  03f8 89            	pushw	x
1401  03f9 ae0013        	ldw	x,#_strAT
1402  03fc cd0000        	call	_mystrcmp
1404  03ff 85            	popw	x
1405  0400 4d            	tnz	a
1406  0401 2736          	jreq	L364
1407                     ; 303 					if(bCmpEnd||nlenstrAT!=11)
1409  0403 3d06          	tnz	_bCmpEnd
1410  0405 2632          	jrne	L364
1412  0407 b600          	ld	a,_nlenstrAT
1413  0409 a10b          	cp	a,#11
1414  040b 262c          	jrne	L364
1415                     ; 307 						byteTxD[4]=FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
1417  040d b61d          	ld	a,_strAT+10
1418  040f cd0000        	call	_FromChar09AF
1420  0412 6b0b          	ld	(OFST-2,sp),a
1421                     ; 308 						if((byteTxD[4]>=1)&&(byteTxD[4]<=8))
1423  0414 0d0b          	tnz	(OFST-2,sp)
1424  0416 2721          	jreq	L364
1426  0418 7b0b          	ld	a,(OFST-2,sp)
1427  041a a109          	cp	a,#9
1428  041c 241b          	jruge	L364
1429                     ; 310 							nLuxLevel=byteTxD[4];
1431  041e 7b0b          	ld	a,(OFST-2,sp)
1432  0420 b707          	ld	_nLuxLevel,a
1433                     ; 311 							Lux_SetMTreg();
1435  0422 cd0000        	call	_Lux_SetMTreg
1437                     ; 312 							WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
1439  0425 3b0007        	push	_nLuxLevel
1440  0428 ae1002        	ldw	x,#4098
1441  042b 89            	pushw	x
1442  042c ae0000        	ldw	x,#0
1443  042f 89            	pushw	x
1444  0430 cd0000        	call	_WriteEeprom
1446  0433 5b05          	addw	sp,#5
1447                     ; 313 							bGoodCmd=TRUE;
1449  0435 a601          	ld	a,#1
1450  0437 6b06          	ld	(OFST-7,sp),a
1451  0439               L364:
1452                     ; 318 			if(bGoodCmd)
1454  0439 0d06          	tnz	(OFST-7,sp)
1455  043b 2603          	jrne	L07
1456  043d cc04de        	jp	L542
1457  0440               L07:
1458                     ; 321 				byteTxD[0]=ToChar09AF(nLuxLevel);
1460  0440 b607          	ld	a,_nLuxLevel
1461  0442 cd0000        	call	_ToChar09AF
1463  0445 6b07          	ld	(OFST-6,sp),a
1464                     ; 322 				byteTxD[1]=0;
1466  0447 0f08          	clr	(OFST-5,sp)
1467                     ; 323 				myputs(byteTxD);
1469  0449 96            	ldw	x,sp
1470  044a 1c0007        	addw	x,#OFST-6
1471  044d cd0000        	call	_myputs
1473  0450 acde04de      	jpf	L542
1474  0454               L554:
1475                     ; 326 		if(mystrcmp(strAT, "ATLOWBAT"))
1477  0454 ae0012        	ldw	x,#L705
1478  0457 89            	pushw	x
1479  0458 ae0013        	ldw	x,#_strAT
1480  045b cd0000        	call	_mystrcmp
1482  045e 85            	popw	x
1483  045f 4d            	tnz	a
1484  0460 277c          	jreq	L542
1485                     ; 328 			if(bCmpEnd)
1487  0462 3d06          	tnz	_bCmpEnd
1488  0464 2706          	jreq	L115
1489                     ; 330 				bGoodCmd=TRUE;
1491  0466 a601          	ld	a,#1
1492  0468 6b06          	ld	(OFST-7,sp),a
1494  046a 2049          	jra	L315
1495  046c               L115:
1496                     ; 333 				if(mystrcmp(strAT, "ATLOWBAT="))
1498  046c ae0008        	ldw	x,#L715
1499  046f 89            	pushw	x
1500  0470 ae0013        	ldw	x,#_strAT
1501  0473 cd0000        	call	_mystrcmp
1503  0476 85            	popw	x
1504  0477 4d            	tnz	a
1505  0478 273b          	jreq	L315
1506                     ; 335 					if(bCmpEnd||nlenstrAT!=11)
1508  047a 3d06          	tnz	_bCmpEnd
1509  047c 2637          	jrne	L315
1511  047e b600          	ld	a,_nlenstrAT
1512  0480 a10b          	cp	a,#11
1513  0482 2631          	jrne	L315
1514                     ; 339 						byteTxD[4]=(FromChar09AF(strAT[9])<<4)+FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
1516  0484 b61d          	ld	a,_strAT+10
1517  0486 cd0000        	call	_FromChar09AF
1519  0489 6b01          	ld	(OFST-12,sp),a
1520  048b b61c          	ld	a,_strAT+9
1521  048d cd0000        	call	_FromChar09AF
1523  0490 97            	ld	xl,a
1524  0491 a610          	ld	a,#16
1525  0493 42            	mul	x,a
1526  0494 9f            	ld	a,xl
1527  0495 1b01          	add	a,(OFST-12,sp)
1528  0497 6b0b          	ld	(OFST-2,sp),a
1529                     ; 340 						if(byteTxD[4]!=0)
1531  0499 0d0b          	tnz	(OFST-2,sp)
1532  049b 2718          	jreq	L315
1533                     ; 342 							nLowBatTime=byteTxD[4];
1535  049d 7b0b          	ld	a,(OFST-2,sp)
1536  049f b70a          	ld	_nLowBatTime,a
1537                     ; 343 							WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
1539  04a1 3b000a        	push	_nLowBatTime
1540  04a4 ae1003        	ldw	x,#4099
1541  04a7 89            	pushw	x
1542  04a8 ae0000        	ldw	x,#0
1543  04ab 89            	pushw	x
1544  04ac cd0000        	call	_WriteEeprom
1546  04af 5b05          	addw	sp,#5
1547                     ; 344 							bGoodCmd=TRUE;
1549  04b1 a601          	ld	a,#1
1550  04b3 6b06          	ld	(OFST-7,sp),a
1551  04b5               L315:
1552                     ; 349 			if(bGoodCmd)
1554  04b5 0d06          	tnz	(OFST-7,sp)
1555  04b7 2725          	jreq	L542
1556                     ; 351 				RTC_SetWakeupPeriod(TRUE);
1558  04b9 a601          	ld	a,#1
1559  04bb cd0000        	call	_RTC_SetWakeupPeriod
1561                     ; 352 				MotionFlags2|=bm2LowBat;
1563  04be 72100003      	bset	_MotionFlags2+1,#0
1564                     ; 353 				byteTxD[0]=ToChar09AF(nLowBatTime>>4);
1566  04c2 b60a          	ld	a,_nLowBatTime
1567  04c4 4e            	swap	a
1568  04c5 a40f          	and	a,#15
1569  04c7 cd0000        	call	_ToChar09AF
1571  04ca 6b07          	ld	(OFST-6,sp),a
1572                     ; 354 				byteTxD[1]=ToChar09AF(nLowBatTime&0x0F);
1574  04cc b60a          	ld	a,_nLowBatTime
1575  04ce a40f          	and	a,#15
1576  04d0 cd0000        	call	_ToChar09AF
1578  04d3 6b08          	ld	(OFST-5,sp),a
1579                     ; 355 				byteTxD[2]=0;
1581  04d5 0f09          	clr	(OFST-4,sp)
1582                     ; 356 				myputs(byteTxD);
1584  04d7 96            	ldw	x,sp
1585  04d8 1c0007        	addw	x,#OFST-6
1586  04db cd0000        	call	_myputs
1588  04de               L542:
1589                     ; 361 	if(!bGoodCmd)
1591  04de 0d06          	tnz	(OFST-7,sp)
1592  04e0 2606          	jrne	L335
1593                     ; 362 		myputs(STR_BADCMD);
1595  04e2 ae0000        	ldw	x,#L535
1596  04e5 cd0000        	call	_myputs
1598  04e8               L335:
1599                     ; 363 	if((!(MotionFlags&bmBtnDown))&&(!bcmdLed))
1601  04e8 b601          	ld	a,_MotionFlags+1
1602  04ea a520          	bcp	a,#32
1603  04ec 2608          	jrne	L735
1605  04ee 0d03          	tnz	(OFST-10,sp)
1606  04f0 2604          	jrne	L735
1607                     ; 365 		MotionFlags|=bmHalt;
1609  04f2 721e0000      	bset	_MotionFlags,#7
1610  04f6               L735:
1611                     ; 367 }
1614  04f6 5b0d          	addw	sp,#13
1615  04f8 81            	ret
1674                     ; 369 void TD_Init(bool bInit)
1674                     ; 370 {
1675                     .text:	section	.text,new
1676  0000               _TD_Init:
1678  0000 88            	push	a
1679       00000000      OFST:	set	0
1682                     ; 371 	disableInterrupts();
1685  0001 9b            sim
1687                     ; 372 	if(!bInit)
1690  0002 4d            	tnz	a
1691  0003 262c          	jrne	L755
1692                     ; 374 		Lux_SendCmd(LUX_I2CCmd_PowerDown);
1694  0005 4f            	clr	a
1695  0006 cd0000        	call	_Lux_SendCmd
1697                     ; 375 		GPIO_Init(GPIOC, GPIO_Pin_0, GPIO_Mode_Out_PP_High_Fast);  //I2C_SDA
1699  0009 4bf0          	push	#240
1700  000b 4b01          	push	#1
1701  000d ae500a        	ldw	x,#20490
1702  0010 cd0000        	call	_GPIO_Init
1704  0013 85            	popw	x
1705                     ; 376 		GPIO_Init(GPIOC, GPIO_Pin_1, GPIO_Mode_Out_PP_High_Fast);  //I2C_SCL
1707  0014 4bf0          	push	#240
1708  0016 4b02          	push	#2
1709  0018 ae500a        	ldw	x,#20490
1710  001b cd0000        	call	_GPIO_Init
1712  001e 85            	popw	x
1713                     ; 377 		offPinLedGreen;
1715  001f 4b08          	push	#8
1716  0021 ae5000        	ldw	x,#20480
1717  0024 cd0000        	call	_GPIO_SetBits
1719  0027 84            	pop	a
1720                     ; 378 		offPinLedRed;
1722  0028 4b04          	push	#4
1723  002a ae5000        	ldw	x,#20480
1724  002d cd0000        	call	_GPIO_SetBits
1726  0030 84            	pop	a
1727  0031               L755:
1728                     ; 380 	CLK_PeripheralClockConfig(CLK_Peripheral_USART1,bInit);//USART1时钟;
1730  0031 7b01          	ld	a,(OFST+1,sp)
1731  0033 97            	ld	xl,a
1732  0034 a605          	ld	a,#5
1733  0036 95            	ld	xh,a
1734  0037 cd0000        	call	_CLK_PeripheralClockConfig
1736                     ; 381 	CLK_PeripheralClockConfig(CLK_Peripheral_TIM2,bInit);//TIM2时钟;
1738  003a 7b01          	ld	a,(OFST+1,sp)
1739  003c 97            	ld	xl,a
1740  003d 4f            	clr	a
1741  003e 95            	ld	xh,a
1742  003f cd0000        	call	_CLK_PeripheralClockConfig
1744                     ; 382 	CLK_PeripheralClockConfig(CLK_Peripheral_I2C1,bInit);//IIC1时钟;
1746  0042 7b01          	ld	a,(OFST+1,sp)
1747  0044 97            	ld	xl,a
1748  0045 a603          	ld	a,#3
1749  0047 95            	ld	xh,a
1750  0048 cd0000        	call	_CLK_PeripheralClockConfig
1752                     ; 384 		EXTI_SelectPort(EXTI_Port_B);
1754  004b 4f            	clr	a
1755  004c cd0000        	call	_EXTI_SelectPort
1757                     ; 386 		EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Falling);  //PB0-btn
1759  004f ae0002        	ldw	x,#2
1760  0052 4f            	clr	a
1761  0053 95            	ld	xh,a
1762  0054 cd0000        	call	_EXTI_SetPinSensitivity
1764                     ; 387 		EXTI_SetPinSensitivity(EXTI_Pin_3, EXTI_Trigger_Falling);  //PB3-host wakeup
1766  0057 ae0002        	ldw	x,#2
1767  005a a606          	ld	a,#6
1768  005c 95            	ld	xh,a
1769  005d cd0000        	call	_EXTI_SetPinSensitivity
1771                     ; 388 		EXTI_SetPinSensitivity(EXTI_Pin_7, EXTI_Trigger_Rising);  //PB7-PIR 1 triggers INT
1773  0060 ae0001        	ldw	x,#1
1774  0063 a616          	ld	a,#22
1775  0065 95            	ld	xh,a
1776  0066 cd0000        	call	_EXTI_SetPinSensitivity
1778                     ; 389 		EXTI_ClearITPendingBit(EXTI_IT_Pin0);
1780  0069 ae0001        	ldw	x,#1
1781  006c cd0000        	call	_EXTI_ClearITPendingBit
1783                     ; 390 		EXTI_ClearITPendingBit(EXTI_IT_Pin3);
1785  006f ae0008        	ldw	x,#8
1786  0072 cd0000        	call	_EXTI_ClearITPendingBit
1788                     ; 391 		EXTI_ClearITPendingBit(EXTI_IT_Pin7);
1790  0075 ae0080        	ldw	x,#128
1791  0078 cd0000        	call	_EXTI_ClearITPendingBit
1793                     ; 393 		intPinBtn;  //PB0 Button
1795  007b 4b60          	push	#96
1796  007d 4b01          	push	#1
1797  007f ae5005        	ldw	x,#20485
1798  0082 cd0000        	call	_GPIO_Init
1800  0085 85            	popw	x
1801                     ; 396 		intPinHostWakeUp; //PB3
1804  0086 4b60          	push	#96
1805  0088 4b08          	push	#8
1806  008a ae5005        	ldw	x,#20485
1807  008d cd0000        	call	_GPIO_Init
1809  0090 85            	popw	x
1810                     ; 397 		GPIO_Init(GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Fast);  //NC with host
1813  0091 4be0          	push	#224
1814  0093 4b10          	push	#16
1815  0095 ae5005        	ldw	x,#20485
1816  0098 cd0000        	call	_GPIO_Init
1818  009b 85            	popw	x
1819                     ; 398 		GPIO_Init(GPIOB, GPIO_Pin_5, GPIO_Mode_Out_PP_High_Fast);  //INT to host
1821  009c 4bf0          	push	#240
1822  009e 4b20          	push	#32
1823  00a0 ae5005        	ldw	x,#20485
1824  00a3 cd0000        	call	_GPIO_Init
1826  00a6 85            	popw	x
1827                     ; 399 		GPIO_Init(GPIOB, GPIO_Pin_6, GPIO_Mode_Out_PP_Low_Fast);  //Motion SERIN
1829  00a7 4be0          	push	#224
1830  00a9 4b40          	push	#64
1831  00ab ae5005        	ldw	x,#20485
1832  00ae cd0000        	call	_GPIO_Init
1834  00b1 85            	popw	x
1835                     ; 405 	if(bInit)
1837  00b2 0d01          	tnz	(OFST+1,sp)
1838  00b4 2603          	jrne	L47
1839  00b6 cc0188        	jp	L165
1840  00b9               L47:
1841                     ; 407 		GPIO_Init(GPIOC, GPIO_Pin_0, GPIO_Mode_In_PU_No_IT);  //I2C_SDA
1843  00b9 4b40          	push	#64
1844  00bb 4b01          	push	#1
1845  00bd ae500a        	ldw	x,#20490
1846  00c0 cd0000        	call	_GPIO_Init
1848  00c3 85            	popw	x
1849                     ; 408 		GPIO_Init(GPIOC, GPIO_Pin_1, GPIO_Mode_In_PU_No_IT);  //I2C_SCL
1851  00c4 4b40          	push	#64
1852  00c6 4b02          	push	#2
1853  00c8 ae500a        	ldw	x,#20490
1854  00cb cd0000        	call	_GPIO_Init
1856  00ce 85            	popw	x
1857                     ; 409 		GPIO_Init(GPIOC, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Slow);  //LightSensor DVI
1859  00cf 4bc0          	push	#192
1860  00d1 4b10          	push	#16
1861  00d3 ae500a        	ldw	x,#20490
1862  00d6 cd0000        	call	_GPIO_Init
1864  00d9 85            	popw	x
1865                     ; 410 		GPIO_Init(GPIOC, GPIO_Pin_5, GPIO_Mode_Out_PP_High_Fast);  //USART1 TxD
1867  00da 4bf0          	push	#240
1868  00dc 4b20          	push	#32
1869  00de ae500a        	ldw	x,#20490
1870  00e1 cd0000        	call	_GPIO_Init
1872  00e4 85            	popw	x
1873                     ; 411 		GPIO_Init(GPIOC, GPIO_Pin_6, GPIO_Mode_In_PU_No_IT);  //USART1 RxD
1875  00e5 4b40          	push	#64
1876  00e7 4b40          	push	#64
1877  00e9 ae500a        	ldw	x,#20490
1878  00ec cd0000        	call	_GPIO_Init
1880  00ef 85            	popw	x
1881                     ; 413 		I2C_Init(I2C1,100, 0, I2C_Mode_I2C,I2C_DutyCycle_2, I2C_Ack_Enable, I2C_AcknowledgedAddress_7bit);
1883  00f0 4b00          	push	#0
1884  00f2 4b04          	push	#4
1885  00f4 4b00          	push	#0
1886  00f6 4b00          	push	#0
1887  00f8 5f            	clrw	x
1888  00f9 89            	pushw	x
1889  00fa ae0064        	ldw	x,#100
1890  00fd 89            	pushw	x
1891  00fe ae0000        	ldw	x,#0
1892  0101 89            	pushw	x
1893  0102 ae5210        	ldw	x,#21008
1894  0105 cd0000        	call	_I2C_Init
1896  0108 5b0a          	addw	sp,#10
1897                     ; 414 		I2C_Cmd(I2C1,ENABLE);
1899  010a 4b01          	push	#1
1900  010c ae5210        	ldw	x,#21008
1901  010f cd0000        	call	_I2C_Cmd
1903  0112 84            	pop	a
1904                     ; 415 		setPinLuxDVI;
1906  0113 4b10          	push	#16
1907  0115 ae500a        	ldw	x,#20490
1908  0118 cd0000        	call	_GPIO_SetBits
1910  011b 84            	pop	a
1911                     ; 416 		Lux_SendCmd(LUX_I2CCmd_PowerOn);
1913  011c a601          	ld	a,#1
1914  011e cd0000        	call	_Lux_SendCmd
1916                     ; 420 		TIM2_TimeBaseInit(TIM2_Prescaler_64,TIM2_CounterMode_Up,62500);  //0.25s
1918  0121 aef424        	ldw	x,#62500
1919  0124 89            	pushw	x
1920  0125 5f            	clrw	x
1921  0126 a606          	ld	a,#6
1922  0128 95            	ld	xh,a
1923  0129 cd0000        	call	_TIM2_TimeBaseInit
1925  012c 85            	popw	x
1926                     ; 421 		TIM2_ITConfig(TIM2_IT_Update, ENABLE);
1928  012d ae0001        	ldw	x,#1
1929  0130 a601          	ld	a,#1
1930  0132 95            	ld	xh,a
1931  0133 cd0000        	call	_TIM2_ITConfig
1933                     ; 422 		TIM2_ARRPreloadConfig(ENABLE);
1935  0136 a601          	ld	a,#1
1936  0138 cd0000        	call	_TIM2_ARRPreloadConfig
1938                     ; 423 		TIM2_Cmd(ENABLE);
1940  013b a601          	ld	a,#1
1941  013d cd0000        	call	_TIM2_Cmd
1943                     ; 425 		SYSCFG_REMAPDeInit();
1945  0140 cd0000        	call	_SYSCFG_REMAPDeInit
1947                     ; 426 		SYSCFG_REMAPPinConfig(REMAP_Pin_USART1TxRxPortC, ENABLE);
1949  0143 4b01          	push	#1
1950  0145 ae012c        	ldw	x,#300
1951  0148 cd0000        	call	_SYSCFG_REMAPPinConfig
1953  014b 84            	pop	a
1954                     ; 427 		USART_Init(USART1,(uint32_t)9600, USART_WordLength_8b, USART_StopBits_1,USART_Parity_No, (USART_Mode_TypeDef)(USART_Mode_Tx | USART_Mode_Rx));
1956  014c 4b0c          	push	#12
1957  014e 4b00          	push	#0
1958  0150 4b00          	push	#0
1959  0152 4b00          	push	#0
1960  0154 ae2580        	ldw	x,#9600
1961  0157 89            	pushw	x
1962  0158 ae0000        	ldw	x,#0
1963  015b 89            	pushw	x
1964  015c ae5230        	ldw	x,#21040
1965  015f cd0000        	call	_USART_Init
1967  0162 5b08          	addw	sp,#8
1968                     ; 428 		USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);
1970  0164 4b01          	push	#1
1971  0166 ae0255        	ldw	x,#597
1972  0169 89            	pushw	x
1973  016a ae5230        	ldw	x,#21040
1974  016d cd0000        	call	_USART_ITConfig
1976  0170 5b03          	addw	sp,#3
1977                     ; 431 		USART_Cmd(USART1, ENABLE);
1979  0172 4b01          	push	#1
1980  0174 ae5230        	ldw	x,#21040
1981  0177 cd0000        	call	_USART_Cmd
1983  017a 84            	pop	a
1984                     ; 432 		Lux_SetMTreg();
1986  017b cd0000        	call	_Lux_SetMTreg
1988                     ; 433 		TD_Delay01ms(20);
1990  017e a614          	ld	a,#20
1991  0180 cd0000        	call	_TD_Delay01ms
1993                     ; 434 		Lux_GetReading(LUX_I2CCmd_AutoRes);
1995  0183 a610          	ld	a,#16
1996  0185 cd0000        	call	_Lux_GetReading
1998  0188               L165:
1999                     ; 436 	Pir_SetConfig(bInit);
2001  0188 7b01          	ld	a,(OFST+1,sp)
2002  018a cd0000        	call	_Pir_SetConfig
2004                     ; 437 	enableInterrupts(); 
2007  018d 9a            rim
2009                     ; 438 }
2013  018e 84            	pop	a
2014  018f 81            	ret
2057                     ; 440 void TD_Delay01ms(u8 d)  //unit: 0.1ms
2057                     ; 441 {
2058                     .text:	section	.text,new
2059  0000               _TD_Delay01ms:
2061  0000 88            	push	a
2062  0001 88            	push	a
2063       00000001      OFST:	set	1
2066  0002 200c          	jra	L116
2067  0004               L506:
2068                     ; 445 		for(i=0;i<200;i++) ;
2070  0004 0f01          	clr	(OFST+0,sp)
2071  0006               L516:
2075  0006 0c01          	inc	(OFST+0,sp)
2078  0008 7b01          	ld	a,(OFST+0,sp)
2079  000a a1c8          	cp	a,#200
2080  000c 25f8          	jrult	L516
2081                     ; 443 	for(;d>0;d--)
2083  000e 0a02          	dec	(OFST+1,sp)
2084  0010               L116:
2087  0010 0d02          	tnz	(OFST+1,sp)
2088  0012 26f0          	jrne	L506
2089                     ; 447 }
2092  0014 85            	popw	x
2093  0015 81            	ret
2133                     ; 449 int main() 
2133                     ; 450 { 
2134                     .text:	section	.text,new
2135  0000               _main:
2139                     ; 451 	CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_1);
2141  0000 4f            	clr	a
2142  0001 cd0000        	call	_CLK_SYSCLKDivConfig
2144                     ; 452   CLK_RTCClockConfig(CLK_RTCCLKSource_LSI, CLK_RTCCLKDiv_16);
2146  0004 ae0080        	ldw	x,#128
2147  0007 a604          	ld	a,#4
2148  0009 95            	ld	xh,a
2149  000a cd0000        	call	_CLK_RTCClockConfig
2151                     ; 453   CLK_PeripheralClockConfig(CLK_Peripheral_RTC, ENABLE);
2153  000d ae0001        	ldw	x,#1
2154  0010 a612          	ld	a,#18
2155  0012 95            	ld	xh,a
2156  0013 cd0000        	call	_CLK_PeripheralClockConfig
2158                     ; 455 	FLASH_SetProgrammingTime(FLASH_ProgramTime_Standard);
2160  0016 4f            	clr	a
2161  0017 cd0000        	call	_FLASH_SetProgrammingTime
2163                     ; 456 	MotionFlags=bmStartup;
2165  001a ae0200        	ldw	x,#512
2166  001d bf00          	ldw	_MotionFlags,x
2167                     ; 457 	nTCount=0;
2169  001f 3f0b          	clr	_nTCount
2170                     ; 458 	GPIO_Init(GPIOA, GPIO_Pin_2, GPIO_Mode_Out_OD_HiZ_Slow);  //out: Red LED init off
2172  0021 4b90          	push	#144
2173  0023 4b04          	push	#4
2174  0025 ae5000        	ldw	x,#20480
2175  0028 cd0000        	call	_GPIO_Init
2177  002b 85            	popw	x
2178                     ; 459 	GPIO_Init(GPIOA, GPIO_Pin_3, GPIO_Mode_Out_OD_Low_Slow);  //out: Green LED init on
2180  002c 4b80          	push	#128
2181  002e 4b08          	push	#8
2182  0030 ae5000        	ldw	x,#20480
2183  0033 cd0000        	call	_GPIO_Init
2185  0036 85            	popw	x
2186                     ; 465 	TD_Init(TRUE);
2188  0037 a601          	ld	a,#1
2189  0039 cd0000        	call	_TD_Init
2191                     ; 466 	ReadEeprom();
2193  003c cd0000        	call	_ReadEeprom
2195                     ; 468 	intPinPirDoci;
2197  003f 4b20          	push	#32
2198  0041 4b80          	push	#128
2199  0043 ae5005        	ldw	x,#20485
2200  0046 cd0000        	call	_GPIO_Init
2202  0049 85            	popw	x
2203  004a               L336:
2204                     ; 472 		TD_Delay01ms(20);
2206  004a a614          	ld	a,#20
2207  004c cd0000        	call	_TD_Delay01ms
2209                     ; 474 		if(MotionFlags&bmHalt)
2211  004f b600          	ld	a,_MotionFlags
2212  0051 a580          	bcp	a,#128
2213  0053 2746          	jreq	L736
2214                     ; 476 			MotionFlags&=~bmHalt;
2216  0055 721f0000      	bres	_MotionFlags,#7
2217                     ; 477 			if(MotionFlags&bmCmdEcho)	putchar('z');
2219  0059 b600          	ld	a,_MotionFlags
2220  005b a540          	bcp	a,#64
2221  005d 2705          	jreq	L146
2224  005f a67a          	ld	a,#122
2225  0061 cd0000        	call	_putchar
2227  0064               L146:
2228                     ; 478 			TD_Delay01ms(20);
2230  0064 a614          	ld	a,#20
2231  0066 cd0000        	call	_TD_Delay01ms
2233                     ; 479 			TD_Init(FALSE);
2235  0069 4f            	clr	a
2236  006a cd0000        	call	_TD_Init
2238                     ; 483 			intPinPirDoci;
2240  006d 4b20          	push	#32
2241  006f 4b80          	push	#128
2242  0071 ae5005        	ldw	x,#20485
2243  0074 cd0000        	call	_GPIO_Init
2245  0077 85            	popw	x
2246                     ; 484 			halt();// 进入停机模式
2250  0078 8e            halt
2252                     ; 487 			TD_Init(TRUE);// 系统初始化函数，醒来时执行
2255  0079 a601          	ld	a,#1
2256  007b cd0000        	call	_TD_Init
2258                     ; 488 			TD_Delay01ms(200);
2260  007e a6c8          	ld	a,#200
2261  0080 cd0000        	call	_TD_Delay01ms
2263                     ; 489 			if(MotionFlags&bmCmdEcho)	putchar('.');
2265  0083 b600          	ld	a,_MotionFlags
2266  0085 a540          	bcp	a,#64
2267  0087 2705          	jreq	L346
2270  0089 a62e          	ld	a,#46
2271  008b cd0000        	call	_putchar
2273  008e               L346:
2274                     ; 490 			intPinPirDoci;
2276  008e 4b20          	push	#32
2277  0090 4b80          	push	#128
2278  0092 ae5005        	ldw	x,#20485
2279  0095 cd0000        	call	_GPIO_Init
2281  0098 85            	popw	x
2284  0099 20af          	jra	L336
2285  009b               L736:
2286                     ; 494 			if(MotionFlags&bmIntPir)  //1116 for hw test
2288  009b b601          	ld	a,_MotionFlags+1
2289  009d a510          	bcp	a,#16
2290  009f 271f          	jreq	L746
2291                     ; 496 				intPinPirDoci;
2293  00a1 4b20          	push	#32
2294  00a3 4b80          	push	#128
2295  00a5 ae5005        	ldw	x,#20485
2296  00a8 cd0000        	call	_GPIO_Init
2298  00ab 85            	popw	x
2299                     ; 499 				if(MotionFlags&bmCmdEcho)	putchar('x');
2302  00ac b600          	ld	a,_MotionFlags
2303  00ae a540          	bcp	a,#64
2304  00b0 2705          	jreq	L156
2307  00b2 a678          	ld	a,#120
2308  00b4 cd0000        	call	_putchar
2310  00b7               L156:
2311                     ; 500 				TD_Delay01ms(100);
2313  00b7 a664          	ld	a,#100
2314  00b9 cd0000        	call	_TD_Delay01ms
2316                     ; 502 				MotionFlags&=~bmIntPir;
2318  00bc 72190001      	bres	_MotionFlags+1,#4
2319  00c0               L746:
2320                     ; 505 			if(MotionFlags&bmNeedAtCmd)
2322  00c0 b600          	ld	a,_MotionFlags
2323  00c2 a501          	bcp	a,#1
2324  00c4 2718          	jreq	L356
2325                     ; 507 				clrPinMyIntn;
2327  00c6 4b20          	push	#32
2328  00c8 ae5005        	ldw	x,#20485
2329  00cb cd0000        	call	_GPIO_ResetBits
2331  00ce 84            	pop	a
2332                     ; 508 				if(MotionFlags&bmCmdEcho)	putchar('a');
2334  00cf b600          	ld	a,_MotionFlags
2335  00d1 a540          	bcp	a,#64
2336  00d3 2705          	jreq	L556
2339  00d5 a661          	ld	a,#97
2340  00d7 cd0000        	call	_putchar
2342  00da               L556:
2343                     ; 509 				MotionFlags&=~bmNeedAtCmd;
2345  00da 72110000      	bres	_MotionFlags,#0
2346  00de               L356:
2347                     ; 511 			if(MotionFlags&bmValidCmd)
2349  00de b600          	ld	a,_MotionFlags
2350  00e0 a508          	bcp	a,#8
2351  00e2 2710          	jreq	L756
2352                     ; 513 				MotionFlags&=~bmValidCmd;
2354  00e4 72170000      	bres	_MotionFlags,#3
2355                     ; 514 				setPinMyIntn;
2357  00e8 4b20          	push	#32
2358  00ea ae5005        	ldw	x,#20485
2359  00ed cd0000        	call	_GPIO_SetBits
2361  00f0 84            	pop	a
2362                     ; 515 				ParseAtCmd();
2364  00f1 cd0000        	call	_ParseAtCmd
2366  00f4               L756:
2367                     ; 517 			if(MotionFlags&bmHostWakeUp) //Host wants to send AT
2369  00f4 b601          	ld	a,_MotionFlags+1
2370  00f6 a580          	bcp	a,#128
2371  00f8 271c          	jreq	L166
2372                     ; 519 				if(getPinHostWakeUp!=RESET)
2374  00fa 4b08          	push	#8
2375  00fc ae5005        	ldw	x,#20485
2376  00ff cd0000        	call	_GPIO_ReadInputDataBit
2378  0102 5b01          	addw	sp,#1
2379  0104 4d            	tnz	a
2380  0105 270f          	jreq	L166
2381                     ; 521 					MotionFlags&=~bmHostWakeUp;
2383  0107 721f0001      	bres	_MotionFlags+1,#7
2384                     ; 522 					intPinHostWakeUp;
2386  010b 4b60          	push	#96
2387  010d 4b08          	push	#8
2388  010f ae5005        	ldw	x,#20485
2389  0112 cd0000        	call	_GPIO_Init
2391  0115 85            	popw	x
2393  0116               L166:
2394                     ; 525 			if(MotionFlags&bmBtnDown)
2396  0116 b601          	ld	a,_MotionFlags+1
2397  0118 a520          	bcp	a,#32
2398  011a 2603          	jrne	L201
2399  011c cc004a        	jp	L336
2400  011f               L201:
2401                     ; 527 				if(MotionFlags&bmCmdEcho)	putchar('y');
2403  011f b600          	ld	a,_MotionFlags
2404  0121 a540          	bcp	a,#64
2405  0123 2705          	jreq	L766
2408  0125 a679          	ld	a,#121
2409  0127 cd0000        	call	_putchar
2411  012a               L766:
2412                     ; 528 				TD_Delay01ms(250);
2414  012a a6fa          	ld	a,#250
2415  012c cd0000        	call	_TD_Delay01ms
2417                     ; 529 				TD_Delay01ms(250);
2419  012f a6fa          	ld	a,#250
2420  0131 cd0000        	call	_TD_Delay01ms
2422                     ; 530 				TD_Delay01ms(250);  //debounce 75ms
2424  0134 a6fa          	ld	a,#250
2425  0136 cd0000        	call	_TD_Delay01ms
2427                     ; 531 				if(getPinBtn==RESET)
2429  0139 4b01          	push	#1
2430  013b ae5005        	ldw	x,#20485
2431  013e cd0000        	call	_GPIO_ReadInputDataBit
2433  0141 5b01          	addw	sp,#1
2434  0143 4d            	tnz	a
2435  0144 2626          	jrne	L176
2436                     ; 533 					if(!(MotionFlags&bmBtnDownConfirmed))
2438  0146 b601          	ld	a,_MotionFlags+1
2439  0148 a540          	bcp	a,#64
2440  014a 2703          	jreq	L401
2441  014c cc004a        	jp	L336
2442  014f               L401:
2443                     ; 535 						nTCount=0;
2445  014f 3f0b          	clr	_nTCount
2446                     ; 536 						MotionFlags|=bmStartup;
2448  0151 72120000      	bset	_MotionFlags,#1
2449                     ; 537 						onPinLedGreen;
2451  0155 4b08          	push	#8
2452  0157 ae5000        	ldw	x,#20480
2453  015a cd0000        	call	_GPIO_ResetBits
2455  015d 84            	pop	a
2456                     ; 539 						MotionFlags|=bmBtnDownConfirmed;
2458  015e 721c0001      	bset	_MotionFlags+1,#6
2459                     ; 540 						MotionFlags|=bmNeedAtCmd;
2461  0162 72100000      	bset	_MotionFlags,#0
2462                     ; 541 						nPressed=0;
2464  0166 3f0c          	clr	_nPressed
2465  0168 ac4a004a      	jpf	L336
2466  016c               L176:
2467                     ; 545 					MotionFlags&=~bmBtnDown;
2469  016c 721b0001      	bres	_MotionFlags+1,#5
2470                     ; 546 					MotionFlags&=~bmBtnDownConfirmed;
2472  0170 721d0001      	bres	_MotionFlags+1,#6
2473                     ; 547 					MotionFlags|=bmNeedAtCmd;
2475  0174 72100000      	bset	_MotionFlags,#0
2476                     ; 548 					intPinBtn;
2478  0178 4b60          	push	#96
2479  017a 4b01          	push	#1
2480  017c ae5005        	ldw	x,#20485
2481  017f cd0000        	call	_GPIO_Init
2483  0182 85            	popw	x
2485  0183 ac4a004a      	jpf	L336
2513                     ; 556 INTERRUPT_HANDLER(ISR_Btn,8)  //PB0
2513                     ; 557 {
2515                     .text:	section	.text,new
2516  0000               f_ISR_Btn:
2519  0000 3b0002        	push	c_x+2
2520  0003 be00          	ldw	x,c_x
2521  0005 89            	pushw	x
2522  0006 3b0002        	push	c_y+2
2523  0009 be00          	ldw	x,c_y
2524  000b 89            	pushw	x
2527                     ; 558   RTC_WakeUpCmd(DISABLE);
2529  000c 4f            	clr	a
2530  000d cd0000        	call	_RTC_WakeUpCmd
2532                     ; 559 	MotionFlags2&=~bm2LowBat;
2534  0010 72110003      	bres	_MotionFlags2+1,#0
2535                     ; 561 	iPinBtn;
2537  0014 4b40          	push	#64
2538  0016 4b01          	push	#1
2539  0018 ae5005        	ldw	x,#20485
2540  001b cd0000        	call	_GPIO_Init
2542  001e 85            	popw	x
2543                     ; 562 	if(MotionFlags&bmBtnDown)
2546  001f b601          	ld	a,_MotionFlags+1
2547  0021 a520          	bcp	a,#32
2548  0023 2608          	jrne	L117
2550                     ; 566 		MotionFlags|=bmBtnDown;
2552  0025 721a0001      	bset	_MotionFlags+1,#5
2553                     ; 567 		MotionFlags|=bmNeedAtCmd;
2555  0029 72100000      	bset	_MotionFlags,#0
2556  002d               L117:
2557                     ; 569 	EXTI_ClearITPendingBit(EXTI_IT_Pin0);
2559  002d ae0001        	ldw	x,#1
2560  0030 cd0000        	call	_EXTI_ClearITPendingBit
2562                     ; 570 }
2565  0033 85            	popw	x
2566  0034 bf00          	ldw	c_y,x
2567  0036 320002        	pop	c_y+2
2568  0039 85            	popw	x
2569  003a bf00          	ldw	c_x,x
2570  003c 320002        	pop	c_x+2
2571  003f 80            	iret
2598                     ; 572 INTERRUPT_HANDLER(ISR_HostWakeUp,11)  //PB3
2598                     ; 573 {
2599                     .text:	section	.text,new
2600  0000               f_ISR_HostWakeUp:
2603  0000 3b0002        	push	c_x+2
2604  0003 be00          	ldw	x,c_x
2605  0005 89            	pushw	x
2606  0006 3b0002        	push	c_y+2
2607  0009 be00          	ldw	x,c_y
2608  000b 89            	pushw	x
2611                     ; 574   RTC_WakeUpCmd(DISABLE);
2613  000c 4f            	clr	a
2614  000d cd0000        	call	_RTC_WakeUpCmd
2616                     ; 575 	MotionFlags2&=~bm2LowBat;
2618  0010 72110003      	bres	_MotionFlags2+1,#0
2619                     ; 577 	iPinHostWakeUp;
2621  0014 4b40          	push	#64
2622  0016 4b08          	push	#8
2623  0018 ae5005        	ldw	x,#20485
2624  001b cd0000        	call	_GPIO_Init
2626  001e 85            	popw	x
2627                     ; 578 	MotionFlags|=bmHostWakeUp;
2630  001f 721e0001      	bset	_MotionFlags+1,#7
2631                     ; 579 	MotionFlags|=bmNeedAtCmd;
2633  0023 72100000      	bset	_MotionFlags,#0
2634                     ; 580 	EXTI_ClearITPendingBit(EXTI_IT_Pin3);
2636  0027 ae0008        	ldw	x,#8
2637  002a cd0000        	call	_EXTI_ClearITPendingBit
2639                     ; 581 }
2642  002d 85            	popw	x
2643  002e bf00          	ldw	c_y,x
2644  0030 320002        	pop	c_y+2
2645  0033 85            	popw	x
2646  0034 bf00          	ldw	c_x,x
2647  0036 320002        	pop	c_x+2
2648  0039 80            	iret
2675                     ; 583 INTERRUPT_HANDLER(ISR_RtcWakeUp,4)  //For low battery mode
2675                     ; 584 {
2676                     .text:	section	.text,new
2677  0000               f_ISR_RtcWakeUp:
2680  0000 3b0002        	push	c_x+2
2681  0003 be00          	ldw	x,c_x
2682  0005 89            	pushw	x
2683  0006 3b0002        	push	c_y+2
2684  0009 be00          	ldw	x,c_y
2685  000b 89            	pushw	x
2688                     ; 585 	if(MotionFlags2&bm2LowBat)
2690  000c b603          	ld	a,_MotionFlags2+1
2691  000e a501          	bcp	a,#1
2692  0010 270f          	jreq	L337
2693                     ; 587 		nDelayTime=3;
2695  0012 ae0003        	ldw	x,#3
2696  0015 bf23          	ldw	_nDelayTime,x
2697                     ; 588 		MotionFlags|=bmLedRedFlash;
2699  0017 72140001      	bset	_MotionFlags+1,#2
2700                     ; 589 		MotionFlags|=bmLedDelay;
2702  001b 72180000      	bset	_MotionFlags,#4
2704  001f 200c          	jra	L537
2705  0021               L337:
2706                     ; 592 		MotionFlags|=bmNeedAtCmd;
2708  0021 72100000      	bset	_MotionFlags,#0
2709                     ; 593 		MotionFlags2|=bm2PirRecheck;
2711  0025 72120003      	bset	_MotionFlags2+1,#1
2712                     ; 594 		RTC_WakeUpCmd(DISABLE);
2714  0029 4f            	clr	a
2715  002a cd0000        	call	_RTC_WakeUpCmd
2717  002d               L537:
2718                     ; 596 	RTC_ClearITPendingBit(RTC_IT_WUT);
2720  002d ae0040        	ldw	x,#64
2721  0030 cd0000        	call	_RTC_ClearITPendingBit
2723                     ; 597 }
2726  0033 85            	popw	x
2727  0034 bf00          	ldw	c_y,x
2728  0036 320002        	pop	c_y+2
2729  0039 85            	popw	x
2730  003a bf00          	ldw	c_x,x
2731  003c 320002        	pop	c_x+2
2732  003f 80            	iret
2761                     ; 599 INTERRUPT_HANDLER(ISR_Pir,15)  //PB7 Rising Edge to INT
2761                     ; 600 {
2762                     .text:	section	.text,new
2763  0000               f_ISR_Pir:
2766  0000 3b0002        	push	c_x+2
2767  0003 be00          	ldw	x,c_x
2768  0005 89            	pushw	x
2769  0006 3b0002        	push	c_y+2
2770  0009 be00          	ldw	x,c_y
2771  000b 89            	pushw	x
2774                     ; 601   RTC_WakeUpCmd(DISABLE);
2776  000c 4f            	clr	a
2777  000d cd0000        	call	_RTC_WakeUpCmd
2779                     ; 602 	MotionFlags2&=~bm2LowBat;
2781  0010 72110003      	bres	_MotionFlags2+1,#0
2782                     ; 604 	oPinPirDoci;  //pull down to low at least 100ns to clear PIR INT
2784  0014 4be0          	push	#224
2785  0016 4b80          	push	#128
2786  0018 ae5005        	ldw	x,#20485
2787  001b cd0000        	call	_GPIO_Init
2789  001e 85            	popw	x
2790                     ; 605 	clrPinPirDoci;
2793  001f 4b80          	push	#128
2794  0021 ae5005        	ldw	x,#20485
2795  0024 cd0000        	call	_GPIO_ResetBits
2797  0027 84            	pop	a
2798                     ; 606 	MotionFlags|=bmIntPir;
2800  0028 72180001      	bset	_MotionFlags+1,#4
2801                     ; 607 	MotionFlags|=bmIntPirStaCmd;
2803  002c 72140000      	bset	_MotionFlags,#2
2804                     ; 608 	MotionFlags|=bmNeedAtCmd;
2806  0030 72100000      	bset	_MotionFlags,#0
2807                     ; 609 	RTC_SetWakeupPeriod(FALSE);
2809  0034 4f            	clr	a
2810  0035 cd0000        	call	_RTC_SetWakeupPeriod
2812                     ; 611 	EXTI_ClearITPendingBit(EXTI_IT_Pin7);
2814  0038 ae0080        	ldw	x,#128
2815  003b cd0000        	call	_EXTI_ClearITPendingBit
2817                     ; 612 }
2820  003e 85            	popw	x
2821  003f bf00          	ldw	c_y,x
2822  0041 320002        	pop	c_y+2
2823  0044 85            	popw	x
2824  0045 bf00          	ldw	c_x,x
2825  0047 320002        	pop	c_x+2
2826  004a 80            	iret
2857                     ; 614 INTERRUPT_HANDLER(ISR_Timer2,19)  //0.25s
2857                     ; 615 {
2858                     .text:	section	.text,new
2859  0000               f_ISR_Timer2:
2862  0000 3b0002        	push	c_x+2
2863  0003 be00          	ldw	x,c_x
2864  0005 89            	pushw	x
2865  0006 3b0002        	push	c_y+2
2866  0009 be00          	ldw	x,c_y
2867  000b 89            	pushw	x
2870                     ; 616 	if (TIM2_GetITStatus(TIM2_IT_Update) != RESET)
2872  000c a601          	ld	a,#1
2873  000e cd0000        	call	_TIM2_GetITStatus
2875  0011 4d            	tnz	a
2876  0012 2604          	jrne	L021
2877  0014 acdf00df      	jpf	L757
2878  0018               L021:
2879                     ; 618 		nTCount++;
2881  0018 3c0b          	inc	_nTCount
2882                     ; 619 		if((nTCount==4)&&(MotionFlags&bmStartup))
2884  001a b60b          	ld	a,_nTCount
2885  001c a104          	cp	a,#4
2886  001e 2613          	jrne	L167
2888  0020 b600          	ld	a,_MotionFlags
2889  0022 a502          	bcp	a,#2
2890  0024 270d          	jreq	L167
2891                     ; 621 			offPinLedGreen;
2893  0026 4b08          	push	#8
2894  0028 ae5000        	ldw	x,#20480
2895  002b cd0000        	call	_GPIO_SetBits
2897  002e 84            	pop	a
2898                     ; 622 			MotionFlags&=~bmStartup;
2900  002f 72130000      	bres	_MotionFlags,#1
2901  0033               L167:
2902                     ; 624 		if(MotionFlags&bmLedRedFlash)
2904  0033 b601          	ld	a,_MotionFlags+1
2905  0035 a504          	bcp	a,#4
2906  0037 2723          	jreq	L367
2907                     ; 626 			if((MotionFlags&bmLedRed2Hz)||((MotionFlags&(~bmLedRed2Hz))&&(nTCount%2)))
2909  0039 b601          	ld	a,_MotionFlags+1
2910  003b a508          	bcp	a,#8
2911  003d 2614          	jrne	L767
2913  003f be00          	ldw	x,_MotionFlags
2914  0041 01            	rrwa	x,a
2915  0042 a4f7          	and	a,#247
2916  0044 01            	rrwa	x,a
2917  0045 a4ff          	and	a,#255
2918  0047 01            	rrwa	x,a
2919  0048 a30000        	cpw	x,#0
2920  004b 270f          	jreq	L367
2922  004d b60b          	ld	a,_nTCount
2923  004f a501          	bcp	a,#1
2924  0051 2709          	jreq	L367
2925  0053               L767:
2926                     ; 628 				togPinLedRed;
2928  0053 4b04          	push	#4
2929  0055 ae5000        	ldw	x,#20480
2930  0058 cd0000        	call	_GPIO_ToggleBits
2932  005b 84            	pop	a
2934  005c               L367:
2935                     ; 631 		if(MotionFlags&bmLedGreenFlash)
2937  005c b601          	ld	a,_MotionFlags+1
2938  005e a501          	bcp	a,#1
2939  0060 2723          	jreq	L177
2940                     ; 633 			if((MotionFlags&bmLedGreen2Hz)||((MotionFlags&(~bmLedGreen2Hz))&&(nTCount%2)))
2942  0062 b601          	ld	a,_MotionFlags+1
2943  0064 a502          	bcp	a,#2
2944  0066 2614          	jrne	L577
2946  0068 be00          	ldw	x,_MotionFlags
2947  006a 01            	rrwa	x,a
2948  006b a4fd          	and	a,#253
2949  006d 01            	rrwa	x,a
2950  006e a4ff          	and	a,#255
2951  0070 01            	rrwa	x,a
2952  0071 a30000        	cpw	x,#0
2953  0074 270f          	jreq	L177
2955  0076 b60b          	ld	a,_nTCount
2956  0078 a501          	bcp	a,#1
2957  007a 2709          	jreq	L177
2958  007c               L577:
2959                     ; 635 				togPinLedGreen;
2961  007c 4b08          	push	#8
2962  007e ae5000        	ldw	x,#20480
2963  0081 cd0000        	call	_GPIO_ToggleBits
2965  0084 84            	pop	a
2967  0085               L177:
2968                     ; 638 		if(MotionFlags&bmBtnDownConfirmed)
2970  0085 b601          	ld	a,_MotionFlags+1
2971  0087 a540          	bcp	a,#64
2972  0089 2718          	jreq	L777
2973                     ; 640 			nPressed++;
2975  008b 3c0c          	inc	_nPressed
2976                     ; 641 			if((nPressed==TIME_LONGPRESS)||(nPressed==TIME_MIDPRESS)||(nPressed==TIME_SHORTPRESS))
2978  008d b60c          	ld	a,_nPressed
2979  008f a128          	cp	a,#40
2980  0091 270c          	jreq	L3001
2982  0093 b60c          	ld	a,_nPressed
2983  0095 a114          	cp	a,#20
2984  0097 2706          	jreq	L3001
2986  0099 b60c          	ld	a,_nPressed
2987  009b a108          	cp	a,#8
2988  009d 2604          	jrne	L777
2989  009f               L3001:
2990                     ; 642 				MotionFlags|=bmNeedAtCmd;
2992  009f 72100000      	bset	_MotionFlags,#0
2993  00a3               L777:
2994                     ; 644 		if(MotionFlags&bmLedDelay)
2996  00a3 b600          	ld	a,_MotionFlags
2997  00a5 a510          	bcp	a,#16
2998  00a7 2731          	jreq	L7001
2999                     ; 646 			nDelayTime--;
3001  00a9 be23          	ldw	x,_nDelayTime
3002  00ab 1d0001        	subw	x,#1
3003  00ae bf23          	ldw	_nDelayTime,x
3004                     ; 647 			if(nDelayTime==0)
3006  00b0 be23          	ldw	x,_nDelayTime
3007  00b2 2626          	jrne	L7001
3008                     ; 649 				MotionFlags&=~bmLedDelay;
3010  00b4 72190000      	bres	_MotionFlags,#4
3011                     ; 650 				MotionFlags&=(~bmLedRedFlash)&(~bmLedRed2Hz)&(~bmLedGreenFlash)&(~bmLedGreen2Hz);
3013  00b8 b601          	ld	a,_MotionFlags+1
3014  00ba a4f0          	and	a,#240
3015  00bc b701          	ld	_MotionFlags+1,a
3016                     ; 651 				offPinLedGreen;
3018  00be 4b08          	push	#8
3019  00c0 ae5000        	ldw	x,#20480
3020  00c3 cd0000        	call	_GPIO_SetBits
3022  00c6 84            	pop	a
3023                     ; 652 				offPinLedRed;
3025  00c7 4b04          	push	#4
3026  00c9 ae5000        	ldw	x,#20480
3027  00cc cd0000        	call	_GPIO_SetBits
3029  00cf 84            	pop	a
3030                     ; 653 				if(MotionFlags2&bm2LowBat)
3032  00d0 b603          	ld	a,_MotionFlags2+1
3033  00d2 a501          	bcp	a,#1
3034  00d4 2704          	jreq	L7001
3035                     ; 654 						MotionFlags|=bmHalt;
3037  00d6 721e0000      	bset	_MotionFlags,#7
3038  00da               L7001:
3039                     ; 657 		TIM2_ClearITPendingBit(TIM2_IT_Update);
3041  00da a601          	ld	a,#1
3042  00dc cd0000        	call	_TIM2_ClearITPendingBit
3044  00df               L757:
3045                     ; 659 }
3048  00df 85            	popw	x
3049  00e0 bf00          	ldw	c_y,x
3050  00e2 320002        	pop	c_y+2
3051  00e5 85            	popw	x
3052  00e6 bf00          	ldw	c_x,x
3053  00e8 320002        	pop	c_x+2
3054  00eb 80            	iret
3082                     ; 661 INTERRUPT_HANDLER(ISR_Uart1Rx,28)
3082                     ; 662 {
3083                     .text:	section	.text,new
3084  0000               f_ISR_Uart1Rx:
3089                     ; 663 		if(USART1->DR ==13)
3091  0000 c65231        	ld	a,21041
3092  0003 a10d          	cp	a,#13
3093  0005 263a          	jrne	L5201
3094                     ; 665 			*strxBuf = 0;
3096  0007 923f04        	clr	[_strxBuf.w]
3097                     ; 666 			strxAT=strAT;
3099  000a ae0013        	ldw	x,#_strAT
3100  000d bf11          	ldw	_strxAT,x
3101                     ; 667 			strxBuf=strBuf;
3103  000f ae0001        	ldw	x,#_strBuf
3104  0012 bf04          	ldw	_strxBuf,x
3105                     ; 668 			nlenstrAT=0;
3107  0014 3f00          	clr	_nlenstrAT
3109  0016 2016          	jra	L3301
3110  0018               L7201:
3111                     ; 671 				*strxAT=*strxBuf;
3113  0018 92c604        	ld	a,[_strxBuf.w]
3114  001b 92c711        	ld	[_strxAT.w],a
3115                     ; 672 				strxBuf++;
3117  001e be04          	ldw	x,_strxBuf
3118  0020 1c0001        	addw	x,#1
3119  0023 bf04          	ldw	_strxBuf,x
3120                     ; 673 				strxAT++;
3122  0025 be11          	ldw	x,_strxAT
3123  0027 1c0001        	addw	x,#1
3124  002a bf11          	ldw	_strxAT,x
3125                     ; 674 				nlenstrAT++;
3127  002c 3c00          	inc	_nlenstrAT
3128  002e               L3301:
3129                     ; 669 			while(*strxBuf!=0)
3131  002e 923d04        	tnz	[_strxBuf.w]
3132  0031 26e5          	jrne	L7201
3133                     ; 677 			*strxAT=0;
3135  0033 923f11        	clr	[_strxAT.w]
3136                     ; 678 			strxBuf=strBuf;
3138  0036 ae0001        	ldw	x,#_strBuf
3139  0039 bf04          	ldw	_strxBuf,x
3140                     ; 679 			MotionFlags|=bmValidCmd;
3142  003b 72160000      	bset	_MotionFlags,#3
3144  003f 201e          	jra	L7301
3145  0041               L5201:
3146                     ; 682 			*strxBuf =USART1->DR;
3148  0041 c65231        	ld	a,21041
3149  0044 92c704        	ld	[_strxBuf.w],a
3150                     ; 684 			if((strxBuf-strBuf)<(MAX_STRLEN-1))
3152  0047 9c            	rvf
3153  0048 b604          	ld	a,_strxBuf
3154  004a 97            	ld	xl,a
3155  004b b605          	ld	a,_strxBuf+1
3156  004d a001          	sub	a,#_strBuf
3157  004f 2401          	jrnc	L421
3158  0051 5a            	decw	x
3159  0052               L421:
3160  0052 02            	rlwa	x,a
3161  0053 a3000f        	cpw	x,#15
3162  0056 2e07          	jrsge	L7301
3163                     ; 686 				strxBuf++;
3165  0058 be04          	ldw	x,_strxBuf
3166  005a 1c0001        	addw	x,#1
3167  005d bf04          	ldw	_strxBuf,x
3168  005f               L7301:
3169                     ; 690 }
3172  005f 80            	iret
3326                     	xdef	f_ISR_Uart1Rx
3327                     	xdef	f_ISR_Timer2
3328                     	xdef	f_ISR_Pir
3329                     	xdef	f_ISR_RtcWakeUp
3330                     	xdef	f_ISR_HostWakeUp
3331                     	xdef	f_ISR_Btn
3332                     	xdef	_main
3333                     	xdef	_TD_Init
3334                     	xdef	_ParseAtCmd
3335                     	xdef	_mystrcmp
3336                     	switch	.ubsct
3337  0000               _nlenstrAT:
3338  0000 00            	ds.b	1
3339                     	xdef	_nlenstrAT
3340                     	xdef	_nPressed
3341                     	xdef	_nTCount
3342                     	xdef	_bCmpEnd
3343                     	xdef	_strxBuf
3344  0001               _strBuf:
3345  0001 000000000000  	ds.b	16
3346                     	xdef	_strBuf
3347  0011               _strxAT:
3348  0011 0000          	ds.b	2
3349                     	xdef	_strxAT
3350  0013               _strAT:
3351  0013 000000000000  	ds.b	16
3352                     	xdef	_strAT
3353  0023               _nDelayTime:
3354  0023 0000          	ds.b	2
3355                     	xdef	_nDelayTime
3356                     	xdef	_TD_Delay01ms
3357                     	xref	_WriteEeprom
3358                     	xref	_ReadEeprom
3359                     	xref	_Pir_SetConfig
3360                     	xref	_Pir_GetConfig
3361                     	xref	_Lux_SendCmd
3362                     	xref	_Lux_SetMTreg
3363                     	xref	_Lux_GetReading
3364                     	xref	_RTC_SetWakeupPeriod
3365                     	xdef	_myputs
3366                     	xdef	_putchar
3367                     	xdef	_FromChar09AF
3368                     	xdef	_ToChar09AF
3369                     	xdef	_nLowBatTime
3370                     	xdef	_nPirHoldTime
3371                     	xdef	_nPirLevel
3372                     	xdef	_nLuxLevel
3373                     	xdef	_MotionFlags2
3374                     	xdef	_MotionFlags
3375                     	xref	_USART_ITConfig
3376                     	xref	_USART_Cmd
3377                     	xref	_USART_Init
3378                     	xref	_TIM2_ClearITPendingBit
3379                     	xref	_TIM2_GetITStatus
3380                     	xref	_TIM2_ITConfig
3381                     	xref	_TIM2_Cmd
3382                     	xref	_TIM2_ARRPreloadConfig
3383                     	xref	_TIM2_TimeBaseInit
3384                     	xref	_SYSCFG_REMAPPinConfig
3385                     	xref	_SYSCFG_REMAPDeInit
3386                     	xref	_RTC_ClearITPendingBit
3387                     	xref	_RTC_WakeUpCmd
3388                     	xref	_I2C_Cmd
3389                     	xref	_I2C_Init
3390                     	xref	_GPIO_ReadInputDataBit
3391                     	xref	_GPIO_ToggleBits
3392                     	xref	_GPIO_ResetBits
3393                     	xref	_GPIO_SetBits
3394                     	xref	_GPIO_Init
3395                     	xref	_FLASH_SetProgrammingTime
3396                     	xref	_EXTI_ClearITPendingBit
3397                     	xref	_EXTI_SelectPort
3398                     	xref	_EXTI_SetPinSensitivity
3399                     	xref	_CLK_PeripheralClockConfig
3400                     	xref	_CLK_RTCClockConfig
3401                     	xref	_CLK_SYSCLKDivConfig
3402                     .const:	section	.text
3403  0000               L535:
3404  0000 424144434d44  	dc.b	"BADCMD!",0
3405  0008               L715:
3406  0008 41544c4f5742  	dc.b	"ATLOWBAT=",0
3407  0012               L705:
3408  0012 41544c4f5742  	dc.b	"ATLOWBAT",0
3409  001b               L764:
3410  001b 41544c555853  	dc.b	"ATLUXSSLV=",0
3411  0026               L754:
3412  0026 41544c555800  	dc.b	"ATLUX",0
3413  002c               L734:
3414  002c 415450495253  	dc.b	"ATPIRSSLV=",0
3415  0037               L124:
3416  0037 415450495248  	dc.b	"ATPIRHDTM=",0
3417  0042               L114:
3418  0042 415450495200  	dc.b	"ATPIR",0
3419  0048               L743:
3420  0048 41544c45443d  	dc.b	"ATLED=",0
3421  004f               L733:
3422  004f 415444454600  	dc.b	"ATDEF",0
3423  0055               L723:
3424  0055 415452535400  	dc.b	"ATRST",0
3425  005b               L572:
3426  005b 415453544100  	dc.b	"ATSTA",0
3427  0061               L162:
3428  0061 41544500      	dc.b	"ATE",0
3429  0065               L352:
3430  0065 494242573031  	dc.b	"IBBW01_4 200122",0
3431  0075               L742:
3432  0075 415400        	dc.b	"AT",0
3433                     	xref.b	c_x
3434                     	xref.b	c_y
3454                     	end
