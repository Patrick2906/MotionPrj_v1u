   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 168 void TIM2_DeInit(void)
  32                     ; 169 {
  34                     .text:	section	.text,new
  35  0000               _TIM2_DeInit:
  39                     ; 170   TIM2->CR1 = TIM_CR1_RESET_VALUE;
  41  0000 725f5250      	clr	21072
  42                     ; 171   TIM2->CR2 = TIM_CR2_RESET_VALUE;
  44  0004 725f5251      	clr	21073
  45                     ; 172   TIM2->SMCR = TIM_SMCR_RESET_VALUE;
  47  0008 725f5252      	clr	21074
  48                     ; 173   TIM2->ETR = TIM_ETR_RESET_VALUE;
  50  000c 725f5253      	clr	21075
  51                     ; 174   TIM2->IER = TIM_IER_RESET_VALUE;
  53  0010 725f5255      	clr	21077
  54                     ; 175   TIM2->SR2 = TIM_SR2_RESET_VALUE;
  56  0014 725f5257      	clr	21079
  57                     ; 178   TIM2->CCER1 = TIM_CCER1_RESET_VALUE;
  59  0018 725f525b      	clr	21083
  60                     ; 180   TIM2->CCMR1 = 0x01;/*TIM2_ICxSource_TIxFPx */
  62  001c 35015259      	mov	21081,#1
  63                     ; 181   TIM2->CCMR2 = 0x01;/*TIM2_ICxSource_TIxFPx */
  65  0020 3501525a      	mov	21082,#1
  66                     ; 184   TIM2->CCER1 = TIM_CCER1_RESET_VALUE;
  68  0024 725f525b      	clr	21083
  69                     ; 185   TIM2->CCMR1 = TIM_CCMR1_RESET_VALUE;
  71  0028 725f5259      	clr	21081
  72                     ; 186   TIM2->CCMR2 = TIM_CCMR2_RESET_VALUE;
  74  002c 725f525a      	clr	21082
  75                     ; 188   TIM2->CNTRH = TIM_CNTRH_RESET_VALUE;
  77  0030 725f525c      	clr	21084
  78                     ; 189   TIM2->CNTRL = TIM_CNTRL_RESET_VALUE;
  80  0034 725f525d      	clr	21085
  81                     ; 191   TIM2->PSCR = TIM_PSCR_RESET_VALUE;
  83  0038 725f525e      	clr	21086
  84                     ; 193   TIM2->ARRH = TIM_ARRH_RESET_VALUE;
  86  003c 35ff525f      	mov	21087,#255
  87                     ; 194   TIM2->ARRL = TIM_ARRL_RESET_VALUE;
  89  0040 35ff5260      	mov	21088,#255
  90                     ; 196   TIM2->CCR1H = TIM_CCR1H_RESET_VALUE;
  92  0044 725f5261      	clr	21089
  93                     ; 197   TIM2->CCR1L = TIM_CCR1L_RESET_VALUE;
  95  0048 725f5262      	clr	21090
  96                     ; 198   TIM2->CCR2H = TIM_CCR2H_RESET_VALUE;
  98  004c 725f5263      	clr	21091
  99                     ; 199   TIM2->CCR2L = TIM_CCR2L_RESET_VALUE;
 101  0050 725f5264      	clr	21092
 102                     ; 202   TIM2->OISR = TIM_OISR_RESET_VALUE;
 104  0054 725f5266      	clr	21094
 105                     ; 203   TIM2->EGR = 0x01;/* TIM_EGR_UG */
 107  0058 35015258      	mov	21080,#1
 108                     ; 204   TIM2->BKR = TIM_BKR_RESET_VALUE;
 110  005c 725f5265      	clr	21093
 111                     ; 205   TIM2->SR1 = TIM_SR1_RESET_VALUE;
 113  0060 725f5256      	clr	21078
 114                     ; 206 }
 117  0064 81            	ret
 279                     ; 231 void TIM2_TimeBaseInit(TIM2_Prescaler_TypeDef TIM2_Prescaler,
 279                     ; 232                        TIM2_CounterMode_TypeDef TIM2_CounterMode,
 279                     ; 233                        uint16_t TIM2_Period)
 279                     ; 234 {
 280                     .text:	section	.text,new
 281  0000               _TIM2_TimeBaseInit:
 283  0000 89            	pushw	x
 284       00000000      OFST:	set	0
 287                     ; 236   assert_param(IS_TIM2_PRESCALER(TIM2_Prescaler));
 289                     ; 237   assert_param(IS_TIM2_COUNTER_MODE(TIM2_CounterMode));
 291                     ; 242   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8) ;
 293  0001 7b05          	ld	a,(OFST+5,sp)
 294  0003 c7525f        	ld	21087,a
 295                     ; 243   TIM2->ARRL = (uint8_t)(TIM2_Period);
 297  0006 7b06          	ld	a,(OFST+6,sp)
 298  0008 c75260        	ld	21088,a
 299                     ; 246   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 301  000b 9e            	ld	a,xh
 302  000c c7525e        	ld	21086,a
 303                     ; 249   TIM2->CR1 &= (uint8_t)((uint8_t)(~TIM_CR1_CMS)) & ((uint8_t)(~TIM_CR1_DIR));
 305  000f c65250        	ld	a,21072
 306  0012 a48f          	and	a,#143
 307  0014 c75250        	ld	21072,a
 308                     ; 250   TIM2->CR1 |= (uint8_t)(TIM2_CounterMode);
 310  0017 9f            	ld	a,xl
 311  0018 ca5250        	or	a,21072
 312  001b c75250        	ld	21072,a
 313                     ; 253   TIM2->EGR = TIM2_EventSource_Update;
 315  001e 35015258      	mov	21080,#1
 316                     ; 254 }
 319  0022 85            	popw	x
 320  0023 81            	ret
 388                     ; 274 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
 388                     ; 275                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
 388                     ; 276 {
 389                     .text:	section	.text,new
 390  0000               _TIM2_PrescalerConfig:
 394                     ; 278   assert_param(IS_TIM2_PRESCALER(Prescaler));
 396                     ; 279   assert_param(IS_TIM2_PRESCALER_RELOAD(TIM2_PSCReloadMode));
 398                     ; 282   TIM2->PSCR = (uint8_t)(Prescaler);
 400  0000 9e            	ld	a,xh
 401  0001 c7525e        	ld	21086,a
 402                     ; 285   if (TIM2_PSCReloadMode == TIM2_PSCReloadMode_Immediate)
 404  0004 9f            	ld	a,xl
 405  0005 a101          	cp	a,#1
 406  0007 2606          	jrne	L741
 407                     ; 287     TIM2->EGR |= TIM_EGR_UG ;
 409  0009 72105258      	bset	21080,#0
 411  000d 2004          	jra	L151
 412  000f               L741:
 413                     ; 291     TIM2->EGR &= (uint8_t)(~TIM_EGR_UG) ;
 415  000f 72115258      	bres	21080,#0
 416  0013               L151:
 417                     ; 293 }
 420  0013 81            	ret
 465                     ; 306 void TIM2_CounterModeConfig(TIM2_CounterMode_TypeDef TIM2_CounterMode)
 465                     ; 307 {
 466                     .text:	section	.text,new
 467  0000               _TIM2_CounterModeConfig:
 469  0000 88            	push	a
 470  0001 88            	push	a
 471       00000001      OFST:	set	1
 474                     ; 308   uint8_t tmpcr1 = 0;
 476  0002 0f01          	clr	(OFST+0,sp)
 477                     ; 311   assert_param(IS_TIM2_COUNTER_MODE(TIM2_CounterMode));
 479                     ; 313   tmpcr1 = TIM2->CR1;
 481  0004 c65250        	ld	a,21072
 482  0007 6b01          	ld	(OFST+0,sp),a
 483                     ; 316   tmpcr1 &= (uint8_t)((uint8_t)(~TIM_CR1_CMS) & (uint8_t)(~TIM_CR1_DIR));
 485  0009 7b01          	ld	a,(OFST+0,sp)
 486  000b a48f          	and	a,#143
 487  000d 6b01          	ld	(OFST+0,sp),a
 488                     ; 319   tmpcr1 |= (uint8_t)TIM2_CounterMode;
 490  000f 7b01          	ld	a,(OFST+0,sp)
 491  0011 1a02          	or	a,(OFST+1,sp)
 492  0013 6b01          	ld	(OFST+0,sp),a
 493                     ; 321   TIM2->CR1 = tmpcr1;
 495  0015 7b01          	ld	a,(OFST+0,sp)
 496  0017 c75250        	ld	21072,a
 497                     ; 322 }
 500  001a 85            	popw	x
 501  001b 81            	ret
 535                     ; 330 void TIM2_SetCounter(uint16_t Counter)
 535                     ; 331 {
 536                     .text:	section	.text,new
 537  0000               _TIM2_SetCounter:
 541                     ; 334   TIM2->CNTRH = (uint8_t)(Counter >> 8);
 543  0000 9e            	ld	a,xh
 544  0001 c7525c        	ld	21084,a
 545                     ; 335   TIM2->CNTRL = (uint8_t)(Counter);
 547  0004 9f            	ld	a,xl
 548  0005 c7525d        	ld	21085,a
 549                     ; 336 }
 552  0008 81            	ret
 586                     ; 344 void TIM2_SetAutoreload(uint16_t Autoreload)
 586                     ; 345 {
 587                     .text:	section	.text,new
 588  0000               _TIM2_SetAutoreload:
 592                     ; 347   TIM2->ARRH = (uint8_t)(Autoreload >> 8);
 594  0000 9e            	ld	a,xh
 595  0001 c7525f        	ld	21087,a
 596                     ; 348   TIM2->ARRL = (uint8_t)(Autoreload);
 598  0004 9f            	ld	a,xl
 599  0005 c75260        	ld	21088,a
 600                     ; 349 }
 603  0008 81            	ret
 655                     ; 356 uint16_t TIM2_GetCounter(void)
 655                     ; 357 {
 656                     .text:	section	.text,new
 657  0000               _TIM2_GetCounter:
 659  0000 5204          	subw	sp,#4
 660       00000004      OFST:	set	4
 663                     ; 358   uint16_t tmpcnt = 0;
 665  0002 1e03          	ldw	x,(OFST-1,sp)
 666                     ; 361   tmpcntrh = TIM2->CNTRH;
 668  0004 c6525c        	ld	a,21084
 669  0007 6b02          	ld	(OFST-2,sp),a
 670                     ; 362   tmpcntrl = TIM2->CNTRL;
 672  0009 c6525d        	ld	a,21085
 673  000c 6b01          	ld	(OFST-3,sp),a
 674                     ; 364   tmpcnt = (uint16_t)(tmpcntrl);
 676  000e 7b01          	ld	a,(OFST-3,sp)
 677  0010 5f            	clrw	x
 678  0011 97            	ld	xl,a
 679  0012 1f03          	ldw	(OFST-1,sp),x
 680                     ; 365   tmpcnt |= (uint16_t)((uint16_t)tmpcntrh << 8);
 682  0014 7b02          	ld	a,(OFST-2,sp)
 683  0016 5f            	clrw	x
 684  0017 97            	ld	xl,a
 685  0018 4f            	clr	a
 686  0019 02            	rlwa	x,a
 687  001a 01            	rrwa	x,a
 688  001b 1a04          	or	a,(OFST+0,sp)
 689  001d 01            	rrwa	x,a
 690  001e 1a03          	or	a,(OFST-1,sp)
 691  0020 01            	rrwa	x,a
 692  0021 1f03          	ldw	(OFST-1,sp),x
 693                     ; 367   return ((uint16_t)tmpcnt);
 695  0023 1e03          	ldw	x,(OFST-1,sp)
 698  0025 5b04          	addw	sp,#4
 699  0027 81            	ret
 723                     ; 383 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
 723                     ; 384 {
 724                     .text:	section	.text,new
 725  0000               _TIM2_GetPrescaler:
 729                     ; 386   return ((TIM2_Prescaler_TypeDef)TIM2->PSCR);
 731  0000 c6525e        	ld	a,21086
 734  0003 81            	ret
 790                     ; 396 void TIM2_UpdateDisableConfig(FunctionalState NewState)
 790                     ; 397 {
 791                     .text:	section	.text,new
 792  0000               _TIM2_UpdateDisableConfig:
 796                     ; 399   assert_param(IS_FUNCTIONAL_STATE(NewState));
 798                     ; 402   if (NewState != DISABLE)
 800  0000 4d            	tnz	a
 801  0001 2706          	jreq	L513
 802                     ; 404     TIM2->CR1 |= TIM_CR1_UDIS;
 804  0003 72125250      	bset	21072,#1
 806  0007 2004          	jra	L713
 807  0009               L513:
 808                     ; 408     TIM2->CR1 &= (uint8_t)(~TIM_CR1_UDIS);
 810  0009 72135250      	bres	21072,#1
 811  000d               L713:
 812                     ; 410 }
 815  000d 81            	ret
 873                     ; 420 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
 873                     ; 421 {
 874                     .text:	section	.text,new
 875  0000               _TIM2_UpdateRequestConfig:
 879                     ; 423   assert_param(IS_TIM2_UPDATE_SOURCE(TIM2_UpdateSource));
 881                     ; 426   if (TIM2_UpdateSource == TIM2_UpdateSource_Regular)
 883  0000 a101          	cp	a,#1
 884  0002 2606          	jrne	L743
 885                     ; 428     TIM2->CR1 |= TIM_CR1_URS ;
 887  0004 72145250      	bset	21072,#2
 889  0008 2004          	jra	L153
 890  000a               L743:
 891                     ; 432     TIM2->CR1 &= (uint8_t)(~TIM_CR1_URS);
 893  000a 72155250      	bres	21072,#2
 894  000e               L153:
 895                     ; 434 }
 898  000e 81            	ret
 934                     ; 442 void TIM2_ARRPreloadConfig(FunctionalState NewState)
 934                     ; 443 {
 935                     .text:	section	.text,new
 936  0000               _TIM2_ARRPreloadConfig:
 940                     ; 445   assert_param(IS_FUNCTIONAL_STATE(NewState));
 942                     ; 448   if (NewState != DISABLE)
 944  0000 4d            	tnz	a
 945  0001 2706          	jreq	L173
 946                     ; 450     TIM2->CR1 |= TIM_CR1_ARPE;
 948  0003 721e5250      	bset	21072,#7
 950  0007 2004          	jra	L373
 951  0009               L173:
 952                     ; 454     TIM2->CR1 &= (uint8_t)(~TIM_CR1_ARPE);
 954  0009 721f5250      	bres	21072,#7
 955  000d               L373:
 956                     ; 456 }
 959  000d 81            	ret
1016                     ; 466 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1016                     ; 467 {
1017                     .text:	section	.text,new
1018  0000               _TIM2_SelectOnePulseMode:
1022                     ; 469   assert_param(IS_TIM2_OPM_MODE(TIM2_OPMode));
1024                     ; 472   if (TIM2_OPMode == TIM2_OPMode_Single)
1026  0000 a101          	cp	a,#1
1027  0002 2606          	jrne	L324
1028                     ; 474     TIM2->CR1 |= TIM_CR1_OPM ;
1030  0004 72165250      	bset	21072,#3
1032  0008 2004          	jra	L524
1033  000a               L324:
1034                     ; 478     TIM2->CR1 &= (uint8_t)(~TIM_CR1_OPM);
1036  000a 72175250      	bres	21072,#3
1037  000e               L524:
1038                     ; 480 }
1041  000e 81            	ret
1076                     ; 488 void TIM2_Cmd(FunctionalState NewState)
1076                     ; 489 {
1077                     .text:	section	.text,new
1078  0000               _TIM2_Cmd:
1082                     ; 491   assert_param(IS_FUNCTIONAL_STATE(NewState));
1084                     ; 494   if (NewState != DISABLE)
1086  0000 4d            	tnz	a
1087  0001 2706          	jreq	L544
1088                     ; 496     TIM2->CR1 |= TIM_CR1_CEN;
1090  0003 72105250      	bset	21072,#0
1092  0007 2004          	jra	L744
1093  0009               L544:
1094                     ; 500     TIM2->CR1 &= (uint8_t)(~TIM_CR1_CEN);
1096  0009 72115250      	bres	21072,#0
1097  000d               L744:
1098                     ; 502 }
1101  000d 81            	ret
1299                     ; 578 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
1299                     ; 579                   TIM2_OutputState_TypeDef TIM2_OutputState,
1299                     ; 580                   uint16_t TIM2_Pulse,
1299                     ; 581                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity,
1299                     ; 582                   TIM2_OCIdleState_TypeDef TIM2_OCIdleState)
1299                     ; 583 {
1300                     .text:	section	.text,new
1301  0000               _TIM2_OC1Init:
1303  0000 89            	pushw	x
1304  0001 88            	push	a
1305       00000001      OFST:	set	1
1308                     ; 584   uint8_t tmpccmr1 = 0;
1310  0002 0f01          	clr	(OFST+0,sp)
1311                     ; 587   assert_param(IS_TIM2_OC_MODE(TIM2_OCMode));
1313                     ; 588   assert_param(IS_TIM2_OUTPUT_STATE(TIM2_OutputState));
1315                     ; 589   assert_param(IS_TIM2_OC_POLARITY(TIM2_OCPolarity));
1317                     ; 590   assert_param(IS_TIM2_OCIDLE_STATE(TIM2_OCIdleState));
1319                     ; 592   tmpccmr1 = TIM2->CCMR1;
1321  0004 c65259        	ld	a,21081
1322  0007 6b01          	ld	(OFST+0,sp),a
1323                     ; 595   TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1E);
1325  0009 7211525b      	bres	21083,#0
1326                     ; 597   tmpccmr1 &= (uint8_t)(~TIM_CCMR_OCM);
1328  000d 7b01          	ld	a,(OFST+0,sp)
1329  000f a48f          	and	a,#143
1330  0011 6b01          	ld	(OFST+0,sp),a
1331                     ; 600   tmpccmr1 |= (uint8_t)TIM2_OCMode;
1333  0013 9e            	ld	a,xh
1334  0014 1a01          	or	a,(OFST+0,sp)
1335  0016 6b01          	ld	(OFST+0,sp),a
1336                     ; 602   TIM2->CCMR1 = tmpccmr1;
1338  0018 7b01          	ld	a,(OFST+0,sp)
1339  001a c75259        	ld	21081,a
1340                     ; 605   if (TIM2_OutputState == TIM2_OutputState_Enable)
1342  001d 9f            	ld	a,xl
1343  001e a101          	cp	a,#1
1344  0020 2606          	jrne	L365
1345                     ; 607     TIM2->CCER1 |= TIM_CCER1_CC1E;
1347  0022 7210525b      	bset	21083,#0
1349  0026 2004          	jra	L565
1350  0028               L365:
1351                     ; 611     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1E);
1353  0028 7211525b      	bres	21083,#0
1354  002c               L565:
1355                     ; 615   if (TIM2_OCPolarity == TIM2_OCPolarity_Low)
1357  002c 7b08          	ld	a,(OFST+7,sp)
1358  002e a101          	cp	a,#1
1359  0030 2606          	jrne	L765
1360                     ; 617     TIM2->CCER1 |= TIM_CCER1_CC1P;
1362  0032 7212525b      	bset	21083,#1
1364  0036 2004          	jra	L175
1365  0038               L765:
1366                     ; 621     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1P);
1368  0038 7213525b      	bres	21083,#1
1369  003c               L175:
1370                     ; 625   if (TIM2_OCIdleState == TIM2_OCIdleState_Set)
1372  003c 7b09          	ld	a,(OFST+8,sp)
1373  003e a101          	cp	a,#1
1374  0040 2606          	jrne	L375
1375                     ; 627     TIM2->OISR |= TIM_OISR_OIS1;
1377  0042 72105266      	bset	21094,#0
1379  0046 2004          	jra	L575
1380  0048               L375:
1381                     ; 631     TIM2->OISR &= (uint8_t)(~TIM_OISR_OIS1);
1383  0048 72115266      	bres	21094,#0
1384  004c               L575:
1385                     ; 635   TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
1387  004c 7b06          	ld	a,(OFST+5,sp)
1388  004e c75261        	ld	21089,a
1389                     ; 636   TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
1391  0051 7b07          	ld	a,(OFST+6,sp)
1392  0053 c75262        	ld	21090,a
1393                     ; 637 }
1396  0056 5b03          	addw	sp,#3
1397  0058 81            	ret
1480                     ; 664 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
1480                     ; 665                   TIM2_OutputState_TypeDef TIM2_OutputState,
1480                     ; 666                   uint16_t TIM2_Pulse,
1480                     ; 667                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity,
1480                     ; 668                   TIM2_OCIdleState_TypeDef TIM2_OCIdleState)
1480                     ; 669 {
1481                     .text:	section	.text,new
1482  0000               _TIM2_OC2Init:
1484  0000 89            	pushw	x
1485  0001 88            	push	a
1486       00000001      OFST:	set	1
1489                     ; 670   uint8_t tmpccmr2 = 0;
1491  0002 0f01          	clr	(OFST+0,sp)
1492                     ; 673   assert_param(IS_TIM2_OC_MODE(TIM2_OCMode));
1494                     ; 674   assert_param(IS_TIM2_OUTPUT_STATE(TIM2_OutputState));
1496                     ; 675   assert_param(IS_TIM2_OC_POLARITY(TIM2_OCPolarity));
1498                     ; 676   assert_param(IS_TIM2_OCIDLE_STATE(TIM2_OCIdleState));
1500                     ; 678   tmpccmr2 = TIM2->CCMR2;
1502  0004 c6525a        	ld	a,21082
1503  0007 6b01          	ld	(OFST+0,sp),a
1504                     ; 681   TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2E);
1506  0009 7219525b      	bres	21083,#4
1507                     ; 684   tmpccmr2 &= (uint8_t)(~TIM_CCMR_OCM);
1509  000d 7b01          	ld	a,(OFST+0,sp)
1510  000f a48f          	and	a,#143
1511  0011 6b01          	ld	(OFST+0,sp),a
1512                     ; 687   tmpccmr2 |= (uint8_t)TIM2_OCMode;
1514  0013 9e            	ld	a,xh
1515  0014 1a01          	or	a,(OFST+0,sp)
1516  0016 6b01          	ld	(OFST+0,sp),a
1517                     ; 689   TIM2->CCMR2 = tmpccmr2;
1519  0018 7b01          	ld	a,(OFST+0,sp)
1520  001a c7525a        	ld	21082,a
1521                     ; 692   if (TIM2_OutputState == TIM2_OutputState_Enable)
1523  001d 9f            	ld	a,xl
1524  001e a101          	cp	a,#1
1525  0020 2606          	jrne	L146
1526                     ; 694     TIM2->CCER1 |= TIM_CCER1_CC2E;
1528  0022 7218525b      	bset	21083,#4
1530  0026 2004          	jra	L346
1531  0028               L146:
1532                     ; 698     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2E);
1534  0028 7219525b      	bres	21083,#4
1535  002c               L346:
1536                     ; 702   if (TIM2_OCPolarity == TIM2_OCPolarity_Low)
1538  002c 7b08          	ld	a,(OFST+7,sp)
1539  002e a101          	cp	a,#1
1540  0030 2606          	jrne	L546
1541                     ; 704     TIM2->CCER1 |= TIM_CCER1_CC2P;
1543  0032 721a525b      	bset	21083,#5
1545  0036 2004          	jra	L746
1546  0038               L546:
1547                     ; 708     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2P);
1549  0038 721b525b      	bres	21083,#5
1550  003c               L746:
1551                     ; 713   if (TIM2_OCIdleState == TIM2_OCIdleState_Set)
1553  003c 7b09          	ld	a,(OFST+8,sp)
1554  003e a101          	cp	a,#1
1555  0040 2606          	jrne	L156
1556                     ; 715     TIM2->OISR |= TIM_OISR_OIS2;
1558  0042 72145266      	bset	21094,#2
1560  0046 2004          	jra	L356
1561  0048               L156:
1562                     ; 719     TIM2->OISR &= (uint8_t)(~TIM_OISR_OIS2);
1564  0048 72155266      	bres	21094,#2
1565  004c               L356:
1566                     ; 723   TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
1568  004c 7b06          	ld	a,(OFST+5,sp)
1569  004e c75263        	ld	21091,a
1570                     ; 724   TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
1572  0051 7b07          	ld	a,(OFST+6,sp)
1573  0053 c75264        	ld	21092,a
1574                     ; 725 }
1577  0056 5b03          	addw	sp,#3
1578  0058 81            	ret
1776                     ; 754 void TIM2_BKRConfig(TIM2_OSSIState_TypeDef TIM2_OSSIState,
1776                     ; 755                     TIM2_LockLevel_TypeDef TIM2_LockLevel,
1776                     ; 756                     TIM2_BreakState_TypeDef TIM2_BreakState,
1776                     ; 757                     TIM2_BreakPolarity_TypeDef TIM2_BreakPolarity,
1776                     ; 758                     TIM2_AutomaticOutput_TypeDef TIM2_AutomaticOutput)
1776                     ; 759 
1776                     ; 760 {
1777                     .text:	section	.text,new
1778  0000               _TIM2_BKRConfig:
1780  0000 89            	pushw	x
1781  0001 88            	push	a
1782       00000001      OFST:	set	1
1785                     ; 762   assert_param(IS_TIM2_OSSI_STATE(TIM2_OSSIState));
1787                     ; 763   assert_param(IS_TIM2_LOCK_LEVEL(TIM2_LockLevel));
1789                     ; 764   assert_param(IS_TIM2_BREAK_STATE(TIM2_BreakState));
1791                     ; 765   assert_param(IS_TIM2_BREAK_POLARITY(TIM2_BreakPolarity));
1793                     ; 766   assert_param(IS_TIM2_AUTOMATIC_OUTPUT_STATE(TIM2_AutomaticOutput));
1795                     ; 772   TIM2->BKR = (uint8_t)((uint8_t)((uint8_t)((uint8_t)((uint8_t)TIM2_OSSIState | (uint8_t)TIM2_LockLevel) | \
1795                     ; 773                                   (uint8_t)((uint8_t)TIM2_BreakState | (uint8_t)TIM2_BreakPolarity)) | \
1795                     ; 774                                   TIM2_AutomaticOutput));
1797  0002 7b06          	ld	a,(OFST+5,sp)
1798  0004 1a07          	or	a,(OFST+6,sp)
1799  0006 6b01          	ld	(OFST+0,sp),a
1800  0008 9f            	ld	a,xl
1801  0009 1a02          	or	a,(OFST+1,sp)
1802  000b 1a01          	or	a,(OFST+0,sp)
1803  000d 1a08          	or	a,(OFST+7,sp)
1804  000f c75265        	ld	21093,a
1805                     ; 775 }
1808  0012 5b03          	addw	sp,#3
1809  0014 81            	ret
1845                     ; 783 void TIM2_CtrlPWMOutputs(FunctionalState NewState)
1845                     ; 784 {
1846                     .text:	section	.text,new
1847  0000               _TIM2_CtrlPWMOutputs:
1851                     ; 786   assert_param(IS_FUNCTIONAL_STATE(NewState));
1853                     ; 790   if (NewState != DISABLE)
1855  0000 4d            	tnz	a
1856  0001 2706          	jreq	L5001
1857                     ; 792     TIM2->BKR |= TIM_BKR_MOE ;
1859  0003 721e5265      	bset	21093,#7
1861  0007 2004          	jra	L7001
1862  0009               L5001:
1863                     ; 796     TIM2->BKR &= (uint8_t)(~TIM_BKR_MOE) ;
1865  0009 721f5265      	bres	21093,#7
1866  000d               L7001:
1867                     ; 798 }
1870  000d 81            	ret
1935                     ; 818 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel,
1935                     ; 819                      TIM2_OCMode_TypeDef TIM2_OCMode)
1935                     ; 820 {
1936                     .text:	section	.text,new
1937  0000               _TIM2_SelectOCxM:
1939  0000 89            	pushw	x
1940       00000000      OFST:	set	0
1943                     ; 822   assert_param(IS_TIM2_CHANNEL(TIM2_Channel));
1945                     ; 823   assert_param(IS_TIM2_OCM(TIM2_OCMode));
1947                     ; 825   if (TIM2_Channel == TIM2_Channel_1)
1949  0001 9e            	ld	a,xh
1950  0002 4d            	tnz	a
1951  0003 2615          	jrne	L3401
1952                     ; 828     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1E);
1954  0005 7211525b      	bres	21083,#0
1955                     ; 831     TIM2->CCMR1 &= (uint8_t)(~TIM_CCMR_OCM);
1957  0009 c65259        	ld	a,21081
1958  000c a48f          	and	a,#143
1959  000e c75259        	ld	21081,a
1960                     ; 834     TIM2->CCMR1 |= (uint8_t)TIM2_OCMode;
1962  0011 9f            	ld	a,xl
1963  0012 ca5259        	or	a,21081
1964  0015 c75259        	ld	21081,a
1966  0018 2014          	jra	L5401
1967  001a               L3401:
1968                     ; 839     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2E);
1970  001a 7219525b      	bres	21083,#4
1971                     ; 842     TIM2->CCMR2 &= (uint8_t)(~TIM_CCMR_OCM);
1973  001e c6525a        	ld	a,21082
1974  0021 a48f          	and	a,#143
1975  0023 c7525a        	ld	21082,a
1976                     ; 845     TIM2->CCMR2 |= (uint8_t)TIM2_OCMode;
1978  0026 c6525a        	ld	a,21082
1979  0029 1a02          	or	a,(OFST+2,sp)
1980  002b c7525a        	ld	21082,a
1981  002e               L5401:
1982                     ; 847 }
1985  002e 85            	popw	x
1986  002f 81            	ret
2020                     ; 855 void TIM2_SetCompare1(uint16_t Compare)
2020                     ; 856 {
2021                     .text:	section	.text,new
2022  0000               _TIM2_SetCompare1:
2026                     ; 858   TIM2->CCR1H = (uint8_t)(Compare >> 8);
2028  0000 9e            	ld	a,xh
2029  0001 c75261        	ld	21089,a
2030                     ; 859   TIM2->CCR1L = (uint8_t)(Compare);
2032  0004 9f            	ld	a,xl
2033  0005 c75262        	ld	21090,a
2034                     ; 860 }
2037  0008 81            	ret
2071                     ; 868 void TIM2_SetCompare2(uint16_t Compare)
2071                     ; 869 {
2072                     .text:	section	.text,new
2073  0000               _TIM2_SetCompare2:
2077                     ; 871   TIM2->CCR2H = (uint8_t)(Compare >> 8);
2079  0000 9e            	ld	a,xh
2080  0001 c75263        	ld	21091,a
2081                     ; 872   TIM2->CCR2L = (uint8_t)(Compare);
2083  0004 9f            	ld	a,xl
2084  0005 c75264        	ld	21092,a
2085                     ; 873 }
2088  0008 81            	ret
2155                     ; 883 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2155                     ; 884 {
2156                     .text:	section	.text,new
2157  0000               _TIM2_ForcedOC1Config:
2159  0000 88            	push	a
2160  0001 88            	push	a
2161       00000001      OFST:	set	1
2164                     ; 885   uint8_t tmpccmr1 = 0;
2166  0002 0f01          	clr	(OFST+0,sp)
2167                     ; 888   assert_param(IS_TIM2_FORCED_ACTION(TIM2_ForcedAction));
2169                     ; 890   tmpccmr1 = TIM2->CCMR1;
2171  0004 c65259        	ld	a,21081
2172  0007 6b01          	ld	(OFST+0,sp),a
2173                     ; 893   tmpccmr1 &= (uint8_t)(~TIM_CCMR_OCM);
2175  0009 7b01          	ld	a,(OFST+0,sp)
2176  000b a48f          	and	a,#143
2177  000d 6b01          	ld	(OFST+0,sp),a
2178                     ; 896   tmpccmr1 |= (uint8_t)TIM2_ForcedAction;
2180  000f 7b01          	ld	a,(OFST+0,sp)
2181  0011 1a02          	or	a,(OFST+1,sp)
2182  0013 6b01          	ld	(OFST+0,sp),a
2183                     ; 898   TIM2->CCMR1 = tmpccmr1;
2185  0015 7b01          	ld	a,(OFST+0,sp)
2186  0017 c75259        	ld	21081,a
2187                     ; 899 }
2190  001a 85            	popw	x
2191  001b 81            	ret
2236                     ; 909 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2236                     ; 910 {
2237                     .text:	section	.text,new
2238  0000               _TIM2_ForcedOC2Config:
2240  0000 88            	push	a
2241  0001 88            	push	a
2242       00000001      OFST:	set	1
2245                     ; 911   uint8_t tmpccmr2 = 0;
2247  0002 0f01          	clr	(OFST+0,sp)
2248                     ; 914   assert_param(IS_TIM2_FORCED_ACTION(TIM2_ForcedAction));
2250                     ; 916   tmpccmr2 = TIM2->CCMR2;
2252  0004 c6525a        	ld	a,21082
2253  0007 6b01          	ld	(OFST+0,sp),a
2254                     ; 919   tmpccmr2 &= (uint8_t)(~TIM_CCMR_OCM);
2256  0009 7b01          	ld	a,(OFST+0,sp)
2257  000b a48f          	and	a,#143
2258  000d 6b01          	ld	(OFST+0,sp),a
2259                     ; 922   tmpccmr2 |= (uint8_t)TIM2_ForcedAction;
2261  000f 7b01          	ld	a,(OFST+0,sp)
2262  0011 1a02          	or	a,(OFST+1,sp)
2263  0013 6b01          	ld	(OFST+0,sp),a
2264                     ; 924   TIM2->CCMR2 = tmpccmr2;
2266  0015 7b01          	ld	a,(OFST+0,sp)
2267  0017 c7525a        	ld	21082,a
2268                     ; 925 }
2271  001a 85            	popw	x
2272  001b 81            	ret
2308                     ; 933 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2308                     ; 934 {
2309                     .text:	section	.text,new
2310  0000               _TIM2_OC1PreloadConfig:
2314                     ; 936   assert_param(IS_FUNCTIONAL_STATE(NewState));
2316                     ; 939   if (NewState != DISABLE)
2318  0000 4d            	tnz	a
2319  0001 2706          	jreq	L5711
2320                     ; 941     TIM2->CCMR1 |= TIM_CCMR_OCxPE ;
2322  0003 72165259      	bset	21081,#3
2324  0007 2004          	jra	L7711
2325  0009               L5711:
2326                     ; 945     TIM2->CCMR1 &= (uint8_t)(~TIM_CCMR_OCxPE) ;
2328  0009 72175259      	bres	21081,#3
2329  000d               L7711:
2330                     ; 947 }
2333  000d 81            	ret
2369                     ; 955 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2369                     ; 956 {
2370                     .text:	section	.text,new
2371  0000               _TIM2_OC2PreloadConfig:
2375                     ; 958   assert_param(IS_FUNCTIONAL_STATE(NewState));
2377                     ; 961   if (NewState != DISABLE)
2379  0000 4d            	tnz	a
2380  0001 2706          	jreq	L7121
2381                     ; 963     TIM2->CCMR2 |= TIM_CCMR_OCxPE ;
2383  0003 7216525a      	bset	21082,#3
2385  0007 2004          	jra	L1221
2386  0009               L7121:
2387                     ; 967     TIM2->CCMR2 &= (uint8_t)(~TIM_CCMR_OCxPE) ;
2389  0009 7217525a      	bres	21082,#3
2390  000d               L1221:
2391                     ; 969 }
2394  000d 81            	ret
2429                     ; 977 void TIM2_OC1FastConfig(FunctionalState NewState)
2429                     ; 978 {
2430                     .text:	section	.text,new
2431  0000               _TIM2_OC1FastConfig:
2435                     ; 980   assert_param(IS_FUNCTIONAL_STATE(NewState));
2437                     ; 983   if (NewState != DISABLE)
2439  0000 4d            	tnz	a
2440  0001 2706          	jreq	L1421
2441                     ; 985     TIM2->CCMR1 |= TIM_CCMR_OCxFE ;
2443  0003 72145259      	bset	21081,#2
2445  0007 2004          	jra	L3421
2446  0009               L1421:
2447                     ; 989     TIM2->CCMR1 &= (uint8_t)(~TIM_CCMR_OCxFE) ;
2449  0009 72155259      	bres	21081,#2
2450  000d               L3421:
2451                     ; 991 }
2454  000d 81            	ret
2489                     ; 1000 void TIM2_OC2FastConfig(FunctionalState NewState)
2489                     ; 1001 {
2490                     .text:	section	.text,new
2491  0000               _TIM2_OC2FastConfig:
2495                     ; 1003   assert_param(IS_FUNCTIONAL_STATE(NewState));
2497                     ; 1006   if (NewState != DISABLE)
2499  0000 4d            	tnz	a
2500  0001 2706          	jreq	L3621
2501                     ; 1008     TIM2->CCMR2 |= TIM_CCMR_OCxFE ;
2503  0003 7214525a      	bset	21082,#2
2505  0007 2004          	jra	L5621
2506  0009               L3621:
2507                     ; 1012     TIM2->CCMR2 &= (uint8_t)(~TIM_CCMR_OCxFE) ;
2509  0009 7215525a      	bres	21082,#2
2510  000d               L5621:
2511                     ; 1014 }
2514  000d 81            	ret
2550                     ; 1024 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2550                     ; 1025 {
2551                     .text:	section	.text,new
2552  0000               _TIM2_OC1PolarityConfig:
2556                     ; 1027   assert_param(IS_TIM2_OC_POLARITY(TIM2_OCPolarity));
2558                     ; 1030   if (TIM2_OCPolarity == TIM2_OCPolarity_Low)
2560  0000 a101          	cp	a,#1
2561  0002 2606          	jrne	L5031
2562                     ; 1032     TIM2->CCER1 |= TIM_CCER1_CC1P ;
2564  0004 7212525b      	bset	21083,#1
2566  0008 2004          	jra	L7031
2567  000a               L5031:
2568                     ; 1036     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1P) ;
2570  000a 7213525b      	bres	21083,#1
2571  000e               L7031:
2572                     ; 1038 }
2575  000e 81            	ret
2611                     ; 1048 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2611                     ; 1049 {
2612                     .text:	section	.text,new
2613  0000               _TIM2_OC2PolarityConfig:
2617                     ; 1051   assert_param(IS_TIM2_OC_POLARITY(TIM2_OCPolarity));
2619                     ; 1054   if (TIM2_OCPolarity == TIM2_OCPolarity_Low)
2621  0000 a101          	cp	a,#1
2622  0002 2606          	jrne	L7231
2623                     ; 1056     TIM2->CCER1 |= TIM_CCER1_CC2P ;
2625  0004 721a525b      	bset	21083,#5
2627  0008 2004          	jra	L1331
2628  000a               L7231:
2629                     ; 1060     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2P) ;
2631  000a 721b525b      	bres	21083,#5
2632  000e               L1331:
2633                     ; 1062 }
2636  000e 81            	ret
2681                     ; 1074 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel,
2681                     ; 1075                  FunctionalState NewState)
2681                     ; 1076 {
2682                     .text:	section	.text,new
2683  0000               _TIM2_CCxCmd:
2685  0000 89            	pushw	x
2686       00000000      OFST:	set	0
2689                     ; 1078   assert_param(IS_TIM2_CHANNEL(TIM2_Channel));
2691                     ; 1079   assert_param(IS_FUNCTIONAL_STATE(NewState));
2693                     ; 1081   if (TIM2_Channel == TIM2_Channel_1)
2695  0001 9e            	ld	a,xh
2696  0002 4d            	tnz	a
2697  0003 2610          	jrne	L5531
2698                     ; 1084     if (NewState != DISABLE)
2700  0005 9f            	ld	a,xl
2701  0006 4d            	tnz	a
2702  0007 2706          	jreq	L7531
2703                     ; 1086       TIM2->CCER1 |= TIM_CCER1_CC1E ;
2705  0009 7210525b      	bset	21083,#0
2707  000d 2014          	jra	L3631
2708  000f               L7531:
2709                     ; 1090       TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1E) ;
2711  000f 7211525b      	bres	21083,#0
2712  0013 200e          	jra	L3631
2713  0015               L5531:
2714                     ; 1097     if (NewState != DISABLE)
2716  0015 0d02          	tnz	(OFST+2,sp)
2717  0017 2706          	jreq	L5631
2718                     ; 1099       TIM2->CCER1 |= TIM_CCER1_CC2E;
2720  0019 7218525b      	bset	21083,#4
2722  001d 2004          	jra	L3631
2723  001f               L5631:
2724                     ; 1103       TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2E) ;
2726  001f 7219525b      	bres	21083,#4
2727  0023               L3631:
2728                     ; 1106 }
2731  0023 85            	popw	x
2732  0024 81            	ret
2896                     ; 1184 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
2896                     ; 1185                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
2896                     ; 1186                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
2896                     ; 1187                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
2896                     ; 1188                  uint8_t TIM2_ICFilter)
2896                     ; 1189 {
2897                     .text:	section	.text,new
2898  0000               _TIM2_ICInit:
2900  0000 89            	pushw	x
2901       00000000      OFST:	set	0
2904                     ; 1191   assert_param(IS_TIM2_CHANNEL(TIM2_Channel));
2906                     ; 1193   if (TIM2_Channel == TIM2_Channel_1)
2908  0001 9e            	ld	a,xh
2909  0002 4d            	tnz	a
2910  0003 2614          	jrne	L5641
2911                     ; 1196     TI1_Config(TIM2_ICPolarity, TIM2_ICSelection, TIM2_ICFilter);
2913  0005 7b07          	ld	a,(OFST+7,sp)
2914  0007 88            	push	a
2915  0008 7b06          	ld	a,(OFST+6,sp)
2916  000a 97            	ld	xl,a
2917  000b 7b03          	ld	a,(OFST+3,sp)
2918  000d 95            	ld	xh,a
2919  000e cd0000        	call	L3_TI1_Config
2921  0011 84            	pop	a
2922                     ; 1199     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
2924  0012 7b06          	ld	a,(OFST+6,sp)
2925  0014 cd0000        	call	_TIM2_SetIC1Prescaler
2928  0017 2012          	jra	L7641
2929  0019               L5641:
2930                     ; 1204     TI2_Config(TIM2_ICPolarity, TIM2_ICSelection, TIM2_ICFilter);
2932  0019 7b07          	ld	a,(OFST+7,sp)
2933  001b 88            	push	a
2934  001c 7b06          	ld	a,(OFST+6,sp)
2935  001e 97            	ld	xl,a
2936  001f 7b03          	ld	a,(OFST+3,sp)
2937  0021 95            	ld	xh,a
2938  0022 cd0000        	call	L5_TI2_Config
2940  0025 84            	pop	a
2941                     ; 1207     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
2943  0026 7b06          	ld	a,(OFST+6,sp)
2944  0028 cd0000        	call	_TIM2_SetIC2Prescaler
2946  002b               L7641:
2947                     ; 1209 }
2950  002b 85            	popw	x
2951  002c 81            	ret
3047                     ; 1235 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
3047                     ; 1236                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
3047                     ; 1237                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
3047                     ; 1238                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
3047                     ; 1239                      uint8_t TIM2_ICFilter)
3047                     ; 1240 {
3048                     .text:	section	.text,new
3049  0000               _TIM2_PWMIConfig:
3051  0000 89            	pushw	x
3052  0001 89            	pushw	x
3053       00000002      OFST:	set	2
3056                     ; 1241   uint8_t icpolarity = TIM2_ICPolarity_Rising;
3058  0002 7b01          	ld	a,(OFST-1,sp)
3059  0004 97            	ld	xl,a
3060                     ; 1242   uint8_t icselection = TIM2_ICSelection_DirectTI;
3062  0005 7b02          	ld	a,(OFST+0,sp)
3063  0007 97            	ld	xl,a
3064                     ; 1245   assert_param(IS_TIM2_CHANNEL(TIM2_Channel));
3066                     ; 1248   if (TIM2_ICPolarity == TIM2_ICPolarity_Rising)
3068  0008 0d04          	tnz	(OFST+2,sp)
3069  000a 2606          	jrne	L7351
3070                     ; 1250     icpolarity = TIM2_ICPolarity_Falling;
3072  000c a601          	ld	a,#1
3073  000e 6b01          	ld	(OFST-1,sp),a
3075  0010 2002          	jra	L1451
3076  0012               L7351:
3077                     ; 1254     icpolarity = TIM2_ICPolarity_Rising;
3079  0012 0f01          	clr	(OFST-1,sp)
3080  0014               L1451:
3081                     ; 1258   if (TIM2_ICSelection == TIM2_ICSelection_DirectTI)
3083  0014 7b07          	ld	a,(OFST+5,sp)
3084  0016 a101          	cp	a,#1
3085  0018 2606          	jrne	L3451
3086                     ; 1260     icselection = TIM2_ICSelection_IndirectTI;
3088  001a a602          	ld	a,#2
3089  001c 6b02          	ld	(OFST+0,sp),a
3091  001e 2004          	jra	L5451
3092  0020               L3451:
3093                     ; 1264     icselection = TIM2_ICSelection_DirectTI;
3095  0020 a601          	ld	a,#1
3096  0022 6b02          	ld	(OFST+0,sp),a
3097  0024               L5451:
3098                     ; 1267   if (TIM2_Channel == TIM2_Channel_1)
3100  0024 0d03          	tnz	(OFST+1,sp)
3101  0026 2626          	jrne	L7451
3102                     ; 1270     TI1_Config(TIM2_ICPolarity, TIM2_ICSelection,
3102                     ; 1271                TIM2_ICFilter);
3104  0028 7b09          	ld	a,(OFST+7,sp)
3105  002a 88            	push	a
3106  002b 7b08          	ld	a,(OFST+6,sp)
3107  002d 97            	ld	xl,a
3108  002e 7b05          	ld	a,(OFST+3,sp)
3109  0030 95            	ld	xh,a
3110  0031 cd0000        	call	L3_TI1_Config
3112  0034 84            	pop	a
3113                     ; 1274     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
3115  0035 7b08          	ld	a,(OFST+6,sp)
3116  0037 cd0000        	call	_TIM2_SetIC1Prescaler
3118                     ; 1277     TI2_Config((TIM2_ICPolarity_TypeDef)icpolarity, (TIM2_ICSelection_TypeDef)icselection, TIM2_ICFilter);
3120  003a 7b09          	ld	a,(OFST+7,sp)
3121  003c 88            	push	a
3122  003d 7b03          	ld	a,(OFST+1,sp)
3123  003f 97            	ld	xl,a
3124  0040 7b02          	ld	a,(OFST+0,sp)
3125  0042 95            	ld	xh,a
3126  0043 cd0000        	call	L5_TI2_Config
3128  0046 84            	pop	a
3129                     ; 1280     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
3131  0047 7b08          	ld	a,(OFST+6,sp)
3132  0049 cd0000        	call	_TIM2_SetIC2Prescaler
3135  004c 2024          	jra	L1551
3136  004e               L7451:
3137                     ; 1285     TI2_Config(TIM2_ICPolarity, TIM2_ICSelection,
3137                     ; 1286                TIM2_ICFilter);
3139  004e 7b09          	ld	a,(OFST+7,sp)
3140  0050 88            	push	a
3141  0051 7b08          	ld	a,(OFST+6,sp)
3142  0053 97            	ld	xl,a
3143  0054 7b05          	ld	a,(OFST+3,sp)
3144  0056 95            	ld	xh,a
3145  0057 cd0000        	call	L5_TI2_Config
3147  005a 84            	pop	a
3148                     ; 1289     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
3150  005b 7b08          	ld	a,(OFST+6,sp)
3151  005d cd0000        	call	_TIM2_SetIC2Prescaler
3153                     ; 1292     TI1_Config((TIM2_ICPolarity_TypeDef)icpolarity, (TIM2_ICSelection_TypeDef)icselection, TIM2_ICFilter);
3155  0060 7b09          	ld	a,(OFST+7,sp)
3156  0062 88            	push	a
3157  0063 7b03          	ld	a,(OFST+1,sp)
3158  0065 97            	ld	xl,a
3159  0066 7b02          	ld	a,(OFST+0,sp)
3160  0068 95            	ld	xh,a
3161  0069 cd0000        	call	L3_TI1_Config
3163  006c 84            	pop	a
3164                     ; 1295     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
3166  006d 7b08          	ld	a,(OFST+6,sp)
3167  006f cd0000        	call	_TIM2_SetIC1Prescaler
3169  0072               L1551:
3170                     ; 1297 }
3173  0072 5b04          	addw	sp,#4
3174  0074 81            	ret
3226                     ; 1304 uint16_t TIM2_GetCapture1(void)
3226                     ; 1305 {
3227                     .text:	section	.text,new
3228  0000               _TIM2_GetCapture1:
3230  0000 5204          	subw	sp,#4
3231       00000004      OFST:	set	4
3234                     ; 1306   uint16_t tmpccr1 = 0;
3236  0002 1e03          	ldw	x,(OFST-1,sp)
3237                     ; 1309   tmpccr1h = TIM2->CCR1H;
3239  0004 c65261        	ld	a,21089
3240  0007 6b02          	ld	(OFST-2,sp),a
3241                     ; 1310   tmpccr1l = TIM2->CCR1L;
3243  0009 c65262        	ld	a,21090
3244  000c 6b01          	ld	(OFST-3,sp),a
3245                     ; 1312   tmpccr1 = (uint16_t)(tmpccr1l);
3247  000e 7b01          	ld	a,(OFST-3,sp)
3248  0010 5f            	clrw	x
3249  0011 97            	ld	xl,a
3250  0012 1f03          	ldw	(OFST-1,sp),x
3251                     ; 1313   tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3253  0014 7b02          	ld	a,(OFST-2,sp)
3254  0016 5f            	clrw	x
3255  0017 97            	ld	xl,a
3256  0018 4f            	clr	a
3257  0019 02            	rlwa	x,a
3258  001a 01            	rrwa	x,a
3259  001b 1a04          	or	a,(OFST+0,sp)
3260  001d 01            	rrwa	x,a
3261  001e 1a03          	or	a,(OFST-1,sp)
3262  0020 01            	rrwa	x,a
3263  0021 1f03          	ldw	(OFST-1,sp),x
3264                     ; 1315   return ((uint16_t)tmpccr1);
3266  0023 1e03          	ldw	x,(OFST-1,sp)
3269  0025 5b04          	addw	sp,#4
3270  0027 81            	ret
3322                     ; 1323 uint16_t TIM2_GetCapture2(void)
3322                     ; 1324 {
3323                     .text:	section	.text,new
3324  0000               _TIM2_GetCapture2:
3326  0000 5204          	subw	sp,#4
3327       00000004      OFST:	set	4
3330                     ; 1325   uint16_t tmpccr2 = 0;
3332  0002 1e03          	ldw	x,(OFST-1,sp)
3333                     ; 1328   tmpccr2h = TIM2->CCR2H;
3335  0004 c65263        	ld	a,21091
3336  0007 6b02          	ld	(OFST-2,sp),a
3337                     ; 1329   tmpccr2l = TIM2->CCR2L;
3339  0009 c65264        	ld	a,21092
3340  000c 6b01          	ld	(OFST-3,sp),a
3341                     ; 1331   tmpccr2 = (uint16_t)(tmpccr2l);
3343  000e 7b01          	ld	a,(OFST-3,sp)
3344  0010 5f            	clrw	x
3345  0011 97            	ld	xl,a
3346  0012 1f03          	ldw	(OFST-1,sp),x
3347                     ; 1332   tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3349  0014 7b02          	ld	a,(OFST-2,sp)
3350  0016 5f            	clrw	x
3351  0017 97            	ld	xl,a
3352  0018 4f            	clr	a
3353  0019 02            	rlwa	x,a
3354  001a 01            	rrwa	x,a
3355  001b 1a04          	or	a,(OFST+0,sp)
3356  001d 01            	rrwa	x,a
3357  001e 1a03          	or	a,(OFST-1,sp)
3358  0020 01            	rrwa	x,a
3359  0021 1f03          	ldw	(OFST-1,sp),x
3360                     ; 1334   return ((uint16_t)tmpccr2);
3362  0023 1e03          	ldw	x,(OFST-1,sp)
3365  0025 5b04          	addw	sp,#4
3366  0027 81            	ret
3411                     ; 1347 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
3411                     ; 1348 {
3412                     .text:	section	.text,new
3413  0000               _TIM2_SetIC1Prescaler:
3415  0000 88            	push	a
3416  0001 88            	push	a
3417       00000001      OFST:	set	1
3420                     ; 1349   uint8_t tmpccmr1 = 0;
3422  0002 0f01          	clr	(OFST+0,sp)
3423                     ; 1352   assert_param(IS_TIM2_IC_PRESCALER(TIM2_IC1Prescaler));
3425                     ; 1354   tmpccmr1 = TIM2->CCMR1;
3427  0004 c65259        	ld	a,21081
3428  0007 6b01          	ld	(OFST+0,sp),a
3429                     ; 1357   tmpccmr1 &= (uint8_t)(~TIM_CCMR_ICxPSC);
3431  0009 7b01          	ld	a,(OFST+0,sp)
3432  000b a4f3          	and	a,#243
3433  000d 6b01          	ld	(OFST+0,sp),a
3434                     ; 1360   tmpccmr1 |= (uint8_t)TIM2_IC1Prescaler;
3436  000f 7b01          	ld	a,(OFST+0,sp)
3437  0011 1a02          	or	a,(OFST+1,sp)
3438  0013 6b01          	ld	(OFST+0,sp),a
3439                     ; 1362   TIM2->CCMR1 = tmpccmr1;
3441  0015 7b01          	ld	a,(OFST+0,sp)
3442  0017 c75259        	ld	21081,a
3443                     ; 1363 }
3446  001a 85            	popw	x
3447  001b 81            	ret
3492                     ; 1375 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3492                     ; 1376 {
3493                     .text:	section	.text,new
3494  0000               _TIM2_SetIC2Prescaler:
3496  0000 88            	push	a
3497  0001 88            	push	a
3498       00000001      OFST:	set	1
3501                     ; 1377   uint8_t tmpccmr2 = 0;
3503  0002 0f01          	clr	(OFST+0,sp)
3504                     ; 1380   assert_param(IS_TIM2_IC_PRESCALER(TIM2_IC2Prescaler));
3506                     ; 1382   tmpccmr2 = TIM2->CCMR2;
3508  0004 c6525a        	ld	a,21082
3509  0007 6b01          	ld	(OFST+0,sp),a
3510                     ; 1385   tmpccmr2 &= (uint8_t)(~TIM_CCMR_ICxPSC);
3512  0009 7b01          	ld	a,(OFST+0,sp)
3513  000b a4f3          	and	a,#243
3514  000d 6b01          	ld	(OFST+0,sp),a
3515                     ; 1388   tmpccmr2 |= (uint8_t)TIM2_IC2Prescaler;
3517  000f 7b01          	ld	a,(OFST+0,sp)
3518  0011 1a02          	or	a,(OFST+1,sp)
3519  0013 6b01          	ld	(OFST+0,sp),a
3520                     ; 1390   TIM2->CCMR2 = tmpccmr2;
3522  0015 7b01          	ld	a,(OFST+0,sp)
3523  0017 c7525a        	ld	21082,a
3524                     ; 1391 }
3527  001a 85            	popw	x
3528  001b 81            	ret
3614                     ; 1422 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
3614                     ; 1423 {
3615                     .text:	section	.text,new
3616  0000               _TIM2_ITConfig:
3618  0000 89            	pushw	x
3619       00000000      OFST:	set	0
3622                     ; 1425   assert_param(IS_TIM2_IT(TIM2_IT));
3624                     ; 1426   assert_param(IS_FUNCTIONAL_STATE(NewState));
3626                     ; 1428   if (NewState != DISABLE)
3628  0001 9f            	ld	a,xl
3629  0002 4d            	tnz	a
3630  0003 2709          	jreq	L3371
3631                     ; 1431     TIM2->IER |= (uint8_t)TIM2_IT;
3633  0005 9e            	ld	a,xh
3634  0006 ca5255        	or	a,21077
3635  0009 c75255        	ld	21077,a
3637  000c 2009          	jra	L5371
3638  000e               L3371:
3639                     ; 1436     TIM2->IER &= (uint8_t)(~(uint8_t)TIM2_IT);
3641  000e 7b01          	ld	a,(OFST+1,sp)
3642  0010 43            	cpl	a
3643  0011 c45255        	and	a,21077
3644  0014 c75255        	ld	21077,a
3645  0017               L5371:
3646                     ; 1438 }
3649  0017 85            	popw	x
3650  0018 81            	ret
3731                     ; 1451 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
3731                     ; 1452 {
3732                     .text:	section	.text,new
3733  0000               _TIM2_GenerateEvent:
3737                     ; 1454   assert_param(IS_TIM2_EVENT_SOURCE((uint8_t)TIM2_EventSource));
3739                     ; 1457   TIM2->EGR |= (uint8_t)TIM2_EventSource;
3741  0000 ca5258        	or	a,21080
3742  0003 c75258        	ld	21080,a
3743                     ; 1458 }
3746  0006 81            	ret
3885                     ; 1473 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3885                     ; 1474 {
3886                     .text:	section	.text,new
3887  0000               _TIM2_GetFlagStatus:
3889  0000 89            	pushw	x
3890  0001 89            	pushw	x
3891       00000002      OFST:	set	2
3894                     ; 1475   FlagStatus bitstatus = RESET;
3896  0002 7b02          	ld	a,(OFST+0,sp)
3897  0004 97            	ld	xl,a
3898                     ; 1476   uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3900  0005 7b01          	ld	a,(OFST-1,sp)
3901  0007 97            	ld	xl,a
3904  0008 7b02          	ld	a,(OFST+0,sp)
3905  000a 97            	ld	xl,a
3906                     ; 1479   assert_param(IS_TIM2_GET_FLAG(TIM2_FLAG));
3908                     ; 1481   tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)(TIM2_FLAG));
3910  000b c65256        	ld	a,21078
3911  000e 1404          	and	a,(OFST+2,sp)
3912  0010 6b01          	ld	(OFST-1,sp),a
3913                     ; 1482   tim2_flag_h = (uint8_t)(TIM2->SR2 & (uint8_t)((uint16_t)TIM2_FLAG >> 8));
3915  0012 c65257        	ld	a,21079
3916  0015 1403          	and	a,(OFST+1,sp)
3917  0017 6b02          	ld	(OFST+0,sp),a
3918                     ; 1484   if ((uint8_t)(tim2_flag_l | tim2_flag_h) != 0)
3920  0019 7b01          	ld	a,(OFST-1,sp)
3921  001b 1a02          	or	a,(OFST+0,sp)
3922  001d 2706          	jreq	L7502
3923                     ; 1486     bitstatus = SET;
3925  001f a601          	ld	a,#1
3926  0021 6b02          	ld	(OFST+0,sp),a
3928  0023 2002          	jra	L1602
3929  0025               L7502:
3930                     ; 1490     bitstatus = RESET;
3932  0025 0f02          	clr	(OFST+0,sp)
3933  0027               L1602:
3934                     ; 1492   return ((FlagStatus)bitstatus);
3936  0027 7b02          	ld	a,(OFST+0,sp)
3939  0029 5b04          	addw	sp,#4
3940  002b 81            	ret
3975                     ; 1506 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3975                     ; 1507 {
3976                     .text:	section	.text,new
3977  0000               _TIM2_ClearFlag:
3979  0000 89            	pushw	x
3980       00000000      OFST:	set	0
3983                     ; 1509   assert_param(IS_TIM2_CLEAR_FLAG((uint16_t)TIM2_FLAG));
3985                     ; 1511   TIM2->SR1 = (uint8_t)(~(uint8_t)(TIM2_FLAG));
3987  0001 9f            	ld	a,xl
3988  0002 43            	cpl	a
3989  0003 c75256        	ld	21078,a
3990                     ; 1512   TIM2->SR2 = (uint8_t)(~(uint8_t)((uint16_t)TIM2_FLAG >> 8));
3992  0006 7b01          	ld	a,(OFST+1,sp)
3993  0008 43            	cpl	a
3994  0009 c75257        	ld	21079,a
3995                     ; 1513 }
3998  000c 85            	popw	x
3999  000d 81            	ret
4063                     ; 1526 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
4063                     ; 1527 {
4064                     .text:	section	.text,new
4065  0000               _TIM2_GetITStatus:
4067  0000 88            	push	a
4068  0001 89            	pushw	x
4069       00000002      OFST:	set	2
4072                     ; 1528   ITStatus bitstatus = RESET;
4074  0002 7b02          	ld	a,(OFST+0,sp)
4075  0004 97            	ld	xl,a
4076                     ; 1530   uint8_t TIM2_itStatus = 0x0, TIM2_itEnable = 0x0;
4078  0005 7b01          	ld	a,(OFST-1,sp)
4079  0007 97            	ld	xl,a
4082  0008 7b02          	ld	a,(OFST+0,sp)
4083  000a 97            	ld	xl,a
4084                     ; 1533   assert_param(IS_TIM2_GET_IT(TIM2_IT));
4086                     ; 1535   TIM2_itStatus = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_IT);
4088  000b c65256        	ld	a,21078
4089  000e 1403          	and	a,(OFST+1,sp)
4090  0010 6b01          	ld	(OFST-1,sp),a
4091                     ; 1537   TIM2_itEnable = (uint8_t)(TIM2->IER & (uint8_t)TIM2_IT);
4093  0012 c65255        	ld	a,21077
4094  0015 1403          	and	a,(OFST+1,sp)
4095  0017 6b02          	ld	(OFST+0,sp),a
4096                     ; 1539   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET))
4098  0019 0d01          	tnz	(OFST-1,sp)
4099  001b 270a          	jreq	L3312
4101  001d 0d02          	tnz	(OFST+0,sp)
4102  001f 2706          	jreq	L3312
4103                     ; 1541     bitstatus = (ITStatus)SET;
4105  0021 a601          	ld	a,#1
4106  0023 6b02          	ld	(OFST+0,sp),a
4108  0025 2002          	jra	L5312
4109  0027               L3312:
4110                     ; 1545     bitstatus = (ITStatus)RESET;
4112  0027 0f02          	clr	(OFST+0,sp)
4113  0029               L5312:
4114                     ; 1547   return ((ITStatus)bitstatus);
4116  0029 7b02          	ld	a,(OFST+0,sp)
4119  002b 5b03          	addw	sp,#3
4120  002d 81            	ret
4156                     ; 1561 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
4156                     ; 1562 {
4157                     .text:	section	.text,new
4158  0000               _TIM2_ClearITPendingBit:
4162                     ; 1564   assert_param(IS_TIM2_IT(TIM2_IT));
4164                     ; 1567   TIM2->SR1 = (uint8_t)(~(uint8_t)TIM2_IT);
4166  0000 43            	cpl	a
4167  0001 c75256        	ld	21078,a
4168                     ; 1568 }
4171  0004 81            	ret
4244                     ; 1581 void TIM2_DMACmd( TIM2_DMASource_TypeDef TIM2_DMASource, FunctionalState NewState)
4244                     ; 1582 {
4245                     .text:	section	.text,new
4246  0000               _TIM2_DMACmd:
4248  0000 89            	pushw	x
4249       00000000      OFST:	set	0
4252                     ; 1584   assert_param(IS_FUNCTIONAL_STATE(NewState));
4254                     ; 1585   assert_param(IS_TIM2_DMA_SOURCE(TIM2_DMASource));
4256                     ; 1587   if (NewState != DISABLE)
4258  0001 9f            	ld	a,xl
4259  0002 4d            	tnz	a
4260  0003 2709          	jreq	L1122
4261                     ; 1590     TIM2->DER |= TIM2_DMASource;
4263  0005 9e            	ld	a,xh
4264  0006 ca5254        	or	a,21076
4265  0009 c75254        	ld	21076,a
4267  000c 2009          	jra	L3122
4268  000e               L1122:
4269                     ; 1595     TIM2->DER &= (uint8_t)(~TIM2_DMASource);
4271  000e 7b01          	ld	a,(OFST+1,sp)
4272  0010 43            	cpl	a
4273  0011 c45254        	and	a,21076
4274  0014 c75254        	ld	21076,a
4275  0017               L3122:
4276                     ; 1597 }
4279  0017 85            	popw	x
4280  0018 81            	ret
4315                     ; 1605 void TIM2_SelectCCDMA(FunctionalState NewState)
4315                     ; 1606 {
4316                     .text:	section	.text,new
4317  0000               _TIM2_SelectCCDMA:
4321                     ; 1608   assert_param(IS_FUNCTIONAL_STATE(NewState));
4323                     ; 1610   if (NewState != DISABLE)
4325  0000 4d            	tnz	a
4326  0001 2706          	jreq	L3322
4327                     ; 1613     TIM2->CR2 |= TIM_CR2_CCDS;
4329  0003 72165251      	bset	21073,#3
4331  0007 2004          	jra	L5322
4332  0009               L3322:
4333                     ; 1618     TIM2->CR2 &= (uint8_t)(~TIM_CR2_CCDS);
4335  0009 72175251      	bres	21073,#3
4336  000d               L5322:
4337                     ; 1620 }
4340  000d 81            	ret
4364                     ; 1644 void TIM2_InternalClockConfig(void)
4364                     ; 1645 {
4365                     .text:	section	.text,new
4366  0000               _TIM2_InternalClockConfig:
4370                     ; 1647   TIM2->SMCR &=  (uint8_t)(~TIM_SMCR_SMS);
4372  0000 c65252        	ld	a,21074
4373  0003 a4f8          	and	a,#248
4374  0005 c75252        	ld	21074,a
4375                     ; 1648 }
4378  0008 81            	ret
4467                     ; 1665 void TIM2_TIxExternalClockConfig(TIM2_TIxExternalCLK1Source_TypeDef TIM2_TIxExternalCLKSource,
4467                     ; 1666                                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
4467                     ; 1667                                  uint8_t ICFilter)
4467                     ; 1668 {
4468                     .text:	section	.text,new
4469  0000               _TIM2_TIxExternalClockConfig:
4471  0000 89            	pushw	x
4472       00000000      OFST:	set	0
4475                     ; 1670   assert_param(IS_TIM2_TIXCLK_SOURCE(TIM2_TIxExternalCLKSource));
4477                     ; 1671   assert_param(IS_TIM2_IC_POLARITY(TIM2_ICPolarity));
4479                     ; 1672   assert_param(IS_TIM2_IC_FILTER(ICFilter));
4481                     ; 1675   if (TIM2_TIxExternalCLKSource == TIM2_TIxExternalCLK1Source_TI2)
4483  0001 9e            	ld	a,xh
4484  0002 a160          	cp	a,#96
4485  0004 260f          	jrne	L7032
4486                     ; 1677     TI2_Config(TIM2_ICPolarity, TIM2_ICSelection_DirectTI, ICFilter);
4488  0006 7b05          	ld	a,(OFST+5,sp)
4489  0008 88            	push	a
4490  0009 ae0001        	ldw	x,#1
4491  000c 7b03          	ld	a,(OFST+3,sp)
4492  000e 95            	ld	xh,a
4493  000f cd0000        	call	L5_TI2_Config
4495  0012 84            	pop	a
4497  0013 200d          	jra	L1132
4498  0015               L7032:
4499                     ; 1681     TI1_Config(TIM2_ICPolarity, TIM2_ICSelection_DirectTI, ICFilter);
4501  0015 7b05          	ld	a,(OFST+5,sp)
4502  0017 88            	push	a
4503  0018 ae0001        	ldw	x,#1
4504  001b 7b03          	ld	a,(OFST+3,sp)
4505  001d 95            	ld	xh,a
4506  001e cd0000        	call	L3_TI1_Config
4508  0021 84            	pop	a
4509  0022               L1132:
4510                     ; 1685   TIM2_SelectInputTrigger((TIM2_TRGSelection_TypeDef)TIM2_TIxExternalCLKSource);
4512  0022 7b01          	ld	a,(OFST+1,sp)
4513  0024 cd0000        	call	_TIM2_SelectInputTrigger
4515                     ; 1688   TIM2->SMCR |= (uint8_t)(TIM2_SlaveMode_External1);
4517  0027 c65252        	ld	a,21074
4518  002a aa07          	or	a,#7
4519  002c c75252        	ld	21074,a
4520                     ; 1689 }
4523  002f 85            	popw	x
4524  0030 81            	ret
4641                     ; 1707 void TIM2_ETRClockMode1Config(TIM2_ExtTRGPSC_TypeDef TIM2_ExtTRGPrescaler,
4641                     ; 1708                               TIM2_ExtTRGPolarity_TypeDef TIM2_ExtTRGPolarity,
4641                     ; 1709                               uint8_t ExtTRGFilter)
4641                     ; 1710 {
4642                     .text:	section	.text,new
4643  0000               _TIM2_ETRClockMode1Config:
4645  0000 89            	pushw	x
4646       00000000      OFST:	set	0
4649                     ; 1712   TIM2_ETRConfig(TIM2_ExtTRGPrescaler, TIM2_ExtTRGPolarity, ExtTRGFilter);
4651  0001 7b05          	ld	a,(OFST+5,sp)
4652  0003 88            	push	a
4653  0004 9f            	ld	a,xl
4654  0005 97            	ld	xl,a
4655  0006 7b02          	ld	a,(OFST+2,sp)
4656  0008 95            	ld	xh,a
4657  0009 cd0000        	call	_TIM2_ETRConfig
4659  000c 84            	pop	a
4660                     ; 1715   TIM2->SMCR &= (uint8_t)(~TIM_SMCR_SMS);
4662  000d c65252        	ld	a,21074
4663  0010 a4f8          	and	a,#248
4664  0012 c75252        	ld	21074,a
4665                     ; 1716   TIM2->SMCR |= (uint8_t)(TIM2_SlaveMode_External1);
4667  0015 c65252        	ld	a,21074
4668  0018 aa07          	or	a,#7
4669  001a c75252        	ld	21074,a
4670                     ; 1719   TIM2->SMCR &= (uint8_t)(~TIM_SMCR_TS);
4672  001d c65252        	ld	a,21074
4673  0020 a48f          	and	a,#143
4674  0022 c75252        	ld	21074,a
4675                     ; 1720   TIM2->SMCR |= (uint8_t)((TIM2_TRGSelection_TypeDef)TIM2_TRGSelection_ETRF);
4677  0025 c65252        	ld	a,21074
4678  0028 aa70          	or	a,#112
4679  002a c75252        	ld	21074,a
4680                     ; 1721 }
4683  002d 85            	popw	x
4684  002e 81            	ret
4742                     ; 1739 void TIM2_ETRClockMode2Config(TIM2_ExtTRGPSC_TypeDef TIM2_ExtTRGPrescaler,
4742                     ; 1740                               TIM2_ExtTRGPolarity_TypeDef TIM2_ExtTRGPolarity,
4742                     ; 1741                               uint8_t ExtTRGFilter)
4742                     ; 1742 {
4743                     .text:	section	.text,new
4744  0000               _TIM2_ETRClockMode2Config:
4746  0000 89            	pushw	x
4747       00000000      OFST:	set	0
4750                     ; 1744   TIM2_ETRConfig(TIM2_ExtTRGPrescaler, TIM2_ExtTRGPolarity, ExtTRGFilter);
4752  0001 7b05          	ld	a,(OFST+5,sp)
4753  0003 88            	push	a
4754  0004 9f            	ld	a,xl
4755  0005 97            	ld	xl,a
4756  0006 7b02          	ld	a,(OFST+2,sp)
4757  0008 95            	ld	xh,a
4758  0009 cd0000        	call	_TIM2_ETRConfig
4760  000c 84            	pop	a
4761                     ; 1747   TIM2->ETR |= TIM_ETR_ECE ;
4763  000d 721c5253      	bset	21075,#6
4764                     ; 1748 }
4767  0011 85            	popw	x
4768  0012 81            	ret
4884                     ; 1799 void TIM2_SelectInputTrigger(TIM2_TRGSelection_TypeDef TIM2_InputTriggerSource)
4884                     ; 1800 {
4885                     .text:	section	.text,new
4886  0000               _TIM2_SelectInputTrigger:
4888  0000 88            	push	a
4889  0001 88            	push	a
4890       00000001      OFST:	set	1
4893                     ; 1801   uint8_t tmpsmcr = 0;
4895  0002 0f01          	clr	(OFST+0,sp)
4896                     ; 1804   assert_param(IS_TIM2_TRIGGER_SELECTION(TIM2_InputTriggerSource));
4898                     ; 1806   tmpsmcr = TIM2->SMCR;
4900  0004 c65252        	ld	a,21074
4901  0007 6b01          	ld	(OFST+0,sp),a
4902                     ; 1809   tmpsmcr &= (uint8_t)(~TIM_SMCR_TS);
4904  0009 7b01          	ld	a,(OFST+0,sp)
4905  000b a48f          	and	a,#143
4906  000d 6b01          	ld	(OFST+0,sp),a
4907                     ; 1810   tmpsmcr |= (uint8_t)TIM2_InputTriggerSource;
4909  000f 7b01          	ld	a,(OFST+0,sp)
4910  0011 1a02          	or	a,(OFST+1,sp)
4911  0013 6b01          	ld	(OFST+0,sp),a
4912                     ; 1812   TIM2->SMCR = (uint8_t)tmpsmcr;
4914  0015 7b01          	ld	a,(OFST+0,sp)
4915  0017 c75252        	ld	21074,a
4916                     ; 1813 }
4919  001a 85            	popw	x
4920  001b 81            	ret
5019                     ; 1827 void TIM2_SelectOutputTrigger(TIM2_TRGOSource_TypeDef TIM2_TRGOSource)
5019                     ; 1828 {
5020                     .text:	section	.text,new
5021  0000               _TIM2_SelectOutputTrigger:
5023  0000 88            	push	a
5024  0001 88            	push	a
5025       00000001      OFST:	set	1
5028                     ; 1829   uint8_t tmpcr2 = 0;
5030  0002 0f01          	clr	(OFST+0,sp)
5031                     ; 1832   assert_param(IS_TIM2_TRGO_SOURCE(TIM2_TRGOSource));
5033                     ; 1834   tmpcr2 = TIM2->CR2;
5035  0004 c65251        	ld	a,21073
5036  0007 6b01          	ld	(OFST+0,sp),a
5037                     ; 1837   tmpcr2 &= (uint8_t)(~TIM_CR2_MMS);
5039  0009 7b01          	ld	a,(OFST+0,sp)
5040  000b a48f          	and	a,#143
5041  000d 6b01          	ld	(OFST+0,sp),a
5042                     ; 1840   tmpcr2 |=  (uint8_t)TIM2_TRGOSource;
5044  000f 7b01          	ld	a,(OFST+0,sp)
5045  0011 1a02          	or	a,(OFST+1,sp)
5046  0013 6b01          	ld	(OFST+0,sp),a
5047                     ; 1842   TIM2->CR2 = tmpcr2;
5049  0015 7b01          	ld	a,(OFST+0,sp)
5050  0017 c75251        	ld	21073,a
5051                     ; 1843 }
5054  001a 85            	popw	x
5055  001b 81            	ret
5138                     ; 1855 void TIM2_SelectSlaveMode(TIM2_SlaveMode_TypeDef TIM2_SlaveMode)
5138                     ; 1856 {
5139                     .text:	section	.text,new
5140  0000               _TIM2_SelectSlaveMode:
5142  0000 88            	push	a
5143  0001 88            	push	a
5144       00000001      OFST:	set	1
5147                     ; 1857   uint8_t tmpsmcr = 0;
5149  0002 0f01          	clr	(OFST+0,sp)
5150                     ; 1860   assert_param(IS_TIM2_SLAVE_MODE(TIM2_SlaveMode));
5152                     ; 1862   tmpsmcr = TIM2->SMCR;
5154  0004 c65252        	ld	a,21074
5155  0007 6b01          	ld	(OFST+0,sp),a
5156                     ; 1865   tmpsmcr &= (uint8_t)(~TIM_SMCR_SMS);
5158  0009 7b01          	ld	a,(OFST+0,sp)
5159  000b a4f8          	and	a,#248
5160  000d 6b01          	ld	(OFST+0,sp),a
5161                     ; 1868   tmpsmcr |= (uint8_t)TIM2_SlaveMode;
5163  000f 7b01          	ld	a,(OFST+0,sp)
5164  0011 1a02          	or	a,(OFST+1,sp)
5165  0013 6b01          	ld	(OFST+0,sp),a
5166                     ; 1870   TIM2->SMCR = tmpsmcr;
5168  0015 7b01          	ld	a,(OFST+0,sp)
5169  0017 c75252        	ld	21074,a
5170                     ; 1871 }
5173  001a 85            	popw	x
5174  001b 81            	ret
5210                     ; 1879 void TIM2_SelectMasterSlaveMode(FunctionalState NewState)
5210                     ; 1880 {
5211                     .text:	section	.text,new
5212  0000               _TIM2_SelectMasterSlaveMode:
5216                     ; 1882   assert_param(IS_FUNCTIONAL_STATE(NewState));
5218                     ; 1885   if (NewState != DISABLE)
5220  0000 4d            	tnz	a
5221  0001 2706          	jreq	L7752
5222                     ; 1887     TIM2->SMCR |= TIM_SMCR_MSM;
5224  0003 721e5252      	bset	21074,#7
5226  0007 2004          	jra	L1062
5227  0009               L7752:
5228                     ; 1891     TIM2->SMCR &= (uint8_t)(~TIM_SMCR_MSM);
5230  0009 721f5252      	bres	21074,#7
5231  000d               L1062:
5232                     ; 1893 }
5235  000d 81            	ret
5291                     ; 1911 void TIM2_ETRConfig(TIM2_ExtTRGPSC_TypeDef TIM2_ExtTRGPrescaler,
5291                     ; 1912                     TIM2_ExtTRGPolarity_TypeDef TIM2_ExtTRGPolarity,
5291                     ; 1913                     uint8_t ExtTRGFilter)
5291                     ; 1914 {
5292                     .text:	section	.text,new
5293  0000               _TIM2_ETRConfig:
5295  0000 89            	pushw	x
5296       00000000      OFST:	set	0
5299                     ; 1916   assert_param(IS_TIM2_EXT_PRESCALER(TIM2_ExtTRGPrescaler));
5301                     ; 1917   assert_param(IS_TIM2_EXT_POLARITY(TIM2_ExtTRGPolarity));
5303                     ; 1918   assert_param(IS_TIM2_EXT_FILTER(ExtTRGFilter));
5305                     ; 1921   TIM2->ETR |= (uint8_t)((uint8_t)((uint8_t)TIM2_ExtTRGPrescaler | (uint8_t)TIM2_ExtTRGPolarity)
5305                     ; 1922                          | (uint8_t)ExtTRGFilter);
5307  0001 9f            	ld	a,xl
5308  0002 1a01          	or	a,(OFST+1,sp)
5309  0004 1a05          	or	a,(OFST+5,sp)
5310  0006 ca5253        	or	a,21075
5311  0009 c75253        	ld	21075,a
5312                     ; 1923 }
5315  000c 85            	popw	x
5316  000d 81            	ret
5429                     ; 1958 void TIM2_EncoderInterfaceConfig(TIM2_EncoderMode_TypeDef TIM2_EncoderMode,
5429                     ; 1959                                  TIM2_ICPolarity_TypeDef TIM2_IC1Polarity,
5429                     ; 1960                                  TIM2_ICPolarity_TypeDef TIM2_IC2Polarity)
5429                     ; 1961 {
5430                     .text:	section	.text,new
5431  0000               _TIM2_EncoderInterfaceConfig:
5433  0000 89            	pushw	x
5434  0001 5203          	subw	sp,#3
5435       00000003      OFST:	set	3
5438                     ; 1962   uint8_t tmpsmcr = 0;
5440  0003 7b01          	ld	a,(OFST-2,sp)
5441  0005 97            	ld	xl,a
5442                     ; 1963   uint8_t tmpccmr1 = 0;
5444  0006 7b02          	ld	a,(OFST-1,sp)
5445  0008 97            	ld	xl,a
5446                     ; 1964   uint8_t tmpccmr2 = 0;
5448  0009 7b03          	ld	a,(OFST+0,sp)
5449  000b 97            	ld	xl,a
5450                     ; 1967   assert_param(IS_TIM2_ENCODER_MODE(TIM2_EncoderMode));
5452                     ; 1968   assert_param(IS_TIM2_IC_POLARITY(TIM2_IC1Polarity));
5454                     ; 1969   assert_param(IS_TIM2_IC_POLARITY(TIM2_IC2Polarity));
5456                     ; 1971   tmpsmcr = TIM2->SMCR;
5458  000c c65252        	ld	a,21074
5459  000f 6b01          	ld	(OFST-2,sp),a
5460                     ; 1972   tmpccmr1 = TIM2->CCMR1;
5462  0011 c65259        	ld	a,21081
5463  0014 6b02          	ld	(OFST-1,sp),a
5464                     ; 1973   tmpccmr2 = TIM2->CCMR2;
5466  0016 c6525a        	ld	a,21082
5467  0019 6b03          	ld	(OFST+0,sp),a
5468                     ; 1976   tmpsmcr &= (uint8_t)(TIM_SMCR_MSM | TIM_SMCR_TS)  ;
5470  001b 7b01          	ld	a,(OFST-2,sp)
5471  001d a4f0          	and	a,#240
5472  001f 6b01          	ld	(OFST-2,sp),a
5473                     ; 1977   tmpsmcr |= (uint8_t)TIM2_EncoderMode;
5475  0021 7b01          	ld	a,(OFST-2,sp)
5476  0023 1a04          	or	a,(OFST+1,sp)
5477  0025 6b01          	ld	(OFST-2,sp),a
5478                     ; 1980   tmpccmr1 &= (uint8_t)(~TIM_CCMR_CCxS);
5480  0027 7b02          	ld	a,(OFST-1,sp)
5481  0029 a4fc          	and	a,#252
5482  002b 6b02          	ld	(OFST-1,sp),a
5483                     ; 1981   tmpccmr2 &= (uint8_t)(~TIM_CCMR_CCxS);
5485  002d 7b03          	ld	a,(OFST+0,sp)
5486  002f a4fc          	and	a,#252
5487  0031 6b03          	ld	(OFST+0,sp),a
5488                     ; 1982   tmpccmr1 |= TIM_CCMR_TIxDirect_Set;
5490  0033 7b02          	ld	a,(OFST-1,sp)
5491  0035 aa01          	or	a,#1
5492  0037 6b02          	ld	(OFST-1,sp),a
5493                     ; 1983   tmpccmr2 |= TIM_CCMR_TIxDirect_Set;
5495  0039 7b03          	ld	a,(OFST+0,sp)
5496  003b aa01          	or	a,#1
5497  003d 6b03          	ld	(OFST+0,sp),a
5498                     ; 1986   if (TIM2_IC1Polarity == TIM2_ICPolarity_Falling)
5500  003f 7b05          	ld	a,(OFST+2,sp)
5501  0041 a101          	cp	a,#1
5502  0043 2606          	jrne	L5072
5503                     ; 1988     TIM2->CCER1 |= TIM_CCER1_CC1P ;
5505  0045 7212525b      	bset	21083,#1
5507  0049 2004          	jra	L7072
5508  004b               L5072:
5509                     ; 1992     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1P) ;
5511  004b 7213525b      	bres	21083,#1
5512  004f               L7072:
5513                     ; 1995   if (TIM2_IC2Polarity == TIM2_ICPolarity_Falling)
5515  004f 7b08          	ld	a,(OFST+5,sp)
5516  0051 a101          	cp	a,#1
5517  0053 2606          	jrne	L1172
5518                     ; 1997     TIM2->CCER1 |= TIM_CCER1_CC2P ;
5520  0055 721a525b      	bset	21083,#5
5522  0059 2004          	jra	L3172
5523  005b               L1172:
5524                     ; 2001     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2P) ;
5526  005b 721b525b      	bres	21083,#5
5527  005f               L3172:
5528                     ; 2004   TIM2->SMCR = tmpsmcr;
5530  005f 7b01          	ld	a,(OFST-2,sp)
5531  0061 c75252        	ld	21074,a
5532                     ; 2005   TIM2->CCMR1 = tmpccmr1;
5534  0064 7b02          	ld	a,(OFST-1,sp)
5535  0066 c75259        	ld	21081,a
5536                     ; 2006   TIM2->CCMR2 = tmpccmr2;
5538  0069 7b03          	ld	a,(OFST+0,sp)
5539  006b c7525a        	ld	21082,a
5540                     ; 2007 }
5543  006e 5b05          	addw	sp,#5
5544  0070 81            	ret
5580                     ; 2015 void TIM2_SelectHallSensor(FunctionalState NewState)
5580                     ; 2016 {
5581                     .text:	section	.text,new
5582  0000               _TIM2_SelectHallSensor:
5586                     ; 2018   assert_param(IS_FUNCTIONAL_STATE(NewState));
5588                     ; 2021   if (NewState != DISABLE)
5590  0000 4d            	tnz	a
5591  0001 2706          	jreq	L3372
5592                     ; 2023     TIM2->CR2 |= TIM_CR2_TI1S;
5594  0003 721e5251      	bset	21073,#7
5596  0007 2004          	jra	L5372
5597  0009               L3372:
5598                     ; 2027     TIM2->CR2 &= (uint8_t)(~TIM_CR2_TI1S);
5600  0009 721f5251      	bres	21073,#7
5601  000d               L5372:
5602                     ; 2029 }
5605  000d 81            	ret
5677                     ; 2050 static void TI1_Config(TIM2_ICPolarity_TypeDef TIM2_ICPolarity, \
5677                     ; 2051                        TIM2_ICSelection_TypeDef TIM2_ICSelection, \
5677                     ; 2052                        uint8_t TIM2_ICFilter)
5677                     ; 2053 {
5678                     .text:	section	.text,new
5679  0000               L3_TI1_Config:
5681  0000 89            	pushw	x
5682  0001 89            	pushw	x
5683       00000002      OFST:	set	2
5686                     ; 2054   uint8_t tmpccmr1 = 0;
5688  0002 7b02          	ld	a,(OFST+0,sp)
5689  0004 97            	ld	xl,a
5690                     ; 2055   uint8_t tmpicpolarity = TIM2_ICPolarity;
5692  0005 7b03          	ld	a,(OFST+1,sp)
5693  0007 6b01          	ld	(OFST-1,sp),a
5694                     ; 2056   tmpccmr1 = TIM2->CCMR1;
5696  0009 c65259        	ld	a,21081
5697  000c 6b02          	ld	(OFST+0,sp),a
5698                     ; 2059   assert_param(IS_TIM2_IC_POLARITY(TIM2_ICPolarity));
5700                     ; 2060   assert_param(IS_TIM2_IC_SELECTION(TIM2_ICSelection));
5702                     ; 2061   assert_param(IS_TIM2_IC_FILTER(TIM2_ICFilter));
5704                     ; 2064   TIM2->CCER1 &=  (uint8_t)(~TIM_CCER1_CC1E);
5706  000e 7211525b      	bres	21083,#0
5707                     ; 2067   tmpccmr1 &= (uint8_t)(~TIM_CCMR_CCxS) & (uint8_t)(~TIM_CCMR_ICxF);
5709  0012 7b02          	ld	a,(OFST+0,sp)
5710  0014 a40c          	and	a,#12
5711  0016 6b02          	ld	(OFST+0,sp),a
5712                     ; 2068   tmpccmr1 |= (uint8_t)(((uint8_t)(TIM2_ICSelection)) | ((uint8_t)(TIM2_ICFilter << 4)));
5714  0018 7b07          	ld	a,(OFST+5,sp)
5715  001a 97            	ld	xl,a
5716  001b a610          	ld	a,#16
5717  001d 42            	mul	x,a
5718  001e 9f            	ld	a,xl
5719  001f 1a04          	or	a,(OFST+2,sp)
5720  0021 1a02          	or	a,(OFST+0,sp)
5721  0023 6b02          	ld	(OFST+0,sp),a
5722                     ; 2070   TIM2->CCMR1 = tmpccmr1;
5724  0025 7b02          	ld	a,(OFST+0,sp)
5725  0027 c75259        	ld	21081,a
5726                     ; 2073   if (tmpicpolarity == (uint8_t)(TIM2_ICPolarity_Falling))
5728  002a 7b01          	ld	a,(OFST-1,sp)
5729  002c a101          	cp	a,#1
5730  002e 2606          	jrne	L5772
5731                     ; 2075     TIM2->CCER1 |= TIM_CCER1_CC1P;
5733  0030 7212525b      	bset	21083,#1
5735  0034 2004          	jra	L7772
5736  0036               L5772:
5737                     ; 2079     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC1P);
5739  0036 7213525b      	bres	21083,#1
5740  003a               L7772:
5741                     ; 2083   TIM2->CCER1 |=  TIM_CCER1_CC1E;
5743  003a 7210525b      	bset	21083,#0
5744                     ; 2084 }
5747  003e 5b04          	addw	sp,#4
5748  0040 81            	ret
5820                     ; 2101 static void TI2_Config(TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
5820                     ; 2102                        TIM2_ICSelection_TypeDef TIM2_ICSelection,
5820                     ; 2103                        uint8_t TIM2_ICFilter)
5820                     ; 2104 {
5821                     .text:	section	.text,new
5822  0000               L5_TI2_Config:
5824  0000 89            	pushw	x
5825  0001 89            	pushw	x
5826       00000002      OFST:	set	2
5829                     ; 2105   uint8_t tmpccmr2 = 0;
5831  0002 7b02          	ld	a,(OFST+0,sp)
5832  0004 97            	ld	xl,a
5833                     ; 2106   uint8_t tmpicpolarity = TIM2_ICPolarity;
5835  0005 7b03          	ld	a,(OFST+1,sp)
5836  0007 6b01          	ld	(OFST-1,sp),a
5837                     ; 2109   assert_param(IS_TIM2_IC_POLARITY(TIM2_ICPolarity));
5839                     ; 2110   assert_param(IS_TIM2_IC_SELECTION(TIM2_ICSelection));
5841                     ; 2111   assert_param(IS_TIM2_IC_FILTER(TIM2_ICFilter));
5843                     ; 2113   tmpccmr2 = TIM2->CCMR2;
5845  0009 c6525a        	ld	a,21082
5846  000c 6b02          	ld	(OFST+0,sp),a
5847                     ; 2116   TIM2->CCER1 &=  (uint8_t)(~TIM_CCER1_CC2E);
5849  000e 7219525b      	bres	21083,#4
5850                     ; 2119   tmpccmr2 &= (uint8_t)(~TIM_CCMR_CCxS) & (uint8_t)(~TIM_CCMR_ICxF);
5852  0012 7b02          	ld	a,(OFST+0,sp)
5853  0014 a40c          	and	a,#12
5854  0016 6b02          	ld	(OFST+0,sp),a
5855                     ; 2120   tmpccmr2 |= (uint8_t)(((uint8_t)(TIM2_ICSelection)) | ((uint8_t)(TIM2_ICFilter << 4)));
5857  0018 7b07          	ld	a,(OFST+5,sp)
5858  001a 97            	ld	xl,a
5859  001b a610          	ld	a,#16
5860  001d 42            	mul	x,a
5861  001e 9f            	ld	a,xl
5862  001f 1a04          	or	a,(OFST+2,sp)
5863  0021 1a02          	or	a,(OFST+0,sp)
5864  0023 6b02          	ld	(OFST+0,sp),a
5865                     ; 2122   TIM2->CCMR2 = tmpccmr2;
5867  0025 7b02          	ld	a,(OFST+0,sp)
5868  0027 c7525a        	ld	21082,a
5869                     ; 2125   if (tmpicpolarity == TIM2_ICPolarity_Falling)
5871  002a 7b01          	ld	a,(OFST-1,sp)
5872  002c a101          	cp	a,#1
5873  002e 2606          	jrne	L7303
5874                     ; 2127     TIM2->CCER1 |= TIM_CCER1_CC2P ;
5876  0030 721a525b      	bset	21083,#5
5878  0034 2004          	jra	L1403
5879  0036               L7303:
5880                     ; 2131     TIM2->CCER1 &= (uint8_t)(~TIM_CCER1_CC2P) ;
5882  0036 721b525b      	bres	21083,#5
5883  003a               L1403:
5884                     ; 2135   TIM2->CCER1 |=  TIM_CCER1_CC2E;
5886  003a 7218525b      	bset	21083,#4
5887                     ; 2136 }
5890  003e 5b04          	addw	sp,#4
5891  0040 81            	ret
5904                     	xdef	_TIM2_SelectHallSensor
5905                     	xdef	_TIM2_EncoderInterfaceConfig
5906                     	xdef	_TIM2_ETRConfig
5907                     	xdef	_TIM2_SelectMasterSlaveMode
5908                     	xdef	_TIM2_SelectSlaveMode
5909                     	xdef	_TIM2_SelectOutputTrigger
5910                     	xdef	_TIM2_SelectInputTrigger
5911                     	xdef	_TIM2_ETRClockMode2Config
5912                     	xdef	_TIM2_ETRClockMode1Config
5913                     	xdef	_TIM2_TIxExternalClockConfig
5914                     	xdef	_TIM2_InternalClockConfig
5915                     	xdef	_TIM2_SelectCCDMA
5916                     	xdef	_TIM2_DMACmd
5917                     	xdef	_TIM2_ClearITPendingBit
5918                     	xdef	_TIM2_GetITStatus
5919                     	xdef	_TIM2_ClearFlag
5920                     	xdef	_TIM2_GetFlagStatus
5921                     	xdef	_TIM2_GenerateEvent
5922                     	xdef	_TIM2_ITConfig
5923                     	xdef	_TIM2_SetIC2Prescaler
5924                     	xdef	_TIM2_SetIC1Prescaler
5925                     	xdef	_TIM2_GetCapture2
5926                     	xdef	_TIM2_GetCapture1
5927                     	xdef	_TIM2_PWMIConfig
5928                     	xdef	_TIM2_ICInit
5929                     	xdef	_TIM2_CCxCmd
5930                     	xdef	_TIM2_OC2PolarityConfig
5931                     	xdef	_TIM2_OC1PolarityConfig
5932                     	xdef	_TIM2_OC2FastConfig
5933                     	xdef	_TIM2_OC1FastConfig
5934                     	xdef	_TIM2_OC2PreloadConfig
5935                     	xdef	_TIM2_OC1PreloadConfig
5936                     	xdef	_TIM2_ForcedOC2Config
5937                     	xdef	_TIM2_ForcedOC1Config
5938                     	xdef	_TIM2_SetCompare2
5939                     	xdef	_TIM2_SetCompare1
5940                     	xdef	_TIM2_SelectOCxM
5941                     	xdef	_TIM2_CtrlPWMOutputs
5942                     	xdef	_TIM2_BKRConfig
5943                     	xdef	_TIM2_OC2Init
5944                     	xdef	_TIM2_OC1Init
5945                     	xdef	_TIM2_Cmd
5946                     	xdef	_TIM2_SelectOnePulseMode
5947                     	xdef	_TIM2_ARRPreloadConfig
5948                     	xdef	_TIM2_UpdateRequestConfig
5949                     	xdef	_TIM2_UpdateDisableConfig
5950                     	xdef	_TIM2_GetPrescaler
5951                     	xdef	_TIM2_GetCounter
5952                     	xdef	_TIM2_SetAutoreload
5953                     	xdef	_TIM2_SetCounter
5954                     	xdef	_TIM2_CounterModeConfig
5955                     	xdef	_TIM2_PrescalerConfig
5956                     	xdef	_TIM2_TimeBaseInit
5957                     	xdef	_TIM2_DeInit
5976                     	end
