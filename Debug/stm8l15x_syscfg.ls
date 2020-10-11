   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 119 void SYSCFG_RIDeInit(void)
  32                     ; 120 {
  34                     .text:	section	.text,new
  35  0000               _SYSCFG_RIDeInit:
  39                     ; 121   RI->ICR1   = RI_ICR1_RESET_VALUE;     /*!< Set RI->ICR1 to reset value */
  41  0000 725f5431      	clr	21553
  42                     ; 122   RI->ICR2   = RI_ICR2_RESET_VALUE;     /*!< Set RI->ICR2 to reset value */
  44  0004 725f5432      	clr	21554
  45                     ; 123   RI->IOSR1  = RI_IOSR1_RESET_VALUE;    /*!< Set RI->IOSR1 to reset value */
  47  0008 725f5439      	clr	21561
  48                     ; 124   RI->IOSR2  = RI_IOSR2_RESET_VALUE;    /*!< Set RI->IOSR2 to reset value */
  50  000c 725f543a      	clr	21562
  51                     ; 125   RI->IOSR3  = RI_IOSR3_RESET_VALUE;    /*!< Set RI->IOSR3 to reset value */
  53  0010 725f543b      	clr	21563
  54                     ; 126   RI->IOSR4  = RI_IOSR4_RESET_VALUE;    /*!< Set RI->IOSR3 to reset value */
  56  0014 725f5457      	clr	21591
  57                     ; 127   RI->ASCR1  = RI_ASCR1_RESET_VALUE;    /*!< Set RI->ASCR1 to reset value */
  59  0018 725f543d      	clr	21565
  60                     ; 128   RI->ASCR2  = RI_ASCR2_RESET_VALUE;    /*!< Set RI->ASCR2 to reset value */
  62  001c 725f543e      	clr	21566
  63                     ; 129   RI->RCR    = RI_RCR_RESET_VALUE;      /*!< Set RI->RCR to reset value */
  65  0020 725f543f      	clr	21567
  66                     ; 130 }
  69  0024 81            	ret
 328                     ; 142 void SYSCFG_RITIMInputCaptureConfig(RI_InputCapture_TypeDef RI_InputCapture,
 328                     ; 143                                     RI_InputCaptureRouting_TypeDef RI_InputCaptureRouting)
 328                     ; 144 {
 329                     .text:	section	.text,new
 330  0000               _SYSCFG_RITIMInputCaptureConfig:
 332  0000 89            	pushw	x
 333       00000000      OFST:	set	0
 336                     ; 146   assert_param(IS_RI_INPUTCAPTURE(RI_InputCapture));
 338                     ; 147   assert_param(IS_RI_INPUTCAPTUREROUTING(RI_InputCaptureRouting));
 340                     ; 150   if (RI_InputCapture == RI_InputCapture_IC2)
 342  0001 9e            	ld	a,xh
 343  0002 a102          	cp	a,#2
 344  0004 2606          	jrne	L531
 345                     ; 153     RI->ICR1 = (uint8_t) RI_InputCaptureRouting;
 347  0006 9f            	ld	a,xl
 348  0007 c75431        	ld	21553,a
 350  000a 2005          	jra	L731
 351  000c               L531:
 352                     ; 159     RI->ICR2 = (uint8_t) RI_InputCaptureRouting;
 354  000c 7b02          	ld	a,(OFST+2,sp)
 355  000e c75432        	ld	21554,a
 356  0011               L731:
 357                     ; 161 }
 360  0011 85            	popw	x
 361  0012 81            	ret
 543                     ; 184 void SYSCFG_RIAnalogSwitchConfig(RI_AnalogSwitch_TypeDef RI_AnalogSwitch,
 543                     ; 185                                  FunctionalState NewState)
 543                     ; 186 {
 544                     .text:	section	.text,new
 545  0000               _SYSCFG_RIAnalogSwitchConfig:
 547  0000 89            	pushw	x
 548  0001 89            	pushw	x
 549       00000002      OFST:	set	2
 552                     ; 187   uint8_t AnalogSwitchRegister, AnalogSwitchIndex = 0;
 554  0002 7b02          	ld	a,(OFST+0,sp)
 555  0004 97            	ld	xl,a
 556                     ; 190   assert_param(IS_RI_ANALOGSWITCH(RI_AnalogSwitch));
 558                     ; 191   assert_param(IS_FUNCTIONAL_STATE(NewState));
 560                     ; 194   AnalogSwitchRegister = (uint8_t) (RI_AnalogSwitch & (uint8_t) 0xF0);
 562  0005 7b03          	ld	a,(OFST+1,sp)
 563  0007 a4f0          	and	a,#240
 564  0009 6b01          	ld	(OFST-1,sp),a
 565                     ; 197   AnalogSwitchIndex = (uint8_t) (RI_AnalogSwitch & (uint8_t) 0x0F);
 567  000b 7b03          	ld	a,(OFST+1,sp)
 568  000d a40f          	and	a,#15
 569  000f 6b02          	ld	(OFST+0,sp),a
 570                     ; 199   if (NewState != DISABLE)
 572  0011 0d04          	tnz	(OFST+2,sp)
 573  0013 2730          	jreq	L142
 574                     ; 201     if (AnalogSwitchRegister == (uint8_t) 0x10)
 576  0015 7b01          	ld	a,(OFST-1,sp)
 577  0017 a110          	cp	a,#16
 578  0019 2615          	jrne	L342
 579                     ; 204       RI->ASCR1 |= (uint8_t) ((uint8_t)1 << (uint8_t) AnalogSwitchIndex);
 581  001b 7b02          	ld	a,(OFST+0,sp)
 582  001d 5f            	clrw	x
 583  001e 97            	ld	xl,a
 584  001f a601          	ld	a,#1
 585  0021 5d            	tnzw	x
 586  0022 2704          	jreq	L21
 587  0024               L41:
 588  0024 48            	sll	a
 589  0025 5a            	decw	x
 590  0026 26fc          	jrne	L41
 591  0028               L21:
 592  0028 ca543d        	or	a,21565
 593  002b c7543d        	ld	21565,a
 595  002e 2045          	jra	L742
 596  0030               L342:
 597                     ; 209       RI->ASCR2 |= (uint8_t) ((uint8_t)1 << (uint8_t) AnalogSwitchIndex);
 599  0030 7b02          	ld	a,(OFST+0,sp)
 600  0032 5f            	clrw	x
 601  0033 97            	ld	xl,a
 602  0034 a601          	ld	a,#1
 603  0036 5d            	tnzw	x
 604  0037 2704          	jreq	L61
 605  0039               L02:
 606  0039 48            	sll	a
 607  003a 5a            	decw	x
 608  003b 26fc          	jrne	L02
 609  003d               L61:
 610  003d ca543e        	or	a,21566
 611  0040 c7543e        	ld	21566,a
 612  0043 2030          	jra	L742
 613  0045               L142:
 614                     ; 214     if (AnalogSwitchRegister == (uint8_t) 0x10)
 616  0045 7b01          	ld	a,(OFST-1,sp)
 617  0047 a110          	cp	a,#16
 618  0049 2616          	jrne	L152
 619                     ; 217       RI->ASCR1 &= (uint8_t) (~(uint8_t)((uint8_t)1 <<  AnalogSwitchIndex));
 621  004b 7b02          	ld	a,(OFST+0,sp)
 622  004d 5f            	clrw	x
 623  004e 97            	ld	xl,a
 624  004f a601          	ld	a,#1
 625  0051 5d            	tnzw	x
 626  0052 2704          	jreq	L22
 627  0054               L42:
 628  0054 48            	sll	a
 629  0055 5a            	decw	x
 630  0056 26fc          	jrne	L42
 631  0058               L22:
 632  0058 43            	cpl	a
 633  0059 c4543d        	and	a,21565
 634  005c c7543d        	ld	21565,a
 636  005f 2014          	jra	L742
 637  0061               L152:
 638                     ; 222       RI->ASCR2 &= (uint8_t) (~ (uint8_t)((uint8_t)1 << AnalogSwitchIndex));
 640  0061 7b02          	ld	a,(OFST+0,sp)
 641  0063 5f            	clrw	x
 642  0064 97            	ld	xl,a
 643  0065 a601          	ld	a,#1
 644  0067 5d            	tnzw	x
 645  0068 2704          	jreq	L62
 646  006a               L03:
 647  006a 48            	sll	a
 648  006b 5a            	decw	x
 649  006c 26fc          	jrne	L03
 650  006e               L62:
 651  006e 43            	cpl	a
 652  006f c4543e        	and	a,21566
 653  0072 c7543e        	ld	21566,a
 654  0075               L742:
 655                     ; 225 }
 658  0075 5b04          	addw	sp,#4
 659  0077 81            	ret
 925                     ; 234 void SYSCFG_RIIOSwitchConfig(RI_IOSwitch_TypeDef RI_IOSwitch,
 925                     ; 235                              FunctionalState NewState)
 925                     ; 236 {
 926                     .text:	section	.text,new
 927  0000               _SYSCFG_RIIOSwitchConfig:
 929  0000 89            	pushw	x
 930  0001 89            	pushw	x
 931       00000002      OFST:	set	2
 934                     ; 237   uint8_t IOSwitchRegister, IOSwitchIndex = 0;
 936  0002 7b02          	ld	a,(OFST+0,sp)
 937  0004 97            	ld	xl,a
 938                     ; 240   assert_param(IS_RI_IOSWITCH(RI_IOSwitch));
 940                     ; 241   assert_param(IS_FUNCTIONAL_STATE(NewState));
 942                     ; 244   IOSwitchIndex = (uint8_t) (RI_IOSwitch & (uint8_t) 0x0F);
 944  0005 7b03          	ld	a,(OFST+1,sp)
 945  0007 a40f          	and	a,#15
 946  0009 6b02          	ld	(OFST+0,sp),a
 947                     ; 247   IOSwitchRegister = (uint8_t) (RI_IOSwitch & (uint8_t) 0xF0);
 949  000b 7b03          	ld	a,(OFST+1,sp)
 950  000d a4f0          	and	a,#240
 951  000f 6b01          	ld	(OFST-1,sp),a
 952                     ; 250   if (IOSwitchRegister == (uint8_t) 0x10)
 954  0011 7b01          	ld	a,(OFST-1,sp)
 955  0013 a110          	cp	a,#16
 956  0015 2633          	jrne	L304
 957                     ; 252     if (NewState != DISABLE)
 959  0017 0d04          	tnz	(OFST+2,sp)
 960  0019 2717          	jreq	L504
 961                     ; 255       RI->IOSR1 |= (uint8_t) ((uint8_t)1 << IOSwitchIndex);
 963  001b 7b02          	ld	a,(OFST+0,sp)
 964  001d 5f            	clrw	x
 965  001e 97            	ld	xl,a
 966  001f a601          	ld	a,#1
 967  0021 5d            	tnzw	x
 968  0022 2704          	jreq	L43
 969  0024               L63:
 970  0024 48            	sll	a
 971  0025 5a            	decw	x
 972  0026 26fc          	jrne	L63
 973  0028               L43:
 974  0028 ca5439        	or	a,21561
 975  002b c75439        	ld	21561,a
 977  002e ace100e1      	jpf	L114
 978  0032               L504:
 979                     ; 260       RI->IOSR1 &= (uint8_t) (~ (uint8_t)((uint8_t)1 << IOSwitchIndex));
 981  0032 7b02          	ld	a,(OFST+0,sp)
 982  0034 5f            	clrw	x
 983  0035 97            	ld	xl,a
 984  0036 a601          	ld	a,#1
 985  0038 5d            	tnzw	x
 986  0039 2704          	jreq	L04
 987  003b               L24:
 988  003b 48            	sll	a
 989  003c 5a            	decw	x
 990  003d 26fc          	jrne	L24
 991  003f               L04:
 992  003f 43            	cpl	a
 993  0040 c45439        	and	a,21561
 994  0043 c75439        	ld	21561,a
 995  0046 ace100e1      	jpf	L114
 996  004a               L304:
 997                     ; 265   else if (IOSwitchRegister == (uint8_t) 0x20)
 999  004a 7b01          	ld	a,(OFST-1,sp)
1000  004c a120          	cp	a,#32
1001  004e 262f          	jrne	L314
1002                     ; 267     if (NewState != DISABLE)
1004  0050 0d04          	tnz	(OFST+2,sp)
1005  0052 2715          	jreq	L514
1006                     ; 270       RI->IOSR2 |= (uint8_t) ((uint8_t)1 << IOSwitchIndex);
1008  0054 7b02          	ld	a,(OFST+0,sp)
1009  0056 5f            	clrw	x
1010  0057 97            	ld	xl,a
1011  0058 a601          	ld	a,#1
1012  005a 5d            	tnzw	x
1013  005b 2704          	jreq	L44
1014  005d               L64:
1015  005d 48            	sll	a
1016  005e 5a            	decw	x
1017  005f 26fc          	jrne	L64
1018  0061               L44:
1019  0061 ca543a        	or	a,21562
1020  0064 c7543a        	ld	21562,a
1022  0067 2078          	jra	L114
1023  0069               L514:
1024                     ; 275       RI->IOSR2 &= (uint8_t) (~(uint8_t)((uint8_t)1 <<  IOSwitchIndex));
1026  0069 7b02          	ld	a,(OFST+0,sp)
1027  006b 5f            	clrw	x
1028  006c 97            	ld	xl,a
1029  006d a601          	ld	a,#1
1030  006f 5d            	tnzw	x
1031  0070 2704          	jreq	L05
1032  0072               L25:
1033  0072 48            	sll	a
1034  0073 5a            	decw	x
1035  0074 26fc          	jrne	L25
1036  0076               L05:
1037  0076 43            	cpl	a
1038  0077 c4543a        	and	a,21562
1039  007a c7543a        	ld	21562,a
1040  007d 2062          	jra	L114
1041  007f               L314:
1042                     ; 280   else if (IOSwitchRegister == (uint8_t) 0x30)
1044  007f 7b01          	ld	a,(OFST-1,sp)
1045  0081 a130          	cp	a,#48
1046  0083 262f          	jrne	L324
1047                     ; 282     if (NewState != DISABLE)
1049  0085 0d04          	tnz	(OFST+2,sp)
1050  0087 2715          	jreq	L524
1051                     ; 285       RI->IOSR3 |= (uint8_t) ((uint8_t)1 << IOSwitchIndex);
1053  0089 7b02          	ld	a,(OFST+0,sp)
1054  008b 5f            	clrw	x
1055  008c 97            	ld	xl,a
1056  008d a601          	ld	a,#1
1057  008f 5d            	tnzw	x
1058  0090 2704          	jreq	L45
1059  0092               L65:
1060  0092 48            	sll	a
1061  0093 5a            	decw	x
1062  0094 26fc          	jrne	L65
1063  0096               L45:
1064  0096 ca543b        	or	a,21563
1065  0099 c7543b        	ld	21563,a
1067  009c 2043          	jra	L114
1068  009e               L524:
1069                     ; 290       RI->IOSR3 &= (uint8_t) (~ (uint8_t) ((uint8_t) 1 << IOSwitchIndex));
1071  009e 7b02          	ld	a,(OFST+0,sp)
1072  00a0 5f            	clrw	x
1073  00a1 97            	ld	xl,a
1074  00a2 a601          	ld	a,#1
1075  00a4 5d            	tnzw	x
1076  00a5 2704          	jreq	L06
1077  00a7               L26:
1078  00a7 48            	sll	a
1079  00a8 5a            	decw	x
1080  00a9 26fc          	jrne	L26
1081  00ab               L06:
1082  00ab 43            	cpl	a
1083  00ac c4543b        	and	a,21563
1084  00af c7543b        	ld	21563,a
1085  00b2 202d          	jra	L114
1086  00b4               L324:
1087                     ; 297     if (NewState != DISABLE)
1089  00b4 0d04          	tnz	(OFST+2,sp)
1090  00b6 2715          	jreq	L334
1091                     ; 300       RI->IOSR4 |= (uint8_t) ((uint8_t)1 << IOSwitchIndex);
1093  00b8 7b02          	ld	a,(OFST+0,sp)
1094  00ba 5f            	clrw	x
1095  00bb 97            	ld	xl,a
1096  00bc a601          	ld	a,#1
1097  00be 5d            	tnzw	x
1098  00bf 2704          	jreq	L46
1099  00c1               L66:
1100  00c1 48            	sll	a
1101  00c2 5a            	decw	x
1102  00c3 26fc          	jrne	L66
1103  00c5               L46:
1104  00c5 ca5457        	or	a,21591
1105  00c8 c75457        	ld	21591,a
1107  00cb 2014          	jra	L114
1108  00cd               L334:
1109                     ; 305       RI->IOSR4 &= (uint8_t) (~ (uint8_t) ((uint8_t) 1 << IOSwitchIndex));
1111  00cd 7b02          	ld	a,(OFST+0,sp)
1112  00cf 5f            	clrw	x
1113  00d0 97            	ld	xl,a
1114  00d1 a601          	ld	a,#1
1115  00d3 5d            	tnzw	x
1116  00d4 2704          	jreq	L07
1117  00d6               L27:
1118  00d6 48            	sll	a
1119  00d7 5a            	decw	x
1120  00d8 26fc          	jrne	L27
1121  00da               L07:
1122  00da 43            	cpl	a
1123  00db c45457        	and	a,21591
1124  00de c75457        	ld	21591,a
1125  00e1               L114:
1126                     ; 308 }
1129  00e1 5b04          	addw	sp,#4
1130  00e3 81            	ret
1210                     ; 320 void SYSCFG_RIResistorConfig(RI_Resistor_TypeDef RI_Resistor, FunctionalState NewState)
1210                     ; 321 {
1211                     .text:	section	.text,new
1212  0000               _SYSCFG_RIResistorConfig:
1214  0000 89            	pushw	x
1215       00000000      OFST:	set	0
1218                     ; 323   assert_param(IS_RI_RESISTOR(RI_Resistor));
1220                     ; 324   assert_param(IS_FUNCTIONAL_STATE(NewState));
1222                     ; 326   if (NewState != DISABLE)
1224  0001 9f            	ld	a,xl
1225  0002 4d            	tnz	a
1226  0003 2709          	jreq	L574
1227                     ; 329     RI->RCR |= (uint8_t) RI_Resistor;
1229  0005 9e            	ld	a,xh
1230  0006 ca543f        	or	a,21567
1231  0009 c7543f        	ld	21567,a
1233  000c 2009          	jra	L774
1234  000e               L574:
1235                     ; 334     RI->RCR &= (uint8_t) (~RI_Resistor);
1237  000e 7b01          	ld	a,(OFST+1,sp)
1238  0010 43            	cpl	a
1239  0011 c4543f        	and	a,21567
1240  0014 c7543f        	ld	21567,a
1241  0017               L774:
1242                     ; 336 }
1245  0017 85            	popw	x
1246  0018 81            	ret
1269                     ; 368 void SYSCFG_REMAPDeInit(void)
1269                     ; 369 {
1270                     .text:	section	.text,new
1271  0000               _SYSCFG_REMAPDeInit:
1275                     ; 371   SYSCFG->RMPCR1 = SYSCFG_RMPCR1_RESET_VALUE;
1277  0000 350c509e      	mov	20638,#12
1278                     ; 374   SYSCFG->RMPCR2 = SYSCFG_RMPCR2_RESET_VALUE;
1280  0004 725f509f      	clr	20639
1281                     ; 377   SYSCFG->RMPCR3 = SYSCFG_RMPCR3_RESET_VALUE;
1283  0008 725f509d      	clr	20637
1284                     ; 378 }
1287  000c 81            	ret
1505                     ; 411 void SYSCFG_REMAPPinConfig(REMAP_Pin_TypeDef REMAP_Pin, FunctionalState NewState)
1505                     ; 412 {
1506                     .text:	section	.text,new
1507  0000               _SYSCFG_REMAPPinConfig:
1509  0000 89            	pushw	x
1510  0001 88            	push	a
1511       00000001      OFST:	set	1
1514                     ; 413   uint8_t regindex = 0;
1516  0002 0f01          	clr	(OFST+0,sp)
1517                     ; 415   assert_param(IS_REMAP_PIN(REMAP_Pin));
1519                     ; 416   assert_param(IS_FUNCTIONAL_STATE(NewState));
1521                     ; 419   regindex = (uint8_t) ((uint16_t) REMAP_Pin >> 8);
1523  0004 9e            	ld	a,xh
1524  0005 6b01          	ld	(OFST+0,sp),a
1525                     ; 422   if (regindex == 0x01)
1527  0007 7b01          	ld	a,(OFST+0,sp)
1528  0009 a101          	cp	a,#1
1529  000b 261e          	jrne	L316
1530                     ; 424     SYSCFG->RMPCR1 &= (uint8_t)((uint8_t)((uint8_t)REMAP_Pin << 4) | (uint8_t)0x0F);
1532  000d 9f            	ld	a,xl
1533  000e 97            	ld	xl,a
1534  000f a610          	ld	a,#16
1535  0011 42            	mul	x,a
1536  0012 9f            	ld	a,xl
1537  0013 aa0f          	or	a,#15
1538  0015 c4509e        	and	a,20638
1539  0018 c7509e        	ld	20638,a
1540                     ; 425     if (NewState != DISABLE)
1542  001b 0d06          	tnz	(OFST+5,sp)
1543  001d 2742          	jreq	L716
1544                     ; 427       SYSCFG->RMPCR1 |= (uint8_t)((uint16_t)REMAP_Pin & (uint16_t)0x00F0);
1546  001f 7b03          	ld	a,(OFST+2,sp)
1547  0021 a4f0          	and	a,#240
1548  0023 ca509e        	or	a,20638
1549  0026 c7509e        	ld	20638,a
1550  0029 2036          	jra	L716
1551  002b               L316:
1552                     ; 431   else if (regindex == 0x02)
1554  002b 7b01          	ld	a,(OFST+0,sp)
1555  002d a102          	cp	a,#2
1556  002f 2619          	jrne	L126
1557                     ; 433     if (NewState != DISABLE)
1559  0031 0d06          	tnz	(OFST+5,sp)
1560  0033 270a          	jreq	L326
1561                     ; 435       SYSCFG->RMPCR2 |= (uint8_t) REMAP_Pin;
1563  0035 c6509f        	ld	a,20639
1564  0038 1a03          	or	a,(OFST+2,sp)
1565  003a c7509f        	ld	20639,a
1567  003d 2022          	jra	L716
1568  003f               L326:
1569                     ; 439       SYSCFG->RMPCR2 &= (uint8_t)((uint16_t)(~(uint16_t)REMAP_Pin));
1571  003f 7b03          	ld	a,(OFST+2,sp)
1572  0041 43            	cpl	a
1573  0042 c4509f        	and	a,20639
1574  0045 c7509f        	ld	20639,a
1575  0048 2017          	jra	L716
1576  004a               L126:
1577                     ; 445     if (NewState != DISABLE)
1579  004a 0d06          	tnz	(OFST+5,sp)
1580  004c 270a          	jreq	L136
1581                     ; 447       SYSCFG->RMPCR3 |= (uint8_t) REMAP_Pin;
1583  004e c6509d        	ld	a,20637
1584  0051 1a03          	or	a,(OFST+2,sp)
1585  0053 c7509d        	ld	20637,a
1587  0056 2009          	jra	L716
1588  0058               L136:
1589                     ; 451       SYSCFG->RMPCR3 &= (uint8_t)((uint16_t)(~(uint16_t)REMAP_Pin));
1591  0058 7b03          	ld	a,(OFST+2,sp)
1592  005a 43            	cpl	a
1593  005b c4509d        	and	a,20637
1594  005e c7509d        	ld	20637,a
1595  0061               L716:
1596                     ; 454 }
1599  0061 5b03          	addw	sp,#3
1600  0063 81            	ret
1706                     ; 470 void SYSCFG_REMAPDMAChannelConfig(REMAP_DMAChannel_TypeDef REMAP_DMAChannel)
1706                     ; 471 {
1707                     .text:	section	.text,new
1708  0000               _SYSCFG_REMAPDMAChannelConfig:
1710  0000 88            	push	a
1711       00000000      OFST:	set	0
1714                     ; 473   assert_param(IS_REMAP_DMACHANNEL(REMAP_DMAChannel));
1716                     ; 476   if ((REMAP_DMAChannel & 0xF0) != RESET)
1718  0001 a5f0          	bcp	a,#240
1719  0003 270a          	jreq	L776
1720                     ; 479     SYSCFG->RMPCR1 &= (uint8_t) (~SYSCFG_RMPCR1_TIM4DMA_REMAP);
1722  0005 c6509e        	ld	a,20638
1723  0008 a4f3          	and	a,#243
1724  000a c7509e        	ld	20638,a
1726  000d 2008          	jra	L107
1727  000f               L776:
1728                     ; 485     SYSCFG->RMPCR1 &= (uint8_t) (~SYSCFG_RMPCR1_ADC1DMA_REMAP);
1730  000f c6509e        	ld	a,20638
1731  0012 a4fc          	and	a,#252
1732  0014 c7509e        	ld	20638,a
1733  0017               L107:
1734                     ; 488   SYSCFG->RMPCR1 |= (uint8_t) ((uint8_t)0x0F & REMAP_DMAChannel);
1736  0017 7b01          	ld	a,(OFST+1,sp)
1737  0019 a40f          	and	a,#15
1738  001b ca509e        	or	a,20638
1739  001e c7509e        	ld	20638,a
1740                     ; 489 }
1743  0021 84            	pop	a
1744  0022 81            	ret
1757                     	xdef	_SYSCFG_REMAPDMAChannelConfig
1758                     	xdef	_SYSCFG_REMAPPinConfig
1759                     	xdef	_SYSCFG_REMAPDeInit
1760                     	xdef	_SYSCFG_RIResistorConfig
1761                     	xdef	_SYSCFG_RIIOSwitchConfig
1762                     	xdef	_SYSCFG_RIAnalogSwitchConfig
1763                     	xdef	_SYSCFG_RITIMInputCaptureConfig
1764                     	xdef	_SYSCFG_RIDeInit
1783                     	end
