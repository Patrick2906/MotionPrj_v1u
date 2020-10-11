   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     .const:	section	.text
   5  0000               _SYSDivFactor:
   6  0000 01            	dc.b	1
   7  0001 02            	dc.b	2
   8  0002 04            	dc.b	4
   9  0003 08            	dc.b	8
  10  0004 10            	dc.b	16
  39                     ; 120 void CLK_DeInit(void)
  39                     ; 121 {
  41                     .text:	section	.text,new
  42  0000               _CLK_DeInit:
  46                     ; 122   CLK->ICKCR = CLK_ICKCR_RESET_VALUE;
  48  0000 351150c2      	mov	20674,#17
  49                     ; 123   CLK->ECKCR = CLK_ECKCR_RESET_VALUE;
  51  0004 725f50c6      	clr	20678
  52                     ; 124   CLK->CRTCR = CLK_CRTCR_RESET_VALUE;
  54  0008 725f50c1      	clr	20673
  55                     ; 125   CLK->CBEEPR = CLK_CBEEPR_RESET_VALUE;
  57  000c 725f50cb      	clr	20683
  58                     ; 126   CLK->SWR  = CLK_SWR_RESET_VALUE;
  60  0010 350150c8      	mov	20680,#1
  61                     ; 127   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  63  0014 725f50c9      	clr	20681
  64                     ; 128   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  66  0018 350350c0      	mov	20672,#3
  67                     ; 129   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  69  001c 725f50c3      	clr	20675
  70                     ; 130   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  72  0020 358050c4      	mov	20676,#128
  73                     ; 131   CLK->PCKENR3 = CLK_PCKENR3_RESET_VALUE;
  75  0024 725f50d0      	clr	20688
  76                     ; 132   CLK->CSSR  = CLK_CSSR_RESET_VALUE;
  78  0028 725f50ca      	clr	20682
  79                     ; 133   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  81  002c 725f50c5      	clr	20677
  82                     ; 134   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  84  0030 725f50cd      	clr	20685
  85                     ; 135   CLK->HSICALR = CLK_HSICALR_RESET_VALUE;
  87  0034 725f50cc      	clr	20684
  88                     ; 136   CLK->HSIUNLCKR = CLK_HSIUNLCKR_RESET_VALUE;
  90  0038 725f50ce      	clr	20686
  91                     ; 137   CLK->REGCSR = CLK_REGCSR_RESET_VALUE;
  93  003c 35b950cf      	mov	20687,#185
  94                     ; 138 }
  97  0040 81            	ret
 152                     ; 160 void CLK_HSICmd(FunctionalState NewState)
 152                     ; 161 {
 153                     .text:	section	.text,new
 154  0000               _CLK_HSICmd:
 158                     ; 163   assert_param(IS_FUNCTIONAL_STATE(NewState));
 160                     ; 165   if (NewState != DISABLE)
 162  0000 4d            	tnz	a
 163  0001 2706          	jreq	L74
 164                     ; 168     CLK->ICKCR |= CLK_ICKCR_HSION;
 166  0003 721050c2      	bset	20674,#0
 168  0007 2004          	jra	L15
 169  0009               L74:
 170                     ; 173     CLK->ICKCR &= (uint8_t)(~CLK_ICKCR_HSION);
 172  0009 721150c2      	bres	20674,#0
 173  000d               L15:
 174                     ; 175 }
 177  000d 81            	ret
 213                     ; 188 void CLK_AdjustHSICalibrationValue(uint8_t CLK_HSICalibrationValue)
 213                     ; 189 {
 214                     .text:	section	.text,new
 215  0000               _CLK_AdjustHSICalibrationValue:
 219                     ; 191   CLK->HSIUNLCKR = 0xAC;
 221  0000 35ac50ce      	mov	20686,#172
 222                     ; 192   CLK->HSIUNLCKR = 0x35;
 224  0004 353550ce      	mov	20686,#53
 225                     ; 195   CLK->HSITRIMR = (uint8_t)CLK_HSICalibrationValue;
 227  0008 c750cd        	ld	20685,a
 228                     ; 196 }
 231  000b 81            	ret
 266                     ; 212 void CLK_LSICmd(FunctionalState NewState)
 266                     ; 213 {
 267                     .text:	section	.text,new
 268  0000               _CLK_LSICmd:
 272                     ; 216   assert_param(IS_FUNCTIONAL_STATE(NewState));
 274                     ; 218   if (NewState != DISABLE)
 276  0000 4d            	tnz	a
 277  0001 2706          	jreq	L701
 278                     ; 221     CLK->ICKCR |= CLK_ICKCR_LSION;
 280  0003 721450c2      	bset	20674,#2
 282  0007 2004          	jra	L111
 283  0009               L701:
 284                     ; 226     CLK->ICKCR &= (uint8_t)(~CLK_ICKCR_LSION);
 286  0009 721550c2      	bres	20674,#2
 287  000d               L111:
 288                     ; 228 }
 291  000d 81            	ret
 353                     ; 249 void CLK_HSEConfig(CLK_HSE_TypeDef CLK_HSE)
 353                     ; 250 {
 354                     .text:	section	.text,new
 355  0000               _CLK_HSEConfig:
 359                     ; 252   assert_param(IS_CLK_HSE(CLK_HSE));
 361                     ; 256   CLK->ECKCR &= (uint8_t)~CLK_ECKCR_HSEON;
 363  0000 721150c6      	bres	20678,#0
 364                     ; 259   CLK->ECKCR &= (uint8_t)~CLK_ECKCR_HSEBYP;
 366  0004 721950c6      	bres	20678,#4
 367                     ; 262   CLK->ECKCR |= (uint8_t)CLK_HSE;
 369  0008 ca50c6        	or	a,20678
 370  000b c750c6        	ld	20678,a
 371                     ; 263 }
 374  000e 81            	ret
 436                     ; 280 void CLK_LSEConfig(CLK_LSE_TypeDef CLK_LSE)
 436                     ; 281 {
 437                     .text:	section	.text,new
 438  0000               _CLK_LSEConfig:
 442                     ; 283   assert_param(IS_CLK_LSE(CLK_LSE));
 444                     ; 287   CLK->ECKCR &= (uint8_t)~CLK_ECKCR_LSEON;
 446  0000 721550c6      	bres	20678,#2
 447                     ; 290   CLK->ECKCR &= (uint8_t)~CLK_ECKCR_LSEBYP;
 449  0004 721b50c6      	bres	20678,#5
 450                     ; 293   CLK->ECKCR |= (uint8_t)CLK_LSE;
 452  0008 ca50c6        	or	a,20678
 453  000b c750c6        	ld	20678,a
 454                     ; 295 }
 457  000e 81            	ret
 481                     ; 306 void CLK_ClockSecuritySystemEnable(void)
 481                     ; 307 {
 482                     .text:	section	.text,new
 483  0000               _CLK_ClockSecuritySystemEnable:
 487                     ; 309   CLK->CSSR |= CLK_CSSR_CSSEN;
 489  0000 721050ca      	bset	20682,#0
 490                     ; 310 }
 493  0004 81            	ret
 529                     ; 317 void CLK_ClockSecuritySytemDeglitchCmd(FunctionalState NewState)
 529                     ; 318 {
 530                     .text:	section	.text,new
 531  0000               _CLK_ClockSecuritySytemDeglitchCmd:
 535                     ; 320   assert_param(IS_FUNCTIONAL_STATE(NewState));
 537                     ; 322   if (NewState != DISABLE)
 539  0000 4d            	tnz	a
 540  0001 2706          	jreq	L122
 541                     ; 325     CLK->CSSR |= CLK_CSSR_CSSDGON;
 543  0003 721850ca      	bset	20682,#4
 545  0007 2004          	jra	L322
 546  0009               L122:
 547                     ; 330     CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDGON);
 549  0009 721950ca      	bres	20682,#4
 550  000d               L322:
 551                     ; 332 }
 554  000d 81            	ret
 695                     ; 356 void CLK_CCOConfig(CLK_CCOSource_TypeDef CLK_CCOSource, CLK_CCODiv_TypeDef CLK_CCODiv)
 695                     ; 357 {
 696                     .text:	section	.text,new
 697  0000               _CLK_CCOConfig:
 699  0000 89            	pushw	x
 700       00000000      OFST:	set	0
 703                     ; 359   assert_param(IS_CLK_OUTPUT(CLK_CCOSource));
 705                     ; 360   assert_param(IS_CLK_OUTPUT_DIVIDER(CLK_CCODiv));
 707                     ; 363   CLK->CCOR = (uint8_t)((uint8_t)CLK_CCOSource | (uint8_t)CLK_CCODiv);
 709  0001 9f            	ld	a,xl
 710  0002 1a01          	or	a,(OFST+1,sp)
 711  0004 c750c5        	ld	20677,a
 712                     ; 364 }
 715  0007 85            	popw	x
 716  0008 81            	ret
 790                     ; 416 void CLK_SYSCLKSourceConfig(CLK_SYSCLKSource_TypeDef CLK_SYSCLKSource)
 790                     ; 417 {
 791                     .text:	section	.text,new
 792  0000               _CLK_SYSCLKSourceConfig:
 796                     ; 419   assert_param(IS_CLK_SOURCE(CLK_SYSCLKSource));
 798                     ; 422   CLK->SWR = (uint8_t)CLK_SYSCLKSource;
 800  0000 c750c8        	ld	20680,a
 801                     ; 423 }
 804  0003 81            	ret
 829                     ; 435 CLK_SYSCLKSource_TypeDef CLK_GetSYSCLKSource(void)
 829                     ; 436 {
 830                     .text:	section	.text,new
 831  0000               _CLK_GetSYSCLKSource:
 835                     ; 437   return ((CLK_SYSCLKSource_TypeDef)(CLK->SCSR));
 837  0000 c650c7        	ld	a,20679
 840  0003 81            	ret
 912                     ; 478 uint32_t CLK_GetClockFreq(void)
 912                     ; 479 {
 913                     .text:	section	.text,new
 914  0000               _CLK_GetClockFreq:
 916  0000 5209          	subw	sp,#9
 917       00000009      OFST:	set	9
 920                     ; 480   uint32_t clockfrequency = 0;
 922  0002 96            	ldw	x,sp
 923  0003 1c0005        	addw	x,#OFST-4
 924  0006 cd0000        	call	c_ltor
 926                     ; 481   uint32_t sourcefrequency = 0;
 928  0009 ae0000        	ldw	x,#0
 929  000c 1f07          	ldw	(OFST-2,sp),x
 930  000e ae0000        	ldw	x,#0
 931  0011 1f05          	ldw	(OFST-4,sp),x
 932                     ; 482   CLK_SYSCLKSource_TypeDef clocksource = CLK_SYSCLKSource_HSI;
 934  0013 7b09          	ld	a,(OFST+0,sp)
 935  0015 97            	ld	xl,a
 936                     ; 483   uint8_t tmp = 0, presc = 0;
 938  0016 7b09          	ld	a,(OFST+0,sp)
 939  0018 97            	ld	xl,a
 942  0019 7b09          	ld	a,(OFST+0,sp)
 943  001b 97            	ld	xl,a
 944                     ; 486   clocksource = (CLK_SYSCLKSource_TypeDef)CLK->SCSR;
 946  001c c650c7        	ld	a,20679
 947  001f 6b09          	ld	(OFST+0,sp),a
 948                     ; 488   if ( clocksource == CLK_SYSCLKSource_HSI)
 950  0021 7b09          	ld	a,(OFST+0,sp)
 951  0023 a101          	cp	a,#1
 952  0025 260c          	jrne	L704
 953                     ; 490     sourcefrequency = HSI_VALUE;
 955  0027 ae2400        	ldw	x,#9216
 956  002a 1f07          	ldw	(OFST-2,sp),x
 957  002c ae00f4        	ldw	x,#244
 958  002f 1f05          	ldw	(OFST-4,sp),x
 960  0031 202b          	jra	L114
 961  0033               L704:
 962                     ; 492   else if ( clocksource == CLK_SYSCLKSource_LSI)
 964  0033 7b09          	ld	a,(OFST+0,sp)
 965  0035 a102          	cp	a,#2
 966  0037 260c          	jrne	L314
 967                     ; 494     sourcefrequency = LSI_VALUE;
 969  0039 ae9470        	ldw	x,#38000
 970  003c 1f07          	ldw	(OFST-2,sp),x
 971  003e ae0000        	ldw	x,#0
 972  0041 1f05          	ldw	(OFST-4,sp),x
 974  0043 2019          	jra	L114
 975  0045               L314:
 976                     ; 496   else if ( clocksource == CLK_SYSCLKSource_HSE)
 978  0045 7b09          	ld	a,(OFST+0,sp)
 979  0047 a104          	cp	a,#4
 980  0049 260c          	jrne	L714
 981                     ; 498     sourcefrequency = HSE_VALUE;
 983  004b ae2400        	ldw	x,#9216
 984  004e 1f07          	ldw	(OFST-2,sp),x
 985  0050 ae00f4        	ldw	x,#244
 986  0053 1f05          	ldw	(OFST-4,sp),x
 988  0055 2007          	jra	L114
 989  0057               L714:
 990                     ; 502     clockfrequency = LSE_VALUE;
 992  0057 96            	ldw	x,sp
 993  0058 1c0005        	addw	x,#OFST-4
 994  005b cd0000        	call	c_ltor
 996  005e               L114:
 997                     ; 506   tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_CKM);
 999  005e c650c0        	ld	a,20672
1000  0061 a407          	and	a,#7
1001  0063 6b09          	ld	(OFST+0,sp),a
1002                     ; 507   presc = SYSDivFactor[tmp];
1004  0065 7b09          	ld	a,(OFST+0,sp)
1005  0067 5f            	clrw	x
1006  0068 97            	ld	xl,a
1007  0069 d60000        	ld	a,(_SYSDivFactor,x)
1008  006c 6b09          	ld	(OFST+0,sp),a
1009                     ; 510   clockfrequency = sourcefrequency / presc;
1011  006e 7b09          	ld	a,(OFST+0,sp)
1012  0070 b703          	ld	c_lreg+3,a
1013  0072 3f02          	clr	c_lreg+2
1014  0074 3f01          	clr	c_lreg+1
1015  0076 3f00          	clr	c_lreg
1016  0078 96            	ldw	x,sp
1017  0079 1c0001        	addw	x,#OFST-8
1018  007c cd0000        	call	c_rtol
1020  007f 96            	ldw	x,sp
1021  0080 1c0005        	addw	x,#OFST-4
1022  0083 cd0000        	call	c_ltor
1024  0086 96            	ldw	x,sp
1025  0087 1c0001        	addw	x,#OFST-8
1026  008a cd0000        	call	c_ludv
1028  008d 96            	ldw	x,sp
1029  008e 1c0005        	addw	x,#OFST-4
1030  0091 cd0000        	call	c_rtol
1032                     ; 512   return((uint32_t)clockfrequency);
1034  0094 96            	ldw	x,sp
1035  0095 1c0005        	addw	x,#OFST-4
1036  0098 cd0000        	call	c_ltor
1040  009b 5b09          	addw	sp,#9
1041  009d 81            	ret
1139                     ; 528 void CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_TypeDef CLK_SYSCLKDiv)
1139                     ; 529 {
1140                     .text:	section	.text,new
1141  0000               _CLK_SYSCLKDivConfig:
1145                     ; 531   assert_param(IS_CLK_SYSTEM_DIVIDER(CLK_SYSCLKDiv));
1147                     ; 533   CLK->CKDIVR = (uint8_t)(CLK_SYSCLKDiv);
1149  0000 c750c0        	ld	20672,a
1150                     ; 534 }
1153  0003 81            	ret
1189                     ; 541 void CLK_SYSCLKSourceSwitchCmd(FunctionalState NewState)
1189                     ; 542 {
1190                     .text:	section	.text,new
1191  0000               _CLK_SYSCLKSourceSwitchCmd:
1195                     ; 544   assert_param(IS_FUNCTIONAL_STATE(NewState));
1197                     ; 546   if (NewState != DISABLE)
1199  0000 4d            	tnz	a
1200  0001 2706          	jreq	L305
1201                     ; 549     CLK->SWCR |= CLK_SWCR_SWEN;
1203  0003 721250c9      	bset	20681,#1
1205  0007 2004          	jra	L505
1206  0009               L305:
1207                     ; 554     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
1209  0009 721350c9      	bres	20681,#1
1210  000d               L505:
1211                     ; 556 }
1214  000d 81            	ret
1360                     ; 616 void CLK_RTCClockConfig(CLK_RTCCLKSource_TypeDef CLK_RTCCLKSource, CLK_RTCCLKDiv_TypeDef CLK_RTCCLKDiv)
1360                     ; 617 {
1361                     .text:	section	.text,new
1362  0000               _CLK_RTCClockConfig:
1364  0000 89            	pushw	x
1365       00000000      OFST:	set	0
1368                     ; 619   assert_param(IS_CLK_CLOCK_RTC(CLK_RTCCLKSource));
1370                     ; 620   assert_param(IS_CLK_CLOCK_RTC_DIV(CLK_RTCCLKDiv));
1372                     ; 623   CLK->CRTCR = (uint8_t)((uint8_t)CLK_RTCCLKSource | (uint8_t)CLK_RTCCLKDiv);
1374  0001 9f            	ld	a,xl
1375  0002 1a01          	or	a,(OFST+1,sp)
1376  0004 c750c1        	ld	20673,a
1377                     ; 624 }
1380  0007 85            	popw	x
1381  0008 81            	ret
1447                     ; 635 void CLK_BEEPClockConfig(CLK_BEEPCLKSource_TypeDef CLK_BEEPCLKSource)
1447                     ; 636 {
1448                     .text:	section	.text,new
1449  0000               _CLK_BEEPClockConfig:
1453                     ; 638   assert_param(IS_CLK_CLOCK_BEEP(CLK_BEEPCLKSource));
1455                     ; 641   CLK->CBEEPR = (uint8_t)(CLK_BEEPCLKSource);
1457  0000 c750cb        	ld	20683,a
1458                     ; 643 }
1461  0003 81            	ret
1686                     ; 677 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
1686                     ; 678 {
1687                     .text:	section	.text,new
1688  0000               _CLK_PeripheralClockConfig:
1690  0000 89            	pushw	x
1691  0001 88            	push	a
1692       00000001      OFST:	set	1
1695                     ; 679   uint8_t reg = 0;
1697  0002 0f01          	clr	(OFST+0,sp)
1698                     ; 682   assert_param(IS_CLK_PERIPHERAL(CLK_Peripheral));
1700                     ; 683   assert_param(IS_FUNCTIONAL_STATE(NewState));
1702                     ; 686   reg = (uint8_t)((uint8_t)CLK_Peripheral & (uint8_t)0xF0);
1704  0004 9e            	ld	a,xh
1705  0005 a4f0          	and	a,#240
1706  0007 6b01          	ld	(OFST+0,sp),a
1707                     ; 688   if ( reg == 0x00)
1709  0009 0d01          	tnz	(OFST+0,sp)
1710  000b 2635          	jrne	L527
1711                     ; 690     if (NewState != DISABLE)
1713  000d 0d03          	tnz	(OFST+2,sp)
1714  000f 2719          	jreq	L727
1715                     ; 693       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
1717  0011 7b02          	ld	a,(OFST+1,sp)
1718  0013 a40f          	and	a,#15
1719  0015 5f            	clrw	x
1720  0016 97            	ld	xl,a
1721  0017 a601          	ld	a,#1
1722  0019 5d            	tnzw	x
1723  001a 2704          	jreq	L64
1724  001c               L05:
1725  001c 48            	sll	a
1726  001d 5a            	decw	x
1727  001e 26fc          	jrne	L05
1728  0020               L64:
1729  0020 ca50c3        	or	a,20675
1730  0023 c750c3        	ld	20675,a
1732  0026 acac00ac      	jpf	L337
1733  002a               L727:
1734                     ; 698       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1736  002a 7b02          	ld	a,(OFST+1,sp)
1737  002c a40f          	and	a,#15
1738  002e 5f            	clrw	x
1739  002f 97            	ld	xl,a
1740  0030 a601          	ld	a,#1
1741  0032 5d            	tnzw	x
1742  0033 2704          	jreq	L25
1743  0035               L45:
1744  0035 48            	sll	a
1745  0036 5a            	decw	x
1746  0037 26fc          	jrne	L45
1747  0039               L25:
1748  0039 43            	cpl	a
1749  003a c450c3        	and	a,20675
1750  003d c750c3        	ld	20675,a
1751  0040 206a          	jra	L337
1752  0042               L527:
1753                     ; 701   else if (reg == 0x10)
1755  0042 7b01          	ld	a,(OFST+0,sp)
1756  0044 a110          	cp	a,#16
1757  0046 2633          	jrne	L537
1758                     ; 703     if (NewState != DISABLE)
1760  0048 0d03          	tnz	(OFST+2,sp)
1761  004a 2717          	jreq	L737
1762                     ; 706       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
1764  004c 7b02          	ld	a,(OFST+1,sp)
1765  004e a40f          	and	a,#15
1766  0050 5f            	clrw	x
1767  0051 97            	ld	xl,a
1768  0052 a601          	ld	a,#1
1769  0054 5d            	tnzw	x
1770  0055 2704          	jreq	L65
1771  0057               L06:
1772  0057 48            	sll	a
1773  0058 5a            	decw	x
1774  0059 26fc          	jrne	L06
1775  005b               L65:
1776  005b ca50c4        	or	a,20676
1777  005e c750c4        	ld	20676,a
1779  0061 2049          	jra	L337
1780  0063               L737:
1781                     ; 711       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1783  0063 7b02          	ld	a,(OFST+1,sp)
1784  0065 a40f          	and	a,#15
1785  0067 5f            	clrw	x
1786  0068 97            	ld	xl,a
1787  0069 a601          	ld	a,#1
1788  006b 5d            	tnzw	x
1789  006c 2704          	jreq	L26
1790  006e               L46:
1791  006e 48            	sll	a
1792  006f 5a            	decw	x
1793  0070 26fc          	jrne	L46
1794  0072               L26:
1795  0072 43            	cpl	a
1796  0073 c450c4        	and	a,20676
1797  0076 c750c4        	ld	20676,a
1798  0079 2031          	jra	L337
1799  007b               L537:
1800                     ; 716     if (NewState != DISABLE)
1802  007b 0d03          	tnz	(OFST+2,sp)
1803  007d 2717          	jreq	L547
1804                     ; 719       CLK->PCKENR3 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
1806  007f 7b02          	ld	a,(OFST+1,sp)
1807  0081 a40f          	and	a,#15
1808  0083 5f            	clrw	x
1809  0084 97            	ld	xl,a
1810  0085 a601          	ld	a,#1
1811  0087 5d            	tnzw	x
1812  0088 2704          	jreq	L66
1813  008a               L07:
1814  008a 48            	sll	a
1815  008b 5a            	decw	x
1816  008c 26fc          	jrne	L07
1817  008e               L66:
1818  008e ca50d0        	or	a,20688
1819  0091 c750d0        	ld	20688,a
1821  0094 2016          	jra	L337
1822  0096               L547:
1823                     ; 724       CLK->PCKENR3 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1825  0096 7b02          	ld	a,(OFST+1,sp)
1826  0098 a40f          	and	a,#15
1827  009a 5f            	clrw	x
1828  009b 97            	ld	xl,a
1829  009c a601          	ld	a,#1
1830  009e 5d            	tnzw	x
1831  009f 2704          	jreq	L27
1832  00a1               L47:
1833  00a1 48            	sll	a
1834  00a2 5a            	decw	x
1835  00a3 26fc          	jrne	L47
1836  00a5               L27:
1837  00a5 43            	cpl	a
1838  00a6 c450d0        	and	a,20688
1839  00a9 c750d0        	ld	20688,a
1840  00ac               L337:
1841                     ; 727 }
1844  00ac 5b03          	addw	sp,#3
1845  00ae 81            	ret
1869                     ; 765 void CLK_LSEClockSecuritySystemEnable(void)
1869                     ; 766 {
1870                     .text:	section	.text,new
1871  0000               _CLK_LSEClockSecuritySystemEnable:
1875                     ; 768   CSSLSE->CSR |= CSSLSE_CSR_CSSEN;
1877  0000 72105190      	bset	20880,#0
1878                     ; 769 }
1881  0004 81            	ret
1905                     ; 777 void CLK_RTCCLKSwitchOnLSEFailureEnable(void)
1905                     ; 778 {
1906                     .text:	section	.text,new
1907  0000               _CLK_RTCCLKSwitchOnLSEFailureEnable:
1911                     ; 780   CSSLSE->CSR |= CSSLSE_CSR_SWITCHEN;
1913  0000 72125190      	bset	20880,#1
1914                     ; 781 }
1917  0004 81            	ret
1992                     ; 807 void CLK_HaltConfig(CLK_Halt_TypeDef CLK_Halt, FunctionalState NewState)
1992                     ; 808 {
1993                     .text:	section	.text,new
1994  0000               _CLK_HaltConfig:
1996  0000 89            	pushw	x
1997       00000000      OFST:	set	0
2000                     ; 810   assert_param(IS_CLK_HALT(CLK_Halt));
2002                     ; 811   assert_param(IS_FUNCTIONAL_STATE(NewState));
2004                     ; 813   if (NewState != DISABLE)
2006  0001 9f            	ld	a,xl
2007  0002 4d            	tnz	a
2008  0003 2709          	jreq	L5201
2009                     ; 815     CLK->ICKCR |= (uint8_t)(CLK_Halt);
2011  0005 9e            	ld	a,xh
2012  0006 ca50c2        	or	a,20674
2013  0009 c750c2        	ld	20674,a
2015  000c 2009          	jra	L7201
2016  000e               L5201:
2017                     ; 819     CLK->ICKCR &= (uint8_t)(~CLK_Halt);
2019  000e 7b01          	ld	a,(OFST+1,sp)
2020  0010 43            	cpl	a
2021  0011 c450c2        	and	a,20674
2022  0014 c750c2        	ld	20674,a
2023  0017               L7201:
2024                     ; 821 }
2027  0017 85            	popw	x
2028  0018 81            	ret
2064                     ; 831 void CLK_MainRegulatorCmd(FunctionalState NewState)
2064                     ; 832 {
2065                     .text:	section	.text,new
2066  0000               _CLK_MainRegulatorCmd:
2070                     ; 834   assert_param(IS_FUNCTIONAL_STATE(NewState));
2072                     ; 836   if (NewState != DISABLE)
2074  0000 4d            	tnz	a
2075  0001 2706          	jreq	L7401
2076                     ; 839     CLK->REGCSR &= (uint8_t)(~CLK_REGCSR_REGOFF);
2078  0003 721350cf      	bres	20687,#1
2080  0007 2004          	jra	L1501
2081  0009               L7401:
2082                     ; 844     CLK->REGCSR |= CLK_REGCSR_REGOFF;
2084  0009 721250cf      	bset	20687,#1
2085  000d               L1501:
2086                     ; 846 }
2089  000d 81            	ret
2161                     ; 875 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
2161                     ; 876 {
2162                     .text:	section	.text,new
2163  0000               _CLK_ITConfig:
2165  0000 89            	pushw	x
2166       00000000      OFST:	set	0
2169                     ; 879   assert_param(IS_CLK_IT(CLK_IT));
2171                     ; 880   assert_param(IS_FUNCTIONAL_STATE(NewState));
2173                     ; 882   if (NewState != DISABLE)
2175  0001 9f            	ld	a,xl
2176  0002 4d            	tnz	a
2177  0003 271d          	jreq	L7011
2178                     ; 884     if (CLK_IT == CLK_IT_SWIF)
2180  0005 9e            	ld	a,xh
2181  0006 a11c          	cp	a,#28
2182  0008 2606          	jrne	L1111
2183                     ; 887       CLK->SWCR |= CLK_SWCR_SWIEN;
2185  000a 721450c9      	bset	20681,#2
2187  000e 202e          	jra	L1211
2188  0010               L1111:
2189                     ; 889     else if (CLK_IT == CLK_IT_LSECSSF)
2191  0010 7b01          	ld	a,(OFST+1,sp)
2192  0012 a12c          	cp	a,#44
2193  0014 2606          	jrne	L5111
2194                     ; 892       CSSLSE->CSR |= CSSLSE_CSR_CSSIE;
2196  0016 72145190      	bset	20880,#2
2198  001a 2022          	jra	L1211
2199  001c               L5111:
2200                     ; 897       CLK->CSSR |= CLK_CSSR_CSSDIE;
2202  001c 721450ca      	bset	20682,#2
2203  0020 201c          	jra	L1211
2204  0022               L7011:
2205                     ; 902     if (CLK_IT == CLK_IT_SWIF)
2207  0022 7b01          	ld	a,(OFST+1,sp)
2208  0024 a11c          	cp	a,#28
2209  0026 2606          	jrne	L3211
2210                     ; 905       CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
2212  0028 721550c9      	bres	20681,#2
2214  002c 2010          	jra	L1211
2215  002e               L3211:
2216                     ; 907     else if (CLK_IT == CLK_IT_LSECSSF)
2218  002e 7b01          	ld	a,(OFST+1,sp)
2219  0030 a12c          	cp	a,#44
2220  0032 2606          	jrne	L7211
2221                     ; 910       CSSLSE->CSR &= (uint8_t)(~CSSLSE_CSR_CSSIE);
2223  0034 72155190      	bres	20880,#2
2225  0038 2004          	jra	L1211
2226  003a               L7211:
2227                     ; 915       CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
2229  003a 721550ca      	bres	20682,#2
2230  003e               L1211:
2231                     ; 918 }
2234  003e 85            	popw	x
2235  003f 81            	ret
2458                     ; 945 FlagStatus CLK_GetFlagStatus(CLK_FLAG_TypeDef CLK_FLAG)
2458                     ; 946 {
2459                     .text:	section	.text,new
2460  0000               _CLK_GetFlagStatus:
2462  0000 88            	push	a
2463  0001 89            	pushw	x
2464       00000002      OFST:	set	2
2467                     ; 947   uint8_t reg = 0;
2469  0002 7b02          	ld	a,(OFST+0,sp)
2470  0004 97            	ld	xl,a
2471                     ; 948   uint8_t pos = 0;
2473  0005 7b01          	ld	a,(OFST-1,sp)
2474  0007 97            	ld	xl,a
2475                     ; 949   FlagStatus bitstatus = RESET;
2477  0008 7b02          	ld	a,(OFST+0,sp)
2478  000a 97            	ld	xl,a
2479                     ; 952   assert_param(IS_CLK_FLAGS(CLK_FLAG));
2481                     ; 955   reg = (uint8_t)((uint8_t)CLK_FLAG & (uint8_t)0xF0);
2483  000b 7b03          	ld	a,(OFST+1,sp)
2484  000d a4f0          	and	a,#240
2485  000f 6b02          	ld	(OFST+0,sp),a
2486                     ; 958   pos = (uint8_t)((uint8_t)CLK_FLAG & (uint8_t)0x0F);
2488  0011 7b03          	ld	a,(OFST+1,sp)
2489  0013 a40f          	and	a,#15
2490  0015 6b01          	ld	(OFST-1,sp),a
2491                     ; 960   if (reg == 0x00) /* The flag to check is in CRTC Rregister */
2493  0017 0d02          	tnz	(OFST+0,sp)
2494  0019 2607          	jrne	L7421
2495                     ; 962     reg = CLK->CRTCR;
2497  001b c650c1        	ld	a,20673
2498  001e 6b02          	ld	(OFST+0,sp),a
2500  0020 2060          	jra	L1521
2501  0022               L7421:
2502                     ; 964   else if (reg == 0x10) /* The flag to check is in ICKCR register */
2504  0022 7b02          	ld	a,(OFST+0,sp)
2505  0024 a110          	cp	a,#16
2506  0026 2607          	jrne	L3521
2507                     ; 966     reg = CLK->ICKCR;
2509  0028 c650c2        	ld	a,20674
2510  002b 6b02          	ld	(OFST+0,sp),a
2512  002d 2053          	jra	L1521
2513  002f               L3521:
2514                     ; 968   else if (reg == 0x20) /* The flag to check is in CCOR register */
2516  002f 7b02          	ld	a,(OFST+0,sp)
2517  0031 a120          	cp	a,#32
2518  0033 2607          	jrne	L7521
2519                     ; 970     reg = CLK->CCOR;
2521  0035 c650c5        	ld	a,20677
2522  0038 6b02          	ld	(OFST+0,sp),a
2524  003a 2046          	jra	L1521
2525  003c               L7521:
2526                     ; 972   else if (reg == 0x30) /* The flag to check is in ECKCR register */
2528  003c 7b02          	ld	a,(OFST+0,sp)
2529  003e a130          	cp	a,#48
2530  0040 2607          	jrne	L3621
2531                     ; 974     reg = CLK->ECKCR;
2533  0042 c650c6        	ld	a,20678
2534  0045 6b02          	ld	(OFST+0,sp),a
2536  0047 2039          	jra	L1521
2537  0049               L3621:
2538                     ; 976   else if (reg == 0x40) /* The flag to check is in SWCR register */
2540  0049 7b02          	ld	a,(OFST+0,sp)
2541  004b a140          	cp	a,#64
2542  004d 2607          	jrne	L7621
2543                     ; 978     reg = CLK->SWCR;
2545  004f c650c9        	ld	a,20681
2546  0052 6b02          	ld	(OFST+0,sp),a
2548  0054 202c          	jra	L1521
2549  0056               L7621:
2550                     ; 980   else if (reg == 0x50) /* The flag to check is in CSSR register */
2552  0056 7b02          	ld	a,(OFST+0,sp)
2553  0058 a150          	cp	a,#80
2554  005a 2607          	jrne	L3721
2555                     ; 982     reg = CLK->CSSR;
2557  005c c650ca        	ld	a,20682
2558  005f 6b02          	ld	(OFST+0,sp),a
2560  0061 201f          	jra	L1521
2561  0063               L3721:
2562                     ; 984   else if (reg == 0x70) /* The flag to check is in REGCSR register */
2564  0063 7b02          	ld	a,(OFST+0,sp)
2565  0065 a170          	cp	a,#112
2566  0067 2607          	jrne	L7721
2567                     ; 986     reg = CLK->REGCSR;
2569  0069 c650cf        	ld	a,20687
2570  006c 6b02          	ld	(OFST+0,sp),a
2572  006e 2012          	jra	L1521
2573  0070               L7721:
2574                     ; 988   else if (reg == 0x80) /* The flag to check is in CSSLSE_CSRregister */
2576  0070 7b02          	ld	a,(OFST+0,sp)
2577  0072 a180          	cp	a,#128
2578  0074 2607          	jrne	L3031
2579                     ; 990     reg = CSSLSE->CSR;
2581  0076 c65190        	ld	a,20880
2582  0079 6b02          	ld	(OFST+0,sp),a
2584  007b 2005          	jra	L1521
2585  007d               L3031:
2586                     ; 994     reg = CLK->CBEEPR;
2588  007d c650cb        	ld	a,20683
2589  0080 6b02          	ld	(OFST+0,sp),a
2590  0082               L1521:
2591                     ; 998   if ((reg & (uint8_t)((uint8_t)1 << (uint8_t)pos)) != (uint8_t)RESET)
2593  0082 7b01          	ld	a,(OFST-1,sp)
2594  0084 5f            	clrw	x
2595  0085 97            	ld	xl,a
2596  0086 a601          	ld	a,#1
2597  0088 5d            	tnzw	x
2598  0089 2704          	jreq	L211
2599  008b               L411:
2600  008b 48            	sll	a
2601  008c 5a            	decw	x
2602  008d 26fc          	jrne	L411
2603  008f               L211:
2604  008f 1402          	and	a,(OFST+0,sp)
2605  0091 2706          	jreq	L7031
2606                     ; 1000     bitstatus = SET;
2608  0093 a601          	ld	a,#1
2609  0095 6b02          	ld	(OFST+0,sp),a
2611  0097 2002          	jra	L1131
2612  0099               L7031:
2613                     ; 1004     bitstatus = RESET;
2615  0099 0f02          	clr	(OFST+0,sp)
2616  009b               L1131:
2617                     ; 1008   return((FlagStatus)bitstatus);
2619  009b 7b02          	ld	a,(OFST+0,sp)
2622  009d 5b03          	addw	sp,#3
2623  009f 81            	ret
2646                     ; 1016 void CLK_ClearFlag(void)
2646                     ; 1017 {
2647                     .text:	section	.text,new
2648  0000               _CLK_ClearFlag:
2652                     ; 1020   CSSLSE->CSR &= (uint8_t)(~CSSLSE_CSR_CSSF);
2654  0000 72175190      	bres	20880,#3
2655                     ; 1021 }
2658  0004 81            	ret
2704                     ; 1032 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2704                     ; 1033 {
2705                     .text:	section	.text,new
2706  0000               _CLK_GetITStatus:
2708  0000 88            	push	a
2709  0001 88            	push	a
2710       00000001      OFST:	set	1
2713                     ; 1035   ITStatus bitstatus = RESET;
2715  0002 0f01          	clr	(OFST+0,sp)
2716                     ; 1038   assert_param(IS_CLK_IT(CLK_IT));
2718                     ; 1040   if (CLK_IT == CLK_IT_SWIF)
2720  0004 a11c          	cp	a,#28
2721  0006 2611          	jrne	L5431
2722                     ; 1043     if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2724  0008 c450c9        	and	a,20681
2725  000b a10c          	cp	a,#12
2726  000d 2606          	jrne	L7431
2727                     ; 1045       bitstatus = SET;
2729  000f a601          	ld	a,#1
2730  0011 6b01          	ld	(OFST+0,sp),a
2732  0013 202e          	jra	L3531
2733  0015               L7431:
2734                     ; 1049       bitstatus = RESET;
2736  0015 0f01          	clr	(OFST+0,sp)
2737  0017 202a          	jra	L3531
2738  0019               L5431:
2739                     ; 1052   else if (CLK_IT == CLK_IT_LSECSSF)
2741  0019 7b02          	ld	a,(OFST+1,sp)
2742  001b a12c          	cp	a,#44
2743  001d 2613          	jrne	L5531
2744                     ; 1055     if ((CSSLSE->CSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2746  001f c65190        	ld	a,20880
2747  0022 1402          	and	a,(OFST+1,sp)
2748  0024 a10c          	cp	a,#12
2749  0026 2606          	jrne	L7531
2750                     ; 1057       bitstatus = SET;
2752  0028 a601          	ld	a,#1
2753  002a 6b01          	ld	(OFST+0,sp),a
2755  002c 2015          	jra	L3531
2756  002e               L7531:
2757                     ; 1061       bitstatus = RESET;
2759  002e 0f01          	clr	(OFST+0,sp)
2760  0030 2011          	jra	L3531
2761  0032               L5531:
2762                     ; 1067     if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2764  0032 c650ca        	ld	a,20682
2765  0035 1402          	and	a,(OFST+1,sp)
2766  0037 a10c          	cp	a,#12
2767  0039 2606          	jrne	L5631
2768                     ; 1069       bitstatus = SET;
2770  003b a601          	ld	a,#1
2771  003d 6b01          	ld	(OFST+0,sp),a
2773  003f 2002          	jra	L3531
2774  0041               L5631:
2775                     ; 1073       bitstatus = RESET;
2777  0041 0f01          	clr	(OFST+0,sp)
2778  0043               L3531:
2779                     ; 1078   return bitstatus;
2781  0043 7b01          	ld	a,(OFST+0,sp)
2784  0045 85            	popw	x
2785  0046 81            	ret
2821                     ; 1089 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2821                     ; 1090 {
2822                     .text:	section	.text,new
2823  0000               _CLK_ClearITPendingBit:
2827                     ; 1093   assert_param(IS_CLK_CLEAR_IT(CLK_IT));
2829                     ; 1095   if ((uint8_t)((uint8_t)CLK_IT & (uint8_t)0xF0) == (uint8_t)0x20)
2831  0000 a4f0          	and	a,#240
2832  0002 a120          	cp	a,#32
2833  0004 2606          	jrne	L7041
2834                     ; 1098     CSSLSE->CSR &= (uint8_t)(~CSSLSE_CSR_CSSF);
2836  0006 72175190      	bres	20880,#3
2838  000a 2004          	jra	L1141
2839  000c               L7041:
2840                     ; 1103     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2842  000c 721750c9      	bres	20681,#3
2843  0010               L1141:
2844                     ; 1105 }
2847  0010 81            	ret
2872                     	xdef	_SYSDivFactor
2873                     	xdef	_CLK_ClearITPendingBit
2874                     	xdef	_CLK_GetITStatus
2875                     	xdef	_CLK_ClearFlag
2876                     	xdef	_CLK_GetFlagStatus
2877                     	xdef	_CLK_ITConfig
2878                     	xdef	_CLK_MainRegulatorCmd
2879                     	xdef	_CLK_HaltConfig
2880                     	xdef	_CLK_RTCCLKSwitchOnLSEFailureEnable
2881                     	xdef	_CLK_LSEClockSecuritySystemEnable
2882                     	xdef	_CLK_PeripheralClockConfig
2883                     	xdef	_CLK_BEEPClockConfig
2884                     	xdef	_CLK_RTCClockConfig
2885                     	xdef	_CLK_SYSCLKSourceSwitchCmd
2886                     	xdef	_CLK_SYSCLKDivConfig
2887                     	xdef	_CLK_GetClockFreq
2888                     	xdef	_CLK_GetSYSCLKSource
2889                     	xdef	_CLK_SYSCLKSourceConfig
2890                     	xdef	_CLK_CCOConfig
2891                     	xdef	_CLK_ClockSecuritySytemDeglitchCmd
2892                     	xdef	_CLK_ClockSecuritySystemEnable
2893                     	xdef	_CLK_LSEConfig
2894                     	xdef	_CLK_HSEConfig
2895                     	xdef	_CLK_LSICmd
2896                     	xdef	_CLK_AdjustHSICalibrationValue
2897                     	xdef	_CLK_HSICmd
2898                     	xdef	_CLK_DeInit
2899                     	xref.b	c_lreg
2918                     	xref	c_ludv
2919                     	xref	c_rtol
2920                     	xref	c_ltor
2921                     	end
