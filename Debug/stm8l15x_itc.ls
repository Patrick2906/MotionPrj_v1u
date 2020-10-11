   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 56 uint8_t ITC_GetCPUCC(void)
  32                     ; 57 {
  34                     .text:	section	.text,new
  35  0000               _ITC_GetCPUCC:
  39                     ; 59   _asm("push cc");
  42  0000 8a            push cc
  44                     ; 60   _asm("pop a");
  47  0001 84            pop a
  49                     ; 61   return; /* Ignore compiler warning, the returned value is in A register */
  52  0002 81            	ret
  75                     ; 87 void ITC_DeInit(void)
  75                     ; 88 {
  76                     .text:	section	.text,new
  77  0000               _ITC_DeInit:
  81                     ; 89   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  83  0000 35ff7f70      	mov	32624,#255
  84                     ; 90   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  86  0004 35ff7f71      	mov	32625,#255
  87                     ; 91   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
  89  0008 35ff7f72      	mov	32626,#255
  90                     ; 92   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
  92  000c 35ff7f73      	mov	32627,#255
  93                     ; 93   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
  95  0010 35ff7f74      	mov	32628,#255
  96                     ; 94   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
  98  0014 35ff7f75      	mov	32629,#255
  99                     ; 95   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 101  0018 35ff7f76      	mov	32630,#255
 102                     ; 96   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 104  001c 35ff7f77      	mov	32631,#255
 105                     ; 97 }
 108  0020 81            	ret
 133                     ; 104 uint8_t ITC_GetSoftIntStatus(void)
 133                     ; 105 {
 134                     .text:	section	.text,new
 135  0000               _ITC_GetSoftIntStatus:
 139                     ; 106   return ((uint8_t)(ITC_GetCPUCC() & CPU_SOFT_INT_DISABLED));
 141  0000 cd0000        	call	_ITC_GetCPUCC
 143  0003 a428          	and	a,#40
 146  0005 81            	ret
 432                     .const:	section	.text
 433  0000               L22:
 434  0000 0029          	dc.w	L14
 435  0002 0029          	dc.w	L14
 436  0004 0029          	dc.w	L14
 437  0006 0032          	dc.w	L34
 438  0008 0032          	dc.w	L34
 439  000a 0032          	dc.w	L34
 440  000c 0032          	dc.w	L34
 441  000e 003b          	dc.w	L54
 442  0010 003b          	dc.w	L54
 443  0012 003b          	dc.w	L54
 444  0014 003b          	dc.w	L54
 445  0016 0044          	dc.w	L74
 446  0018 0044          	dc.w	L74
 447  001a 0044          	dc.w	L74
 448  001c 0044          	dc.w	L74
 449  001e 006f          	dc.w	L712
 450  0020 004d          	dc.w	L15
 451  0022 004d          	dc.w	L15
 452  0024 004d          	dc.w	L15
 453  0026 0056          	dc.w	L35
 454  0028 0056          	dc.w	L35
 455  002a 0056          	dc.w	L35
 456  002c 006f          	dc.w	L712
 457  002e 006f          	dc.w	L712
 458  0030 005f          	dc.w	L55
 459  0032 005f          	dc.w	L55
 460  0034 005f          	dc.w	L55
 461  0036 0068          	dc.w	L75
 462  0038 0068          	dc.w	L75
 463                     ; 114 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(IRQn_TypeDef IRQn)
 463                     ; 115 {
 464                     .text:	section	.text,new
 465  0000               _ITC_GetSoftwarePriority:
 467  0000 88            	push	a
 468  0001 89            	pushw	x
 469       00000002      OFST:	set	2
 472                     ; 116   uint8_t Value = 0;
 474  0002 0f02          	clr	(OFST+0,sp)
 475                     ; 117   uint8_t Mask = 0;
 477  0004 7b01          	ld	a,(OFST-1,sp)
 478  0006 97            	ld	xl,a
 479                     ; 120   assert_param(IS_ITC_IRQ(IRQn));
 481                     ; 123   Mask = (uint8_t)(0x03U << ((IRQn % 4U) * 2U));
 483  0007 7b03          	ld	a,(OFST+1,sp)
 484  0009 a403          	and	a,#3
 485  000b 48            	sll	a
 486  000c 5f            	clrw	x
 487  000d 97            	ld	xl,a
 488  000e a603          	ld	a,#3
 489  0010 5d            	tnzw	x
 490  0011 2704          	jreq	L41
 491  0013               L61:
 492  0013 48            	sll	a
 493  0014 5a            	decw	x
 494  0015 26fc          	jrne	L61
 495  0017               L41:
 496  0017 6b01          	ld	(OFST-1,sp),a
 497                     ; 125   switch (IRQn)
 499  0019 7b03          	ld	a,(OFST+1,sp)
 501                     ; 223     default:
 501                     ; 224       break;
 502  001b 4a            	dec	a
 503  001c a11d          	cp	a,#29
 504  001e 2407          	jruge	L02
 505  0020 5f            	clrw	x
 506  0021 97            	ld	xl,a
 507  0022 58            	sllw	x
 508  0023 de0000        	ldw	x,(L22,x)
 509  0026 fc            	jp	(x)
 510  0027               L02:
 511  0027 2046          	jra	L712
 512  0029               L14:
 513                     ; 127     case FLASH_IRQn:
 513                     ; 128     case DMA1_CHANNEL0_1_IRQn:
 513                     ; 129     case DMA1_CHANNEL2_3_IRQn:
 513                     ; 130       Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 515  0029 c67f70        	ld	a,32624
 516  002c 1401          	and	a,(OFST-1,sp)
 517  002e 6b02          	ld	(OFST+0,sp),a
 518                     ; 131       break;
 520  0030 203d          	jra	L712
 521  0032               L34:
 522                     ; 133     case EXTIE_F_PVD_IRQn:
 522                     ; 134 #if defined (STM8L15X_MD) || defined (STM8L05X_MD_VL) || defined (STM8AL31_L_MD)
 522                     ; 135     case RTC_IRQn:
 522                     ; 136     case EXTIB_IRQn:
 522                     ; 137     case EXTID_IRQn:
 522                     ; 138 #elif defined (STM8L15X_LD) || defined (STM8L05X_LD_VL)
 522                     ; 139     case RTC_CSSLSE_IRQn:
 522                     ; 140     case EXTIB_IRQn:
 522                     ; 141     case EXTID_IRQn:
 522                     ; 142 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 522                     ; 143     case RTC_CSSLSE_IRQn:
 522                     ; 144     case EXTIB_G_IRQn:
 522                     ; 145     case EXTID_H_IRQn:
 522                     ; 146 #endif  /* STM8L15X_MD */
 522                     ; 147       Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 524  0032 c67f71        	ld	a,32625
 525  0035 1401          	and	a,(OFST-1,sp)
 526  0037 6b02          	ld	(OFST+0,sp),a
 527                     ; 148       break;
 529  0039 2034          	jra	L712
 530  003b               L54:
 531                     ; 150     case EXTI0_IRQn:
 531                     ; 151     case EXTI1_IRQn:
 531                     ; 152     case EXTI2_IRQn:
 531                     ; 153     case EXTI3_IRQn:
 531                     ; 154       Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 533  003b c67f72        	ld	a,32626
 534  003e 1401          	and	a,(OFST-1,sp)
 535  0040 6b02          	ld	(OFST+0,sp),a
 536                     ; 155       break;
 538  0042 202b          	jra	L712
 539  0044               L74:
 540                     ; 157     case EXTI4_IRQn:
 540                     ; 158     case EXTI5_IRQn:
 540                     ; 159     case EXTI6_IRQn:
 540                     ; 160     case EXTI7_IRQn:
 540                     ; 161       Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 542  0044 c67f73        	ld	a,32627
 543  0047 1401          	and	a,(OFST-1,sp)
 544  0049 6b02          	ld	(OFST+0,sp),a
 545                     ; 162       break;
 547  004b 2022          	jra	L712
 548  004d               L15:
 549                     ; 165     case SWITCH_CSS_IRQn:
 549                     ; 166 #else
 549                     ; 167     case SWITCH_CSS_BREAK_DAC_IRQn:
 549                     ; 168 #endif /* STM8L15X_LD */		
 549                     ; 169     case ADC1_COMP_IRQn:
 549                     ; 170 #if defined (STM8L15X_MD) || defined (STM8L05X_MD_VL) || defined (STM8AL31_L_MD)
 549                     ; 171     case LCD_IRQn:
 549                     ; 172     case TIM2_UPD_OVF_TRG_BRK_IRQn:
 549                     ; 173 #elif defined (STM8L15X_LD) || defined (STM8L05X_LD_VL)
 549                     ; 174     case TIM2_UPD_OVF_TRG_BRK_IRQn:
 549                     ; 175 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 549                     ; 176     case LCD_AES_IRQn:
 549                     ; 177     case TIM2_UPD_OVF_TRG_BRK_USART2_TX_IRQn:
 549                     ; 178 #endif  /* STM8L15X_MD */
 549                     ; 179       Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 551  004d c67f74        	ld	a,32628
 552  0050 1401          	and	a,(OFST-1,sp)
 553  0052 6b02          	ld	(OFST+0,sp),a
 554                     ; 180       break;
 556  0054 2019          	jra	L712
 557  0056               L35:
 558                     ; 187     case TIM2_CC_IRQn:
 558                     ; 188     case TIM3_UPD_OVF_TRG_BRK_IRQn :
 558                     ; 189     case TIM3_CC_IRQn:
 558                     ; 190 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 558                     ; 191     case TIM2_CC_USART2_RX_IRQn:
 558                     ; 192     case TIM3_UPD_OVF_TRG_BRK_USART3_TX_IRQn :
 558                     ; 193     case TIM3_CC_USART3_RX_IRQn:
 558                     ; 194 #endif  /* STM8L15X_MD */
 558                     ; 195       Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 560  0056 c67f75        	ld	a,32629
 561  0059 1401          	and	a,(OFST-1,sp)
 562  005b 6b02          	ld	(OFST+0,sp),a
 563                     ; 196       break;
 565  005d 2010          	jra	L712
 566  005f               L55:
 567                     ; 201     case TIM4_UPD_OVF_TRG_IRQn:
 567                     ; 202     case SPI1_IRQn:
 567                     ; 203 #if defined (STM8L15X_MD) || defined (STM8L15X_LD) || defined (STM8L05X_MD_VL) ||\
 567                     ; 204  defined (STM8AL31_L_MD) || defined (STM8L05X_LD_VL)
 567                     ; 205     case USART1_TX_IRQn:
 567                     ; 206 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 567                     ; 207     case USART1_TX_TIM5_UPD_OVF_TRG_BRK_IRQn:
 567                     ; 208 #endif  /* STM8L15X_MD || STM8L15X_LD */
 567                     ; 209       Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 569  005f c67f76        	ld	a,32630
 570  0062 1401          	and	a,(OFST-1,sp)
 571  0064 6b02          	ld	(OFST+0,sp),a
 572                     ; 210       break;
 574  0066 2007          	jra	L712
 575  0068               L75:
 576                     ; 214     case USART1_RX_IRQn:
 576                     ; 215     case I2C1_IRQn:
 576                     ; 216 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 576                     ; 217     case USART1_RX_TIM5_CC_IRQn:
 576                     ; 218     case I2C1_SPI2_IRQn:
 576                     ; 219 #endif  /* STM8L15X_MD || STM8L15X_LD*/
 576                     ; 220       Value = (uint8_t)(ITC->ISPR8 & Mask); /* Read software priority */
 578  0068 c67f77        	ld	a,32631
 579  006b 1401          	and	a,(OFST-1,sp)
 580  006d 6b02          	ld	(OFST+0,sp),a
 581                     ; 221       break;
 583  006f               L16:
 584                     ; 223     default:
 584                     ; 224       break;
 586  006f               L712:
 587                     ; 227   Value >>= (uint8_t)((IRQn % 4u) * 2u);
 589  006f 7b03          	ld	a,(OFST+1,sp)
 590  0071 a403          	and	a,#3
 591  0073 48            	sll	a
 592  0074 5f            	clrw	x
 593  0075 97            	ld	xl,a
 594  0076 7b02          	ld	a,(OFST+0,sp)
 595  0078 5d            	tnzw	x
 596  0079 2704          	jreq	L42
 597  007b               L62:
 598  007b 44            	srl	a
 599  007c 5a            	decw	x
 600  007d 26fc          	jrne	L62
 601  007f               L42:
 602  007f 6b02          	ld	(OFST+0,sp),a
 603                     ; 229   return((ITC_PriorityLevel_TypeDef)Value);
 605  0081 7b02          	ld	a,(OFST+0,sp)
 608  0083 5b03          	addw	sp,#3
 609  0085 81            	ret
 673                     	switch	.const
 674  003a               L44:
 675  003a 003f          	dc.w	L122
 676  003c 003f          	dc.w	L122
 677  003e 003f          	dc.w	L122
 678  0040 0051          	dc.w	L322
 679  0042 0051          	dc.w	L322
 680  0044 0051          	dc.w	L322
 681  0046 0051          	dc.w	L322
 682  0048 0063          	dc.w	L522
 683  004a 0063          	dc.w	L522
 684  004c 0063          	dc.w	L522
 685  004e 0063          	dc.w	L522
 686  0050 0075          	dc.w	L722
 687  0052 0075          	dc.w	L722
 688  0054 0075          	dc.w	L722
 689  0056 0075          	dc.w	L722
 690  0058 00cd          	dc.w	L772
 691  005a 0087          	dc.w	L132
 692  005c 0087          	dc.w	L132
 693  005e 0087          	dc.w	L132
 694  0060 0099          	dc.w	L332
 695  0062 0099          	dc.w	L332
 696  0064 0099          	dc.w	L332
 697  0066 00cd          	dc.w	L772
 698  0068 00cd          	dc.w	L772
 699  006a 00ab          	dc.w	L532
 700  006c 00ab          	dc.w	L532
 701  006e 00ab          	dc.w	L532
 702  0070 00bd          	dc.w	L732
 703  0072 00bd          	dc.w	L732
 704                     ; 250 void ITC_SetSoftwarePriority(IRQn_TypeDef IRQn, ITC_PriorityLevel_TypeDef ITC_PriorityLevel)
 704                     ; 251 {
 705                     .text:	section	.text,new
 706  0000               _ITC_SetSoftwarePriority:
 708  0000 89            	pushw	x
 709  0001 89            	pushw	x
 710       00000002      OFST:	set	2
 713                     ; 252   uint8_t Mask = 0;
 715  0002 7b01          	ld	a,(OFST-1,sp)
 716  0004 97            	ld	xl,a
 717                     ; 253   uint8_t NewPriority = 0;
 719  0005 7b02          	ld	a,(OFST+0,sp)
 720  0007 97            	ld	xl,a
 721                     ; 256   assert_param(IS_ITC_IRQ(IRQn));
 723                     ; 257   assert_param(IS_ITC_PRIORITY(ITC_PriorityLevel));
 725                     ; 260   assert_param(IS_ITC_INTERRUPTS_DISABLED);
 727                     ; 264   Mask = (uint8_t)(~(uint8_t)(0x03U << ((IRQn % 4U) * 2U)));
 729  0008 7b03          	ld	a,(OFST+1,sp)
 730  000a a403          	and	a,#3
 731  000c 48            	sll	a
 732  000d 5f            	clrw	x
 733  000e 97            	ld	xl,a
 734  000f a603          	ld	a,#3
 735  0011 5d            	tnzw	x
 736  0012 2704          	jreq	L23
 737  0014               L43:
 738  0014 48            	sll	a
 739  0015 5a            	decw	x
 740  0016 26fc          	jrne	L43
 741  0018               L23:
 742  0018 43            	cpl	a
 743  0019 6b01          	ld	(OFST-1,sp),a
 744                     ; 266   NewPriority = (uint8_t)((uint8_t)(ITC_PriorityLevel) << ((IRQn % 4U) * 2U));
 746  001b 7b03          	ld	a,(OFST+1,sp)
 747  001d a403          	and	a,#3
 748  001f 48            	sll	a
 749  0020 5f            	clrw	x
 750  0021 97            	ld	xl,a
 751  0022 7b04          	ld	a,(OFST+2,sp)
 752  0024 5d            	tnzw	x
 753  0025 2704          	jreq	L63
 754  0027               L04:
 755  0027 48            	sll	a
 756  0028 5a            	decw	x
 757  0029 26fc          	jrne	L04
 758  002b               L63:
 759  002b 6b02          	ld	(OFST+0,sp),a
 760                     ; 268   switch (IRQn)
 762  002d 7b03          	ld	a,(OFST+1,sp)
 764                     ; 372     default:
 764                     ; 373       break;
 765  002f 4a            	dec	a
 766  0030 a11d          	cp	a,#29
 767  0032 2407          	jruge	L24
 768  0034 5f            	clrw	x
 769  0035 97            	ld	xl,a
 770  0036 58            	sllw	x
 771  0037 de003a        	ldw	x,(L44,x)
 772  003a fc            	jp	(x)
 773  003b               L24:
 774  003b accd00cd      	jpf	L772
 775  003f               L122:
 776                     ; 270     case FLASH_IRQn:
 776                     ; 271     case DMA1_CHANNEL0_1_IRQn:
 776                     ; 272     case DMA1_CHANNEL2_3_IRQn:
 776                     ; 273       ITC->ISPR1 &= Mask;
 778  003f c67f70        	ld	a,32624
 779  0042 1401          	and	a,(OFST-1,sp)
 780  0044 c77f70        	ld	32624,a
 781                     ; 274       ITC->ISPR1 |= NewPriority;
 783  0047 c67f70        	ld	a,32624
 784  004a 1a02          	or	a,(OFST+0,sp)
 785  004c c77f70        	ld	32624,a
 786                     ; 275       break;
 788  004f 207c          	jra	L772
 789  0051               L322:
 790                     ; 277     case EXTIE_F_PVD_IRQn:
 790                     ; 278 #if defined (STM8L15X_MD) || defined (STM8L05X_MD_VL) || defined (STM8AL31_L_MD)
 790                     ; 279     case RTC_IRQn:
 790                     ; 280     case EXTIB_IRQn:
 790                     ; 281     case EXTID_IRQn:
 790                     ; 282 #elif defined (STM8L15X_LD) || defined (STM8L05X_LD_VL)
 790                     ; 283     case RTC_CSSLSE_IRQn:
 790                     ; 284     case EXTIB_IRQn:
 790                     ; 285     case EXTID_IRQn:
 790                     ; 286 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 790                     ; 287     case RTC_CSSLSE_IRQn:
 790                     ; 288     case EXTIB_G_IRQn:
 790                     ; 289     case EXTID_H_IRQn:
 790                     ; 290 #endif  /* STM8L15X_MD */
 790                     ; 291       ITC->ISPR2 &= Mask;
 792  0051 c67f71        	ld	a,32625
 793  0054 1401          	and	a,(OFST-1,sp)
 794  0056 c77f71        	ld	32625,a
 795                     ; 292       ITC->ISPR2 |= NewPriority;
 797  0059 c67f71        	ld	a,32625
 798  005c 1a02          	or	a,(OFST+0,sp)
 799  005e c77f71        	ld	32625,a
 800                     ; 293       break;
 802  0061 206a          	jra	L772
 803  0063               L522:
 804                     ; 295     case EXTI0_IRQn:
 804                     ; 296     case EXTI1_IRQn:
 804                     ; 297     case EXTI2_IRQn:
 804                     ; 298     case EXTI3_IRQn:
 804                     ; 299       ITC->ISPR3 &= Mask;
 806  0063 c67f72        	ld	a,32626
 807  0066 1401          	and	a,(OFST-1,sp)
 808  0068 c77f72        	ld	32626,a
 809                     ; 300       ITC->ISPR3 |= NewPriority;
 811  006b c67f72        	ld	a,32626
 812  006e 1a02          	or	a,(OFST+0,sp)
 813  0070 c77f72        	ld	32626,a
 814                     ; 301       break;
 816  0073 2058          	jra	L772
 817  0075               L722:
 818                     ; 303     case EXTI4_IRQn:
 818                     ; 304     case EXTI5_IRQn:
 818                     ; 305     case EXTI6_IRQn:
 818                     ; 306     case EXTI7_IRQn:
 818                     ; 307       ITC->ISPR4 &= Mask;
 820  0075 c67f73        	ld	a,32627
 821  0078 1401          	and	a,(OFST-1,sp)
 822  007a c77f73        	ld	32627,a
 823                     ; 308       ITC->ISPR4 |= NewPriority;
 825  007d c67f73        	ld	a,32627
 826  0080 1a02          	or	a,(OFST+0,sp)
 827  0082 c77f73        	ld	32627,a
 828                     ; 309       break;
 830  0085 2046          	jra	L772
 831  0087               L132:
 832                     ; 313     case SWITCH_CSS_IRQn:
 832                     ; 314 #endif /*	STM8L15X_LD	*/
 832                     ; 315     case ADC1_COMP_IRQn:
 832                     ; 316 #if defined (STM8L15X_MD) || defined (STM8L05X_MD_VL) || defined (STM8AL31_L_MD)
 832                     ; 317     case LCD_IRQn:
 832                     ; 318     case TIM2_UPD_OVF_TRG_BRK_IRQn:
 832                     ; 319 #elif defined (STM8L15X_LD) || defined (STM8L05X_LD_VL)
 832                     ; 320     case TIM2_UPD_OVF_TRG_BRK_IRQn:
 832                     ; 321 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 832                     ; 322     case LCD_AES_IRQn:
 832                     ; 323     case TIM2_UPD_OVF_TRG_BRK_USART2_TX_IRQn:
 832                     ; 324 #endif  /* STM8L15X_MD */
 832                     ; 325       ITC->ISPR5 &= Mask;
 834  0087 c67f74        	ld	a,32628
 835  008a 1401          	and	a,(OFST-1,sp)
 836  008c c77f74        	ld	32628,a
 837                     ; 326       ITC->ISPR5 |= NewPriority;
 839  008f c67f74        	ld	a,32628
 840  0092 1a02          	or	a,(OFST+0,sp)
 841  0094 c77f74        	ld	32628,a
 842                     ; 327       break;
 844  0097 2034          	jra	L772
 845  0099               L332:
 846                     ; 333     case TIM2_CC_IRQn:
 846                     ; 334     case TIM3_UPD_OVF_TRG_BRK_IRQn :
 846                     ; 335     case TIM3_CC_IRQn:
 846                     ; 336 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 846                     ; 337     case TIM2_CC_USART2_RX_IRQn:
 846                     ; 338     case TIM3_UPD_OVF_TRG_BRK_USART3_TX_IRQn :
 846                     ; 339     case TIM3_CC_USART3_RX_IRQn:
 846                     ; 340 #endif  /* STM8L15X_MD */
 846                     ; 341       ITC->ISPR6 &= Mask;
 848  0099 c67f75        	ld	a,32629
 849  009c 1401          	and	a,(OFST-1,sp)
 850  009e c77f75        	ld	32629,a
 851                     ; 342       ITC->ISPR6 |= NewPriority;
 853  00a1 c67f75        	ld	a,32629
 854  00a4 1a02          	or	a,(OFST+0,sp)
 855  00a6 c77f75        	ld	32629,a
 856                     ; 343       break;
 858  00a9 2022          	jra	L772
 859  00ab               L532:
 860                     ; 348     case TIM4_UPD_OVF_TRG_IRQn:
 860                     ; 349     case SPI1_IRQn:
 860                     ; 350 #if defined (STM8L15X_MD) || defined (STM8L15X_LD) || defined (STM8L05X_MD_VL) ||\
 860                     ; 351  defined (STM8AL31_L_MD) || defined (STM8L05X_LD_VL)
 860                     ; 352     case USART1_TX_IRQn:
 860                     ; 353 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 860                     ; 354     case USART1_TX_TIM5_UPD_OVF_TRG_BRK_IRQn:
 860                     ; 355 #endif  /* STM8L15X_MD */
 860                     ; 356       ITC->ISPR7 &= Mask;
 862  00ab c67f76        	ld	a,32630
 863  00ae 1401          	and	a,(OFST-1,sp)
 864  00b0 c77f76        	ld	32630,a
 865                     ; 357       ITC->ISPR7 |= NewPriority;
 867  00b3 c67f76        	ld	a,32630
 868  00b6 1a02          	or	a,(OFST+0,sp)
 869  00b8 c77f76        	ld	32630,a
 870                     ; 358       break;
 872  00bb 2010          	jra	L772
 873  00bd               L732:
 874                     ; 362     case USART1_RX_IRQn:
 874                     ; 363     case I2C1_IRQn:
 874                     ; 364 #elif defined (STM8L15X_HD) || defined (STM8L15X_MDP) || defined (STM8L05X_HD_VL)
 874                     ; 365     case USART1_RX_TIM5_CC_IRQn:
 874                     ; 366     case I2C1_SPI2_IRQn:
 874                     ; 367 #endif  /* STM8L15X_MD */
 874                     ; 368       ITC->ISPR8 &= Mask;
 876  00bd c67f77        	ld	a,32631
 877  00c0 1401          	and	a,(OFST-1,sp)
 878  00c2 c77f77        	ld	32631,a
 879                     ; 369       ITC->ISPR8 |= NewPriority;
 881  00c5 c67f77        	ld	a,32631
 882  00c8 1a02          	or	a,(OFST+0,sp)
 883  00ca c77f77        	ld	32631,a
 884                     ; 370       break;
 886  00cd               L142:
 887                     ; 372     default:
 887                     ; 373       break;
 889  00cd               L772:
 890                     ; 375 }
 893  00cd 5b04          	addw	sp,#4
 894  00cf 81            	ret
 907                     	xdef	_ITC_GetSoftwarePriority
 908                     	xdef	_ITC_SetSoftwarePriority
 909                     	xdef	_ITC_GetSoftIntStatus
 910                     	xdef	_ITC_GetCPUCC
 911                     	xdef	_ITC_DeInit
 930                     	end
