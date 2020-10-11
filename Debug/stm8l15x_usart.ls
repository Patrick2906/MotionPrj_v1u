   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 152                     ; 148 void USART_DeInit(USART_TypeDef* USARTx)
 152                     ; 149 {
 154                     .text:	section	.text,new
 155  0000               _USART_DeInit:
 157  0000 89            	pushw	x
 158       00000000      OFST:	set	0
 161                     ; 153   (void) USARTx->SR;
 163  0001 f6            	ld	a,(x)
 164  0002 97            	ld	xl,a
 165                     ; 154   (void) USARTx->DR;
 167  0003 1e01          	ldw	x,(OFST+1,sp)
 168  0005 e601          	ld	a,(1,x)
 169  0007 97            	ld	xl,a
 170                     ; 156   USARTx->BRR2 = USART_BRR2_RESET_VALUE;  /* Set USART_BRR2 to reset value 0x00 */
 172  0008 1e01          	ldw	x,(OFST+1,sp)
 173  000a 6f03          	clr	(3,x)
 174                     ; 157   USARTx->BRR1 = USART_BRR1_RESET_VALUE;  /* Set USART_BRR1 to reset value 0x00 */
 176  000c 1e01          	ldw	x,(OFST+1,sp)
 177  000e 6f02          	clr	(2,x)
 178                     ; 159   USARTx->CR1 = USART_CR1_RESET_VALUE;  /* Set USART_CR1 to reset value 0x00 */
 180  0010 1e01          	ldw	x,(OFST+1,sp)
 181  0012 6f04          	clr	(4,x)
 182                     ; 160   USARTx->CR2 = USART_CR2_RESET_VALUE;  /* Set USART_CR2 to reset value 0x00 */
 184  0014 1e01          	ldw	x,(OFST+1,sp)
 185  0016 6f05          	clr	(5,x)
 186                     ; 161   USARTx->CR3 = USART_CR3_RESET_VALUE;  /* Set USART_CR3 to reset value 0x00 */
 188  0018 1e01          	ldw	x,(OFST+1,sp)
 189  001a 6f06          	clr	(6,x)
 190                     ; 162   USARTx->CR4 = USART_CR4_RESET_VALUE;  /* Set USART_CR4 to reset value 0x00 */
 192  001c 1e01          	ldw	x,(OFST+1,sp)
 193  001e 6f07          	clr	(7,x)
 194                     ; 163 }
 197  0020 85            	popw	x
 198  0021 81            	ret
 390                     ; 192 void USART_Init(USART_TypeDef* USARTx, uint32_t BaudRate, USART_WordLength_TypeDef
 390                     ; 193                 USART_WordLength, USART_StopBits_TypeDef USART_StopBits,
 390                     ; 194                 USART_Parity_TypeDef USART_Parity,  USART_Mode_TypeDef USART_Mode)
 390                     ; 195 {
 391                     .text:	section	.text,new
 392  0000               _USART_Init:
 394  0000 89            	pushw	x
 395  0001 5204          	subw	sp,#4
 396       00000004      OFST:	set	4
 399                     ; 196   uint32_t BaudRate_Mantissa = 0;
 401  0003 ae0000        	ldw	x,#0
 402  0006 1f03          	ldw	(OFST-1,sp),x
 403  0008 ae0000        	ldw	x,#0
 404  000b 1f01          	ldw	(OFST-3,sp),x
 405                     ; 199   assert_param(IS_USART_BAUDRATE(BaudRate));
 407                     ; 201   assert_param(IS_USART_WORDLENGTH(USART_WordLength));
 409                     ; 203   assert_param(IS_USART_STOPBITS(USART_StopBits));
 411                     ; 205   assert_param(IS_USART_PARITY(USART_Parity));
 413                     ; 207   assert_param(IS_USART_MODE(USART_Mode));
 415                     ; 210   USARTx->CR1 &= (uint8_t)(~(USART_CR1_PCEN | USART_CR1_PS | USART_CR1_M));
 417  000d 1e05          	ldw	x,(OFST+1,sp)
 418  000f e604          	ld	a,(4,x)
 419  0011 a4e9          	and	a,#233
 420  0013 e704          	ld	(4,x),a
 421                     ; 213   USARTx->CR1 |= (uint8_t)((uint8_t)USART_WordLength | (uint8_t)USART_Parity);
 423  0015 1e05          	ldw	x,(OFST+1,sp)
 424  0017 7b0d          	ld	a,(OFST+9,sp)
 425  0019 1a0f          	or	a,(OFST+11,sp)
 426  001b ea04          	or	a,(4,x)
 427  001d e704          	ld	(4,x),a
 428                     ; 216   USARTx->CR3 &= (uint8_t)(~USART_CR3_STOP);
 430  001f 1e05          	ldw	x,(OFST+1,sp)
 431  0021 e606          	ld	a,(6,x)
 432  0023 a4cf          	and	a,#207
 433  0025 e706          	ld	(6,x),a
 434                     ; 218   USARTx->CR3 |= (uint8_t)USART_StopBits;
 436  0027 1e05          	ldw	x,(OFST+1,sp)
 437  0029 e606          	ld	a,(6,x)
 438  002b 1a0e          	or	a,(OFST+10,sp)
 439  002d e706          	ld	(6,x),a
 440                     ; 221   USARTx->BRR1 &= (uint8_t)(~USART_BRR1_DIVM);
 442  002f 1e05          	ldw	x,(OFST+1,sp)
 443  0031 6f02          	clr	(2,x)
 444                     ; 223   USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVM);
 446  0033 1e05          	ldw	x,(OFST+1,sp)
 447  0035 e603          	ld	a,(3,x)
 448  0037 a40f          	and	a,#15
 449  0039 e703          	ld	(3,x),a
 450                     ; 225   USARTx->BRR2 &= (uint8_t)(~USART_BRR2_DIVF);
 452  003b 1e05          	ldw	x,(OFST+1,sp)
 453  003d e603          	ld	a,(3,x)
 454  003f a4f0          	and	a,#240
 455  0041 e703          	ld	(3,x),a
 456                     ; 227   BaudRate_Mantissa  = (uint32_t)(CLK_GetClockFreq() / BaudRate );
 458  0043 cd0000        	call	_CLK_GetClockFreq
 460  0046 96            	ldw	x,sp
 461  0047 1c0009        	addw	x,#OFST+5
 462  004a cd0000        	call	c_ludv
 464  004d 96            	ldw	x,sp
 465  004e 1c0001        	addw	x,#OFST-3
 466  0051 cd0000        	call	c_rtol
 468                     ; 229   USARTx->BRR2 = (uint8_t)((BaudRate_Mantissa >> (uint8_t)8) & (uint8_t)0xF0);
 470  0054 7b03          	ld	a,(OFST-1,sp)
 471  0056 a4f0          	and	a,#240
 472  0058 1e05          	ldw	x,(OFST+1,sp)
 473  005a e703          	ld	(3,x),a
 474                     ; 231   USARTx->BRR2 |= (uint8_t)(BaudRate_Mantissa & (uint8_t)0x0F);
 476  005c 1e05          	ldw	x,(OFST+1,sp)
 477  005e 7b04          	ld	a,(OFST+0,sp)
 478  0060 a40f          	and	a,#15
 479  0062 ea03          	or	a,(3,x)
 480  0064 e703          	ld	(3,x),a
 481                     ; 233   USARTx->BRR1 = (uint8_t)(BaudRate_Mantissa >> (uint8_t)4);
 483  0066 96            	ldw	x,sp
 484  0067 1c0001        	addw	x,#OFST-3
 485  006a cd0000        	call	c_ltor
 487  006d a604          	ld	a,#4
 488  006f cd0000        	call	c_lursh
 490  0072 b603          	ld	a,c_lreg+3
 491  0074 1e05          	ldw	x,(OFST+1,sp)
 492  0076 e702          	ld	(2,x),a
 493                     ; 236   USARTx->CR2 &= (uint8_t)~(USART_CR2_TEN | USART_CR2_REN);
 495  0078 1e05          	ldw	x,(OFST+1,sp)
 496  007a e605          	ld	a,(5,x)
 497  007c a4f3          	and	a,#243
 498  007e e705          	ld	(5,x),a
 499                     ; 238   USARTx->CR2 |= (uint8_t)USART_Mode;
 501  0080 1e05          	ldw	x,(OFST+1,sp)
 502  0082 e605          	ld	a,(5,x)
 503  0084 1a10          	or	a,(OFST+12,sp)
 504  0086 e705          	ld	(5,x),a
 505                     ; 239 }
 508  0088 5b06          	addw	sp,#6
 509  008a 81            	ret
 669                     ; 264 void USART_ClockInit(USART_TypeDef* USARTx, USART_Clock_TypeDef USART_Clock,
 669                     ; 265                      USART_CPOL_TypeDef USART_CPOL, USART_CPHA_TypeDef USART_CPHA,
 669                     ; 266                      USART_LastBit_TypeDef USART_LastBit)
 669                     ; 267 {
 670                     .text:	section	.text,new
 671  0000               _USART_ClockInit:
 673  0000 89            	pushw	x
 674       00000000      OFST:	set	0
 677                     ; 269   assert_param(IS_USART_CLOCK(USART_Clock));
 679                     ; 270   assert_param(IS_USART_CPOL(USART_CPOL));
 681                     ; 271   assert_param(IS_USART_CPHA(USART_CPHA));
 683                     ; 272   assert_param(IS_USART_LASTBIT(USART_LastBit));
 685                     ; 275   USARTx->CR3 &= (uint8_t)~(USART_CR3_CPOL | USART_CR3_CPHA | USART_CR3_LBCL);
 687  0001 e606          	ld	a,(6,x)
 688  0003 a4f8          	and	a,#248
 689  0005 e706          	ld	(6,x),a
 690                     ; 277   USARTx->CR3 |= (uint8_t)((uint8_t)((uint8_t)(USART_CPOL | (uint8_t)USART_CPHA ) | USART_LastBit));
 692  0007 7b06          	ld	a,(OFST+6,sp)
 693  0009 1a07          	or	a,(OFST+7,sp)
 694  000b 1a08          	or	a,(OFST+8,sp)
 695  000d ea06          	or	a,(6,x)
 696  000f e706          	ld	(6,x),a
 697                     ; 279   if (USART_Clock != USART_Clock_Disable)
 699  0011 0d05          	tnz	(OFST+5,sp)
 700  0013 2708          	jreq	L523
 701                     ; 281     USARTx->CR3 |= (uint8_t)(USART_CR3_CLKEN); /* Set the Clock Enable bit */
 703  0015 e606          	ld	a,(6,x)
 704  0017 aa08          	or	a,#8
 705  0019 e706          	ld	(6,x),a
 707  001b 2008          	jra	L723
 708  001d               L523:
 709                     ; 285     USARTx->CR3 &= (uint8_t)(~USART_CR3_CLKEN); /* Clear the Clock Enable bit */
 711  001d 1e01          	ldw	x,(OFST+1,sp)
 712  001f e606          	ld	a,(6,x)
 713  0021 a4f7          	and	a,#247
 714  0023 e706          	ld	(6,x),a
 715  0025               L723:
 716                     ; 287 }
 719  0025 85            	popw	x
 720  0026 81            	ret
 787                     ; 296 void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
 787                     ; 297 {
 788                     .text:	section	.text,new
 789  0000               _USART_Cmd:
 791  0000 89            	pushw	x
 792       00000000      OFST:	set	0
 795                     ; 298   if (NewState != DISABLE)
 797  0001 0d05          	tnz	(OFST+5,sp)
 798  0003 2708          	jreq	L563
 799                     ; 300     USARTx->CR1 &= (uint8_t)(~USART_CR1_USARTD); /**< USART Enable */
 801  0005 e604          	ld	a,(4,x)
 802  0007 a4df          	and	a,#223
 803  0009 e704          	ld	(4,x),a
 805  000b 2008          	jra	L763
 806  000d               L563:
 807                     ; 304     USARTx->CR1 |= USART_CR1_USARTD;  /**< USART Disable (for low power consumption) */
 809  000d 1e01          	ldw	x,(OFST+1,sp)
 810  000f e604          	ld	a,(4,x)
 811  0011 aa20          	or	a,#32
 812  0013 e704          	ld	(4,x),a
 813  0015               L763:
 814                     ; 306 }
 817  0015 85            	popw	x
 818  0016 81            	ret
 864                     ; 329 void USART_SetPrescaler(USART_TypeDef* USARTx, uint8_t USART_Prescaler)
 864                     ; 330 {
 865                     .text:	section	.text,new
 866  0000               _USART_SetPrescaler:
 868  0000 89            	pushw	x
 869       00000000      OFST:	set	0
 872                     ; 332   USARTx->PSCR = USART_Prescaler;
 874  0001 7b05          	ld	a,(OFST+5,sp)
 875  0003 1e01          	ldw	x,(OFST+1,sp)
 876  0005 e70a          	ld	(10,x),a
 877                     ; 333 }
 880  0007 85            	popw	x
 881  0008 81            	ret
 918                     ; 340 void USART_SendBreak(USART_TypeDef* USARTx)
 918                     ; 341 {
 919                     .text:	section	.text,new
 920  0000               _USART_SendBreak:
 924                     ; 342   USARTx->CR2 |= USART_CR2_SBK;
 926  0000 e605          	ld	a,(5,x)
 927  0002 aa01          	or	a,#1
 928  0004 e705          	ld	(5,x),a
 929                     ; 343 }
 932  0006 81            	ret
 969                     ; 382 uint8_t USART_ReceiveData8(USART_TypeDef* USARTx)
 969                     ; 383 {
 970                     .text:	section	.text,new
 971  0000               _USART_ReceiveData8:
 975                     ; 384   return USARTx->DR;
 977  0000 e601          	ld	a,(1,x)
 980  0002 81            	ret
1026                     ; 392 uint16_t USART_ReceiveData9(USART_TypeDef* USARTx)
1026                     ; 393 {
1027                     .text:	section	.text,new
1028  0000               _USART_ReceiveData9:
1030  0000 89            	pushw	x
1031  0001 89            	pushw	x
1032       00000002      OFST:	set	2
1035                     ; 394   uint16_t temp = 0;
1037  0002 5f            	clrw	x
1038  0003 1f01          	ldw	(OFST-1,sp),x
1039                     ; 396   temp = ((uint16_t)(((uint16_t)((uint16_t)USARTx->CR1 & (uint16_t)USART_CR1_R8)) << 1));
1041  0005 1e03          	ldw	x,(OFST+1,sp)
1042  0007 e604          	ld	a,(4,x)
1043  0009 5f            	clrw	x
1044  000a a480          	and	a,#128
1045  000c 5f            	clrw	x
1046  000d 02            	rlwa	x,a
1047  000e 58            	sllw	x
1048  000f 1f01          	ldw	(OFST-1,sp),x
1049                     ; 397   return (uint16_t)( ((uint16_t)((uint16_t)USARTx->DR) | temp) & ((uint16_t)0x01FF));
1051  0011 1e03          	ldw	x,(OFST+1,sp)
1052  0013 e601          	ld	a,(1,x)
1053  0015 5f            	clrw	x
1054  0016 97            	ld	xl,a
1055  0017 01            	rrwa	x,a
1056  0018 1a02          	or	a,(OFST+0,sp)
1057  001a 01            	rrwa	x,a
1058  001b 1a01          	or	a,(OFST-1,sp)
1059  001d 01            	rrwa	x,a
1060  001e 01            	rrwa	x,a
1061  001f a4ff          	and	a,#255
1062  0021 01            	rrwa	x,a
1063  0022 a401          	and	a,#1
1064  0024 01            	rrwa	x,a
1067  0025 5b04          	addw	sp,#4
1068  0027 81            	ret
1114                     ; 405 void USART_SendData8(USART_TypeDef* USARTx, uint8_t Data)
1114                     ; 406 {
1115                     .text:	section	.text,new
1116  0000               _USART_SendData8:
1118  0000 89            	pushw	x
1119       00000000      OFST:	set	0
1122                     ; 408   USARTx->DR = Data;
1124  0001 7b05          	ld	a,(OFST+5,sp)
1125  0003 1e01          	ldw	x,(OFST+1,sp)
1126  0005 e701          	ld	(1,x),a
1127                     ; 409 }
1130  0007 85            	popw	x
1131  0008 81            	ret
1177                     ; 418 void USART_SendData9(USART_TypeDef* USARTx, uint16_t Data)
1177                     ; 419 {
1178                     .text:	section	.text,new
1179  0000               _USART_SendData9:
1181  0000 89            	pushw	x
1182       00000000      OFST:	set	0
1185                     ; 420   assert_param(IS_USART_DATA_9BITS(Data));
1187                     ; 423   USARTx->CR1 &= ((uint8_t)~USART_CR1_T8);
1189  0001 e604          	ld	a,(4,x)
1190  0003 a4bf          	and	a,#191
1191  0005 e704          	ld	(4,x),a
1192                     ; 426   USARTx->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & USART_CR1_T8);
1194  0007 1605          	ldw	y,(OFST+5,sp)
1195  0009 9054          	srlw	y
1196  000b 9054          	srlw	y
1197  000d 909f          	ld	a,yl
1198  000f a440          	and	a,#64
1199  0011 ea04          	or	a,(4,x)
1200  0013 e704          	ld	(4,x),a
1201                     ; 429   USARTx->DR   = (uint8_t)(Data);
1203  0015 7b06          	ld	a,(OFST+6,sp)
1204  0017 1e01          	ldw	x,(OFST+1,sp)
1205  0019 e701          	ld	(1,x),a
1206                     ; 430 }
1209  001b 85            	popw	x
1210  001c 81            	ret
1258                     ; 473 void USART_ReceiverWakeUpCmd(USART_TypeDef* USARTx, FunctionalState NewState)
1258                     ; 474 {
1259                     .text:	section	.text,new
1260  0000               _USART_ReceiverWakeUpCmd:
1262  0000 89            	pushw	x
1263       00000000      OFST:	set	0
1266                     ; 475   assert_param(IS_FUNCTIONAL_STATE(NewState));
1268                     ; 477   if (NewState != DISABLE)
1270  0001 0d05          	tnz	(OFST+5,sp)
1271  0003 2708          	jreq	L575
1272                     ; 480     USARTx->CR2 |= USART_CR2_RWU;
1274  0005 e605          	ld	a,(5,x)
1275  0007 aa02          	or	a,#2
1276  0009 e705          	ld	(5,x),a
1278  000b 2008          	jra	L775
1279  000d               L575:
1280                     ; 485     USARTx->CR2 &= ((uint8_t)~USART_CR2_RWU);
1282  000d 1e01          	ldw	x,(OFST+1,sp)
1283  000f e605          	ld	a,(5,x)
1284  0011 a4fd          	and	a,#253
1285  0013 e705          	ld	(5,x),a
1286  0015               L775:
1287                     ; 487 }
1290  0015 85            	popw	x
1291  0016 81            	ret
1337                     ; 496 void USART_SetAddress(USART_TypeDef* USARTx, uint8_t USART_Address)
1337                     ; 497 {
1338                     .text:	section	.text,new
1339  0000               _USART_SetAddress:
1341  0000 89            	pushw	x
1342       00000000      OFST:	set	0
1345                     ; 499   assert_param(IS_USART_ADDRESS(USART_Address));
1347                     ; 502   USARTx->CR4 &= ((uint8_t)~USART_CR4_ADD);
1349  0001 e607          	ld	a,(7,x)
1350  0003 a4f0          	and	a,#240
1351  0005 e707          	ld	(7,x),a
1352                     ; 504   USARTx->CR4 |= USART_Address;
1354  0007 e607          	ld	a,(7,x)
1355  0009 1a05          	or	a,(OFST+5,sp)
1356  000b e707          	ld	(7,x),a
1357                     ; 505 }
1360  000d 85            	popw	x
1361  000e 81            	ret
1430                     ; 515 void USART_WakeUpConfig(USART_TypeDef* USARTx, USART_WakeUp_TypeDef USART_WakeUp)
1430                     ; 516 {
1431                     .text:	section	.text,new
1432  0000               _USART_WakeUpConfig:
1434  0000 89            	pushw	x
1435       00000000      OFST:	set	0
1438                     ; 517   assert_param(IS_USART_WAKEUP(USART_WakeUp));
1440                     ; 519   USARTx->CR1 &= ((uint8_t)~USART_CR1_WAKE);
1442  0001 e604          	ld	a,(4,x)
1443  0003 a4f7          	and	a,#247
1444  0005 e704          	ld	(4,x),a
1445                     ; 520   USARTx->CR1 |= (uint8_t)USART_WakeUp;
1447  0007 e604          	ld	a,(4,x)
1448  0009 1a05          	or	a,(OFST+5,sp)
1449  000b e704          	ld	(4,x),a
1450                     ; 521 }
1453  000d 85            	popw	x
1454  000e 81            	ret
1502                     ; 566 void USART_HalfDuplexCmd(USART_TypeDef* USARTx, FunctionalState NewState)
1502                     ; 567 {
1503                     .text:	section	.text,new
1504  0000               _USART_HalfDuplexCmd:
1506  0000 89            	pushw	x
1507       00000000      OFST:	set	0
1510                     ; 568   assert_param(IS_FUNCTIONAL_STATE(NewState));
1512                     ; 570   if (NewState != DISABLE)
1514  0001 0d05          	tnz	(OFST+5,sp)
1515  0003 2708          	jreq	L507
1516                     ; 572     USARTx->CR5 |= USART_CR5_HDSEL;  /**< USART Half Duplex Enable  */
1518  0005 e608          	ld	a,(8,x)
1519  0007 aa08          	or	a,#8
1520  0009 e708          	ld	(8,x),a
1522  000b 2008          	jra	L707
1523  000d               L507:
1524                     ; 576     USARTx->CR5 &= (uint8_t)~USART_CR5_HDSEL; /**< USART Half Duplex Disable */
1526  000d 1e01          	ldw	x,(OFST+1,sp)
1527  000f e608          	ld	a,(8,x)
1528  0011 a4f7          	and	a,#247
1529  0013 e708          	ld	(8,x),a
1530  0015               L707:
1531                     ; 578 }
1534  0015 85            	popw	x
1535  0016 81            	ret
1582                     ; 644 void USART_SmartCardCmd(USART_TypeDef* USARTx, FunctionalState NewState)
1582                     ; 645 {
1583                     .text:	section	.text,new
1584  0000               _USART_SmartCardCmd:
1586  0000 89            	pushw	x
1587       00000000      OFST:	set	0
1590                     ; 646   assert_param(IS_FUNCTIONAL_STATE(NewState));
1592                     ; 648   if (NewState != DISABLE)
1594  0001 0d05          	tnz	(OFST+5,sp)
1595  0003 2708          	jreq	L537
1596                     ; 651     USARTx->CR5 |= USART_CR5_SCEN;
1598  0005 e608          	ld	a,(8,x)
1599  0007 aa20          	or	a,#32
1600  0009 e708          	ld	(8,x),a
1602  000b 2008          	jra	L737
1603  000d               L537:
1604                     ; 656     USARTx->CR5 &= ((uint8_t)(~USART_CR5_SCEN));
1606  000d 1e01          	ldw	x,(OFST+1,sp)
1607  000f e608          	ld	a,(8,x)
1608  0011 a4df          	and	a,#223
1609  0013 e708          	ld	(8,x),a
1610  0015               L737:
1611                     ; 658 }
1614  0015 85            	popw	x
1615  0016 81            	ret
1663                     ; 667 void USART_SmartCardNACKCmd(USART_TypeDef* USARTx, FunctionalState NewState)
1663                     ; 668 {
1664                     .text:	section	.text,new
1665  0000               _USART_SmartCardNACKCmd:
1667  0000 89            	pushw	x
1668       00000000      OFST:	set	0
1671                     ; 669   assert_param(IS_FUNCTIONAL_STATE(NewState));
1673                     ; 671   if (NewState != DISABLE)
1675  0001 0d05          	tnz	(OFST+5,sp)
1676  0003 2708          	jreq	L567
1677                     ; 674     USARTx->CR5 |= USART_CR5_NACK;
1679  0005 e608          	ld	a,(8,x)
1680  0007 aa10          	or	a,#16
1681  0009 e708          	ld	(8,x),a
1683  000b 2008          	jra	L767
1684  000d               L567:
1685                     ; 679     USARTx->CR5 &= ((uint8_t)~(USART_CR5_NACK));
1687  000d 1e01          	ldw	x,(OFST+1,sp)
1688  000f e608          	ld	a,(8,x)
1689  0011 a4ef          	and	a,#239
1690  0013 e708          	ld	(8,x),a
1691  0015               L767:
1692                     ; 681 }
1695  0015 85            	popw	x
1696  0016 81            	ret
1742                     ; 690 void USART_SetGuardTime(USART_TypeDef* USARTx, uint8_t USART_GuardTime)
1742                     ; 691 {
1743                     .text:	section	.text,new
1744  0000               _USART_SetGuardTime:
1746  0000 89            	pushw	x
1747       00000000      OFST:	set	0
1750                     ; 693   USARTx->GTR = USART_GuardTime;
1752  0001 7b05          	ld	a,(OFST+5,sp)
1753  0003 1e01          	ldw	x,(OFST+1,sp)
1754  0005 e709          	ld	(9,x),a
1755                     ; 694 }
1758  0007 85            	popw	x
1759  0008 81            	ret
1828                     ; 751 void USART_IrDAConfig(USART_TypeDef* USARTx, USART_IrDAMode_TypeDef USART_IrDAMode)
1828                     ; 752 {
1829                     .text:	section	.text,new
1830  0000               _USART_IrDAConfig:
1832  0000 89            	pushw	x
1833       00000000      OFST:	set	0
1836                     ; 753   assert_param(IS_USART_IRDAMODE(USART_IrDAMode));
1838                     ; 755   if (USART_IrDAMode != USART_IrDAMode_Normal)
1840  0001 0d05          	tnz	(OFST+5,sp)
1841  0003 2708          	jreq	L1501
1842                     ; 757     USARTx->CR5 |= USART_CR5_IRLP;
1844  0005 e608          	ld	a,(8,x)
1845  0007 aa04          	or	a,#4
1846  0009 e708          	ld	(8,x),a
1848  000b 2008          	jra	L3501
1849  000d               L1501:
1850                     ; 761     USARTx->CR5 &= ((uint8_t)~USART_CR5_IRLP);
1852  000d 1e01          	ldw	x,(OFST+1,sp)
1853  000f e608          	ld	a,(8,x)
1854  0011 a4fb          	and	a,#251
1855  0013 e708          	ld	(8,x),a
1856  0015               L3501:
1857                     ; 763 }
1860  0015 85            	popw	x
1861  0016 81            	ret
1908                     ; 772 void USART_IrDACmd(USART_TypeDef* USARTx, FunctionalState NewState)
1908                     ; 773 {
1909                     .text:	section	.text,new
1910  0000               _USART_IrDACmd:
1912  0000 89            	pushw	x
1913       00000000      OFST:	set	0
1916                     ; 776   assert_param(IS_FUNCTIONAL_STATE(NewState));
1918                     ; 778   if (NewState != DISABLE)
1920  0001 0d05          	tnz	(OFST+5,sp)
1921  0003 2708          	jreq	L1011
1922                     ; 781     USARTx->CR5 |= USART_CR5_IREN;
1924  0005 e608          	ld	a,(8,x)
1925  0007 aa02          	or	a,#2
1926  0009 e708          	ld	(8,x),a
1928  000b 2008          	jra	L3011
1929  000d               L1011:
1930                     ; 786     USARTx->CR5 &= ((uint8_t)~USART_CR5_IREN);
1932  000d 1e01          	ldw	x,(OFST+1,sp)
1933  000f e608          	ld	a,(8,x)
1934  0011 a4fd          	and	a,#253
1935  0013 e708          	ld	(8,x),a
1936  0015               L3011:
1937                     ; 788 }
1940  0015 85            	popw	x
1941  0016 81            	ret
2018                     ; 818 void USART_DMACmd(USART_TypeDef* USARTx, USART_DMAReq_TypeDef USART_DMAReq,
2018                     ; 819                   FunctionalState NewState)
2018                     ; 820 {
2019                     .text:	section	.text,new
2020  0000               _USART_DMACmd:
2022  0000 89            	pushw	x
2023       00000000      OFST:	set	0
2026                     ; 822   assert_param(IS_USART_DMAREQ(USART_DMAReq));
2028                     ; 823   assert_param(IS_FUNCTIONAL_STATE(NewState));
2030                     ; 825   if (NewState != DISABLE)
2032  0001 0d06          	tnz	(OFST+6,sp)
2033  0003 2708          	jreq	L5411
2034                     ; 829     USARTx->CR5 |= (uint8_t) USART_DMAReq;
2036  0005 e608          	ld	a,(8,x)
2037  0007 1a05          	or	a,(OFST+5,sp)
2038  0009 e708          	ld	(8,x),a
2040  000b 2009          	jra	L7411
2041  000d               L5411:
2042                     ; 835     USARTx->CR5 &= (uint8_t)~USART_DMAReq;
2044  000d 1e01          	ldw	x,(OFST+1,sp)
2045  000f 7b05          	ld	a,(OFST+5,sp)
2046  0011 43            	cpl	a
2047  0012 e408          	and	a,(8,x)
2048  0014 e708          	ld	(8,x),a
2049  0016               L7411:
2050                     ; 837 }
2053  0016 85            	popw	x
2054  0017 81            	ret
2198                     ; 939 void USART_ITConfig(USART_TypeDef* USARTx, USART_IT_TypeDef USART_IT, FunctionalState NewState)
2198                     ; 940 {
2199                     .text:	section	.text,new
2200  0000               _USART_ITConfig:
2202  0000 89            	pushw	x
2203  0001 89            	pushw	x
2204       00000002      OFST:	set	2
2207                     ; 941   uint8_t usartreg, itpos = 0x00;
2209  0002 7b02          	ld	a,(OFST+0,sp)
2210  0004 97            	ld	xl,a
2211                     ; 942   assert_param(IS_USART_CONFIG_IT(USART_IT));
2213                     ; 943   assert_param(IS_FUNCTIONAL_STATE(NewState));
2215                     ; 946   usartreg = (uint8_t)((uint16_t)USART_IT >> 0x08);
2217  0005 7b07          	ld	a,(OFST+5,sp)
2218  0007 6b01          	ld	(OFST-1,sp),a
2219                     ; 948   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)USART_IT & (uint8_t)0x0F));
2221  0009 7b08          	ld	a,(OFST+6,sp)
2222  000b a40f          	and	a,#15
2223  000d 5f            	clrw	x
2224  000e 97            	ld	xl,a
2225  000f a601          	ld	a,#1
2226  0011 5d            	tnzw	x
2227  0012 2704          	jreq	L65
2228  0014               L06:
2229  0014 48            	sll	a
2230  0015 5a            	decw	x
2231  0016 26fc          	jrne	L06
2232  0018               L65:
2233  0018 6b02          	ld	(OFST+0,sp),a
2234                     ; 950   if (NewState != DISABLE)
2236  001a 0d09          	tnz	(OFST+7,sp)
2237  001c 272a          	jreq	L7321
2238                     ; 953     if (usartreg == 0x01)
2240  001e 7b01          	ld	a,(OFST-1,sp)
2241  0020 a101          	cp	a,#1
2242  0022 260a          	jrne	L1421
2243                     ; 955       USARTx->CR1 |= itpos;
2245  0024 1e03          	ldw	x,(OFST+1,sp)
2246  0026 e604          	ld	a,(4,x)
2247  0028 1a02          	or	a,(OFST+0,sp)
2248  002a e704          	ld	(4,x),a
2250  002c 2045          	jra	L1521
2251  002e               L1421:
2252                     ; 957     else if (usartreg == 0x05)
2254  002e 7b01          	ld	a,(OFST-1,sp)
2255  0030 a105          	cp	a,#5
2256  0032 260a          	jrne	L5421
2257                     ; 959       USARTx->CR5 |= itpos;
2259  0034 1e03          	ldw	x,(OFST+1,sp)
2260  0036 e608          	ld	a,(8,x)
2261  0038 1a02          	or	a,(OFST+0,sp)
2262  003a e708          	ld	(8,x),a
2264  003c 2035          	jra	L1521
2265  003e               L5421:
2266                     ; 964       USARTx->CR2 |= itpos;
2268  003e 1e03          	ldw	x,(OFST+1,sp)
2269  0040 e605          	ld	a,(5,x)
2270  0042 1a02          	or	a,(OFST+0,sp)
2271  0044 e705          	ld	(5,x),a
2272  0046 202b          	jra	L1521
2273  0048               L7321:
2274                     ; 970     if (usartreg == 0x01)
2276  0048 7b01          	ld	a,(OFST-1,sp)
2277  004a a101          	cp	a,#1
2278  004c 260b          	jrne	L3521
2279                     ; 972       USARTx->CR1 &= (uint8_t)(~itpos);
2281  004e 1e03          	ldw	x,(OFST+1,sp)
2282  0050 7b02          	ld	a,(OFST+0,sp)
2283  0052 43            	cpl	a
2284  0053 e404          	and	a,(4,x)
2285  0055 e704          	ld	(4,x),a
2287  0057 201a          	jra	L1521
2288  0059               L3521:
2289                     ; 974     else if (usartreg == 0x05)
2291  0059 7b01          	ld	a,(OFST-1,sp)
2292  005b a105          	cp	a,#5
2293  005d 260b          	jrne	L7521
2294                     ; 976       USARTx->CR5 &= (uint8_t)(~itpos);
2296  005f 1e03          	ldw	x,(OFST+1,sp)
2297  0061 7b02          	ld	a,(OFST+0,sp)
2298  0063 43            	cpl	a
2299  0064 e408          	and	a,(8,x)
2300  0066 e708          	ld	(8,x),a
2302  0068 2009          	jra	L1521
2303  006a               L7521:
2304                     ; 981       USARTx->CR2 &= (uint8_t)(~itpos);
2306  006a 1e03          	ldw	x,(OFST+1,sp)
2307  006c 7b02          	ld	a,(OFST+0,sp)
2308  006e 43            	cpl	a
2309  006f e405          	and	a,(5,x)
2310  0071 e705          	ld	(5,x),a
2311  0073               L1521:
2312                     ; 984 }
2315  0073 5b04          	addw	sp,#4
2316  0075 81            	ret
2464                     ; 1002 FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
2464                     ; 1003 {
2465                     .text:	section	.text,new
2466  0000               _USART_GetFlagStatus:
2468  0000 89            	pushw	x
2469  0001 88            	push	a
2470       00000001      OFST:	set	1
2473                     ; 1004   FlagStatus status = RESET;
2475  0002 0f01          	clr	(OFST+0,sp)
2476                     ; 1007   assert_param(IS_USART_FLAG(USART_FLAG));
2478                     ; 1009   if (USART_FLAG == USART_FLAG_SBK)
2480  0004 1e06          	ldw	x,(OFST+5,sp)
2481  0006 a30101        	cpw	x,#257
2482  0009 2612          	jrne	L1531
2483                     ; 1011     if ((USARTx->CR2 & (uint8_t)USART_FLAG) != (uint8_t)0x00)
2485  000b 1e02          	ldw	x,(OFST+1,sp)
2486  000d e605          	ld	a,(5,x)
2487  000f 1507          	bcp	a,(OFST+6,sp)
2488  0011 2706          	jreq	L3531
2489                     ; 1014       status = SET;
2491  0013 a601          	ld	a,#1
2492  0015 6b01          	ld	(OFST+0,sp),a
2494  0017 2013          	jra	L7531
2495  0019               L3531:
2496                     ; 1019       status = RESET;
2498  0019 0f01          	clr	(OFST+0,sp)
2499  001b 200f          	jra	L7531
2500  001d               L1531:
2501                     ; 1024     if ((USARTx->SR & (uint8_t)USART_FLAG) != (uint8_t)0x00)
2503  001d 1e02          	ldw	x,(OFST+1,sp)
2504  001f f6            	ld	a,(x)
2505  0020 1507          	bcp	a,(OFST+6,sp)
2506  0022 2706          	jreq	L1631
2507                     ; 1027       status = SET;
2509  0024 a601          	ld	a,#1
2510  0026 6b01          	ld	(OFST+0,sp),a
2512  0028 2002          	jra	L7531
2513  002a               L1631:
2514                     ; 1032       status = RESET;
2516  002a 0f01          	clr	(OFST+0,sp)
2517  002c               L7531:
2518                     ; 1036   return status;
2520  002c 7b01          	ld	a,(OFST+0,sp)
2523  002e 5b03          	addw	sp,#3
2524  0030 81            	ret
2571                     ; 1060 void USART_ClearFlag(USART_TypeDef* USARTx, USART_FLAG_TypeDef USART_FLAG)
2571                     ; 1061 {
2572                     .text:	section	.text,new
2573  0000               _USART_ClearFlag:
2575  0000 89            	pushw	x
2576       00000000      OFST:	set	0
2579                     ; 1063   assert_param(IS_USART_CLEAR_FLAG(USART_FLAG));
2581                     ; 1065   USARTx->SR = (uint8_t)((uint16_t)~((uint16_t)USART_FLAG));
2583  0001 7b06          	ld	a,(OFST+6,sp)
2584  0003 43            	cpl	a
2585  0004 1e01          	ldw	x,(OFST+1,sp)
2586  0006 f7            	ld	(x),a
2587                     ; 1066 }
2590  0007 85            	popw	x
2591  0008 81            	ret
2694                     ; 1083 ITStatus USART_GetITStatus(USART_TypeDef* USARTx, USART_IT_TypeDef USART_IT)
2694                     ; 1084 {
2695                     .text:	section	.text,new
2696  0000               _USART_GetITStatus:
2698  0000 89            	pushw	x
2699  0001 5203          	subw	sp,#3
2700       00000003      OFST:	set	3
2703                     ; 1085   ITStatus pendingbitstatus = RESET;
2705  0003 7b03          	ld	a,(OFST+0,sp)
2706  0005 97            	ld	xl,a
2707                     ; 1086   uint8_t temp = 0;
2709  0006 7b01          	ld	a,(OFST-2,sp)
2710  0008 97            	ld	xl,a
2711                     ; 1087   uint8_t itpos = 0;
2713  0009 7b02          	ld	a,(OFST-1,sp)
2714  000b 97            	ld	xl,a
2715                     ; 1088   uint8_t itmask1 = 0;
2717  000c 7b03          	ld	a,(OFST+0,sp)
2718  000e 97            	ld	xl,a
2719                     ; 1089   uint8_t itmask2 = 0;
2721  000f 7b03          	ld	a,(OFST+0,sp)
2722  0011 97            	ld	xl,a
2723                     ; 1090   uint8_t enablestatus = 0;
2725  0012 7b03          	ld	a,(OFST+0,sp)
2726  0014 97            	ld	xl,a
2727                     ; 1093   assert_param(IS_USART_GET_IT(USART_IT));
2729                     ; 1096   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)USART_IT & (uint8_t)0x0F));
2731  0015 7b09          	ld	a,(OFST+6,sp)
2732  0017 a40f          	and	a,#15
2733  0019 5f            	clrw	x
2734  001a 97            	ld	xl,a
2735  001b a601          	ld	a,#1
2736  001d 5d            	tnzw	x
2737  001e 2704          	jreq	L07
2738  0020               L27:
2739  0020 48            	sll	a
2740  0021 5a            	decw	x
2741  0022 26fc          	jrne	L27
2742  0024               L07:
2743  0024 6b02          	ld	(OFST-1,sp),a
2744                     ; 1098   itmask1 = (uint8_t)((uint8_t)USART_IT >> (uint8_t)4);
2746  0026 7b09          	ld	a,(OFST+6,sp)
2747  0028 4e            	swap	a
2748  0029 a40f          	and	a,#15
2749  002b 6b03          	ld	(OFST+0,sp),a
2750                     ; 1100   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2752  002d 7b03          	ld	a,(OFST+0,sp)
2753  002f 5f            	clrw	x
2754  0030 97            	ld	xl,a
2755  0031 a601          	ld	a,#1
2756  0033 5d            	tnzw	x
2757  0034 2704          	jreq	L47
2758  0036               L67:
2759  0036 48            	sll	a
2760  0037 5a            	decw	x
2761  0038 26fc          	jrne	L67
2762  003a               L47:
2763  003a 6b03          	ld	(OFST+0,sp),a
2764                     ; 1103   if (USART_IT == USART_IT_PE)
2766  003c 1e08          	ldw	x,(OFST+5,sp)
2767  003e a30100        	cpw	x,#256
2768  0041 261d          	jrne	L5641
2769                     ; 1106     enablestatus = (uint8_t)((uint8_t)USARTx->CR1 & itmask2);
2771  0043 1e04          	ldw	x,(OFST+1,sp)
2772  0045 e604          	ld	a,(4,x)
2773  0047 1403          	and	a,(OFST+0,sp)
2774  0049 6b03          	ld	(OFST+0,sp),a
2775                     ; 1109     if (((USARTx->SR & itpos) != (uint8_t)0x00) && enablestatus)
2777  004b 1e04          	ldw	x,(OFST+1,sp)
2778  004d f6            	ld	a,(x)
2779  004e 1502          	bcp	a,(OFST-1,sp)
2780  0050 270a          	jreq	L7641
2782  0052 0d03          	tnz	(OFST+0,sp)
2783  0054 2706          	jreq	L7641
2784                     ; 1112       pendingbitstatus = SET;
2786  0056 a601          	ld	a,#1
2787  0058 6b03          	ld	(OFST+0,sp),a
2789  005a 204f          	jra	L3741
2790  005c               L7641:
2791                     ; 1117       pendingbitstatus = RESET;
2793  005c 0f03          	clr	(OFST+0,sp)
2794  005e 204b          	jra	L3741
2795  0060               L5641:
2796                     ; 1121   else if (USART_IT == USART_IT_OR)
2798  0060 1e08          	ldw	x,(OFST+5,sp)
2799  0062 a30235        	cpw	x,#565
2800  0065 2629          	jrne	L5741
2801                     ; 1124     enablestatus = (uint8_t)((uint8_t)USARTx->CR2 & itmask2);
2803  0067 1e04          	ldw	x,(OFST+1,sp)
2804  0069 e605          	ld	a,(5,x)
2805  006b 1403          	and	a,(OFST+0,sp)
2806  006d 6b03          	ld	(OFST+0,sp),a
2807                     ; 1127     temp = (uint8_t)(USARTx->CR5 & USART_CR5_EIE);
2809  006f 1e04          	ldw	x,(OFST+1,sp)
2810  0071 e608          	ld	a,(8,x)
2811  0073 a401          	and	a,#1
2812  0075 6b01          	ld	(OFST-2,sp),a
2813                     ; 1129     if (( (USARTx->SR & itpos) != 0x00) && ((enablestatus || temp)))
2815  0077 1e04          	ldw	x,(OFST+1,sp)
2816  0079 f6            	ld	a,(x)
2817  007a 1502          	bcp	a,(OFST-1,sp)
2818  007c 270e          	jreq	L7741
2820  007e 0d03          	tnz	(OFST+0,sp)
2821  0080 2604          	jrne	L1051
2823  0082 0d01          	tnz	(OFST-2,sp)
2824  0084 2706          	jreq	L7741
2825  0086               L1051:
2826                     ; 1132       pendingbitstatus = SET;
2828  0086 a601          	ld	a,#1
2829  0088 6b03          	ld	(OFST+0,sp),a
2831  008a 201f          	jra	L3741
2832  008c               L7741:
2833                     ; 1137       pendingbitstatus = RESET;
2835  008c 0f03          	clr	(OFST+0,sp)
2836  008e 201b          	jra	L3741
2837  0090               L5741:
2838                     ; 1144     enablestatus = (uint8_t)((uint8_t)USARTx->CR2 & itmask2);
2840  0090 1e04          	ldw	x,(OFST+1,sp)
2841  0092 e605          	ld	a,(5,x)
2842  0094 1403          	and	a,(OFST+0,sp)
2843  0096 6b03          	ld	(OFST+0,sp),a
2844                     ; 1146     if (((USARTx->SR & itpos) != (uint8_t)0x00) && enablestatus)
2846  0098 1e04          	ldw	x,(OFST+1,sp)
2847  009a f6            	ld	a,(x)
2848  009b 1502          	bcp	a,(OFST-1,sp)
2849  009d 270a          	jreq	L7051
2851  009f 0d03          	tnz	(OFST+0,sp)
2852  00a1 2706          	jreq	L7051
2853                     ; 1149       pendingbitstatus = SET;
2855  00a3 a601          	ld	a,#1
2856  00a5 6b03          	ld	(OFST+0,sp),a
2858  00a7 2002          	jra	L3741
2859  00a9               L7051:
2860                     ; 1154       pendingbitstatus = RESET;
2862  00a9 0f03          	clr	(OFST+0,sp)
2863  00ab               L3741:
2864                     ; 1159   return  pendingbitstatus;
2866  00ab 7b03          	ld	a,(OFST+0,sp)
2869  00ad 5b05          	addw	sp,#5
2870  00af 81            	ret
2908                     ; 1183 void USART_ClearITPendingBit(USART_TypeDef* USARTx, USART_IT_TypeDef USART_IT)
2908                     ; 1184 {
2909                     .text:	section	.text,new
2910  0000               _USART_ClearITPendingBit:
2914                     ; 1185   assert_param(IS_USART_CLEAR_IT(USART_IT));
2916                     ; 1188   USARTx->SR &= (uint8_t)(~USART_SR_TC);
2918  0000 f6            	ld	a,(x)
2919  0001 a4bf          	and	a,#191
2920  0003 f7            	ld	(x),a
2921                     ; 1189 }
2924  0004 81            	ret
2937                     	xdef	_USART_ClearITPendingBit
2938                     	xdef	_USART_GetITStatus
2939                     	xdef	_USART_ClearFlag
2940                     	xdef	_USART_GetFlagStatus
2941                     	xdef	_USART_ITConfig
2942                     	xdef	_USART_DMACmd
2943                     	xdef	_USART_IrDACmd
2944                     	xdef	_USART_IrDAConfig
2945                     	xdef	_USART_SetGuardTime
2946                     	xdef	_USART_SmartCardNACKCmd
2947                     	xdef	_USART_SmartCardCmd
2948                     	xdef	_USART_HalfDuplexCmd
2949                     	xdef	_USART_SetAddress
2950                     	xdef	_USART_ReceiverWakeUpCmd
2951                     	xdef	_USART_WakeUpConfig
2952                     	xdef	_USART_ReceiveData9
2953                     	xdef	_USART_ReceiveData8
2954                     	xdef	_USART_SendData9
2955                     	xdef	_USART_SendData8
2956                     	xdef	_USART_SendBreak
2957                     	xdef	_USART_SetPrescaler
2958                     	xdef	_USART_Cmd
2959                     	xdef	_USART_ClockInit
2960                     	xdef	_USART_Init
2961                     	xdef	_USART_DeInit
2962                     	xref	_CLK_GetClockFreq
2963                     	xref.b	c_lreg
2982                     	xref	c_lursh
2983                     	xref	c_ltor
2984                     	xref	c_rtol
2985                     	xref	c_ludv
2986                     	end
