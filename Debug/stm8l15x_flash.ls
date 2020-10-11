   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  67                     ; 174 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
  67                     ; 175 {
  69                     .text:	section	.text,new
  70  0000               _FLASH_SetProgrammingTime:
  74                     ; 177   assert_param(IS_FLASH_PROGRAM_TIME(FLASH_ProgTime));
  76                     ; 179   FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
  78  0000 72115050      	bres	20560,#0
  79                     ; 180   FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
  81  0004 ca5050        	or	a,20560
  82  0007 c75050        	ld	20560,a
  83                     ; 181 }
  86  000a 81            	ret
 111                     ; 188 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
 111                     ; 189 {
 112                     .text:	section	.text,new
 113  0000               _FLASH_GetProgrammingTime:
 117                     ; 190   return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
 119  0000 c65050        	ld	a,20560
 120  0003 a401          	and	a,#1
 123  0005 81            	ret
 179                     ; 203 void FLASH_PowerWaitModeConfig(FLASH_Power_TypeDef FLASH_Power)
 179                     ; 204 {
 180                     .text:	section	.text,new
 181  0000               _FLASH_PowerWaitModeConfig:
 185                     ; 206   assert_param(IS_FLASH_POWER(FLASH_Power));
 187                     ; 209   if(FLASH_Power != FLASH_Power_On)
 189  0000 a101          	cp	a,#1
 190  0002 2706          	jreq	L57
 191                     ; 211     FLASH->CR1 |= (uint8_t)FLASH_CR1_WAITM;
 193  0004 72145050      	bset	20560,#2
 195  0008 2004          	jra	L77
 196  000a               L57:
 197                     ; 216     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_WAITM);
 199  000a 72155050      	bres	20560,#2
 200  000e               L77:
 201                     ; 218 }
 204  000e 81            	ret
 227                     ; 259 void FLASH_DeInit(void)
 227                     ; 260 {
 228                     .text:	section	.text,new
 229  0000               _FLASH_DeInit:
 233                     ; 261   FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 235  0000 725f5050      	clr	20560
 236                     ; 262   FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 238  0004 725f5051      	clr	20561
 239                     ; 263   FLASH->IAPSR = FLASH_IAPSR_RESET_VALUE;
 241  0008 35405054      	mov	20564,#64
 242                     ; 264   (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 244  000c c65054        	ld	a,20564
 245  000f 97            	ld	xl,a
 246                     ; 265 }
 249  0010 81            	ret
 305                     ; 275 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
 305                     ; 276 {
 306                     .text:	section	.text,new
 307  0000               _FLASH_Unlock:
 309  0000 88            	push	a
 310       00000000      OFST:	set	0
 313                     ; 278   assert_param(IS_FLASH_MEMORY_TYPE(FLASH_MemType));
 315                     ; 281   if(FLASH_MemType == FLASH_MemType_Program)
 317  0001 a1fd          	cp	a,#253
 318  0003 2608          	jrne	L731
 319                     ; 283     FLASH->PUKR = FLASH_RASS_KEY1;
 321  0005 35565052      	mov	20562,#86
 322                     ; 284     FLASH->PUKR = FLASH_RASS_KEY2;
 324  0009 35ae5052      	mov	20562,#174
 325  000d               L731:
 326                     ; 288   if(FLASH_MemType == FLASH_MemType_Data)
 328  000d 7b01          	ld	a,(OFST+1,sp)
 329  000f a1f7          	cp	a,#247
 330  0011 2608          	jrne	L141
 331                     ; 290     FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 333  0013 35ae5053      	mov	20563,#174
 334                     ; 291     FLASH->DUKR = FLASH_RASS_KEY1;
 336  0017 35565053      	mov	20563,#86
 337  001b               L141:
 338                     ; 293 }
 341  001b 84            	pop	a
 342  001c 81            	ret
 377                     ; 303 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 377                     ; 304 {
 378                     .text:	section	.text,new
 379  0000               _FLASH_Lock:
 383                     ; 306   assert_param(IS_FLASH_MEMORY_TYPE(FLASH_MemType));
 385                     ; 309   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 387  0000 c45054        	and	a,20564
 388  0003 c75054        	ld	20564,a
 389                     ; 310 }
 392  0006 81            	ret
 435                     ; 318 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 435                     ; 319 {
 436                     .text:	section	.text,new
 437  0000               _FLASH_ProgramByte:
 439       00000000      OFST:	set	0
 442                     ; 321   assert_param(IS_FLASH_ADDRESS(Address));
 444                     ; 323   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = Data;
 446  0000 7b07          	ld	a,(OFST+7,sp)
 447  0002 1e05          	ldw	x,(OFST+5,sp)
 448  0004 f7            	ld	(x),a
 449                     ; 324 }
 452  0005 81            	ret
 486                     ; 331 void FLASH_EraseByte(uint32_t Address)
 486                     ; 332 {
 487                     .text:	section	.text,new
 488  0000               _FLASH_EraseByte:
 490       00000000      OFST:	set	0
 493                     ; 334   assert_param(IS_FLASH_ADDRESS(Address));
 495                     ; 336   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = FLASH_CLEAR_BYTE; /* Erase byte */
 497  0000 1e05          	ldw	x,(OFST+5,sp)
 498  0002 7f            	clr	(x)
 499                     ; 337 }
 502  0003 81            	ret
 545                     ; 345 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 545                     ; 346 {
 546                     .text:	section	.text,new
 547  0000               _FLASH_ProgramWord:
 549       00000000      OFST:	set	0
 552                     ; 348   assert_param(IS_FLASH_ADDRESS(Address));
 554                     ; 350   FLASH->CR2 |= FLASH_CR2_WPRG;
 556  0000 721c5051      	bset	20561,#6
 557                     ; 353   *((PointerAttr uint8_t*)(MemoryAddressCast)Address)       = *((uint8_t*)(&Data));   
 559  0004 7b07          	ld	a,(OFST+7,sp)
 560  0006 1e05          	ldw	x,(OFST+5,sp)
 561  0008 f7            	ld	(x),a
 562                     ; 355   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 1) = *((uint8_t*)(&Data) + 1);
 564  0009 7b08          	ld	a,(OFST+8,sp)
 565  000b 1e05          	ldw	x,(OFST+5,sp)
 566  000d e701          	ld	(1,x),a
 567                     ; 357   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 2) = *((uint8_t*)(&Data) + 2); 
 569  000f 7b09          	ld	a,(OFST+9,sp)
 570  0011 1e05          	ldw	x,(OFST+5,sp)
 571  0013 e702          	ld	(2,x),a
 572                     ; 359   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 3) = *((uint8_t*)(&Data) + 3); 
 574  0015 7b0a          	ld	a,(OFST+10,sp)
 575  0017 1e05          	ldw	x,(OFST+5,sp)
 576  0019 e703          	ld	(3,x),a
 577                     ; 360 }
 580  001b 81            	ret
 614                     ; 367 uint8_t FLASH_ReadByte(uint32_t Address)
 614                     ; 368 {
 615                     .text:	section	.text,new
 616  0000               _FLASH_ReadByte:
 618       00000000      OFST:	set	0
 621                     ; 370   return(*(PointerAttr uint8_t *) (MemoryAddressCast)Address);
 623  0000 1e05          	ldw	x,(OFST+5,sp)
 624  0002 f6            	ld	a,(x)
 627  0003 81            	ret
 672                     ; 417 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 672                     ; 418 {
 673                     .text:	section	.text,new
 674  0000               _FLASH_ProgramOptionByte:
 676  0000 89            	pushw	x
 677       00000000      OFST:	set	0
 680                     ; 420   assert_param(IS_OPTION_BYTE_ADDRESS(Address));
 682                     ; 423   FLASH->CR2 |= FLASH_CR2_OPT;
 684  0001 721e5051      	bset	20561,#7
 685                     ; 426   *((PointerAttr uint8_t*)Address) = Data;
 687  0005 7b05          	ld	a,(OFST+5,sp)
 688  0007 1e01          	ldw	x,(OFST+1,sp)
 689  0009 f7            	ld	(x),a
 690                     ; 428   FLASH_WaitForLastOperation(FLASH_MemType_Program);
 692  000a a6fd          	ld	a,#253
 693  000c cd0000        	call	_FLASH_WaitForLastOperation
 695                     ; 431   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 697  000f 721f5051      	bres	20561,#7
 698                     ; 432 }
 701  0013 85            	popw	x
 702  0014 81            	ret
 738                     ; 439 void FLASH_EraseOptionByte(uint16_t Address)
 738                     ; 440 {
 739                     .text:	section	.text,new
 740  0000               _FLASH_EraseOptionByte:
 744                     ; 442   assert_param(IS_OPTION_BYTE_ADDRESS(Address));
 746                     ; 445   FLASH->CR2 |= FLASH_CR2_OPT;
 748  0000 721e5051      	bset	20561,#7
 749                     ; 448   *((PointerAttr uint8_t*)Address) = FLASH_CLEAR_BYTE;
 751  0004 7f            	clr	(x)
 752                     ; 450   FLASH_WaitForLastOperation(FLASH_MemType_Program);
 754  0005 a6fd          	ld	a,#253
 755  0007 cd0000        	call	_FLASH_WaitForLastOperation
 757                     ; 453   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 759  000a 721f5051      	bres	20561,#7
 760                     ; 454 }
 763  000e 81            	ret
 820                     ; 462 FunctionalState FLASH_GetReadOutProtectionStatus(void)
 820                     ; 463 {
 821                     .text:	section	.text,new
 822  0000               _FLASH_GetReadOutProtectionStatus:
 824  0000 88            	push	a
 825       00000001      OFST:	set	1
 828                     ; 464   FunctionalState state = DISABLE;
 830  0001 0f01          	clr	(OFST+0,sp)
 831                     ; 466   if(OPT->ROP == FLASH_READOUTPROTECTION_KEY)
 833  0003 c64800        	ld	a,18432
 834  0006 a1aa          	cp	a,#170
 835  0008 2606          	jrne	L743
 836                     ; 469     state =  ENABLE;
 838  000a a601          	ld	a,#1
 839  000c 6b01          	ld	(OFST+0,sp),a
 841  000e 2002          	jra	L153
 842  0010               L743:
 843                     ; 474     state =  DISABLE;
 845  0010 0f01          	clr	(OFST+0,sp)
 846  0012               L153:
 847                     ; 477   return state;
 849  0012 7b01          	ld	a,(OFST+0,sp)
 852  0014 5b01          	addw	sp,#1
 853  0016 81            	ret
 887                     ; 485 uint16_t FLASH_GetBootSize(void)
 887                     ; 486 {
 888                     .text:	section	.text,new
 889  0000               _FLASH_GetBootSize:
 891  0000 89            	pushw	x
 892       00000002      OFST:	set	2
 895                     ; 487   uint16_t temp = 0;
 897  0001 5f            	clrw	x
 898  0002 1f01          	ldw	(OFST-1,sp),x
 899                     ; 490   temp = (uint16_t)((uint16_t)OPT->UBC * (uint16_t)128);
 901  0004 c64802        	ld	a,18434
 902  0007 5f            	clrw	x
 903  0008 97            	ld	xl,a
 904  0009 4f            	clr	a
 905  000a 02            	rlwa	x,a
 906  000b 44            	srl	a
 907  000c 56            	rrcw	x
 908  000d 1f01          	ldw	(OFST-1,sp),x
 909                     ; 493   if(OPT->UBC > 0x7F)
 911  000f c64802        	ld	a,18434
 912  0012 a180          	cp	a,#128
 913  0014 2505          	jrult	L173
 914                     ; 495     temp = 8192;
 916  0016 ae2000        	ldw	x,#8192
 917  0019 1f01          	ldw	(OFST-1,sp),x
 918  001b               L173:
 919                     ; 499   return(temp);
 921  001b 1e01          	ldw	x,(OFST-1,sp)
 924  001d 5b02          	addw	sp,#2
 925  001f 81            	ret
 959                     ; 508 uint16_t FLASH_GetCodeSize(void)
 959                     ; 509 {
 960                     .text:	section	.text,new
 961  0000               _FLASH_GetCodeSize:
 963  0000 89            	pushw	x
 964       00000002      OFST:	set	2
 967                     ; 510   uint16_t temp = 0;
 969  0001 5f            	clrw	x
 970  0002 1f01          	ldw	(OFST-1,sp),x
 971                     ; 513   temp = (uint16_t)((uint16_t)OPT->PCODESIZE * (uint16_t)128);
 973  0004 c64807        	ld	a,18439
 974  0007 5f            	clrw	x
 975  0008 97            	ld	xl,a
 976  0009 4f            	clr	a
 977  000a 02            	rlwa	x,a
 978  000b 44            	srl	a
 979  000c 56            	rrcw	x
 980  000d 1f01          	ldw	(OFST-1,sp),x
 981                     ; 516   if(OPT->PCODESIZE > 0x7F)
 983  000f c64807        	ld	a,18439
 984  0012 a180          	cp	a,#128
 985  0014 2505          	jrult	L114
 986                     ; 518     temp = 8192;
 988  0016 ae2000        	ldw	x,#8192
 989  0019 1f01          	ldw	(OFST-1,sp),x
 990  001b               L114:
 991                     ; 522   return(temp);
 993  001b 1e01          	ldw	x,(OFST-1,sp)
 996  001d 5b02          	addw	sp,#2
 997  001f 81            	ret
1032                     ; 547 void FLASH_ITConfig(FunctionalState NewState)
1032                     ; 548 {
1033                     .text:	section	.text,new
1034  0000               _FLASH_ITConfig:
1038                     ; 550   assert_param(IS_FUNCTIONAL_STATE(NewState));
1040                     ; 552   if(NewState != DISABLE)
1042  0000 4d            	tnz	a
1043  0001 2706          	jreq	L134
1044                     ; 555     FLASH->CR1 |= FLASH_CR1_IE;
1046  0003 72125050      	bset	20560,#1
1048  0007 2004          	jra	L334
1049  0009               L134:
1050                     ; 560     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE);
1052  0009 72135050      	bres	20560,#1
1053  000d               L334:
1054                     ; 562 }
1057  000d 81            	ret
1166                     ; 576 FlagStatus FLASH_GetFlagStatus(FLASH_FLAG_TypeDef FLASH_FLAG)
1166                     ; 577 {
1167                     .text:	section	.text,new
1168  0000               _FLASH_GetFlagStatus:
1170  0000 88            	push	a
1171       00000001      OFST:	set	1
1174                     ; 578   FlagStatus status = RESET;
1176  0001 0f01          	clr	(OFST+0,sp)
1177                     ; 579   assert_param(IS_FLASH_FLAGS(FLASH_FLAG));
1179                     ; 582   if((FLASH->IAPSR  & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1181  0003 c45054        	and	a,20564
1182  0006 2706          	jreq	L505
1183                     ; 584     status = SET; /* Flash_FLAG is set*/
1185  0008 a601          	ld	a,#1
1186  000a 6b01          	ld	(OFST+0,sp),a
1188  000c 2002          	jra	L705
1189  000e               L505:
1190                     ; 588     status = RESET; /* Flash_FLAG is reset*/
1192  000e 0f01          	clr	(OFST+0,sp)
1193  0010               L705:
1194                     ; 592   return status;
1196  0010 7b01          	ld	a,(OFST+0,sp)
1199  0012 5b01          	addw	sp,#1
1200  0014 81            	ret
1236                     ; 719 IN_RAM(void FLASH_PowerRunModeConfig(FLASH_Power_TypeDef FLASH_Power))
1236                     ; 720 {
1237                     .text:	section	.text,new
1238  0000               _FLASH_PowerRunModeConfig:
1242                     ; 722   assert_param(IS_FLASH_POWER(FLASH_Power));
1244                     ; 724   if(FLASH_Power != FLASH_Power_On)
1246  0000 a101          	cp	a,#1
1247  0002 2706          	jreq	L725
1248                     ; 726     FLASH->CR1 |= (uint8_t)FLASH_CR1_EEPM;
1250  0004 72165050      	bset	20560,#3
1252  0008 2004          	jra	L135
1253  000a               L725:
1254                     ; 730     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_EEPM);
1256  000a 72175050      	bres	20560,#3
1257  000e               L135:
1258                     ; 732 }
1261  000e 81            	ret
1325                     ; 745 IN_RAM(FLASH_PowerStatus_TypeDef FLASH_GetPowerStatus(void))
1325                     ; 746 {
1326                     .text:	section	.text,new
1327  0000               _FLASH_GetPowerStatus:
1331                     ; 747   return((FLASH_PowerStatus_TypeDef)(FLASH->CR1 & (uint8_t)0x0C));
1333  0000 c65050        	ld	a,20560
1334  0003 a40c          	and	a,#12
1337  0005 81            	ret
1441                     ; 765 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType,
1441                     ; 766                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1441                     ; 767 {
1442                     .text:	section	.text,new
1443  0000               _FLASH_ProgramBlock:
1445  0000 89            	pushw	x
1446  0001 5206          	subw	sp,#6
1447       00000006      OFST:	set	6
1450                     ; 768   uint16_t Count = 0;
1452  0003 1e05          	ldw	x,(OFST-1,sp)
1453                     ; 769   uint32_t startaddress = 0;
1455  0005 96            	ldw	x,sp
1456  0006 1c0001        	addw	x,#OFST-5
1457  0009 cd0000        	call	c_ltor
1459                     ; 772   assert_param(IS_FLASH_MEMORY_TYPE(FLASH_MemType));
1461                     ; 773   assert_param(IS_FLASH_PROGRAM_MODE(FLASH_ProgMode));
1463                     ; 774   if(FLASH_MemType == FLASH_MemType_Program)
1465  000c 7b0b          	ld	a,(OFST+5,sp)
1466  000e a1fd          	cp	a,#253
1467  0010 260c          	jrne	L136
1468                     ; 776     assert_param(IS_FLASH_PROGRAM_BLOCK_NUMBER(BlockNum));
1470                     ; 777     startaddress = FLASH_PROGRAM_START_PHYSICAL_ADDRESS;
1472  0012 ae8000        	ldw	x,#32768
1473  0015 1f03          	ldw	(OFST-3,sp),x
1474  0017 ae0000        	ldw	x,#0
1475  001a 1f01          	ldw	(OFST-5,sp),x
1477  001c 200a          	jra	L336
1478  001e               L136:
1479                     ; 781     assert_param(IS_FLASH_DATA_EEPROM_BLOCK_NUMBER(BlockNum));
1481                     ; 782     startaddress = FLASH_DATA_EEPROM_START_PHYSICAL_ADDRESS;
1483  001e ae1000        	ldw	x,#4096
1484  0021 1f03          	ldw	(OFST-3,sp),x
1485  0023 ae0000        	ldw	x,#0
1486  0026 1f01          	ldw	(OFST-5,sp),x
1487  0028               L336:
1488                     ; 786   startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1490  0028 1e07          	ldw	x,(OFST+1,sp)
1491  002a a640          	ld	a,#64
1492  002c cd0000        	call	c_cmulx
1494  002f 96            	ldw	x,sp
1495  0030 1c0001        	addw	x,#OFST-5
1496  0033 cd0000        	call	c_lgadd
1498                     ; 789   if(FLASH_ProgMode == FLASH_ProgramMode_Standard)
1500  0036 0d0c          	tnz	(OFST+6,sp)
1501  0038 2606          	jrne	L536
1502                     ; 792     FLASH->CR2 |= FLASH_CR2_PRG;
1504  003a 72105051      	bset	20561,#0
1506  003e 2004          	jra	L736
1507  0040               L536:
1508                     ; 797     FLASH->CR2 |= FLASH_CR2_FPRG;
1510  0040 72185051      	bset	20561,#4
1511  0044               L736:
1512                     ; 801   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1514  0044 5f            	clrw	x
1515  0045 1f05          	ldw	(OFST-1,sp),x
1516  0047               L146:
1517                     ; 803     *((PointerAttr uint8_t*) (MemoryAddressCast)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1519  0047 1e0d          	ldw	x,(OFST+7,sp)
1520  0049 72fb05        	addw	x,(OFST-1,sp)
1521  004c f6            	ld	a,(x)
1522  004d 1e03          	ldw	x,(OFST-3,sp)
1523  004f 72fb05        	addw	x,(OFST-1,sp)
1524  0052 f7            	ld	(x),a
1525                     ; 801   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1527  0053 1e05          	ldw	x,(OFST-1,sp)
1528  0055 1c0001        	addw	x,#1
1529  0058 1f05          	ldw	(OFST-1,sp),x
1532  005a 1e05          	ldw	x,(OFST-1,sp)
1533  005c a30040        	cpw	x,#64
1534  005f 25e6          	jrult	L146
1535                     ; 805 }
1538  0061 5b08          	addw	sp,#8
1539  0063 81            	ret
1602                     ; 817 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1602                     ; 818 {
1603                     .text:	section	.text,new
1604  0000               _FLASH_EraseBlock:
1606  0000 89            	pushw	x
1607  0001 5206          	subw	sp,#6
1608       00000006      OFST:	set	6
1611                     ; 819   uint32_t startaddress = 0;
1613  0003 96            	ldw	x,sp
1614  0004 1c0003        	addw	x,#OFST-3
1615  0007 cd0000        	call	c_ltor
1617                     ; 829   assert_param(IS_FLASH_MEMORY_TYPE(FLASH_MemType));
1619                     ; 830   if(FLASH_MemType == FLASH_MemType_Program)
1621  000a 7b0b          	ld	a,(OFST+5,sp)
1622  000c a1fd          	cp	a,#253
1623  000e 260c          	jrne	L107
1624                     ; 832     assert_param(IS_FLASH_PROGRAM_BLOCK_NUMBER(BlockNum));
1626                     ; 833     startaddress = FLASH_PROGRAM_START_PHYSICAL_ADDRESS;
1628  0010 ae8000        	ldw	x,#32768
1629  0013 1f05          	ldw	(OFST-1,sp),x
1630  0015 ae0000        	ldw	x,#0
1631  0018 1f03          	ldw	(OFST-3,sp),x
1633  001a 200a          	jra	L307
1634  001c               L107:
1635                     ; 837     assert_param(IS_FLASH_DATA_EEPROM_BLOCK_NUMBER(BlockNum));
1637                     ; 838     startaddress = FLASH_DATA_EEPROM_START_PHYSICAL_ADDRESS;
1639  001c ae1000        	ldw	x,#4096
1640  001f 1f05          	ldw	(OFST-1,sp),x
1641  0021 ae0000        	ldw	x,#0
1642  0024 1f03          	ldw	(OFST-3,sp),x
1643  0026               L307:
1644                     ; 844     pwFlash = (PointerAttr uint32_t *)(uint16_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1646  0026 1e07          	ldw	x,(OFST+1,sp)
1647  0028 a640          	ld	a,#64
1648  002a cd0000        	call	c_cmulx
1650  002d 96            	ldw	x,sp
1651  002e 1c0003        	addw	x,#OFST-3
1652  0031 cd0000        	call	c_ladd
1654  0034 be02          	ldw	x,c_lreg+2
1655  0036 1f01          	ldw	(OFST-5,sp),x
1656                     ; 851   FLASH->CR2 |= FLASH_CR2_ERASE;
1658  0038 721a5051      	bset	20561,#5
1659                     ; 855     *pwFlash = (uint32_t)0;  
1661  003c 1e01          	ldw	x,(OFST-5,sp)
1662  003e a600          	ld	a,#0
1663  0040 e703          	ld	(3,x),a
1664  0042 a600          	ld	a,#0
1665  0044 e702          	ld	(2,x),a
1666  0046 a600          	ld	a,#0
1667  0048 e701          	ld	(1,x),a
1668  004a a600          	ld	a,#0
1669  004c f7            	ld	(x),a
1670                     ; 863 }
1673  004d 5b08          	addw	sp,#8
1674  004f 81            	ret
1759                     ; 875 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType))
1759                     ; 876 {
1760                     .text:	section	.text,new
1761  0000               _FLASH_WaitForLastOperation:
1763  0000 5203          	subw	sp,#3
1764       00000003      OFST:	set	3
1767                     ; 877   uint16_t timeout = OPERATION_TIMEOUT;
1769  0002 aeffff        	ldw	x,#65535
1770  0005 1f01          	ldw	(OFST-2,sp),x
1771                     ; 878   uint8_t flagstatus = 0x00;
1773  0007 0f03          	clr	(OFST+0,sp)
1774                     ; 881   if(FLASH_MemType == FLASH_MemType_Program)
1776  0009 a1fd          	cp	a,#253
1777  000b 2628          	jrne	L367
1779  000d 200e          	jra	L157
1780  000f               L747:
1781                     ; 885       flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_EOP |
1781                     ; 886                                                       FLASH_IAPSR_WR_PG_DIS));
1783  000f c65054        	ld	a,20564
1784  0012 a405          	and	a,#5
1785  0014 6b03          	ld	(OFST+0,sp),a
1786                     ; 887       timeout--;
1788  0016 1e01          	ldw	x,(OFST-2,sp)
1789  0018 1d0001        	subw	x,#1
1790  001b 1f01          	ldw	(OFST-2,sp),x
1791  001d               L157:
1792                     ; 883     while((flagstatus == 0x00) && (timeout != 0x00))
1794  001d 0d03          	tnz	(OFST+0,sp)
1795  001f 261c          	jrne	L757
1797  0021 1e01          	ldw	x,(OFST-2,sp)
1798  0023 26ea          	jrne	L747
1799  0025 2016          	jra	L757
1800  0027               L167:
1801                     ; 894       flagstatus = (uint8_t)(FLASH->IAPSR & (uint8_t)(FLASH_IAPSR_HVOFF |
1801                     ; 895                                                       FLASH_IAPSR_WR_PG_DIS));
1803  0027 c65054        	ld	a,20564
1804  002a a441          	and	a,#65
1805  002c 6b03          	ld	(OFST+0,sp),a
1806                     ; 896       timeout--;
1808  002e 1e01          	ldw	x,(OFST-2,sp)
1809  0030 1d0001        	subw	x,#1
1810  0033 1f01          	ldw	(OFST-2,sp),x
1811  0035               L367:
1812                     ; 892     while((flagstatus == 0x00) && (timeout != 0x00))
1814  0035 0d03          	tnz	(OFST+0,sp)
1815  0037 2604          	jrne	L757
1817  0039 1e01          	ldw	x,(OFST-2,sp)
1818  003b 26ea          	jrne	L167
1819  003d               L757:
1820                     ; 900   if(timeout == 0x00)
1822  003d 1e01          	ldw	x,(OFST-2,sp)
1823  003f 2604          	jrne	L177
1824                     ; 902     flagstatus = FLASH_Status_TimeOut;
1826  0041 a602          	ld	a,#2
1827  0043 6b03          	ld	(OFST+0,sp),a
1828  0045               L177:
1829                     ; 905   return((FLASH_Status_TypeDef)flagstatus);
1831  0045 7b03          	ld	a,(OFST+0,sp)
1834  0047 5b03          	addw	sp,#3
1835  0049 81            	ret
1848                     	xdef	_FLASH_WaitForLastOperation
1849                     	xdef	_FLASH_EraseBlock
1850                     	xdef	_FLASH_ProgramBlock
1851                     	xdef	_FLASH_GetPowerStatus
1852                     	xdef	_FLASH_PowerRunModeConfig
1853                     	xdef	_FLASH_GetFlagStatus
1854                     	xdef	_FLASH_ITConfig
1855                     	xdef	_FLASH_EraseOptionByte
1856                     	xdef	_FLASH_ProgramOptionByte
1857                     	xdef	_FLASH_GetReadOutProtectionStatus
1858                     	xdef	_FLASH_GetCodeSize
1859                     	xdef	_FLASH_GetBootSize
1860                     	xdef	_FLASH_ReadByte
1861                     	xdef	_FLASH_ProgramWord
1862                     	xdef	_FLASH_EraseByte
1863                     	xdef	_FLASH_ProgramByte
1864                     	xdef	_FLASH_Lock
1865                     	xdef	_FLASH_Unlock
1866                     	xdef	_FLASH_DeInit
1867                     	xdef	_FLASH_PowerWaitModeConfig
1868                     	xdef	_FLASH_SetProgrammingTime
1869                     	xdef	_FLASH_GetProgrammingTime
1870                     	xref.b	c_lreg
1889                     	xref	c_ladd
1890                     	xref	c_lgadd
1891                     	xref	c_cmulx
1892                     	xref	c_ltor
1893                     	end
