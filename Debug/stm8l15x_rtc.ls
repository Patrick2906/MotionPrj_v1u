   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  85                     ; 232 ErrorStatus RTC_DeInit(void)
  85                     ; 233 {
  87                     .text:	section	.text,new
  88  0000               _RTC_DeInit:
  90  0000 5205          	subw	sp,#5
  91       00000005      OFST:	set	5
  94                     ; 234   ErrorStatus status = ERROR;
  96  0002 7b01          	ld	a,(OFST-4,sp)
  97  0004 97            	ld	xl,a
  98                     ; 235   uint16_t wutwfcount = 0;
 100  0005 5f            	clrw	x
 101  0006 1f02          	ldw	(OFST-3,sp),x
 102                     ; 236   uint16_t recalpfcount = 0;
 104  0008 5f            	clrw	x
 105  0009 1f04          	ldw	(OFST-1,sp),x
 106                     ; 239   RTC->WPR = 0xCA;
 108  000b 35ca5159      	mov	20825,#202
 109                     ; 240   RTC->WPR = 0x53;
 111  000f 35535159      	mov	20825,#83
 112                     ; 243   if (RTC_EnterInitMode() == ERROR)
 114  0013 cd0000        	call	_RTC_EnterInitMode
 116  0016 4d            	tnz	a
 117  0017 260b          	jrne	L35
 118                     ; 245     status = ERROR;
 120  0019 0f01          	clr	(OFST-4,sp)
 121                     ; 247     RTC->WPR = 0xFF; 
 123  001b 35ff5159      	mov	20825,#255
 125  001f               L55:
 126                     ; 343   return (ErrorStatus)status;
 128  001f 7b01          	ld	a,(OFST-4,sp)
 131  0021 5b05          	addw	sp,#5
 132  0023 81            	ret
 133  0024               L35:
 134                     ; 252     RTC->TR1 = RTC_TR1_RESET_VALUE;
 136  0024 725f5140      	clr	20800
 137                     ; 253     RTC->TR2 = RTC_TR2_RESET_VALUE;
 139  0028 725f5141      	clr	20801
 140                     ; 254     RTC->TR3 = RTC_TR3_RESET_VALUE;
 142  002c 725f5142      	clr	20802
 143                     ; 257     RTC->DR1 = RTC_DR1_RESET_VALUE;
 145  0030 35015144      	mov	20804,#1
 146                     ; 258     RTC->DR2 = RTC_DR2_RESET_VALUE;
 148  0034 35215145      	mov	20805,#33
 149                     ; 259     RTC->DR3 = RTC_DR3_RESET_VALUE;
 151  0038 725f5146      	clr	20806
 152                     ; 262     RTC->SPRERH = RTC_SPRERH_RESET_VALUE;
 154  003c 725f5150      	clr	20816
 155                     ; 263     RTC->SPRERL = RTC_SPRERL_RESET_VALUE;
 157  0040 35ff5151      	mov	20817,#255
 158                     ; 264     RTC->APRER  = RTC_APRER_RESET_VALUE;
 160  0044 357f5152      	mov	20818,#127
 161                     ; 266     RTC->TCR1 = RTC_TCR1_RESET_VALUE;
 163  0048 725f516c      	clr	20844
 164                     ; 267     RTC->TCR2 = RTC_TCR2_RESET_VALUE;
 166  004c 725f516d      	clr	20845
 167                     ; 271     RTC->CR1 = RTC_CR1_RESET_VALUE;
 169  0050 725f5148      	clr	20808
 170                     ; 272     RTC->CR2 = RTC_CR2_RESET_VALUE;
 172  0054 725f5149      	clr	20809
 173                     ; 273     RTC->CR3 = RTC_CR3_RESET_VALUE;
 175  0058 725f514a      	clr	20810
 177  005c 200b          	jra	L36
 178  005e               L75:
 179                     ; 278       wutwfcount++;
 181  005e 1e02          	ldw	x,(OFST-3,sp)
 182  0060 1c0001        	addw	x,#1
 183  0063 1f02          	ldw	(OFST-3,sp),x
 184                     ; 279       RTC->ISR1 = 0;
 186  0065 725f514c      	clr	20812
 187  0069               L36:
 188                     ; 276     while (((RTC->ISR1 & RTC_ISR1_WUTWF) == RESET) && ( wutwfcount != WUTWF_TIMEOUT))
 190  0069 c6514c        	ld	a,20812
 191  006c a504          	bcp	a,#4
 192  006e 2607          	jrne	L76
 194  0070 1e02          	ldw	x,(OFST-3,sp)
 195  0072 a3ffff        	cpw	x,#65535
 196  0075 26e7          	jrne	L75
 197  0077               L76:
 198                     ; 282     if ((RTC->ISR1 & RTC_ISR1_WUTWF) == RESET)
 200  0077 c6514c        	ld	a,20812
 201  007a a504          	bcp	a,#4
 202  007c 2608          	jrne	L17
 203                     ; 284       status = ERROR;
 205  007e 0f01          	clr	(OFST-4,sp)
 206                     ; 286       RTC->WPR = 0xFF; 
 208  0080 35ff5159      	mov	20825,#255
 210  0084 2099          	jra	L55
 211  0086               L17:
 212                     ; 291       RTC->CR1 = RTC_CR1_RESET_VALUE;
 214  0086 725f5148      	clr	20808
 215                     ; 294       RTC->WUTRH = RTC_WUTRH_RESET_VALUE;
 217  008a 35ff5154      	mov	20820,#255
 218                     ; 295       RTC->WUTRL = RTC_WUTRL_RESET_VALUE;
 220  008e 35ff5155      	mov	20821,#255
 221                     ; 298       RTC->ALRMAR1 = RTC_ALRMAR1_RESET_VALUE;
 223  0092 725f515c      	clr	20828
 224                     ; 299       RTC->ALRMAR2 = RTC_ALRMAR2_RESET_VALUE;
 226  0096 725f515d      	clr	20829
 227                     ; 300       RTC->ALRMAR3 = RTC_ALRMAR3_RESET_VALUE;
 229  009a 725f515e      	clr	20830
 230                     ; 301       RTC->ALRMAR4 = RTC_ALRMAR4_RESET_VALUE;
 232  009e 725f515f      	clr	20831
 233                     ; 303       RTC->ALRMASSRH = RTC_ALRMASSRH_RESET_VALUE;
 235  00a2 725f5164      	clr	20836
 236                     ; 304       RTC->ALRMASSRL = RTC_ALRMASSRL_RESET_VALUE;
 238  00a6 725f5165      	clr	20837
 239                     ; 305       RTC->ALRMASSMSKR = RTC_ALRMASSMSKR_RESET_VALUE;
 241  00aa 725f5166      	clr	20838
 242                     ; 308       RTC->ISR1 = (uint8_t)0x00;
 244  00ae 725f514c      	clr	20812
 245                     ; 309       RTC->ISR2 = RTC_ISR2_RESET_VALUE;
 247  00b2 725f514d      	clr	20813
 248                     ; 311       if ((RTC->ISR1 & RTC_ISR1_RECALPF) != RESET)
 250  00b6 c6514c        	ld	a,20812
 251  00b9 a502          	bcp	a,#2
 252  00bb 2717          	jreq	L57
 254  00bd 2007          	jra	L101
 255  00bf               L77:
 256                     ; 315           recalpfcount++;
 258  00bf 1e04          	ldw	x,(OFST-1,sp)
 259  00c1 1c0001        	addw	x,#1
 260  00c4 1f04          	ldw	(OFST-1,sp),x
 261  00c6               L101:
 262                     ; 313         while (((RTC->ISR1 & RTC_ISR1_RECALPF) != RESET) && (recalpfcount != RECALPF_TIMEOUT))
 264  00c6 c6514c        	ld	a,20812
 265  00c9 a502          	bcp	a,#2
 266  00cb 2707          	jreq	L57
 268  00cd 1e04          	ldw	x,(OFST-1,sp)
 269  00cf a3ffff        	cpw	x,#65535
 270  00d2 26eb          	jrne	L77
 271  00d4               L57:
 272                     ; 318       if ((RTC->ISR1 & RTC_ISR1_RECALPF) == RESET)
 274  00d4 c6514c        	ld	a,20812
 275  00d7 a502          	bcp	a,#2
 276  00d9 2618          	jrne	L701
 277                     ; 320         RTC->CALRH = RTC_CALRH_RESET_VALUE;
 279  00db 725f516a      	clr	20842
 280                     ; 321         RTC->CALRL = RTC_CALRL_RESET_VALUE;
 282  00df 725f516b      	clr	20843
 283                     ; 323         if (RTC_WaitForSynchro() == ERROR)
 285  00e3 cd0000        	call	_RTC_WaitForSynchro
 287  00e6 4d            	tnz	a
 288  00e7 2604          	jrne	L111
 289                     ; 325           status = ERROR;
 291  00e9 0f01          	clr	(OFST-4,sp)
 293  00eb 2008          	jra	L511
 294  00ed               L111:
 295                     ; 329           status = SUCCESS;
 297  00ed a601          	ld	a,#1
 298  00ef 6b01          	ld	(OFST-4,sp),a
 299  00f1 2002          	jra	L511
 300  00f3               L701:
 301                     ; 334         status = ERROR;
 303  00f3 0f01          	clr	(OFST-4,sp)
 304  00f5               L511:
 305                     ; 338       RTC->WPR = 0xFF; 
 307  00f5 35ff5159      	mov	20825,#255
 308  00f9 ac1f001f      	jpf	L55
 408                     ; 359 ErrorStatus RTC_Init(RTC_InitTypeDef* RTC_InitStruct)
 408                     ; 360 {
 409                     .text:	section	.text,new
 410  0000               _RTC_Init:
 412  0000 89            	pushw	x
 413  0001 88            	push	a
 414       00000001      OFST:	set	1
 417                     ; 361   ErrorStatus status = ERROR;
 419  0002 0f01          	clr	(OFST+0,sp)
 420                     ; 364   assert_param(IS_RTC_HOUR_FORMAT(RTC_InitStruct->RTC_HourFormat));
 422                     ; 365   assert_param(IS_RTC_ASYNCH_PREDIV(RTC_InitStruct->RTC_AsynchPrediv));
 424                     ; 366   assert_param(IS_RTC_SYNCH_PREDIV(RTC_InitStruct->RTC_SynchPrediv));
 426                     ; 369   RTC->WPR = 0xCA;
 428  0004 35ca5159      	mov	20825,#202
 429                     ; 370   RTC->WPR = 0x53;
 431  0008 35535159      	mov	20825,#83
 432                     ; 373   if (RTC_EnterInitMode() == ERROR)
 434  000c cd0000        	call	_RTC_EnterInitMode
 436  000f 4d            	tnz	a
 437  0010 2604          	jrne	L761
 438                     ; 375     status = ERROR;
 440  0012 0f01          	clr	(OFST+0,sp)
 442  0014 202d          	jra	L171
 443  0016               L761:
 444                     ; 380     RTC->CR1 &= ((uint8_t)~( RTC_CR1_FMT ));
 446  0016 721d5148      	bres	20808,#6
 447                     ; 383     RTC->CR1 |=  ((uint8_t)(RTC_InitStruct->RTC_HourFormat));
 449  001a 1e02          	ldw	x,(OFST+1,sp)
 450  001c c65148        	ld	a,20808
 451  001f fa            	or	a,(x)
 452  0020 c75148        	ld	20808,a
 453                     ; 386     RTC->SPRERH = (uint8_t)(RTC_InitStruct->RTC_SynchPrediv >> 8);
 455  0023 1e02          	ldw	x,(OFST+1,sp)
 456  0025 ee02          	ldw	x,(2,x)
 457  0027 4f            	clr	a
 458  0028 01            	rrwa	x,a
 459  0029 9f            	ld	a,xl
 460  002a c75150        	ld	20816,a
 461                     ; 387     RTC->SPRERL = (uint8_t)(RTC_InitStruct->RTC_SynchPrediv);
 463  002d 1e02          	ldw	x,(OFST+1,sp)
 464  002f e603          	ld	a,(3,x)
 465  0031 c75151        	ld	20817,a
 466                     ; 388     RTC->APRER =  (uint8_t)(RTC_InitStruct->RTC_AsynchPrediv);
 468  0034 1e02          	ldw	x,(OFST+1,sp)
 469  0036 e601          	ld	a,(1,x)
 470  0038 c75152        	ld	20818,a
 471                     ; 391     RTC->ISR1 &= (uint8_t)~RTC_ISR1_INIT;
 473  003b 721f514c      	bres	20812,#7
 474                     ; 393     status = SUCCESS;
 476  003f a601          	ld	a,#1
 477  0041 6b01          	ld	(OFST+0,sp),a
 478  0043               L171:
 479                     ; 397   RTC->WPR = 0xFF; 
 481  0043 35ff5159      	mov	20825,#255
 482                     ; 400   return (ErrorStatus)(status);
 484  0047 7b01          	ld	a,(OFST+0,sp)
 487  0049 5b03          	addw	sp,#3
 488  004b 81            	ret
 525                     ; 410 void RTC_StructInit(RTC_InitTypeDef* RTC_InitStruct)
 525                     ; 411 {
 526                     .text:	section	.text,new
 527  0000               _RTC_StructInit:
 531                     ; 413   RTC_InitStruct->RTC_HourFormat = RTC_HourFormat_24;
 533  0000 7f            	clr	(x)
 534                     ; 416   RTC_InitStruct->RTC_AsynchPrediv = RTC_APRER_RESET_VALUE;
 536  0001 a67f          	ld	a,#127
 537  0003 e701          	ld	(1,x),a
 538                     ; 419   RTC_InitStruct->RTC_SynchPrediv = RTC_SPRERL_RESET_VALUE;
 540  0005 90ae00ff      	ldw	y,#255
 541  0009 ef02          	ldw	(2,x),y
 542                     ; 420 }
 545  000b 81            	ret
 601                     ; 430 void RTC_WriteProtectionCmd(FunctionalState NewState)
 601                     ; 431 {
 602                     .text:	section	.text,new
 603  0000               _RTC_WriteProtectionCmd:
 607                     ; 433   assert_param(IS_FUNCTIONAL_STATE(NewState));
 609                     ; 435   if (NewState != DISABLE)
 611  0000 4d            	tnz	a
 612  0001 2706          	jreq	L142
 613                     ; 438     RTC->WPR = RTC_WPR_EnableKey;
 615  0003 35ff5159      	mov	20825,#255
 617  0007 2008          	jra	L342
 618  0009               L142:
 619                     ; 443     RTC->WPR = RTC_WPR_DisableKey1;
 621  0009 35ca5159      	mov	20825,#202
 622                     ; 444     RTC->WPR = RTC_WPR_DisableKey2;
 624  000d 35535159      	mov	20825,#83
 625  0011               L342:
 626                     ; 446 }
 629  0011 81            	ret
 674                     ; 458 ErrorStatus RTC_EnterInitMode(void)
 674                     ; 459 {
 675                     .text:	section	.text,new
 676  0000               _RTC_EnterInitMode:
 678  0000 5203          	subw	sp,#3
 679       00000003      OFST:	set	3
 682                     ; 460   ErrorStatus status = ERROR;
 684  0002 7b01          	ld	a,(OFST-2,sp)
 685  0004 97            	ld	xl,a
 686                     ; 461   uint16_t initfcount = 0;
 688  0005 5f            	clrw	x
 689  0006 1f02          	ldw	(OFST-1,sp),x
 690                     ; 464   if ((RTC->ISR1 & RTC_ISR1_INITF) == RESET)
 692  0008 c6514c        	ld	a,20812
 693  000b a540          	bcp	a,#64
 694  000d 261b          	jrne	L762
 695                     ; 467     RTC->ISR1 = (uint8_t)RTC_ISR1_INIT;
 697  000f 3580514c      	mov	20812,#128
 699  0013 2007          	jra	L572
 700  0015               L172:
 701                     ; 472       initfcount++;
 703  0015 1e02          	ldw	x,(OFST-1,sp)
 704  0017 1c0001        	addw	x,#1
 705  001a 1f02          	ldw	(OFST-1,sp),x
 706  001c               L572:
 707                     ; 470     while (((RTC->ISR1 & RTC_ISR1_INITF) == RESET) && ( initfcount != INITF_TIMEOUT))
 709  001c c6514c        	ld	a,20812
 710  001f a540          	bcp	a,#64
 711  0021 2607          	jrne	L762
 713  0023 1e02          	ldw	x,(OFST-1,sp)
 714  0025 a3ffff        	cpw	x,#65535
 715  0028 26eb          	jrne	L172
 716  002a               L762:
 717                     ; 476   if ((RTC->ISR1 & RTC_ISR1_INITF) == RESET)
 719  002a c6514c        	ld	a,20812
 720  002d a540          	bcp	a,#64
 721  002f 2604          	jrne	L303
 722                     ; 478     status = ERROR;
 724  0031 0f01          	clr	(OFST-2,sp)
 726  0033 2004          	jra	L503
 727  0035               L303:
 728                     ; 482     status = SUCCESS;
 730  0035 a601          	ld	a,#1
 731  0037 6b01          	ld	(OFST-2,sp),a
 732  0039               L503:
 733                     ; 485   return (ErrorStatus)status;
 735  0039 7b01          	ld	a,(OFST-2,sp)
 738  003b 5b03          	addw	sp,#3
 739  003d 81            	ret
 762                     ; 498 void RTC_ExitInitMode(void)
 762                     ; 499 {
 763                     .text:	section	.text,new
 764  0000               _RTC_ExitInitMode:
 768                     ; 501   RTC->ISR1 &= (uint8_t)~RTC_ISR1_INIT;
 770  0000 721f514c      	bres	20812,#7
 771                     ; 502 }
 774  0004 81            	ret
 819                     ; 527 ErrorStatus RTC_WaitForSynchro(void)
 819                     ; 528 {
 820                     .text:	section	.text,new
 821  0000               _RTC_WaitForSynchro:
 823  0000 5203          	subw	sp,#3
 824       00000003      OFST:	set	3
 827                     ; 529   uint16_t rsfcount = 0;
 829  0002 5f            	clrw	x
 830  0003 1f02          	ldw	(OFST-1,sp),x
 831                     ; 530   ErrorStatus status = ERROR;
 833  0005 7b01          	ld	a,(OFST-2,sp)
 834  0007 97            	ld	xl,a
 835                     ; 533   RTC->WPR = 0xCA;
 837  0008 35ca5159      	mov	20825,#202
 838                     ; 534   RTC->WPR = 0x53;
 840  000c 35535159      	mov	20825,#83
 841                     ; 537   RTC->ISR1 &= (uint8_t)~(RTC_ISR1_RSF | RTC_ISR1_INIT);
 843  0010 c6514c        	ld	a,20812
 844  0013 a45f          	and	a,#95
 845  0015 c7514c        	ld	20812,a
 847  0018 2007          	jra	L343
 848  001a               L143:
 849                     ; 542     rsfcount++;
 851  001a 1e02          	ldw	x,(OFST-1,sp)
 852  001c 1c0001        	addw	x,#1
 853  001f 1f02          	ldw	(OFST-1,sp),x
 854  0021               L343:
 855                     ; 540   while (((RTC->ISR1 & RTC_ISR1_RSF) == RESET) && ( rsfcount != RSF_TIMEOUT))
 857  0021 c6514c        	ld	a,20812
 858  0024 a520          	bcp	a,#32
 859  0026 2607          	jrne	L743
 861  0028 1e02          	ldw	x,(OFST-1,sp)
 862  002a a3ffff        	cpw	x,#65535
 863  002d 26eb          	jrne	L143
 864  002f               L743:
 865                     ; 546   if ((RTC->ISR1 & RTC_ISR1_RSF) != RESET)
 867  002f c6514c        	ld	a,20812
 868  0032 a520          	bcp	a,#32
 869  0034 2706          	jreq	L153
 870                     ; 548     status = SUCCESS;
 872  0036 a601          	ld	a,#1
 873  0038 6b01          	ld	(OFST-2,sp),a
 875  003a 2002          	jra	L353
 876  003c               L153:
 877                     ; 552     status = ERROR;
 879  003c 0f01          	clr	(OFST-2,sp)
 880  003e               L353:
 881                     ; 556   RTC->WPR = 0xFF; 
 883  003e 35ff5159      	mov	20825,#255
 884                     ; 558   return (ErrorStatus)status;
 886  0042 7b01          	ld	a,(OFST-2,sp)
 889  0044 5b03          	addw	sp,#3
 890  0046 81            	ret
 925                     ; 568 void RTC_RatioCmd(FunctionalState NewState)
 925                     ; 569 {
 926                     .text:	section	.text,new
 927  0000               _RTC_RatioCmd:
 931                     ; 571   assert_param(IS_FUNCTIONAL_STATE(NewState));
 933                     ; 574   RTC->WPR = 0xCA;
 935  0000 35ca5159      	mov	20825,#202
 936                     ; 575   RTC->WPR = 0x53;
 938  0004 35535159      	mov	20825,#83
 939                     ; 577   if (NewState != DISABLE)
 941  0008 4d            	tnz	a
 942  0009 2706          	jreq	L373
 943                     ; 580     RTC->CR1 |= (uint8_t)RTC_CR1_RATIO;
 945  000b 721a5148      	bset	20808,#5
 947  000f 2004          	jra	L573
 948  0011               L373:
 949                     ; 585     RTC->CR1 &= (uint8_t)~RTC_CR1_RATIO;
 951  0011 721b5148      	bres	20808,#5
 952  0015               L573:
 953                     ; 589   RTC->WPR = 0xFF; 
 955  0015 35ff5159      	mov	20825,#255
 956                     ; 590 }
 959  0019 81            	ret
 995                     ; 598 void RTC_BypassShadowCmd(FunctionalState NewState)
 995                     ; 599 {
 996                     .text:	section	.text,new
 997  0000               _RTC_BypassShadowCmd:
1001                     ; 601   assert_param(IS_FUNCTIONAL_STATE(NewState));
1003                     ; 604   RTC->WPR = 0xCA;
1005  0000 35ca5159      	mov	20825,#202
1006                     ; 605   RTC->WPR = 0x53;
1008  0004 35535159      	mov	20825,#83
1009                     ; 607   if (NewState != DISABLE)
1011  0008 4d            	tnz	a
1012  0009 2706          	jreq	L514
1013                     ; 610     RTC->CR1 |= (uint8_t)RTC_CR1_BYPSHAD;
1015  000b 72185148      	bset	20808,#4
1017  000f 2004          	jra	L714
1018  0011               L514:
1019                     ; 615     RTC->CR1 &= (uint8_t)~RTC_CR1_BYPSHAD;
1021  0011 72195148      	bres	20808,#4
1022  0015               L714:
1023                     ; 619   RTC->WPR = 0xFF; 
1025  0015 35ff5159      	mov	20825,#255
1026                     ; 620 }
1029  0019 81            	ret
1177                     ; 659 ErrorStatus RTC_SetTime(RTC_Format_TypeDef RTC_Format,
1177                     ; 660                         RTC_TimeTypeDef* RTC_TimeStruct)
1177                     ; 661 {
1178                     .text:	section	.text,new
1179  0000               _RTC_SetTime:
1181  0000 88            	push	a
1182  0001 88            	push	a
1183       00000001      OFST:	set	1
1186                     ; 662   ErrorStatus status = ERROR;
1188  0002 7b01          	ld	a,(OFST+0,sp)
1189  0004 97            	ld	xl,a
1190                     ; 663   uint8_t temp = 0;
1192  0005 7b01          	ld	a,(OFST+0,sp)
1193  0007 97            	ld	xl,a
1194                     ; 666   assert_param(IS_RTC_FORMAT(RTC_Format));
1196                     ; 668   if (RTC_Format == RTC_Format_BIN)
1198  0008 0d02          	tnz	(OFST+1,sp)
1199  000a 2609          	jrne	L315
1200                     ; 671     if ((RTC->CR1 & RTC_CR1_FMT) != RESET)
1202  000c c65148        	ld	a,20808
1203  000f a540          	bcp	a,#64
1204  0011 2700          	jreq	L515
1205                     ; 673       assert_param(IS_RTC_HOUR12_MAX(RTC_TimeStruct->RTC_Hours));
1207                     ; 674       assert_param(IS_RTC_HOUR12_MIN(RTC_TimeStruct->RTC_Hours));
1210  0013               L515:
1211                     ; 678       assert_param(IS_RTC_HOUR24(RTC_TimeStruct->RTC_Hours));
1213                     ; 680     assert_param(IS_RTC_MINUTES(RTC_TimeStruct->RTC_Minutes));
1215                     ; 681     assert_param(IS_RTC_SECONDS(RTC_TimeStruct->RTC_Seconds));
1218  0013 2007          	jra	L125
1219  0015               L315:
1220                     ; 686     if ((RTC->CR1 & RTC_CR1_FMT) != RESET)
1222  0015 c65148        	ld	a,20808
1223  0018 a540          	bcp	a,#64
1224  001a 2700          	jreq	L325
1225                     ; 688       assert_param(IS_RTC_HOUR12_MAX(Bcd2ToByte(RTC_TimeStruct->RTC_Hours)));
1227                     ; 689       assert_param(IS_RTC_HOUR12_MIN(Bcd2ToByte(RTC_TimeStruct->RTC_Hours)));
1230  001c               L325:
1231                     ; 693       assert_param(IS_RTC_HOUR24(Bcd2ToByte(RTC_TimeStruct->RTC_Hours)));
1233                     ; 695     assert_param(IS_RTC_MINUTES(Bcd2ToByte(RTC_TimeStruct->RTC_Minutes)));
1235                     ; 696     assert_param(IS_RTC_SECONDS(Bcd2ToByte(RTC_TimeStruct->RTC_Seconds)));
1237  001c               L125:
1238                     ; 701   RTC->WPR = 0xCA;
1240  001c 35ca5159      	mov	20825,#202
1241                     ; 702   RTC->WPR = 0x53;
1243  0020 35535159      	mov	20825,#83
1244                     ; 705   if (RTC_EnterInitMode() == ERROR)
1246  0024 cd0000        	call	_RTC_EnterInitMode
1248  0027 4d            	tnz	a
1249  0028 2608          	jrne	L725
1250                     ; 707     status = ERROR;
1252  002a 0f01          	clr	(OFST+0,sp)
1253                     ; 709     RTC->WPR = 0xFF; 
1255  002c 35ff5159      	mov	20825,#255
1257  0030 2073          	jra	L135
1258  0032               L725:
1259                     ; 714     if ((RTC->CR1 & RTC_CR1_FMT) != RESET)
1261  0032 c65148        	ld	a,20808
1262  0035 a540          	bcp	a,#64
1263  0037 2708          	jreq	L335
1264                     ; 716       assert_param(IS_RTC_H12(RTC_TimeStruct->RTC_H12));
1266                     ; 717       temp = RTC_TimeStruct->RTC_H12;
1268  0039 1e05          	ldw	x,(OFST+4,sp)
1269  003b e603          	ld	a,(3,x)
1270  003d 6b01          	ld	(OFST+0,sp),a
1272  003f 2002          	jra	L535
1273  0041               L335:
1274                     ; 721       temp = 0;
1276  0041 0f01          	clr	(OFST+0,sp)
1277  0043               L535:
1278                     ; 724     if (RTC_Format != RTC_Format_BIN)
1280  0043 0d02          	tnz	(OFST+1,sp)
1281  0045 2718          	jreq	L735
1282                     ; 726       RTC->TR1 = (uint8_t)(RTC_TimeStruct->RTC_Seconds);
1284  0047 1e05          	ldw	x,(OFST+4,sp)
1285  0049 e602          	ld	a,(2,x)
1286  004b c75140        	ld	20800,a
1287                     ; 727       RTC->TR2 = (uint8_t)(RTC_TimeStruct->RTC_Minutes) ;
1289  004e 1e05          	ldw	x,(OFST+4,sp)
1290  0050 e601          	ld	a,(1,x)
1291  0052 c75141        	ld	20801,a
1292                     ; 728       RTC->TR3 = (uint8_t)( temp | RTC_TimeStruct->RTC_Hours) ;
1294  0055 1e05          	ldw	x,(OFST+4,sp)
1295  0057 f6            	ld	a,(x)
1296  0058 1a01          	or	a,(OFST+0,sp)
1297  005a c75142        	ld	20802,a
1299  005d 201f          	jra	L145
1300  005f               L735:
1301                     ; 732       RTC->TR1 = (uint8_t)(ByteToBcd2(RTC_TimeStruct->RTC_Seconds));
1303  005f 1e05          	ldw	x,(OFST+4,sp)
1304  0061 e602          	ld	a,(2,x)
1305  0063 cd0000        	call	L3_ByteToBcd2
1307  0066 c75140        	ld	20800,a
1308                     ; 733       RTC->TR2 = (uint8_t)(ByteToBcd2(RTC_TimeStruct->RTC_Minutes)) ;
1310  0069 1e05          	ldw	x,(OFST+4,sp)
1311  006b e601          	ld	a,(1,x)
1312  006d cd0000        	call	L3_ByteToBcd2
1314  0070 c75141        	ld	20801,a
1315                     ; 734       RTC->TR3 = (uint8_t)( temp | ByteToBcd2(RTC_TimeStruct->RTC_Hours));
1317  0073 1e05          	ldw	x,(OFST+4,sp)
1318  0075 f6            	ld	a,(x)
1319  0076 cd0000        	call	L3_ByteToBcd2
1321  0079 1a01          	or	a,(OFST+0,sp)
1322  007b c75142        	ld	20802,a
1323  007e               L145:
1324                     ; 737     (void)(RTC->DR3);
1326  007e c65146        	ld	a,20806
1327  0081 97            	ld	xl,a
1328                     ; 740     RTC->ISR1 &= (uint8_t)~RTC_ISR1_INIT;
1330  0082 721f514c      	bres	20812,#7
1331                     ; 743     RTC->WPR = 0xFF; 
1333  0086 35ff5159      	mov	20825,#255
1334                     ; 746     if ((RTC->CR1 & RTC_CR1_BYPSHAD) == RESET)
1336  008a c65148        	ld	a,20808
1337  008d a510          	bcp	a,#16
1338  008f 2610          	jrne	L345
1339                     ; 748       if (RTC_WaitForSynchro() == ERROR)
1341  0091 cd0000        	call	_RTC_WaitForSynchro
1343  0094 4d            	tnz	a
1344  0095 2604          	jrne	L545
1345                     ; 750         status = ERROR;
1347  0097 0f01          	clr	(OFST+0,sp)
1349  0099 200a          	jra	L135
1350  009b               L545:
1351                     ; 754         status = SUCCESS;
1353  009b a601          	ld	a,#1
1354  009d 6b01          	ld	(OFST+0,sp),a
1355  009f 2004          	jra	L135
1356  00a1               L345:
1357                     ; 759       status = SUCCESS;
1359  00a1 a601          	ld	a,#1
1360  00a3 6b01          	ld	(OFST+0,sp),a
1361  00a5               L135:
1362                     ; 763   return (ErrorStatus)status;
1364  00a5 7b01          	ld	a,(OFST+0,sp)
1367  00a7 85            	popw	x
1368  00a8 81            	ret
1405                     ; 775 void RTC_TimeStructInit(RTC_TimeTypeDef* RTC_TimeStruct)
1405                     ; 776 {
1406                     .text:	section	.text,new
1407  0000               _RTC_TimeStructInit:
1411                     ; 778   RTC_TimeStruct->RTC_H12 = RTC_H12_AM;
1413  0000 6f03          	clr	(3,x)
1414                     ; 779   RTC_TimeStruct->RTC_Hours = 0;
1416  0002 7f            	clr	(x)
1417                     ; 780   RTC_TimeStruct->RTC_Minutes = 0;
1419  0003 6f01          	clr	(1,x)
1420                     ; 781   RTC_TimeStruct->RTC_Seconds = 0;
1422  0005 6f02          	clr	(2,x)
1423                     ; 782 }
1426  0007 81            	ret
1483                     ; 798 void RTC_GetTime(RTC_Format_TypeDef RTC_Format,
1483                     ; 799                  RTC_TimeTypeDef* RTC_TimeStruct)
1483                     ; 800 {
1484                     .text:	section	.text,new
1485  0000               _RTC_GetTime:
1487  0000 88            	push	a
1488  0001 88            	push	a
1489       00000001      OFST:	set	1
1492                     ; 801   uint8_t  tmpreg = 0;
1494  0002 0f01          	clr	(OFST+0,sp)
1495                     ; 804   assert_param(IS_RTC_FORMAT(RTC_Format));
1497                     ; 808   RTC_TimeStruct->RTC_Seconds = RTC->TR1;
1499  0004 1e05          	ldw	x,(OFST+4,sp)
1500  0006 c65140        	ld	a,20800
1501  0009 e702          	ld	(2,x),a
1502                     ; 811   RTC_TimeStruct->RTC_Minutes = RTC->TR2;
1504  000b 1e05          	ldw	x,(OFST+4,sp)
1505  000d c65141        	ld	a,20801
1506  0010 e701          	ld	(1,x),a
1507                     ; 814   tmpreg = (uint8_t)RTC->TR3;
1509  0012 c65142        	ld	a,20802
1510  0015 6b01          	ld	(OFST+0,sp),a
1511                     ; 817   (void) (RTC->DR3) ;
1513  0017 c65146        	ld	a,20806
1514  001a 97            	ld	xl,a
1515                     ; 821   RTC_TimeStruct->RTC_Hours = (uint8_t)(tmpreg & (uint8_t)~(RTC_TR3_PM));
1517  001b 7b01          	ld	a,(OFST+0,sp)
1518  001d a4bf          	and	a,#191
1519  001f 1e05          	ldw	x,(OFST+4,sp)
1520  0021 f7            	ld	(x),a
1521                     ; 824   RTC_TimeStruct->RTC_H12 = (RTC_H12_TypeDef)(tmpreg & RTC_TR3_PM);
1523  0022 7b01          	ld	a,(OFST+0,sp)
1524  0024 a440          	and	a,#64
1525  0026 1e05          	ldw	x,(OFST+4,sp)
1526  0028 e703          	ld	(3,x),a
1527                     ; 827   if (RTC_Format == RTC_Format_BIN)
1529  002a 0d02          	tnz	(OFST+1,sp)
1530  002c 261f          	jrne	L326
1531                     ; 830     RTC_TimeStruct->RTC_Hours = (uint8_t)Bcd2ToByte(RTC_TimeStruct->RTC_Hours);
1533  002e 1e05          	ldw	x,(OFST+4,sp)
1534  0030 f6            	ld	a,(x)
1535  0031 cd0000        	call	L5_Bcd2ToByte
1537  0034 1e05          	ldw	x,(OFST+4,sp)
1538  0036 f7            	ld	(x),a
1539                     ; 831     RTC_TimeStruct->RTC_Minutes = (uint8_t)Bcd2ToByte(RTC_TimeStruct->RTC_Minutes);
1541  0037 1e05          	ldw	x,(OFST+4,sp)
1542  0039 e601          	ld	a,(1,x)
1543  003b cd0000        	call	L5_Bcd2ToByte
1545  003e 1e05          	ldw	x,(OFST+4,sp)
1546  0040 e701          	ld	(1,x),a
1547                     ; 832     RTC_TimeStruct->RTC_Seconds = (uint8_t)Bcd2ToByte(RTC_TimeStruct->RTC_Seconds);
1549  0042 1e05          	ldw	x,(OFST+4,sp)
1550  0044 e602          	ld	a,(2,x)
1551  0046 cd0000        	call	L5_Bcd2ToByte
1553  0049 1e05          	ldw	x,(OFST+4,sp)
1554  004b e702          	ld	(2,x),a
1555  004d               L326:
1556                     ; 834 }
1559  004d 85            	popw	x
1560  004e 81            	ret
1612                     ; 845 uint16_t RTC_GetSubSecond(void)
1612                     ; 846 {
1613                     .text:	section	.text,new
1614  0000               _RTC_GetSubSecond:
1616  0000 5206          	subw	sp,#6
1617       00000006      OFST:	set	6
1620                     ; 847   uint8_t ssrhreg = 0, ssrlreg = 0;
1622  0002 7b03          	ld	a,(OFST-3,sp)
1623  0004 97            	ld	xl,a
1626  0005 7b04          	ld	a,(OFST-2,sp)
1627  0007 97            	ld	xl,a
1628                     ; 848   uint16_t ssrreg = 0;
1630  0008 1e05          	ldw	x,(OFST-1,sp)
1631                     ; 851   ssrhreg = RTC->SSRH;
1633  000a c65157        	ld	a,20823
1634  000d 6b03          	ld	(OFST-3,sp),a
1635                     ; 852   ssrlreg = RTC->SSRL;
1637  000f c65158        	ld	a,20824
1638  0012 6b04          	ld	(OFST-2,sp),a
1639                     ; 855   (void) (RTC->DR3);
1641  0014 c65146        	ld	a,20806
1642  0017 97            	ld	xl,a
1643                     ; 858   ssrreg = (uint16_t)((uint16_t)((uint16_t)ssrhreg << 8) | (uint16_t)(ssrlreg));
1645  0018 7b04          	ld	a,(OFST-2,sp)
1646  001a 5f            	clrw	x
1647  001b 97            	ld	xl,a
1648  001c 1f01          	ldw	(OFST-5,sp),x
1649  001e 7b03          	ld	a,(OFST-3,sp)
1650  0020 5f            	clrw	x
1651  0021 97            	ld	xl,a
1652  0022 4f            	clr	a
1653  0023 02            	rlwa	x,a
1654  0024 01            	rrwa	x,a
1655  0025 1a02          	or	a,(OFST-4,sp)
1656  0027 01            	rrwa	x,a
1657  0028 1a01          	or	a,(OFST-5,sp)
1658  002a 01            	rrwa	x,a
1659  002b 1f05          	ldw	(OFST-1,sp),x
1660                     ; 859   return (uint16_t)(ssrreg);
1662  002d 1e05          	ldw	x,(OFST-1,sp)
1665  002f 5b06          	addw	sp,#6
1666  0031 81            	ret
1918                     ; 876 ErrorStatus RTC_SetDate(RTC_Format_TypeDef RTC_Format,
1918                     ; 877                         RTC_DateTypeDef* RTC_DateStruct)
1918                     ; 878 {
1919                     .text:	section	.text,new
1920  0000               _RTC_SetDate:
1922  0000 88            	push	a
1923  0001 89            	pushw	x
1924       00000002      OFST:	set	2
1927                     ; 879   ErrorStatus status = ERROR;
1929  0002 0f02          	clr	(OFST+0,sp)
1930                     ; 881   if ((RTC_Format == RTC_Format_BIN) && ((RTC_DateStruct->RTC_Month & TEN_VALUE_BCD) == TEN_VALUE_BCD))
1932  0004 4d            	tnz	a
1933  0005 2616          	jrne	L1001
1935  0007 1e06          	ldw	x,(OFST+4,sp)
1936  0009 e601          	ld	a,(1,x)
1937  000b a410          	and	a,#16
1938  000d a110          	cp	a,#16
1939  000f 260c          	jrne	L1001
1940                     ; 883     RTC_DateStruct->RTC_Month = (RTC_Month_TypeDef)((RTC_DateStruct->RTC_Month & (uint8_t)~(TEN_VALUE_BCD)) + TEN_VALUE_BIN);
1942  0011 1e06          	ldw	x,(OFST+4,sp)
1943  0013 e601          	ld	a,(1,x)
1944  0015 a4ef          	and	a,#239
1945  0017 ab0a          	add	a,#10
1946  0019 1e06          	ldw	x,(OFST+4,sp)
1947  001b e701          	ld	(1,x),a
1948  001d               L1001:
1949                     ; 887   assert_param(IS_RTC_FORMAT(RTC_Format));
1951                     ; 888   if (RTC_Format == RTC_Format_BIN)
1953  001d 0d03          	tnz	(OFST+1,sp)
1954  001f 2600          	jrne	L3001
1955                     ; 890     assert_param(IS_RTC_YEAR(RTC_DateStruct->RTC_Year));
1957                     ; 891     assert_param(IS_RTC_MONTH_MIN(RTC_DateStruct->RTC_Month));
1959                     ; 892     assert_param(IS_RTC_MONTH_MAX(RTC_DateStruct->RTC_Month));
1961                     ; 893     assert_param(IS_RTC_DATE_MIN(RTC_DateStruct->RTC_Date));
1963                     ; 894     assert_param(IS_RTC_DATE_MAX(RTC_DateStruct->RTC_Date));
1966  0021               L3001:
1967                     ; 898     assert_param(IS_RTC_YEAR(Bcd2ToByte(RTC_DateStruct->RTC_Year)));
1969                     ; 899     assert_param(IS_RTC_MONTH_MAX(Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Month)));
1971                     ; 900     assert_param(IS_RTC_MONTH_MIN(Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Month)));
1973                     ; 901     assert_param(IS_RTC_DATE_MIN(Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Date)));
1975                     ; 902     assert_param(IS_RTC_DATE_MAX(Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Date)));
1977                     ; 904   assert_param(IS_RTC_WEEKDAY(RTC_DateStruct->RTC_WeekDay));
1979                     ; 907   RTC->WPR = 0xCA;
1981  0021 35ca5159      	mov	20825,#202
1982                     ; 908   RTC->WPR = 0x53;
1984  0025 35535159      	mov	20825,#83
1985                     ; 911   if (RTC_EnterInitMode() == ERROR)
1987  0029 cd0000        	call	_RTC_EnterInitMode
1989  002c 4d            	tnz	a
1990  002d 2608          	jrne	L7001
1991                     ; 913     status = ERROR;
1993  002f 0f02          	clr	(OFST+0,sp)
1994                     ; 915     RTC->WPR = 0xFF; 
1996  0031 35ff5159      	mov	20825,#255
1998  0035 2074          	jra	L1101
1999  0037               L7001:
2000                     ; 919     (void)(RTC->TR1);
2002  0037 c65140        	ld	a,20800
2003  003a 97            	ld	xl,a
2004                     ; 922     if (RTC_Format != RTC_Format_BIN)
2006  003b 0d03          	tnz	(OFST+1,sp)
2007  003d 271f          	jreq	L3101
2008                     ; 924       RTC->DR1 = (uint8_t)(RTC_DateStruct->RTC_Date);
2010  003f 1e06          	ldw	x,(OFST+4,sp)
2011  0041 e602          	ld	a,(2,x)
2012  0043 c75144        	ld	20804,a
2013                     ; 925       RTC->DR2 = (uint8_t)((RTC_DateStruct->RTC_Month) | (uint8_t)((RTC_DateStruct->RTC_WeekDay) << 5));
2015  0046 1e06          	ldw	x,(OFST+4,sp)
2016  0048 f6            	ld	a,(x)
2017  0049 97            	ld	xl,a
2018  004a a620          	ld	a,#32
2019  004c 42            	mul	x,a
2020  004d 9f            	ld	a,xl
2021  004e 1e06          	ldw	x,(OFST+4,sp)
2022  0050 ea01          	or	a,(1,x)
2023  0052 c75145        	ld	20805,a
2024                     ; 926       RTC->DR3 = (uint8_t)((RTC_DateStruct->RTC_Year));
2026  0055 1e06          	ldw	x,(OFST+4,sp)
2027  0057 e603          	ld	a,(3,x)
2028  0059 c75146        	ld	20806,a
2030  005c 202a          	jra	L5101
2031  005e               L3101:
2032                     ; 930       RTC->DR1 = (uint8_t)(ByteToBcd2 ((uint8_t)RTC_DateStruct->RTC_Date));
2034  005e 1e06          	ldw	x,(OFST+4,sp)
2035  0060 e602          	ld	a,(2,x)
2036  0062 cd0000        	call	L3_ByteToBcd2
2038  0065 c75144        	ld	20804,a
2039                     ; 931       RTC->DR2 = (uint8_t)((ByteToBcd2((uint8_t)RTC_DateStruct->RTC_Month)) | (uint8_t)((RTC_DateStruct->RTC_WeekDay) << 5));
2041  0068 1e06          	ldw	x,(OFST+4,sp)
2042  006a f6            	ld	a,(x)
2043  006b 97            	ld	xl,a
2044  006c a620          	ld	a,#32
2045  006e 42            	mul	x,a
2046  006f 9f            	ld	a,xl
2047  0070 6b01          	ld	(OFST-1,sp),a
2048  0072 1e06          	ldw	x,(OFST+4,sp)
2049  0074 e601          	ld	a,(1,x)
2050  0076 cd0000        	call	L3_ByteToBcd2
2052  0079 1a01          	or	a,(OFST-1,sp)
2053  007b c75145        	ld	20805,a
2054                     ; 932       RTC->DR3 = (uint8_t)(ByteToBcd2((uint8_t)RTC_DateStruct->RTC_Year));
2056  007e 1e06          	ldw	x,(OFST+4,sp)
2057  0080 e603          	ld	a,(3,x)
2058  0082 cd0000        	call	L3_ByteToBcd2
2060  0085 c75146        	ld	20806,a
2061  0088               L5101:
2062                     ; 936     RTC->ISR1 &= (uint8_t)~RTC_ISR1_INIT;
2064  0088 721f514c      	bres	20812,#7
2065                     ; 939     RTC->WPR = 0xFF; 
2067  008c 35ff5159      	mov	20825,#255
2068                     ; 942     if ((RTC->CR1 & RTC_CR1_BYPSHAD) == RESET)
2070  0090 c65148        	ld	a,20808
2071  0093 a510          	bcp	a,#16
2072  0095 2610          	jrne	L7101
2073                     ; 944       if (RTC_WaitForSynchro() == ERROR)
2075  0097 cd0000        	call	_RTC_WaitForSynchro
2077  009a 4d            	tnz	a
2078  009b 2604          	jrne	L1201
2079                     ; 946         status = ERROR;
2081  009d 0f02          	clr	(OFST+0,sp)
2083  009f 200a          	jra	L1101
2084  00a1               L1201:
2085                     ; 950         status = SUCCESS;
2087  00a1 a601          	ld	a,#1
2088  00a3 6b02          	ld	(OFST+0,sp),a
2089  00a5 2004          	jra	L1101
2090  00a7               L7101:
2091                     ; 955       status = SUCCESS;
2093  00a7 a601          	ld	a,#1
2094  00a9 6b02          	ld	(OFST+0,sp),a
2095  00ab               L1101:
2096                     ; 959   return (ErrorStatus)status;
2098  00ab 7b02          	ld	a,(OFST+0,sp)
2101  00ad 5b03          	addw	sp,#3
2102  00af 81            	ret
2139                     ; 968 void RTC_DateStructInit(RTC_DateTypeDef* RTC_DateStruct)
2139                     ; 969 {
2140                     .text:	section	.text,new
2141  0000               _RTC_DateStructInit:
2145                     ; 971   RTC_DateStruct->RTC_WeekDay = RTC_Weekday_Monday;
2147  0000 a601          	ld	a,#1
2148  0002 f7            	ld	(x),a
2149                     ; 972   RTC_DateStruct->RTC_Date = 1;
2151  0003 a601          	ld	a,#1
2152  0005 e702          	ld	(2,x),a
2153                     ; 973   RTC_DateStruct->RTC_Month = RTC_Month_January;
2155  0007 a601          	ld	a,#1
2156  0009 e701          	ld	(1,x),a
2157                     ; 974   RTC_DateStruct->RTC_Year = 0;
2159  000b 6f03          	clr	(3,x)
2160                     ; 975 }
2163  000d 81            	ret
2220                     ; 988 void RTC_GetDate(RTC_Format_TypeDef RTC_Format,
2220                     ; 989                  RTC_DateTypeDef* RTC_DateStruct)
2220                     ; 990 {
2221                     .text:	section	.text,new
2222  0000               _RTC_GetDate:
2224  0000 88            	push	a
2225  0001 88            	push	a
2226       00000001      OFST:	set	1
2229                     ; 991   uint8_t tmpreg = 0;
2231  0002 0f01          	clr	(OFST+0,sp)
2232                     ; 994   assert_param(IS_RTC_FORMAT(RTC_Format));
2234                     ; 997   (void) (RTC->TR1) ;
2236  0004 c65140        	ld	a,20800
2237  0007 97            	ld	xl,a
2238                     ; 998   RTC_DateStruct->RTC_Date = (uint8_t)(RTC->DR1);
2240  0008 1e05          	ldw	x,(OFST+4,sp)
2241  000a c65144        	ld	a,20804
2242  000d e702          	ld	(2,x),a
2243                     ; 999   tmpreg = (uint8_t)RTC->DR2;
2245  000f c65145        	ld	a,20805
2246  0012 6b01          	ld	(OFST+0,sp),a
2247                     ; 1000   RTC_DateStruct->RTC_Year = (uint8_t)(RTC->DR3);
2249  0014 1e05          	ldw	x,(OFST+4,sp)
2250  0016 c65146        	ld	a,20806
2251  0019 e703          	ld	(3,x),a
2252                     ; 1003   RTC_DateStruct->RTC_Month = (RTC_Month_TypeDef)(tmpreg & (uint8_t)(RTC_DR2_MT | RTC_DR2_MU));
2254  001b 7b01          	ld	a,(OFST+0,sp)
2255  001d a41f          	and	a,#31
2256  001f 1e05          	ldw	x,(OFST+4,sp)
2257  0021 e701          	ld	(1,x),a
2258                     ; 1004   RTC_DateStruct->RTC_WeekDay = (RTC_Weekday_TypeDef)((uint8_t)((uint8_t)tmpreg & (uint8_t)(RTC_DR2_WDU)) >> (uint8_t)5);
2260  0023 7b01          	ld	a,(OFST+0,sp)
2261  0025 a4e0          	and	a,#224
2262  0027 4e            	swap	a
2263  0028 44            	srl	a
2264  0029 a407          	and	a,#7
2265  002b 1e05          	ldw	x,(OFST+4,sp)
2266  002d f7            	ld	(x),a
2267                     ; 1007   if (RTC_Format == RTC_Format_BIN)
2269  002e 0d02          	tnz	(OFST+1,sp)
2270  0030 2621          	jrne	L7701
2271                     ; 1010     RTC_DateStruct->RTC_Year = (uint8_t)Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Year);
2273  0032 1e05          	ldw	x,(OFST+4,sp)
2274  0034 e603          	ld	a,(3,x)
2275  0036 cd0000        	call	L5_Bcd2ToByte
2277  0039 1e05          	ldw	x,(OFST+4,sp)
2278  003b e703          	ld	(3,x),a
2279                     ; 1011     RTC_DateStruct->RTC_Month = (RTC_Month_TypeDef)Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Month);
2281  003d 1e05          	ldw	x,(OFST+4,sp)
2282  003f e601          	ld	a,(1,x)
2283  0041 cd0000        	call	L5_Bcd2ToByte
2285  0044 1e05          	ldw	x,(OFST+4,sp)
2286  0046 e701          	ld	(1,x),a
2287                     ; 1012     RTC_DateStruct->RTC_Date = (uint8_t)(Bcd2ToByte((uint8_t)RTC_DateStruct->RTC_Date));
2289  0048 1e05          	ldw	x,(OFST+4,sp)
2290  004a e602          	ld	a,(2,x)
2291  004c cd0000        	call	L5_Bcd2ToByte
2293  004f 1e05          	ldw	x,(OFST+4,sp)
2294  0051 e702          	ld	(2,x),a
2295  0053               L7701:
2296                     ; 1014 }
2299  0053 85            	popw	x
2300  0054 81            	ret
2449                     ; 1044 void RTC_SetAlarm(RTC_Format_TypeDef RTC_Format,
2449                     ; 1045                   RTC_AlarmTypeDef* RTC_AlarmStruct)
2449                     ; 1046 {
2450                     .text:	section	.text,new
2451  0000               _RTC_SetAlarm:
2453  0000 88            	push	a
2454  0001 5205          	subw	sp,#5
2455       00000005      OFST:	set	5
2458                     ; 1047   uint8_t tmpreg1 = 0;
2460  0003 7b02          	ld	a,(OFST-3,sp)
2461  0005 97            	ld	xl,a
2462                     ; 1048   uint8_t tmpreg2 = 0;
2464  0006 7b03          	ld	a,(OFST-2,sp)
2465  0008 97            	ld	xl,a
2466                     ; 1049   uint8_t tmpreg3 = 0;
2468  0009 7b04          	ld	a,(OFST-1,sp)
2469  000b 97            	ld	xl,a
2470                     ; 1050   uint8_t tmpreg4 = 0;
2472  000c 7b05          	ld	a,(OFST+0,sp)
2473  000e 97            	ld	xl,a
2474                     ; 1053   assert_param(IS_RTC_ALARM_MASK(RTC_AlarmStruct->RTC_AlarmMask));
2476                     ; 1054   assert_param(IS_RTC_FORMAT(RTC_Format));
2478                     ; 1055   assert_param(IS_RTC_H12(RTC_AlarmStruct->RTC_AlarmTime.RTC_H12));
2480                     ; 1056   assert_param(IS_RTC_ALARM_DATEWEEKDAY_SEL(RTC_AlarmStruct->RTC_AlarmDateWeekDaySel));
2482                     ; 1059   if (RTC_Format == RTC_Format_BIN)
2484  000f 0d06          	tnz	(OFST+1,sp)
2485  0011 2609          	jrne	L5711
2486                     ; 1062     if ((RTC->CR1 & RTC_CR1_FMT) != RESET)
2488  0013 c65148        	ld	a,20808
2489  0016 a540          	bcp	a,#64
2490  0018 2700          	jreq	L7711
2491                     ; 1064       assert_param(IS_RTC_HOUR12_MAX(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours));
2493                     ; 1065       assert_param(IS_RTC_HOUR12_MIN(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours));
2496  001a               L7711:
2497                     ; 1069       assert_param(IS_RTC_HOUR24(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours));
2499                     ; 1071     assert_param(IS_RTC_MINUTES(RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes));
2501                     ; 1072     assert_param(IS_RTC_SECONDS(RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds));
2504  001a 2007          	jra	L3021
2505  001c               L5711:
2506                     ; 1077     if ((RTC->CR1 & RTC_CR1_FMT) != RESET)
2508  001c c65148        	ld	a,20808
2509  001f a540          	bcp	a,#64
2510  0021 2700          	jreq	L5021
2511                     ; 1079       assert_param(IS_RTC_HOUR12_MAX(Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours)));
2513                     ; 1080       assert_param(IS_RTC_HOUR12_MIN(Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours)));
2516  0023               L5021:
2517                     ; 1084       assert_param(IS_RTC_HOUR24(Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours)));
2519                     ; 1087     assert_param(IS_RTC_MINUTES(Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes)));
2521                     ; 1089     assert_param(IS_RTC_SECONDS(Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds)));
2523  0023               L3021:
2524                     ; 1094   if ((RTC_AlarmStruct->RTC_AlarmMask & RTC_AlarmMask_DateWeekDay) == RESET )
2526  0023 1e09          	ldw	x,(OFST+4,sp)
2527  0025 e604          	ld	a,(4,x)
2528  0027 a510          	bcp	a,#16
2529  0029 2608          	jrne	L1121
2530                     ; 1096     if (RTC_AlarmStruct->RTC_AlarmDateWeekDaySel == RTC_AlarmDateWeekDaySel_WeekDay)
2532  002b 1e09          	ldw	x,(OFST+4,sp)
2533  002d e605          	ld	a,(5,x)
2534  002f a140          	cp	a,#64
2535  0031 2600          	jrne	L3121
2536                     ; 1098       assert_param(IS_RTC_WEEKDAY(RTC_AlarmStruct->RTC_AlarmDateWeekDay));
2539  0033               L3121:
2540                     ; 1102       assert_param(IS_RTC_DATE_MIN(RTC_AlarmStruct->RTC_AlarmDateWeekDay));
2542                     ; 1103       assert_param(IS_RTC_DATE_MAX(RTC_AlarmStruct->RTC_AlarmDateWeekDay));
2544  0033               L1121:
2545                     ; 1108   RTC->WPR = 0xCA;
2547  0033 35ca5159      	mov	20825,#202
2548                     ; 1109   RTC->WPR = 0x53;
2550  0037 35535159      	mov	20825,#83
2551                     ; 1113   if (RTC_Format != RTC_Format_BIN)
2553  003b 0d06          	tnz	(OFST+1,sp)
2554  003d 2747          	jreq	L7121
2555                     ; 1115     tmpreg1 = (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds) | \
2555                     ; 1116                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask) & (uint8_t)RTC_ALRMAR1_MSK1));
2557  003f 1e09          	ldw	x,(OFST+4,sp)
2558  0041 e604          	ld	a,(4,x)
2559  0043 a480          	and	a,#128
2560  0045 1e09          	ldw	x,(OFST+4,sp)
2561  0047 ea02          	or	a,(2,x)
2562  0049 6b02          	ld	(OFST-3,sp),a
2563                     ; 1118     tmpreg2 = (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes) | \
2563                     ; 1119                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 1) & (uint8_t)RTC_ALRMAR2_MSK2));
2565  004b 1e09          	ldw	x,(OFST+4,sp)
2566  004d e604          	ld	a,(4,x)
2567  004f 48            	sll	a
2568  0050 a480          	and	a,#128
2569  0052 1e09          	ldw	x,(OFST+4,sp)
2570  0054 ea01          	or	a,(1,x)
2571  0056 6b03          	ld	(OFST-2,sp),a
2572                     ; 1121     tmpreg3 = (uint8_t)((uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours) | \
2572                     ; 1122                                   (uint8_t)(RTC_AlarmStruct->RTC_AlarmTime.RTC_H12)) | \
2572                     ; 1123                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 2) & (uint8_t)RTC_ALRMAR3_MSK3));
2574  0058 1e09          	ldw	x,(OFST+4,sp)
2575  005a e604          	ld	a,(4,x)
2576  005c 48            	sll	a
2577  005d 48            	sll	a
2578  005e a480          	and	a,#128
2579  0060 6b01          	ld	(OFST-4,sp),a
2580  0062 1e09          	ldw	x,(OFST+4,sp)
2581  0064 e603          	ld	a,(3,x)
2582  0066 1e09          	ldw	x,(OFST+4,sp)
2583  0068 fa            	or	a,(x)
2584  0069 1a01          	or	a,(OFST-4,sp)
2585  006b 6b04          	ld	(OFST-1,sp),a
2586                     ; 1125     tmpreg4 = (uint8_t)((uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmDateWeekDay) | \
2586                     ; 1126                                   (uint8_t)(RTC_AlarmStruct->RTC_AlarmDateWeekDaySel)) | \
2586                     ; 1127                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 3) & (uint8_t)RTC_ALRMAR4_MSK4));
2588  006d 1e09          	ldw	x,(OFST+4,sp)
2589  006f e604          	ld	a,(4,x)
2590  0071 48            	sll	a
2591  0072 48            	sll	a
2592  0073 48            	sll	a
2593  0074 a480          	and	a,#128
2594  0076 6b01          	ld	(OFST-4,sp),a
2595  0078 1e09          	ldw	x,(OFST+4,sp)
2596  007a e605          	ld	a,(5,x)
2597  007c 1e09          	ldw	x,(OFST+4,sp)
2598  007e ea06          	or	a,(6,x)
2599  0080 1a01          	or	a,(OFST-4,sp)
2600  0082 6b05          	ld	(OFST+0,sp),a
2602  0084 2059          	jra	L1221
2603  0086               L7121:
2604                     ; 1132     tmpreg1 = (uint8_t)((ByteToBcd2(RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds)) | \
2604                     ; 1133                         (uint8_t)(RTC_AlarmStruct->RTC_AlarmMask & RTC_ALRMAR1_MSK1));
2606  0086 1e09          	ldw	x,(OFST+4,sp)
2607  0088 e604          	ld	a,(4,x)
2608  008a a480          	and	a,#128
2609  008c 6b01          	ld	(OFST-4,sp),a
2610  008e 1e09          	ldw	x,(OFST+4,sp)
2611  0090 e602          	ld	a,(2,x)
2612  0092 cd0000        	call	L3_ByteToBcd2
2614  0095 1a01          	or	a,(OFST-4,sp)
2615  0097 6b02          	ld	(OFST-3,sp),a
2616                     ; 1135     tmpreg2 = (uint8_t)((ByteToBcd2(RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes)) | \
2616                     ; 1136                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 1) & (uint8_t)RTC_ALRMAR2_MSK2));
2618  0099 1e09          	ldw	x,(OFST+4,sp)
2619  009b e604          	ld	a,(4,x)
2620  009d 48            	sll	a
2621  009e a480          	and	a,#128
2622  00a0 6b01          	ld	(OFST-4,sp),a
2623  00a2 1e09          	ldw	x,(OFST+4,sp)
2624  00a4 e601          	ld	a,(1,x)
2625  00a6 cd0000        	call	L3_ByteToBcd2
2627  00a9 1a01          	or	a,(OFST-4,sp)
2628  00ab 6b03          	ld	(OFST-2,sp),a
2629                     ; 1138     tmpreg3 = (uint8_t)((uint8_t)((ByteToBcd2(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours)) | \
2629                     ; 1139                                   (uint8_t)(RTC_AlarmStruct->RTC_AlarmTime.RTC_H12)) | \
2629                     ; 1140                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 2) & (uint8_t)RTC_ALRMAR3_MSK3));
2631  00ad 1e09          	ldw	x,(OFST+4,sp)
2632  00af e604          	ld	a,(4,x)
2633  00b1 48            	sll	a
2634  00b2 48            	sll	a
2635  00b3 a480          	and	a,#128
2636  00b5 6b01          	ld	(OFST-4,sp),a
2637  00b7 1e09          	ldw	x,(OFST+4,sp)
2638  00b9 f6            	ld	a,(x)
2639  00ba cd0000        	call	L3_ByteToBcd2
2641  00bd 1e09          	ldw	x,(OFST+4,sp)
2642  00bf ea03          	or	a,(3,x)
2643  00c1 1a01          	or	a,(OFST-4,sp)
2644  00c3 6b04          	ld	(OFST-1,sp),a
2645                     ; 1142     tmpreg4 = (uint8_t)((uint8_t)((ByteToBcd2(RTC_AlarmStruct->RTC_AlarmDateWeekDay)) | \
2645                     ; 1143                                   (uint8_t)(RTC_AlarmStruct->RTC_AlarmDateWeekDaySel)) | \
2645                     ; 1144                         (uint8_t)((uint8_t)(RTC_AlarmStruct->RTC_AlarmMask << 3) & (uint8_t)(RTC_ALRMAR4_MSK4)));
2647  00c5 1e09          	ldw	x,(OFST+4,sp)
2648  00c7 e604          	ld	a,(4,x)
2649  00c9 48            	sll	a
2650  00ca 48            	sll	a
2651  00cb 48            	sll	a
2652  00cc a480          	and	a,#128
2653  00ce 6b01          	ld	(OFST-4,sp),a
2654  00d0 1e09          	ldw	x,(OFST+4,sp)
2655  00d2 e606          	ld	a,(6,x)
2656  00d4 cd0000        	call	L3_ByteToBcd2
2658  00d7 1e09          	ldw	x,(OFST+4,sp)
2659  00d9 ea05          	or	a,(5,x)
2660  00db 1a01          	or	a,(OFST-4,sp)
2661  00dd 6b05          	ld	(OFST+0,sp),a
2662  00df               L1221:
2663                     ; 1148   RTC->ALRMAR1 = tmpreg1;
2665  00df 7b02          	ld	a,(OFST-3,sp)
2666  00e1 c7515c        	ld	20828,a
2667                     ; 1149   RTC->ALRMAR2 = tmpreg2;
2669  00e4 7b03          	ld	a,(OFST-2,sp)
2670  00e6 c7515d        	ld	20829,a
2671                     ; 1150   RTC->ALRMAR3 = tmpreg3;
2673  00e9 7b04          	ld	a,(OFST-1,sp)
2674  00eb c7515e        	ld	20830,a
2675                     ; 1151   RTC->ALRMAR4 = tmpreg4;
2677  00ee 7b05          	ld	a,(OFST+0,sp)
2678  00f0 c7515f        	ld	20831,a
2679                     ; 1154   RTC->WPR = 0xFF; 
2681  00f3 35ff5159      	mov	20825,#255
2682                     ; 1155 }
2685  00f7 5b06          	addw	sp,#6
2686  00f9 81            	ret
2724                     ; 1165 void RTC_AlarmStructInit(RTC_AlarmTypeDef* RTC_AlarmStruct)
2724                     ; 1166 {
2725                     .text:	section	.text,new
2726  0000               _RTC_AlarmStructInit:
2730                     ; 1168   RTC_AlarmStruct->RTC_AlarmTime.RTC_H12 = RTC_H12_AM;
2732  0000 6f03          	clr	(3,x)
2733                     ; 1169   RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours = 0;
2735  0002 7f            	clr	(x)
2736                     ; 1170   RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes = 0;
2738  0003 6f01          	clr	(1,x)
2739                     ; 1171   RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds = 0;
2741  0005 6f02          	clr	(2,x)
2742                     ; 1174   RTC_AlarmStruct->RTC_AlarmDateWeekDaySel = RTC_AlarmDateWeekDaySel_Date;
2744  0007 6f05          	clr	(5,x)
2745                     ; 1175   RTC_AlarmStruct->RTC_AlarmDateWeekDay = 1;
2747  0009 a601          	ld	a,#1
2748  000b e706          	ld	(6,x),a
2749                     ; 1178   RTC_AlarmStruct->RTC_AlarmMask = RTC_AlarmMask_All;
2751  000d a6f0          	ld	a,#240
2752  000f e704          	ld	(4,x),a
2753                     ; 1179 }
2756  0011 81            	ret
2849                     ; 1188 void RTC_GetAlarm(RTC_Format_TypeDef RTC_Format,
2849                     ; 1189                   RTC_AlarmTypeDef* RTC_AlarmStruct)
2849                     ; 1190 {
2850                     .text:	section	.text,new
2851  0000               _RTC_GetAlarm:
2853  0000 88            	push	a
2854  0001 5204          	subw	sp,#4
2855       00000004      OFST:	set	4
2858                     ; 1191   uint8_t tmpreg1 = 0;
2860  0003 7b04          	ld	a,(OFST+0,sp)
2861  0005 97            	ld	xl,a
2862                     ; 1192   uint8_t tmpreg2 = 0;
2864  0006 7b01          	ld	a,(OFST-3,sp)
2865  0008 97            	ld	xl,a
2866                     ; 1193   uint8_t tmpreg3 = 0;
2868  0009 7b02          	ld	a,(OFST-2,sp)
2869  000b 97            	ld	xl,a
2870                     ; 1194   uint8_t tmpreg4 = 0;
2872  000c 7b03          	ld	a,(OFST-1,sp)
2873  000e 97            	ld	xl,a
2874                     ; 1195   uint8_t alarmmask = 0;
2876  000f 7b04          	ld	a,(OFST+0,sp)
2877  0011 97            	ld	xl,a
2878                     ; 1198   assert_param(IS_RTC_FORMAT(RTC_Format));
2880                     ; 1201   tmpreg1 = (uint8_t)RTC->ALRMAR1;
2882  0012 c6515c        	ld	a,20828
2883  0015 6b04          	ld	(OFST+0,sp),a
2884                     ; 1202   tmpreg2 = (uint8_t)RTC->ALRMAR2;
2886  0017 c6515d        	ld	a,20829
2887  001a 6b01          	ld	(OFST-3,sp),a
2888                     ; 1203   tmpreg3 = (uint8_t)RTC->ALRMAR3;
2890  001c c6515e        	ld	a,20830
2891  001f 6b02          	ld	(OFST-2,sp),a
2892                     ; 1204   tmpreg4 = (uint8_t)RTC->ALRMAR4;
2894  0021 c6515f        	ld	a,20831
2895  0024 6b03          	ld	(OFST-1,sp),a
2896                     ; 1207   RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds = (uint8_t)((uint8_t)tmpreg1 & (uint8_t)((uint8_t)RTC_ALRMAR1_ST | (uint8_t)RTC_ALRMAR1_SU));
2898  0026 7b04          	ld	a,(OFST+0,sp)
2899  0028 a47f          	and	a,#127
2900  002a 1e08          	ldw	x,(OFST+4,sp)
2901  002c e702          	ld	(2,x),a
2902                     ; 1208   alarmmask = (uint8_t)(tmpreg1 & RTC_ALRMAR1_MSK1);
2904  002e 7b04          	ld	a,(OFST+0,sp)
2905  0030 a480          	and	a,#128
2906  0032 6b04          	ld	(OFST+0,sp),a
2907                     ; 1211   RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes = (uint8_t)((uint8_t)tmpreg2 & (uint8_t)((uint8_t)RTC_ALRMAR2_MNT | (uint8_t)RTC_ALRMAR2_MNU));
2909  0034 7b01          	ld	a,(OFST-3,sp)
2910  0036 a47f          	and	a,#127
2911  0038 1e08          	ldw	x,(OFST+4,sp)
2912  003a e701          	ld	(1,x),a
2913                     ; 1212   alarmmask = (uint8_t)((alarmmask) | (uint8_t)((uint8_t)(tmpreg2 & RTC_ALRMAR2_MSK2) >> 1));
2915  003c 7b01          	ld	a,(OFST-3,sp)
2916  003e a480          	and	a,#128
2917  0040 44            	srl	a
2918  0041 1a04          	or	a,(OFST+0,sp)
2919  0043 6b04          	ld	(OFST+0,sp),a
2920                     ; 1215   RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours = (uint8_t)((uint8_t)tmpreg3 & (uint8_t)((uint8_t)RTC_ALRMAR3_HT | (uint8_t)RTC_ALRMAR3_HU));
2922  0045 7b02          	ld	a,(OFST-2,sp)
2923  0047 a43f          	and	a,#63
2924  0049 1e08          	ldw	x,(OFST+4,sp)
2925  004b f7            	ld	(x),a
2926                     ; 1216   RTC_AlarmStruct->RTC_AlarmTime.RTC_H12 = (RTC_H12_TypeDef)((uint8_t)tmpreg3 & (uint8_t)RTC_ALRMAR3_PM);
2928  004c 7b02          	ld	a,(OFST-2,sp)
2929  004e a440          	and	a,#64
2930  0050 1e08          	ldw	x,(OFST+4,sp)
2931  0052 e703          	ld	(3,x),a
2932                     ; 1217   alarmmask = (uint8_t)((alarmmask) | (uint8_t)((uint8_t)((uint8_t)tmpreg3 & (uint8_t)RTC_ALRMAR3_MSK3) >> 2));
2934  0054 7b02          	ld	a,(OFST-2,sp)
2935  0056 a480          	and	a,#128
2936  0058 44            	srl	a
2937  0059 44            	srl	a
2938  005a 1a04          	or	a,(OFST+0,sp)
2939  005c 6b04          	ld	(OFST+0,sp),a
2940                     ; 1220   RTC_AlarmStruct->RTC_AlarmDateWeekDay = (uint8_t)((uint8_t)tmpreg4 & (uint8_t)((uint8_t)RTC_ALRMAR4_DT | (uint8_t)RTC_ALRMAR4_DU));
2942  005e 7b03          	ld	a,(OFST-1,sp)
2943  0060 a43f          	and	a,#63
2944  0062 1e08          	ldw	x,(OFST+4,sp)
2945  0064 e706          	ld	(6,x),a
2946                     ; 1221   RTC_AlarmStruct->RTC_AlarmDateWeekDaySel = (RTC_AlarmDateWeekDaySel_TypeDef)((uint8_t)tmpreg4 & (uint8_t)RTC_ALRMAR4_WDSEL);
2948  0066 7b03          	ld	a,(OFST-1,sp)
2949  0068 a440          	and	a,#64
2950  006a 1e08          	ldw	x,(OFST+4,sp)
2951  006c e705          	ld	(5,x),a
2952                     ; 1222   alarmmask = (uint8_t)((alarmmask) | (uint8_t)((uint8_t)((uint8_t)tmpreg4 & RTC_ALRMAR4_MSK4) >> 3));
2954  006e 7b03          	ld	a,(OFST-1,sp)
2955  0070 a480          	and	a,#128
2956  0072 44            	srl	a
2957  0073 44            	srl	a
2958  0074 44            	srl	a
2959  0075 1a04          	or	a,(OFST+0,sp)
2960  0077 6b04          	ld	(OFST+0,sp),a
2961                     ; 1224   RTC_AlarmStruct->RTC_AlarmMask = alarmmask;
2963  0079 7b04          	ld	a,(OFST+0,sp)
2964  007b 1e08          	ldw	x,(OFST+4,sp)
2965  007d e704          	ld	(4,x),a
2966                     ; 1226   if (RTC_Format == RTC_Format_BIN)
2968  007f 0d05          	tnz	(OFST+1,sp)
2969  0081 262a          	jrne	L3131
2970                     ; 1228     RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours = Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Hours);
2972  0083 1e08          	ldw	x,(OFST+4,sp)
2973  0085 f6            	ld	a,(x)
2974  0086 cd0000        	call	L5_Bcd2ToByte
2976  0089 1e08          	ldw	x,(OFST+4,sp)
2977  008b f7            	ld	(x),a
2978                     ; 1229     RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes = Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Minutes);
2980  008c 1e08          	ldw	x,(OFST+4,sp)
2981  008e e601          	ld	a,(1,x)
2982  0090 cd0000        	call	L5_Bcd2ToByte
2984  0093 1e08          	ldw	x,(OFST+4,sp)
2985  0095 e701          	ld	(1,x),a
2986                     ; 1230     RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds = Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmTime.RTC_Seconds);
2988  0097 1e08          	ldw	x,(OFST+4,sp)
2989  0099 e602          	ld	a,(2,x)
2990  009b cd0000        	call	L5_Bcd2ToByte
2992  009e 1e08          	ldw	x,(OFST+4,sp)
2993  00a0 e702          	ld	(2,x),a
2994                     ; 1231     RTC_AlarmStruct->RTC_AlarmDateWeekDay = Bcd2ToByte(RTC_AlarmStruct->RTC_AlarmDateWeekDay);
2996  00a2 1e08          	ldw	x,(OFST+4,sp)
2997  00a4 e606          	ld	a,(6,x)
2998  00a6 cd0000        	call	L5_Bcd2ToByte
3000  00a9 1e08          	ldw	x,(OFST+4,sp)
3001  00ab e706          	ld	(6,x),a
3002  00ad               L3131:
3003                     ; 1233 }
3006  00ad 5b05          	addw	sp,#5
3007  00af 81            	ret
3071                     ; 1242 ErrorStatus RTC_AlarmCmd(FunctionalState NewState)
3071                     ; 1243 {
3072                     .text:	section	.text,new
3073  0000               _RTC_AlarmCmd:
3075  0000 88            	push	a
3076  0001 5203          	subw	sp,#3
3077       00000003      OFST:	set	3
3080                     ; 1244   __IO uint16_t alrawfcount = 0;
3082  0003 5f            	clrw	x
3083  0004 1f01          	ldw	(OFST-2,sp),x
3084                     ; 1245   ErrorStatus status = ERROR;
3086  0006 7b03          	ld	a,(OFST+0,sp)
3087  0008 97            	ld	xl,a
3088                     ; 1246   uint8_t temp1 = 0;
3090  0009 7b03          	ld	a,(OFST+0,sp)
3091  000b 97            	ld	xl,a
3092                     ; 1249   assert_param(IS_FUNCTIONAL_STATE(NewState));
3094                     ; 1252   RTC->WPR = 0xCA;
3096  000c 35ca5159      	mov	20825,#202
3097                     ; 1253   RTC->WPR = 0x53;
3099  0010 35535159      	mov	20825,#83
3100                     ; 1256   if (NewState != DISABLE)
3102  0014 0d04          	tnz	(OFST+1,sp)
3103  0016 2711          	jreq	L7431
3104                     ; 1258     RTC->CR2 |= (uint8_t)(RTC_CR2_ALRAE);
3106  0018 72105149      	bset	20809,#0
3107                     ; 1259     status = SUCCESS;
3109  001c a601          	ld	a,#1
3110  001e 6b03          	ld	(OFST+0,sp),a
3112  0020               L1531:
3113                     ; 1283   RTC->WPR = 0xFF; 
3115  0020 35ff5159      	mov	20825,#255
3116                     ; 1286   return (ErrorStatus)status;
3118  0024 7b03          	ld	a,(OFST+0,sp)
3121  0026 5b04          	addw	sp,#4
3122  0028 81            	ret
3123  0029               L7431:
3124                     ; 1263     RTC->CR2 &= (uint8_t)~(RTC_CR2_ALRAE) ;
3126  0029 72115149      	bres	20809,#0
3127                     ; 1266     temp1 = (uint8_t)(RTC->ISR1 & RTC_ISR1_ALRAWF);
3129  002d c6514c        	ld	a,20812
3130  0030 a401          	and	a,#1
3131  0032 6b03          	ld	(OFST+0,sp),a
3133  0034 2007          	jra	L7531
3134  0036               L3531:
3135                     ; 1269       alrawfcount++;
3137  0036 1e01          	ldw	x,(OFST-2,sp)
3138  0038 1c0001        	addw	x,#1
3139  003b 1f01          	ldw	(OFST-2,sp),x
3140  003d               L7531:
3141                     ; 1267     while ((alrawfcount != ALRAWF_TIMEOUT) && (temp1 == RESET))
3143  003d 1e01          	ldw	x,(OFST-2,sp)
3144  003f a3ffff        	cpw	x,#65535
3145  0042 2704          	jreq	L3631
3147  0044 0d03          	tnz	(OFST+0,sp)
3148  0046 27ee          	jreq	L3531
3149  0048               L3631:
3150                     ; 1272     if ((RTC->ISR1 &  RTC_ISR1_ALRAWF) == RESET)
3152  0048 c6514c        	ld	a,20812
3153  004b a501          	bcp	a,#1
3154  004d 2604          	jrne	L5631
3155                     ; 1274       status = ERROR;
3157  004f 0f03          	clr	(OFST+0,sp)
3159  0051 20cd          	jra	L1531
3160  0053               L5631:
3161                     ; 1278       status = SUCCESS;
3163  0053 a601          	ld	a,#1
3164  0055 6b03          	ld	(OFST+0,sp),a
3165  0057 20c7          	jra	L1531
3366                     ; 1298 ErrorStatus RTC_AlarmSubSecondConfig(uint16_t RTC_AlarmSubSecondValue,
3366                     ; 1299                                      RTC_AlarmSubSecondMask_TypeDef RTC_AlarmSubSecondMask)
3366                     ; 1300 {
3367                     .text:	section	.text,new
3368  0000               _RTC_AlarmSubSecondConfig:
3370  0000 89            	pushw	x
3371  0001 88            	push	a
3372       00000001      OFST:	set	1
3375                     ; 1301   uint8_t alarmstatus = 0;
3377  0002 7b01          	ld	a,(OFST+0,sp)
3378  0004 97            	ld	xl,a
3379                     ; 1302   ErrorStatus status = ERROR;
3381  0005 7b01          	ld	a,(OFST+0,sp)
3382  0007 97            	ld	xl,a
3383                     ; 1305   assert_param(IS_RTC_ALARM_SS_VALUE(RTC_AlarmSubSecondValue));
3385                     ; 1306   assert_param(IS_RTC_ALARM_SS_MASK(RTC_AlarmSubSecondMask));
3387                     ; 1309   RTC->WPR = 0xCA;
3389  0008 35ca5159      	mov	20825,#202
3390                     ; 1310   RTC->WPR = 0x53;
3392  000c 35535159      	mov	20825,#83
3393                     ; 1313   if ((RTC->ISR1 & RTC_ISR1_INITF) == RESET)
3395  0010 c6514c        	ld	a,20812
3396  0013 a540          	bcp	a,#64
3397  0015 2628          	jrne	L7641
3398                     ; 1316     alarmstatus = (uint8_t)(RTC->CR2 | RTC_CR2_ALRAE);
3400  0017 c65149        	ld	a,20809
3401  001a aa01          	or	a,#1
3402  001c 6b01          	ld	(OFST+0,sp),a
3403                     ; 1319     RTC->CR2 &= (uint8_t)~(RTC_CR2_ALRAE);
3405  001e 72115149      	bres	20809,#0
3406                     ; 1322     RTC->ALRMASSRH = (uint8_t)(RTC_AlarmSubSecondValue >> 8);
3408  0022 7b02          	ld	a,(OFST+1,sp)
3409  0024 c75164        	ld	20836,a
3410                     ; 1323     RTC->ALRMASSRL = (uint8_t)(RTC_AlarmSubSecondValue);
3412  0027 7b03          	ld	a,(OFST+2,sp)
3413  0029 c75165        	ld	20837,a
3414                     ; 1324     RTC->ALRMASSMSKR = (uint8_t)RTC_AlarmSubSecondMask;
3416  002c 7b06          	ld	a,(OFST+5,sp)
3417  002e c75166        	ld	20838,a
3418                     ; 1327     RTC->CR2 |= alarmstatus;
3420  0031 c65149        	ld	a,20809
3421  0034 1a01          	or	a,(OFST+0,sp)
3422  0036 c75149        	ld	20809,a
3423                     ; 1329     status = SUCCESS;
3425  0039 a601          	ld	a,#1
3426  003b 6b01          	ld	(OFST+0,sp),a
3428  003d 2002          	jra	L1741
3429  003f               L7641:
3430                     ; 1333     status = ERROR;
3432  003f 0f01          	clr	(OFST+0,sp)
3433  0041               L1741:
3434                     ; 1337   RTC->WPR = 0xFF; 
3436  0041 35ff5159      	mov	20825,#255
3437                     ; 1339   return (ErrorStatus)status;
3439  0045 7b01          	ld	a,(OFST+0,sp)
3442  0047 5b03          	addw	sp,#3
3443  0049 81            	ret
3533                     ; 1369 void RTC_WakeUpClockConfig(RTC_WakeUpClock_TypeDef RTC_WakeUpClock)
3533                     ; 1370 {
3534                     .text:	section	.text,new
3535  0000               _RTC_WakeUpClockConfig:
3537  0000 88            	push	a
3538       00000000      OFST:	set	0
3541                     ; 1373   assert_param(IS_RTC_WAKEUP_CLOCK(RTC_WakeUpClock));
3543                     ; 1376   RTC->WPR = 0xCA;
3545  0001 35ca5159      	mov	20825,#202
3546                     ; 1377   RTC->WPR = 0x53;
3548  0005 35535159      	mov	20825,#83
3549                     ; 1380   RTC->CR2 &= (uint8_t)~RTC_CR2_WUTE;
3551  0009 72155149      	bres	20809,#2
3552                     ; 1383   RTC->CR1 &= (uint8_t)~RTC_CR1_WUCKSEL;
3554  000d c65148        	ld	a,20808
3555  0010 a4f8          	and	a,#248
3556  0012 c75148        	ld	20808,a
3557                     ; 1386   RTC->CR1 |= (uint8_t)RTC_WakeUpClock;
3559  0015 c65148        	ld	a,20808
3560  0018 1a01          	or	a,(OFST+1,sp)
3561  001a c75148        	ld	20808,a
3562                     ; 1389   RTC->WPR = 0xFF; 
3564  001d 35ff5159      	mov	20825,#255
3565                     ; 1390 }
3568  0021 84            	pop	a
3569  0022 81            	ret
3604                     ; 1400 void RTC_SetWakeUpCounter(uint16_t RTC_WakeupCounter)
3604                     ; 1401 {
3605                     .text:	section	.text,new
3606  0000               _RTC_SetWakeUpCounter:
3610                     ; 1403   RTC->WPR = 0xCA;
3612  0000 35ca5159      	mov	20825,#202
3613                     ; 1404   RTC->WPR = 0x53;
3615  0004 35535159      	mov	20825,#83
3616                     ; 1408   RTC->WUTRH = (uint8_t)(RTC_WakeupCounter >> 8);
3618  0008 9e            	ld	a,xh
3619  0009 c75154        	ld	20820,a
3620                     ; 1409   RTC->WUTRL = (uint8_t)(RTC_WakeupCounter);
3622  000c 9f            	ld	a,xl
3623  000d c75155        	ld	20821,a
3624                     ; 1412   RTC->WPR = 0xFF; 
3626  0010 35ff5159      	mov	20825,#255
3627                     ; 1413 }
3630  0014 81            	ret
3665                     ; 1420 uint16_t RTC_GetWakeUpCounter(void)
3665                     ; 1421 {
3666                     .text:	section	.text,new
3667  0000               _RTC_GetWakeUpCounter:
3669  0000 89            	pushw	x
3670       00000002      OFST:	set	2
3673                     ; 1422   uint16_t tmpreg = 0;
3675  0001 5f            	clrw	x
3676  0002 1f01          	ldw	(OFST-1,sp),x
3677                     ; 1425   tmpreg = ((uint16_t)RTC->WUTRH) << 8;
3679  0004 c65154        	ld	a,20820
3680  0007 5f            	clrw	x
3681  0008 97            	ld	xl,a
3682  0009 4f            	clr	a
3683  000a 02            	rlwa	x,a
3684  000b 1f01          	ldw	(OFST-1,sp),x
3685                     ; 1426   tmpreg |= RTC->WUTRL;
3687  000d c65155        	ld	a,20821
3688  0010 5f            	clrw	x
3689  0011 97            	ld	xl,a
3690  0012 01            	rrwa	x,a
3691  0013 1a02          	or	a,(OFST+0,sp)
3692  0015 01            	rrwa	x,a
3693  0016 1a01          	or	a,(OFST-1,sp)
3694  0018 01            	rrwa	x,a
3695  0019 1f01          	ldw	(OFST-1,sp),x
3696                     ; 1429   return (uint16_t)tmpreg;
3698  001b 1e01          	ldw	x,(OFST-1,sp)
3701  001d 5b02          	addw	sp,#2
3702  001f 81            	ret
3757                     ; 1440 ErrorStatus RTC_WakeUpCmd(FunctionalState NewState)
3757                     ; 1441 {
3758                     .text:	section	.text,new
3759  0000               _RTC_WakeUpCmd:
3761  0000 88            	push	a
3762  0001 5203          	subw	sp,#3
3763       00000003      OFST:	set	3
3766                     ; 1442   ErrorStatus status = ERROR;
3768  0003 7b01          	ld	a,(OFST-2,sp)
3769  0005 97            	ld	xl,a
3770                     ; 1443   uint16_t wutwfcount = 0;
3772  0006 5f            	clrw	x
3773  0007 1f02          	ldw	(OFST-1,sp),x
3774                     ; 1446   assert_param(IS_FUNCTIONAL_STATE(NewState));
3776                     ; 1449   RTC->WPR = 0xCA;
3778  0009 35ca5159      	mov	20825,#202
3779                     ; 1450   RTC->WPR = 0x53;
3781  000d 35535159      	mov	20825,#83
3782                     ; 1452   if (NewState != DISABLE)
3784  0011 0d04          	tnz	(OFST+1,sp)
3785  0013 2711          	jreq	L3161
3786                     ; 1455     RTC->CR2 |= (uint8_t)RTC_CR2_WUTE;
3788  0015 72145149      	bset	20809,#2
3789                     ; 1457     status = SUCCESS;
3791  0019 a601          	ld	a,#1
3792  001b 6b01          	ld	(OFST-2,sp),a
3794  001d               L5161:
3795                     ; 1482   RTC->WPR = 0xFF; 
3797  001d 35ff5159      	mov	20825,#255
3798                     ; 1485   return (ErrorStatus)status;
3800  0021 7b01          	ld	a,(OFST-2,sp)
3803  0023 5b04          	addw	sp,#4
3804  0025 81            	ret
3805  0026               L3161:
3806                     ; 1462     RTC->CR2 &= (uint8_t)~RTC_CR2_WUTE;
3808  0026 72155149      	bres	20809,#2
3810  002a 2007          	jra	L1261
3811  002c               L7161:
3812                     ; 1467       wutwfcount++;
3814  002c 1e02          	ldw	x,(OFST-1,sp)
3815  002e 1c0001        	addw	x,#1
3816  0031 1f02          	ldw	(OFST-1,sp),x
3817  0033               L1261:
3818                     ; 1465     while (((RTC->ISR1 & RTC_ISR1_WUTWF) == RESET) && ( wutwfcount != WUTWF_TIMEOUT))
3820  0033 c6514c        	ld	a,20812
3821  0036 a504          	bcp	a,#4
3822  0038 2607          	jrne	L5261
3824  003a 1e02          	ldw	x,(OFST-1,sp)
3825  003c a3ffff        	cpw	x,#65535
3826  003f 26eb          	jrne	L7161
3827  0041               L5261:
3828                     ; 1471     if ((RTC->ISR1 & RTC_ISR1_WUTWF) == RESET)
3830  0041 c6514c        	ld	a,20812
3831  0044 a504          	bcp	a,#4
3832  0046 2604          	jrne	L7261
3833                     ; 1473       status = ERROR;
3835  0048 0f01          	clr	(OFST-2,sp)
3837  004a 20d1          	jra	L5161
3838  004c               L7261:
3839                     ; 1477       status = SUCCESS;
3841  004c a601          	ld	a,#1
3842  004e 6b01          	ld	(OFST-2,sp),a
3843  0050 20cb          	jra	L5161
3933                     ; 1522 void RTC_DayLightSavingConfig(RTC_DayLightSaving_TypeDef RTC_DayLightSaving,
3933                     ; 1523                               RTC_StoreOperation_TypeDef RTC_StoreOperation)
3933                     ; 1524 {
3934                     .text:	section	.text,new
3935  0000               _RTC_DayLightSavingConfig:
3937  0000 89            	pushw	x
3938       00000000      OFST:	set	0
3941                     ; 1526   assert_param(IS_RTC_DAYLIGHT_SAVING(RTC_DayLightSaving));
3943                     ; 1527   assert_param(IS_RTC_STORE_OPERATION(RTC_StoreOperation));
3945                     ; 1530   RTC->WPR = 0xCA;
3947  0001 35ca5159      	mov	20825,#202
3948                     ; 1531   RTC->WPR = 0x53;
3950  0005 35535159      	mov	20825,#83
3951                     ; 1534   RTC->CR3 &= (uint8_t)~(RTC_CR3_BCK);
3953  0009 7215514a      	bres	20810,#2
3954                     ; 1537   RTC->CR3 |= (uint8_t)((uint8_t)RTC_DayLightSaving | (uint8_t)RTC_StoreOperation);
3956  000d 9f            	ld	a,xl
3957  000e 1a01          	or	a,(OFST+1,sp)
3958  0010 ca514a        	or	a,20810
3959  0013 c7514a        	ld	20810,a
3960                     ; 1540   RTC->WPR = 0xFF; 
3962  0016 35ff5159      	mov	20825,#255
3963                     ; 1541 }
3966  001a 85            	popw	x
3967  001b 81            	ret
3992                     ; 1549 RTC_StoreOperation_TypeDef  RTC_GetStoreOperation(void)
3992                     ; 1550 {
3993                     .text:	section	.text,new
3994  0000               _RTC_GetStoreOperation:
3998                     ; 1552   return (RTC_StoreOperation_TypeDef)(RTC->CR3 & RTC_CR3_BCK);
4000  0000 c6514a        	ld	a,20810
4001  0003 a404          	and	a,#4
4004  0005 81            	ret
4098                     ; 1587 void RTC_OutputConfig(RTC_Output_TypeDef RTC_Output,
4098                     ; 1588                       RTC_OutputPolarity_TypeDef RTC_OutputPolarity)
4098                     ; 1589 {
4099                     .text:	section	.text,new
4100  0000               _RTC_OutputConfig:
4102  0000 89            	pushw	x
4103       00000000      OFST:	set	0
4106                     ; 1591   assert_param(IS_RTC_OUTPUT_SEL(RTC_Output));
4108                     ; 1592   assert_param(IS_RTC_OUTPUT_POL(RTC_OutputPolarity));
4110                     ; 1595   RTC->WPR = 0xCA;
4112  0001 35ca5159      	mov	20825,#202
4113                     ; 1596   RTC->WPR = 0x53;
4115  0005 35535159      	mov	20825,#83
4116                     ; 1599   RTC->CR3 &= (uint8_t)~(RTC_CR3_OSEL | RTC_CR3_POL);
4118  0009 c6514a        	ld	a,20810
4119  000c a48f          	and	a,#143
4120  000e c7514a        	ld	20810,a
4121                     ; 1602   RTC->CR3 |= (uint8_t)((uint8_t)RTC_Output | (uint8_t)RTC_OutputPolarity);
4123  0011 9f            	ld	a,xl
4124  0012 1a01          	or	a,(OFST+1,sp)
4125  0014 ca514a        	or	a,20810
4126  0017 c7514a        	ld	20810,a
4127                     ; 1605   RTC->WPR = 0xFF; 
4129  001a 35ff5159      	mov	20825,#255
4130                     ; 1606 }
4133  001e 85            	popw	x
4134  001f 81            	ret
4229                     ; 1639 ErrorStatus RTC_SynchroShiftConfig(RTC_ShiftAdd1S_TypeDef RTC_ShiftAdd1S,
4229                     ; 1640                                    uint16_t RTC_ShiftSubFS)
4229                     ; 1641 {
4230                     .text:	section	.text,new
4231  0000               _RTC_SynchroShiftConfig:
4233  0000 88            	push	a
4234  0001 5203          	subw	sp,#3
4235       00000003      OFST:	set	3
4238                     ; 1642   uint8_t shiftrhreg = 0;
4240  0003 7b01          	ld	a,(OFST-2,sp)
4241  0005 97            	ld	xl,a
4242                     ; 1643   ErrorStatus status = ERROR;
4244  0006 7b01          	ld	a,(OFST-2,sp)
4245  0008 97            	ld	xl,a
4246                     ; 1644   uint16_t shpfcount = 0;
4248  0009 5f            	clrw	x
4249  000a 1f02          	ldw	(OFST-1,sp),x
4250                     ; 1647   assert_param(IS_RTC_SHIFT_ADD1S(RTC_ShiftAdd1S));
4252                     ; 1648   assert_param(IS_RTC_SHIFT_SUBFS(RTC_ShiftSubFS));
4254                     ; 1651   RTC->WPR = 0xCA;
4256  000c 35ca5159      	mov	20825,#202
4257                     ; 1652   RTC->WPR = 0x53;
4259  0010 35535159      	mov	20825,#83
4260                     ; 1655   if ((RTC->ISR1 & RTC_ISR1_SHPF) != RESET)
4262  0014 c6514c        	ld	a,20812
4263  0017 a508          	bcp	a,#8
4264  0019 2717          	jreq	L7102
4266  001b 2007          	jra	L3202
4267  001d               L1202:
4268                     ; 1660       shpfcount++;
4270  001d 1e02          	ldw	x,(OFST-1,sp)
4271  001f 1c0001        	addw	x,#1
4272  0022 1f02          	ldw	(OFST-1,sp),x
4273  0024               L3202:
4274                     ; 1658     while (((RTC->ISR1 & RTC_ISR1_SHPF) != RESET) && (shpfcount != SHPF_TIMEOUT))
4276  0024 c6514c        	ld	a,20812
4277  0027 a508          	bcp	a,#8
4278  0029 2707          	jreq	L7102
4280  002b 1e02          	ldw	x,(OFST-1,sp)
4281  002d a3ffff        	cpw	x,#65535
4282  0030 26eb          	jrne	L1202
4283  0032               L7102:
4284                     ; 1665   if ((RTC->ISR1 & RTC_ISR1_SHPF) == RESET)
4286  0032 c6514c        	ld	a,20812
4287  0035 a508          	bcp	a,#8
4288  0037 2616          	jrne	L1302
4289                     ; 1668     shiftrhreg = (uint8_t)((uint8_t)(RTC_ShiftSubFS >> 8) | (uint8_t)(RTC_ShiftAdd1S));
4291  0039 7b07          	ld	a,(OFST+4,sp)
4292  003b 1a04          	or	a,(OFST+1,sp)
4293  003d 6b01          	ld	(OFST-2,sp),a
4294                     ; 1669     RTC->SHIFTRH = (uint8_t)(shiftrhreg);
4296  003f 7b01          	ld	a,(OFST-2,sp)
4297  0041 c7515a        	ld	20826,a
4298                     ; 1670     RTC->SHIFTRL = (uint8_t)(RTC_ShiftSubFS);
4300  0044 7b08          	ld	a,(OFST+5,sp)
4301  0046 c7515b        	ld	20827,a
4302                     ; 1672     status = SUCCESS;
4304  0049 a601          	ld	a,#1
4305  004b 6b01          	ld	(OFST-2,sp),a
4307  004d 2002          	jra	L3302
4308  004f               L1302:
4309                     ; 1676     status = ERROR;
4311  004f 0f01          	clr	(OFST-2,sp)
4312  0051               L3302:
4313                     ; 1680   RTC->WPR = 0xFF; 
4315  0051 35ff5159      	mov	20825,#255
4316                     ; 1682   return (ErrorStatus)(status);
4318  0055 7b01          	ld	a,(OFST-2,sp)
4321  0057 5b04          	addw	sp,#4
4322  0059 81            	ret
4452                     ; 1718 ErrorStatus RTC_SmoothCalibConfig(RTC_SmoothCalibPeriod_TypeDef RTC_SmoothCalibPeriod,
4452                     ; 1719                                   RTC_SmoothCalibPlusPulses_TypeDef RTC_SmoothCalibPlusPulses,
4452                     ; 1720                                   uint16_t RTC_SmouthCalibMinusPulsesValue)
4452                     ; 1721 {
4453                     .text:	section	.text,new
4454  0000               _RTC_SmoothCalibConfig:
4456  0000 89            	pushw	x
4457  0001 5203          	subw	sp,#3
4458       00000003      OFST:	set	3
4461                     ; 1722   ErrorStatus status = ERROR;
4463  0003 7b01          	ld	a,(OFST-2,sp)
4464  0005 97            	ld	xl,a
4465                     ; 1723   uint16_t recalpfcount = 0;
4467  0006 5f            	clrw	x
4468  0007 1f02          	ldw	(OFST-1,sp),x
4469                     ; 1726   assert_param(IS_RTC_SMOOTH_CALIB_PERIOD(RTC_SmoothCalibPeriod));
4471                     ; 1727   assert_param(IS_RTC_SMOOTH_CALIB_PLUS(RTC_SmoothCalibPlusPulses));
4473                     ; 1728   assert_param(IS_RTC_SMOOTH_CALIB_MINUS(RTC_SmouthCalibMinusPulsesValue));
4475                     ; 1731   RTC->WPR = 0xCA;
4477  0009 35ca5159      	mov	20825,#202
4478                     ; 1732   RTC->WPR = 0x53;
4480  000d 35535159      	mov	20825,#83
4481                     ; 1735   if ((RTC->ISR1 & RTC_ISR1_RECALPF) != RESET)
4483  0011 c6514c        	ld	a,20812
4484  0014 a502          	bcp	a,#2
4485  0016 2717          	jreq	L5112
4487  0018 2007          	jra	L1212
4488  001a               L7112:
4489                     ; 1740       recalpfcount++;
4491  001a 1e02          	ldw	x,(OFST-1,sp)
4492  001c 1c0001        	addw	x,#1
4493  001f 1f02          	ldw	(OFST-1,sp),x
4494  0021               L1212:
4495                     ; 1738     while (((RTC->ISR1 & RTC_ISR1_RECALPF) != RESET) && (recalpfcount != RECALPF_TIMEOUT))
4497  0021 c6514c        	ld	a,20812
4498  0024 a502          	bcp	a,#2
4499  0026 2707          	jreq	L5112
4501  0028 1e02          	ldw	x,(OFST-1,sp)
4502  002a a3ffff        	cpw	x,#65535
4503  002d 26eb          	jrne	L7112
4504  002f               L5112:
4505                     ; 1746   if ((RTC->ISR1 & RTC_ISR1_RECALPF) == RESET)
4507  002f c6514c        	ld	a,20812
4508  0032 a502          	bcp	a,#2
4509  0034 2614          	jrne	L7212
4510                     ; 1749     RTC->CALRH = (uint8_t)((uint8_t)((uint8_t)RTC_SmoothCalibPeriod | \
4510                     ; 1750                            (uint8_t)RTC_SmoothCalibPlusPulses) | \
4510                     ; 1751                            (uint8_t)((uint16_t)RTC_SmouthCalibMinusPulsesValue >> 8));
4512  0036 7b04          	ld	a,(OFST+1,sp)
4513  0038 1a05          	or	a,(OFST+2,sp)
4514  003a 1a08          	or	a,(OFST+5,sp)
4515  003c c7516a        	ld	20842,a
4516                     ; 1752     RTC->CALRL = (uint8_t)(RTC_SmouthCalibMinusPulsesValue);
4518  003f 7b09          	ld	a,(OFST+6,sp)
4519  0041 c7516b        	ld	20843,a
4520                     ; 1754     status = SUCCESS;
4522  0044 a601          	ld	a,#1
4523  0046 6b01          	ld	(OFST-2,sp),a
4525  0048 2002          	jra	L1312
4526  004a               L7212:
4527                     ; 1758     status = ERROR;
4529  004a 0f01          	clr	(OFST-2,sp)
4530  004c               L1312:
4531                     ; 1762   RTC->WPR = 0xFF; 
4533  004c 35ff5159      	mov	20825,#255
4534                     ; 1764   return (ErrorStatus)(status);
4536  0050 7b01          	ld	a,(OFST-2,sp)
4539  0052 5b05          	addw	sp,#5
4540  0054 81            	ret
4598                     ; 1790 void RTC_CalibOutputConfig(RTC_CalibOutput_TypeDef RTC_CalibOutput)
4598                     ; 1791 {
4599                     .text:	section	.text,new
4600  0000               _RTC_CalibOutputConfig:
4604                     ; 1793   assert_param(IS_RTC_CALOUTPUT_SELECT(RTC_CalibOutput));
4606                     ; 1796   RTC->WPR = 0xCA;
4608  0000 35ca5159      	mov	20825,#202
4609                     ; 1797   RTC->WPR = 0x53;
4611  0004 35535159      	mov	20825,#83
4612                     ; 1799   if (RTC_CalibOutput != RTC_CalibOutput_512Hz)
4614  0008 4d            	tnz	a
4615  0009 2706          	jreq	L1612
4616                     ; 1802     RTC->CR3 |= (uint8_t)RTC_CR3_COSEL;
4618  000b 7216514a      	bset	20810,#3
4620  000f 2004          	jra	L3612
4621  0011               L1612:
4622                     ; 1807     RTC->CR3 &= (uint8_t)~RTC_CR3_COSEL;
4624  0011 7217514a      	bres	20810,#3
4625  0015               L3612:
4626                     ; 1811   RTC->WPR = 0xFF; 
4628  0015 35ff5159      	mov	20825,#255
4629                     ; 1812 }
4632  0019 81            	ret
4667                     ; 1820 void RTC_CalibOutputCmd(FunctionalState NewState)
4667                     ; 1821 {
4668                     .text:	section	.text,new
4669  0000               _RTC_CalibOutputCmd:
4673                     ; 1823   assert_param(IS_FUNCTIONAL_STATE(NewState));
4675                     ; 1826   RTC->WPR = 0xCA;
4677  0000 35ca5159      	mov	20825,#202
4678                     ; 1827   RTC->WPR = 0x53;
4680  0004 35535159      	mov	20825,#83
4681                     ; 1829   if (NewState != DISABLE)
4683  0008 4d            	tnz	a
4684  0009 2706          	jreq	L3022
4685                     ; 1832     RTC->CR3 |= (uint8_t)RTC_CR3_COE;
4687  000b 721e514a      	bset	20810,#7
4689  000f 2004          	jra	L5022
4690  0011               L3022:
4691                     ; 1837     RTC->CR3 &= (uint8_t)~RTC_CR3_COE;
4693  0011 721f514a      	bres	20810,#7
4694  0015               L5022:
4695                     ; 1841   RTC->WPR = 0xFF; 
4697  0015 35ff5159      	mov	20825,#255
4698                     ; 1842 }
4701  0019 81            	ret
4796                     ; 1871 void RTC_TamperLevelConfig(RTC_Tamper_TypeDef RTC_Tamper,
4796                     ; 1872                            RTC_TamperLevel_TypeDef RTC_TamperLevel)
4796                     ; 1873 {
4797                     .text:	section	.text,new
4798  0000               _RTC_TamperLevelConfig:
4800  0000 89            	pushw	x
4801       00000000      OFST:	set	0
4804                     ; 1875   assert_param(IS_RTC_TAMPER((uint8_t)RTC_Tamper));
4806                     ; 1876   assert_param(IS_RTC_TAMPER_LEVEL(RTC_TamperLevel));
4808                     ; 1879   RTC->WPR = 0xCA;
4810  0001 35ca5159      	mov	20825,#202
4811                     ; 1880   RTC->WPR = 0x53;
4813  0005 35535159      	mov	20825,#83
4814                     ; 1882   if (RTC_TamperLevel != RTC_TamperLevel_Low)
4816  0009 9f            	ld	a,xl
4817  000a 4d            	tnz	a
4818  000b 270a          	jreq	L3522
4819                     ; 1885     RTC->TCR1 |= (uint8_t)(RTC_Tamper << 1);
4821  000d 9e            	ld	a,xh
4822  000e 48            	sll	a
4823  000f ca516c        	or	a,20844
4824  0012 c7516c        	ld	20844,a
4826  0015 200a          	jra	L5522
4827  0017               L3522:
4828                     ; 1890     RTC->TCR1 &= (uint8_t)~(uint8_t)(RTC_Tamper << 1);
4830  0017 7b01          	ld	a,(OFST+1,sp)
4831  0019 48            	sll	a
4832  001a 43            	cpl	a
4833  001b c4516c        	and	a,20844
4834  001e c7516c        	ld	20844,a
4835  0021               L5522:
4836                     ; 1894   RTC->WPR = 0xFF; 
4838  0021 35ff5159      	mov	20825,#255
4839                     ; 1895 }
4842  0025 85            	popw	x
4843  0026 81            	ret
4917                     ; 1903 void RTC_TamperFilterConfig(RTC_TamperFilter_TypeDef RTC_TamperFilter)
4917                     ; 1904 {
4918                     .text:	section	.text,new
4919  0000               _RTC_TamperFilterConfig:
4921  0000 88            	push	a
4922       00000000      OFST:	set	0
4925                     ; 1907   assert_param(IS_RTC_TAMPER_FILTER(RTC_TamperFilter));
4927                     ; 1910   RTC->WPR = 0xCA;
4929  0001 35ca5159      	mov	20825,#202
4930                     ; 1911   RTC->WPR = 0x53;
4932  0005 35535159      	mov	20825,#83
4933                     ; 1914   RTC->TCR2 &= (uint8_t)~(RTC_TCR2_TAMPFLT);
4935  0009 c6516d        	ld	a,20845
4936  000c a4e7          	and	a,#231
4937  000e c7516d        	ld	20845,a
4938                     ; 1917   RTC->TCR2 |= (uint8_t)RTC_TamperFilter;
4940  0011 c6516d        	ld	a,20845
4941  0014 1a01          	or	a,(OFST+1,sp)
4942  0016 c7516d        	ld	20845,a
4943                     ; 1920   RTC->WPR = 0xFF; 
4945  0019 35ff5159      	mov	20825,#255
4946                     ; 1922 }
4949  001d 84            	pop	a
4950  001e 81            	ret
5063                     ; 1931 void RTC_TamperSamplingFreqConfig(RTC_TamperSamplingFreq_TypeDef RTC_TamperSamplingFreq)
5063                     ; 1932 {
5064                     .text:	section	.text,new
5065  0000               _RTC_TamperSamplingFreqConfig:
5067  0000 88            	push	a
5068       00000000      OFST:	set	0
5071                     ; 1934   assert_param(IS_RTC_TAMPER_SAMPLING_FREQ(RTC_TamperSamplingFreq));
5073                     ; 1937   RTC->WPR = 0xCA;
5075  0001 35ca5159      	mov	20825,#202
5076                     ; 1938   RTC->WPR = 0x53;
5078  0005 35535159      	mov	20825,#83
5079                     ; 1941   RTC->TCR2 &= (uint8_t)~(RTC_TCR2_TAMPFREQ);
5081  0009 c6516d        	ld	a,20845
5082  000c a4f8          	and	a,#248
5083  000e c7516d        	ld	20845,a
5084                     ; 1944   RTC->TCR2 |= (uint8_t)RTC_TamperSamplingFreq;
5086  0011 c6516d        	ld	a,20845
5087  0014 1a01          	or	a,(OFST+1,sp)
5088  0016 c7516d        	ld	20845,a
5089                     ; 1947   RTC->WPR = 0xFF; 
5091  0019 35ff5159      	mov	20825,#255
5092                     ; 1948 }
5095  001d 84            	pop	a
5096  001e 81            	ret
5179                     ; 1958 void RTC_TamperPinsPrechargeDuration(RTC_TamperPrechargeDuration_TypeDef RTC_TamperPrechargeDuration)
5179                     ; 1959 {
5180                     .text:	section	.text,new
5181  0000               _RTC_TamperPinsPrechargeDuration:
5183  0000 88            	push	a
5184       00000000      OFST:	set	0
5187                     ; 1961   assert_param(IS_RTC_TAMPER_PINS_PRECHAR_DURATION(RTC_TamperPrechargeDuration));
5189                     ; 1964   RTC->WPR = 0xCA;
5191  0001 35ca5159      	mov	20825,#202
5192                     ; 1965   RTC->WPR = 0x53;
5194  0005 35535159      	mov	20825,#83
5195                     ; 1968   RTC->TCR2 &= (uint8_t)~(RTC_TCR2_TAMPPUDIS | RTC_TCR2_TAMPPRCH);
5197  0009 c6516d        	ld	a,20845
5198  000c a41f          	and	a,#31
5199  000e c7516d        	ld	20845,a
5200                     ; 1971   RTC->TCR2 |= (uint8_t)RTC_TamperPrechargeDuration;
5202  0011 c6516d        	ld	a,20845
5203  0014 1a01          	or	a,(OFST+1,sp)
5204  0016 c7516d        	ld	20845,a
5205                     ; 1974   RTC->WPR = 0xFF; 
5207  0019 35ff5159      	mov	20825,#255
5208                     ; 1975 }
5211  001d 84            	pop	a
5212  001e 81            	ret
5257                     ; 1987 void RTC_TamperCmd(RTC_Tamper_TypeDef RTC_Tamper,
5257                     ; 1988                    FunctionalState NewState)
5257                     ; 1989 {
5258                     .text:	section	.text,new
5259  0000               _RTC_TamperCmd:
5261  0000 89            	pushw	x
5262       00000000      OFST:	set	0
5265                     ; 1992   assert_param(IS_RTC_TAMPER((uint8_t)RTC_Tamper));
5267                     ; 1993   assert_param(IS_FUNCTIONAL_STATE(NewState));
5269                     ; 1996   RTC->WPR = 0xCA;
5271  0001 35ca5159      	mov	20825,#202
5272                     ; 1997   RTC->WPR = 0x53;
5274  0005 35535159      	mov	20825,#83
5275                     ; 2000   if (NewState != DISABLE)
5277  0009 9f            	ld	a,xl
5278  000a 4d            	tnz	a
5279  000b 2709          	jreq	L1342
5280                     ; 2003     RTC->TCR1 |= (uint8_t)RTC_Tamper;
5282  000d 9e            	ld	a,xh
5283  000e ca516c        	or	a,20844
5284  0011 c7516c        	ld	20844,a
5286  0014 2009          	jra	L3342
5287  0016               L1342:
5288                     ; 2008     RTC->TCR1 &= (uint8_t)~RTC_Tamper;
5290  0016 7b01          	ld	a,(OFST+1,sp)
5291  0018 43            	cpl	a
5292  0019 c4516c        	and	a,20844
5293  001c c7516c        	ld	20844,a
5294  001f               L3342:
5295                     ; 2013   RTC->WPR = 0xFF; 
5297  001f 35ff5159      	mov	20825,#255
5298                     ; 2014 }
5301  0023 85            	popw	x
5302  0024 81            	ret
5374                     ; 2058 void RTC_ITConfig(RTC_IT_TypeDef RTC_IT, FunctionalState NewState)
5374                     ; 2059 {
5375                     .text:	section	.text,new
5376  0000               _RTC_ITConfig:
5378  0000 89            	pushw	x
5379       00000000      OFST:	set	0
5382                     ; 2061   assert_param(IS_RTC_CONFIG_IT(RTC_IT));
5384                     ; 2062   assert_param(IS_FUNCTIONAL_STATE(NewState));
5386                     ; 2065   RTC->WPR = 0xCA;
5388  0001 35ca5159      	mov	20825,#202
5389                     ; 2066   RTC->WPR = 0x53;
5391  0005 35535159      	mov	20825,#83
5392                     ; 2068   if (NewState != DISABLE)
5394  0009 0d05          	tnz	(OFST+5,sp)
5395  000b 2715          	jreq	L1742
5396                     ; 2071     RTC->CR2 |= (uint8_t)((uint16_t)RTC_IT & (uint16_t)0x00F0);
5398  000d 9f            	ld	a,xl
5399  000e a4f0          	and	a,#240
5400  0010 ca5149        	or	a,20809
5401  0013 c75149        	ld	20809,a
5402                     ; 2072     RTC->TCR1 |= (uint8_t)((uint16_t)RTC_IT & RTC_TCR1_TAMPIE);
5404  0016 7b02          	ld	a,(OFST+2,sp)
5405  0018 a401          	and	a,#1
5406  001a ca516c        	or	a,20844
5407  001d c7516c        	ld	20844,a
5409  0020 2016          	jra	L3742
5410  0022               L1742:
5411                     ; 2077     RTC->CR2  &= (uint8_t)~(uint8_t)((uint16_t)RTC_IT & (uint16_t)0x00F0);
5413  0022 7b02          	ld	a,(OFST+2,sp)
5414  0024 a4f0          	and	a,#240
5415  0026 43            	cpl	a
5416  0027 c45149        	and	a,20809
5417  002a c75149        	ld	20809,a
5418                     ; 2078     RTC->TCR1 &= (uint8_t)~(uint8_t)((uint16_t)RTC_IT & (uint16_t)RTC_TCR1_TAMPIE);
5420  002d 7b02          	ld	a,(OFST+2,sp)
5421  002f a401          	and	a,#1
5422  0031 43            	cpl	a
5423  0032 c4516c        	and	a,20844
5424  0035 c7516c        	ld	20844,a
5425  0038               L3742:
5426                     ; 2082   RTC->WPR = 0xFF; 
5428  0038 35ff5159      	mov	20825,#255
5429                     ; 2083 }
5432  003c 85            	popw	x
5433  003d 81            	ret
5607                     ; 2090 FlagStatus RTC_GetFlagStatus(RTC_Flag_TypeDef RTC_FLAG)
5607                     ; 2091 {
5608                     .text:	section	.text,new
5609  0000               _RTC_GetFlagStatus:
5611  0000 89            	pushw	x
5612  0001 5203          	subw	sp,#3
5613       00000003      OFST:	set	3
5616                     ; 2092   FlagStatus flagstatus = RESET;
5618  0003 7b01          	ld	a,(OFST-2,sp)
5619  0005 97            	ld	xl,a
5620                     ; 2093   uint16_t tmpreg1 = 0;
5622  0006 1e02          	ldw	x,(OFST-1,sp)
5623                     ; 2094   uint16_t tmpreg2 = 0;
5625  0008 1e02          	ldw	x,(OFST-1,sp)
5626                     ; 2097   assert_param(IS_RTC_GET_FLAG(RTC_FLAG));
5628                     ; 2100   tmpreg2 = (uint16_t)((uint16_t)RTC->ISR1 << 8);
5630  000a c6514c        	ld	a,20812
5631  000d 5f            	clrw	x
5632  000e 97            	ld	xl,a
5633  000f 4f            	clr	a
5634  0010 02            	rlwa	x,a
5635  0011 1f02          	ldw	(OFST-1,sp),x
5636                     ; 2101   tmpreg1 = (uint16_t)((uint16_t)((uint16_t)(RTC->ISR2)) | tmpreg2);
5638  0013 c6514d        	ld	a,20813
5639  0016 5f            	clrw	x
5640  0017 97            	ld	xl,a
5641  0018 01            	rrwa	x,a
5642  0019 1a03          	or	a,(OFST+0,sp)
5643  001b 01            	rrwa	x,a
5644  001c 1a02          	or	a,(OFST-1,sp)
5645  001e 01            	rrwa	x,a
5646  001f 1f02          	ldw	(OFST-1,sp),x
5647                     ; 2104   if ((tmpreg1 & (uint16_t)RTC_FLAG) != RESET)
5649  0021 1e02          	ldw	x,(OFST-1,sp)
5650  0023 01            	rrwa	x,a
5651  0024 1405          	and	a,(OFST+2,sp)
5652  0026 01            	rrwa	x,a
5653  0027 1404          	and	a,(OFST+1,sp)
5654  0029 01            	rrwa	x,a
5655  002a a30000        	cpw	x,#0
5656  002d 2706          	jreq	L3752
5657                     ; 2106     flagstatus = SET;
5659  002f a601          	ld	a,#1
5660  0031 6b01          	ld	(OFST-2,sp),a
5662  0033 2002          	jra	L5752
5663  0035               L3752:
5664                     ; 2110     flagstatus = RESET;
5666  0035 0f01          	clr	(OFST-2,sp)
5667  0037               L5752:
5668                     ; 2112   return (FlagStatus)flagstatus;
5670  0037 7b01          	ld	a,(OFST-2,sp)
5673  0039 5b05          	addw	sp,#5
5674  003b 81            	ret
5709                     ; 2122 void RTC_ClearFlag(RTC_Flag_TypeDef RTC_FLAG)
5709                     ; 2123 {
5710                     .text:	section	.text,new
5711  0000               _RTC_ClearFlag:
5713  0000 89            	pushw	x
5714       00000000      OFST:	set	0
5717                     ; 2125   assert_param(IS_RTC_CLEAR_FLAG((uint16_t)RTC_FLAG));
5719                     ; 2128   RTC->ISR2 = (uint8_t)~((uint8_t)RTC_FLAG) ;
5721  0001 9f            	ld	a,xl
5722  0002 43            	cpl	a
5723  0003 c7514d        	ld	20813,a
5724                     ; 2129   RTC->ISR1 = (uint8_t)(((uint8_t)~(uint8_t)((uint16_t)RTC_FLAG >> (uint8_t)8)) & ((uint8_t)~(uint8_t)(RTC_ISR1_INIT)));
5726  0006 7b01          	ld	a,(OFST+1,sp)
5727  0008 43            	cpl	a
5728  0009 a47f          	and	a,#127
5729  000b c7514c        	ld	20812,a
5730                     ; 2130 }
5733  000e 85            	popw	x
5734  000f 81            	ret
5798                     ; 2138 ITStatus RTC_GetITStatus(RTC_IT_TypeDef RTC_IT)
5798                     ; 2139 {
5799                     .text:	section	.text,new
5800  0000               _RTC_GetITStatus:
5802  0000 89            	pushw	x
5803  0001 89            	pushw	x
5804       00000002      OFST:	set	2
5807                     ; 2140   ITStatus itstatus = RESET;
5809  0002 7b02          	ld	a,(OFST+0,sp)
5810  0004 97            	ld	xl,a
5811                     ; 2141   uint8_t enablestatus = 0, tmpreg = 0;
5813  0005 7b01          	ld	a,(OFST-1,sp)
5814  0007 97            	ld	xl,a
5817  0008 7b02          	ld	a,(OFST+0,sp)
5818  000a 97            	ld	xl,a
5819                     ; 2144   assert_param(IS_RTC_GET_IT(RTC_IT));
5821                     ; 2147   enablestatus = (uint8_t)(RTC->CR2 & (uint16_t)RTC_IT);
5823  000b c65149        	ld	a,20809
5824  000e 1404          	and	a,(OFST+2,sp)
5825  0010 6b01          	ld	(OFST-1,sp),a
5826                     ; 2150   tmpreg = (uint8_t)(RTC->ISR2 & (uint8_t)((uint16_t)RTC_IT >> 4));
5828  0012 1e03          	ldw	x,(OFST+1,sp)
5829  0014 54            	srlw	x
5830  0015 54            	srlw	x
5831  0016 54            	srlw	x
5832  0017 54            	srlw	x
5833  0018 9f            	ld	a,xl
5834  0019 c4514d        	and	a,20813
5835  001c 6b02          	ld	(OFST+0,sp),a
5836                     ; 2153   if ((enablestatus != (uint8_t)RESET) && (tmpreg != (uint8_t)RESET))
5838  001e 0d01          	tnz	(OFST-1,sp)
5839  0020 270a          	jreq	L7462
5841  0022 0d02          	tnz	(OFST+0,sp)
5842  0024 2706          	jreq	L7462
5843                     ; 2155     itstatus = SET;
5845  0026 a601          	ld	a,#1
5846  0028 6b02          	ld	(OFST+0,sp),a
5848  002a 2002          	jra	L1562
5849  002c               L7462:
5850                     ; 2159     itstatus = RESET;
5852  002c 0f02          	clr	(OFST+0,sp)
5853  002e               L1562:
5854                     ; 2162   return (ITStatus)itstatus;
5856  002e 7b02          	ld	a,(OFST+0,sp)
5859  0030 5b04          	addw	sp,#4
5860  0032 81            	ret
5896                     ; 2172 void RTC_ClearITPendingBit(RTC_IT_TypeDef RTC_IT)
5896                     ; 2173 {
5897                     .text:	section	.text,new
5898  0000               _RTC_ClearITPendingBit:
5902                     ; 2175   assert_param(IS_RTC_CLEAR_IT((uint16_t)RTC_IT));
5904                     ; 2178   RTC->ISR2 = (uint8_t)~(uint8_t)((uint16_t)RTC_IT >> 4);
5906  0000 54            	srlw	x
5907  0001 54            	srlw	x
5908  0002 54            	srlw	x
5909  0003 54            	srlw	x
5910  0004 9f            	ld	a,xl
5911  0005 43            	cpl	a
5912  0006 c7514d        	ld	20813,a
5913                     ; 2179 }
5916  0009 81            	ret
5959                     ; 2202 static uint8_t ByteToBcd2(uint8_t Value)
5959                     ; 2203 {
5960                     .text:	section	.text,new
5961  0000               L3_ByteToBcd2:
5963  0000 88            	push	a
5964  0001 88            	push	a
5965       00000001      OFST:	set	1
5968                     ; 2204   uint8_t bcdhigh = 0;
5970  0002 0f01          	clr	(OFST+0,sp)
5972  0004 2008          	jra	L7172
5973  0006               L3172:
5974                     ; 2208     bcdhigh++;
5976  0006 0c01          	inc	(OFST+0,sp)
5977                     ; 2209     Value -= 10;
5979  0008 7b02          	ld	a,(OFST+1,sp)
5980  000a a00a          	sub	a,#10
5981  000c 6b02          	ld	(OFST+1,sp),a
5982  000e               L7172:
5983                     ; 2206   while (Value >= 10)
5985  000e 7b02          	ld	a,(OFST+1,sp)
5986  0010 a10a          	cp	a,#10
5987  0012 24f2          	jruge	L3172
5988                     ; 2212   return  (uint8_t)((uint8_t)(bcdhigh << 4) | Value);
5990  0014 7b01          	ld	a,(OFST+0,sp)
5991  0016 97            	ld	xl,a
5992  0017 a610          	ld	a,#16
5993  0019 42            	mul	x,a
5994  001a 9f            	ld	a,xl
5995  001b 1a02          	or	a,(OFST+1,sp)
5998  001d 85            	popw	x
5999  001e 81            	ret
6042                     ; 2220 static uint8_t Bcd2ToByte(uint8_t Value)
6042                     ; 2221 {
6043                     .text:	section	.text,new
6044  0000               L5_Bcd2ToByte:
6046  0000 88            	push	a
6047  0001 88            	push	a
6048       00000001      OFST:	set	1
6051                     ; 2222   uint8_t tmp = 0;
6053  0002 0f01          	clr	(OFST+0,sp)
6054                     ; 2224   tmp = (uint8_t)((uint8_t)((uint8_t)(Value & (uint8_t)0xF0) >> 4) * (uint8_t)10);
6056  0004 a4f0          	and	a,#240
6057  0006 4e            	swap	a
6058  0007 a40f          	and	a,#15
6059  0009 97            	ld	xl,a
6060  000a a60a          	ld	a,#10
6061  000c 42            	mul	x,a
6062  000d 9f            	ld	a,xl
6063  000e 6b01          	ld	(OFST+0,sp),a
6064                     ; 2226   return (uint8_t)(tmp + (Value & (uint8_t)0x0F));
6066  0010 7b02          	ld	a,(OFST+1,sp)
6067  0012 a40f          	and	a,#15
6068  0014 1b01          	add	a,(OFST+0,sp)
6071  0016 85            	popw	x
6072  0017 81            	ret
6085                     	xdef	_RTC_ClearITPendingBit
6086                     	xdef	_RTC_GetITStatus
6087                     	xdef	_RTC_ClearFlag
6088                     	xdef	_RTC_GetFlagStatus
6089                     	xdef	_RTC_ITConfig
6090                     	xdef	_RTC_TamperCmd
6091                     	xdef	_RTC_TamperPinsPrechargeDuration
6092                     	xdef	_RTC_TamperSamplingFreqConfig
6093                     	xdef	_RTC_TamperFilterConfig
6094                     	xdef	_RTC_TamperLevelConfig
6095                     	xdef	_RTC_CalibOutputCmd
6096                     	xdef	_RTC_CalibOutputConfig
6097                     	xdef	_RTC_SmoothCalibConfig
6098                     	xdef	_RTC_SynchroShiftConfig
6099                     	xdef	_RTC_OutputConfig
6100                     	xdef	_RTC_GetStoreOperation
6101                     	xdef	_RTC_DayLightSavingConfig
6102                     	xdef	_RTC_WakeUpCmd
6103                     	xdef	_RTC_GetWakeUpCounter
6104                     	xdef	_RTC_SetWakeUpCounter
6105                     	xdef	_RTC_WakeUpClockConfig
6106                     	xdef	_RTC_AlarmSubSecondConfig
6107                     	xdef	_RTC_AlarmCmd
6108                     	xdef	_RTC_GetAlarm
6109                     	xdef	_RTC_AlarmStructInit
6110                     	xdef	_RTC_SetAlarm
6111                     	xdef	_RTC_GetDate
6112                     	xdef	_RTC_DateStructInit
6113                     	xdef	_RTC_SetDate
6114                     	xdef	_RTC_GetSubSecond
6115                     	xdef	_RTC_GetTime
6116                     	xdef	_RTC_TimeStructInit
6117                     	xdef	_RTC_SetTime
6118                     	xdef	_RTC_BypassShadowCmd
6119                     	xdef	_RTC_RatioCmd
6120                     	xdef	_RTC_WaitForSynchro
6121                     	xdef	_RTC_ExitInitMode
6122                     	xdef	_RTC_EnterInitMode
6123                     	xdef	_RTC_WriteProtectionCmd
6124                     	xdef	_RTC_StructInit
6125                     	xdef	_RTC_Init
6126                     	xdef	_RTC_DeInit
6145                     	end
