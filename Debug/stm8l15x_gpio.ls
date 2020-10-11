   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  98                     ; 96 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  98                     ; 97 {
 100                     .text:	section	.text,new
 101  0000               _GPIO_DeInit:
 105                     ; 98   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 107  0000 6f04          	clr	(4,x)
 108                     ; 99   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 110  0002 7f            	clr	(x)
 111                     ; 100   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 113  0003 6f02          	clr	(2,x)
 114                     ; 101   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 116  0005 6f03          	clr	(3,x)
 117                     ; 102 }
 120  0007 81            	ret
 276                     ; 133 void GPIO_Init(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 276                     ; 134 {
 277                     .text:	section	.text,new
 278  0000               _GPIO_Init:
 280  0000 89            	pushw	x
 281       00000000      OFST:	set	0
 284                     ; 139   assert_param(IS_GPIO_MODE(GPIO_Mode));
 286                     ; 140   assert_param(IS_GPIO_PIN(GPIO_Pin));
 288                     ; 143   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 290  0001 7b05          	ld	a,(OFST+5,sp)
 291  0003 43            	cpl	a
 292  0004 e404          	and	a,(4,x)
 293  0006 e704          	ld	(4,x),a
 294                     ; 149   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 296  0008 7b06          	ld	a,(OFST+6,sp)
 297  000a a580          	bcp	a,#128
 298  000c 271d          	jreq	L541
 299                     ; 151     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 301  000e 7b06          	ld	a,(OFST+6,sp)
 302  0010 a510          	bcp	a,#16
 303  0012 2706          	jreq	L741
 304                     ; 153       GPIOx->ODR |= GPIO_Pin;
 306  0014 f6            	ld	a,(x)
 307  0015 1a05          	or	a,(OFST+5,sp)
 308  0017 f7            	ld	(x),a
 310  0018 2007          	jra	L151
 311  001a               L741:
 312                     ; 156       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 314  001a 1e01          	ldw	x,(OFST+1,sp)
 315  001c 7b05          	ld	a,(OFST+5,sp)
 316  001e 43            	cpl	a
 317  001f f4            	and	a,(x)
 318  0020 f7            	ld	(x),a
 319  0021               L151:
 320                     ; 159     GPIOx->DDR |= GPIO_Pin;
 322  0021 1e01          	ldw	x,(OFST+1,sp)
 323  0023 e602          	ld	a,(2,x)
 324  0025 1a05          	or	a,(OFST+5,sp)
 325  0027 e702          	ld	(2,x),a
 327  0029 2009          	jra	L351
 328  002b               L541:
 329                     ; 163     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 331  002b 1e01          	ldw	x,(OFST+1,sp)
 332  002d 7b05          	ld	a,(OFST+5,sp)
 333  002f 43            	cpl	a
 334  0030 e402          	and	a,(2,x)
 335  0032 e702          	ld	(2,x),a
 336  0034               L351:
 337                     ; 170   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 339  0034 7b06          	ld	a,(OFST+6,sp)
 340  0036 a540          	bcp	a,#64
 341  0038 270a          	jreq	L551
 342                     ; 172     GPIOx->CR1 |= GPIO_Pin;
 344  003a 1e01          	ldw	x,(OFST+1,sp)
 345  003c e603          	ld	a,(3,x)
 346  003e 1a05          	or	a,(OFST+5,sp)
 347  0040 e703          	ld	(3,x),a
 349  0042 2009          	jra	L751
 350  0044               L551:
 351                     ; 175     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 353  0044 1e01          	ldw	x,(OFST+1,sp)
 354  0046 7b05          	ld	a,(OFST+5,sp)
 355  0048 43            	cpl	a
 356  0049 e403          	and	a,(3,x)
 357  004b e703          	ld	(3,x),a
 358  004d               L751:
 359                     ; 182   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 361  004d 7b06          	ld	a,(OFST+6,sp)
 362  004f a520          	bcp	a,#32
 363  0051 270a          	jreq	L161
 364                     ; 184     GPIOx->CR2 |= GPIO_Pin;
 366  0053 1e01          	ldw	x,(OFST+1,sp)
 367  0055 e604          	ld	a,(4,x)
 368  0057 1a05          	or	a,(OFST+5,sp)
 369  0059 e704          	ld	(4,x),a
 371  005b 2009          	jra	L361
 372  005d               L161:
 373                     ; 187     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 375  005d 1e01          	ldw	x,(OFST+1,sp)
 376  005f 7b05          	ld	a,(OFST+5,sp)
 377  0061 43            	cpl	a
 378  0062 e404          	and	a,(4,x)
 379  0064 e704          	ld	(4,x),a
 380  0066               L361:
 381                     ; 190 }
 384  0066 85            	popw	x
 385  0067 81            	ret
 462                     ; 209 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin, FunctionalState NewState)
 462                     ; 210 {
 463                     .text:	section	.text,new
 464  0000               _GPIO_ExternalPullUpConfig:
 466  0000 89            	pushw	x
 467       00000000      OFST:	set	0
 470                     ; 212   assert_param(IS_GPIO_PIN(GPIO_Pin));
 472                     ; 213   assert_param(IS_FUNCTIONAL_STATE(NewState));
 474                     ; 215   if (NewState != DISABLE) /* External Pull-Up Set*/
 476  0001 0d06          	tnz	(OFST+6,sp)
 477  0003 2708          	jreq	L522
 478                     ; 217     GPIOx->CR1 |= GPIO_Pin;
 480  0005 e603          	ld	a,(3,x)
 481  0007 1a05          	or	a,(OFST+5,sp)
 482  0009 e703          	ld	(3,x),a
 484  000b 2009          	jra	L722
 485  000d               L522:
 486                     ; 220     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 488  000d 1e01          	ldw	x,(OFST+1,sp)
 489  000f 7b05          	ld	a,(OFST+5,sp)
 490  0011 43            	cpl	a
 491  0012 e403          	and	a,(3,x)
 492  0014 e703          	ld	(3,x),a
 493  0016               L722:
 494                     ; 222 }
 497  0016 85            	popw	x
 498  0017 81            	ret
 544                     ; 248 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t GPIO_PortVal)
 544                     ; 249 {
 545                     .text:	section	.text,new
 546  0000               _GPIO_Write:
 548  0000 89            	pushw	x
 549       00000000      OFST:	set	0
 552                     ; 250   GPIOx->ODR = GPIO_PortVal;
 554  0001 7b05          	ld	a,(OFST+5,sp)
 555  0003 1e01          	ldw	x,(OFST+1,sp)
 556  0005 f7            	ld	(x),a
 557                     ; 251 }
 560  0006 85            	popw	x
 561  0007 81            	ret
 721                     ; 270 void GPIO_WriteBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, BitAction GPIO_BitVal)
 721                     ; 271 {
 722                     .text:	section	.text,new
 723  0000               _GPIO_WriteBit:
 725  0000 89            	pushw	x
 726       00000000      OFST:	set	0
 729                     ; 273   assert_param(IS_GPIO_PIN(GPIO_Pin));
 731                     ; 274   assert_param(IS_STATE_VALUE(GPIO_BitVal));
 733                     ; 276   if (GPIO_BitVal != RESET)
 735  0001 0d06          	tnz	(OFST+6,sp)
 736  0003 2706          	jreq	L743
 737                     ; 278     GPIOx->ODR |= GPIO_Pin;
 739  0005 f6            	ld	a,(x)
 740  0006 1a05          	or	a,(OFST+5,sp)
 741  0008 f7            	ld	(x),a
 743  0009 2007          	jra	L153
 744  000b               L743:
 745                     ; 283     GPIOx->ODR &= (uint8_t)(~GPIO_Pin);
 747  000b 1e01          	ldw	x,(OFST+1,sp)
 748  000d 7b05          	ld	a,(OFST+5,sp)
 749  000f 43            	cpl	a
 750  0010 f4            	and	a,(x)
 751  0011 f7            	ld	(x),a
 752  0012               L153:
 753                     ; 285 }
 756  0012 85            	popw	x
 757  0013 81            	ret
 803                     ; 303 void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
 803                     ; 304 {
 804                     .text:	section	.text,new
 805  0000               _GPIO_SetBits:
 807  0000 89            	pushw	x
 808       00000000      OFST:	set	0
 811                     ; 305   GPIOx->ODR |= GPIO_Pin;
 813  0001 f6            	ld	a,(x)
 814  0002 1a05          	or	a,(OFST+5,sp)
 815  0004 f7            	ld	(x),a
 816                     ; 306 }
 819  0005 85            	popw	x
 820  0006 81            	ret
 866                     ; 324 void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
 866                     ; 325 {
 867                     .text:	section	.text,new
 868  0000               _GPIO_ResetBits:
 870  0000 89            	pushw	x
 871       00000000      OFST:	set	0
 874                     ; 326   GPIOx->ODR &= (uint8_t)(~GPIO_Pin);
 876  0001 7b05          	ld	a,(OFST+5,sp)
 877  0003 43            	cpl	a
 878  0004 f4            	and	a,(x)
 879  0005 f7            	ld	(x),a
 880                     ; 327 }
 883  0006 85            	popw	x
 884  0007 81            	ret
 930                     ; 336 void GPIO_ToggleBits(GPIO_TypeDef* GPIOx, uint8_t GPIO_Pin)
 930                     ; 337 {
 931                     .text:	section	.text,new
 932  0000               _GPIO_ToggleBits:
 934  0000 89            	pushw	x
 935       00000000      OFST:	set	0
 938                     ; 338   GPIOx->ODR ^= GPIO_Pin;
 940  0001 f6            	ld	a,(x)
 941  0002 1805          	xor	a,	(OFST+5,sp)
 942  0004 f7            	ld	(x),a
 943                     ; 339 }
 946  0005 85            	popw	x
 947  0006 81            	ret
 984                     ; 347 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 984                     ; 348 {
 985                     .text:	section	.text,new
 986  0000               _GPIO_ReadInputData:
 990                     ; 349   return ((uint8_t)GPIOx->IDR);
 992  0000 e601          	ld	a,(1,x)
 995  0002 81            	ret
1033                     ; 358 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
1033                     ; 359 {
1034                     .text:	section	.text,new
1035  0000               _GPIO_ReadOutputData:
1039                     ; 360   return ((uint8_t)GPIOx->ODR);
1041  0000 f6            	ld	a,(x)
1044  0001 81            	ret
1093                     ; 378 BitStatus GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
1093                     ; 379 {
1094                     .text:	section	.text,new
1095  0000               _GPIO_ReadInputDataBit:
1097  0000 89            	pushw	x
1098       00000000      OFST:	set	0
1101                     ; 380   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
1103  0001 e601          	ld	a,(1,x)
1104  0003 1405          	and	a,(OFST+5,sp)
1107  0005 85            	popw	x
1108  0006 81            	ret
1157                     ; 389 BitStatus GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
1157                     ; 390 {
1158                     .text:	section	.text,new
1159  0000               _GPIO_ReadOutputDataBit:
1161  0000 89            	pushw	x
1162       00000000      OFST:	set	0
1165                     ; 391   return ((BitStatus)(GPIOx->ODR & (uint8_t)GPIO_Pin));
1167  0001 f6            	ld	a,(x)
1168  0002 1405          	and	a,(OFST+5,sp)
1171  0004 85            	popw	x
1172  0005 81            	ret
1185                     	xdef	_GPIO_ReadOutputDataBit
1186                     	xdef	_GPIO_ReadInputDataBit
1187                     	xdef	_GPIO_ReadOutputData
1188                     	xdef	_GPIO_ReadInputData
1189                     	xdef	_GPIO_ToggleBits
1190                     	xdef	_GPIO_ResetBits
1191                     	xdef	_GPIO_SetBits
1192                     	xdef	_GPIO_WriteBit
1193                     	xdef	_GPIO_Write
1194                     	xdef	_GPIO_ExternalPullUpConfig
1195                     	xdef	_GPIO_Init
1196                     	xdef	_GPIO_DeInit
1215                     	end
