//ZF Created on 2019.5.10
//ZF Released on 2019.6.15
//ZF Revised on 2019.8.31
//ZF Revised on 2019.9.24
//ZF Revised on 2019.10.7
//ZF Revised on 2019.11.20
//ZF Revised on 2020.1.23
//v2a applies to spec0.8

#include "motion.h"

u16 MotionFlags=bmStartup,MotionFlags2=0;
u16 nDelayTime;
u8 strAT[MAX_STRLEN],*strxAT,strBuf[MAX_STRLEN],*strxBuf=strBuf;
u8 uartTx[18];
u8 singleWord;
bool bCmpEnd=FALSE;
u8 nLuxLevel=DEF_LUXLEVEL, nPirLevel=DEF_PIRLEVEL,nPirHoldTime=DEF_PIRHOLDTIME,nLowBatTime=DEF_LOWBATTIME,nTCount=0,nPressed=0;
u8 nlenstrAT;

PirModule pirModule;


u8 ToChar09AF(u8 nNum)  //nNum=0..15
{
	u8 nChar=(nNum<=9)?(0x30+nNum):(0x41+nNum-10);
	return nChar;
}

u8 FromChar09AF(u8 nChar)  //nChar='0'..'9','A'..'F'
{
	u8 nNum=(nChar<='9')?(nChar-0x30):(nChar-0x41+10);
	return nNum;
}
	
u8 putchar (u8 c)
{
	USART1->DR=(u8)c;
  return (c);
}

bool myputs(u8 *str, u8 dataLen, bool signleWord)
{
	u8 timeoutCnt;
	u8 i,len;
	
	disableInterrupts();
 	USART1->CR2 &= (~USART_Mode_Rx);	// disable Receive
	
	len = dataLen;
	// copy to uartTx buffer
	for(i = 0; i< dataLen; i++)
	{
		uartTx[i] = *str;
		str++;
	}
	if(!signleWord)
	{
		uartTx[i] = 0x0D;
		uartTx[i+1] = 0x0A;	
		len += 2;
	}
	// last two bytes

	
	for(i = 0; len > 0; i++,len--)
	{
		timeoutCnt = 200;
		// transmit empty?
		while(!(USART1->SR & USART_FLAG_TXE) || (timeoutCnt == 0))
		{
			timeoutCnt--;
		}
		// send next data
		USART1->SR &= (~USART_FLAG_TXE);	//clear by SW
		putchar(uartTx[i]);
	}
	timeoutCnt = 200;
	// wait until transmit complete
	while(!(USART1->SR & USART_FLAG_TC) || (timeoutCnt == 0))
	{
		timeoutCnt--;
	}
	
//	putchar(0x0D);
//	putchar(0x0A);
	
	USART1->CR2 |= USART_Mode_Rx;	// enable Receive
	enableInterrupts();
	
	return 1;
}

bool mystrcmp(u8 *strat,u8 *strstandard)  //return TRUE if strat has same former part of strstandard; bCmpEnd indicates totally match
{
	while((*strstandard)!=0)
	{
		if(((*strat)!=(u8)(*strstandard))||((*strat)==0))
		{
			return FALSE;
		}
		strstandard++;
		strat++;
	}
	bCmpEnd=(*strat==0);
	return TRUE;
}
	
void ParseAtCmd(void) //Processed by visual effect, to be interacted via hyper terminal.
{
	u8 byteTxD[7];
	u16 nInt;
	bool bGoodCmd=FALSE,bcmdLed=FALSE,bcmdLowBat=FALSE;
	
	if(MotionFlags&bmCmdEcho)
		myputs(strAT, 0, TRUE);
	MotionFlags&=~bmLedDelay;
	if(mystrcmp(strAT, "AT"))
	{
		if(bCmpEnd)
		{
			myputs(STR_FWVER, 15, FALSE);
//		putchar(ToChar09AF(nPirHoldTime>>4));
//		putchar(ToChar09AF(nPirHoldTime&0x0F));
//		putchar(0x30+nPirLevel);
//		putchar(0x30+nLuxLevel);
			bGoodCmd=TRUE;
		}else
		if(mystrcmp(strAT, "ATE"))
		{
			if(bCmpEnd)
			{
				if(MotionFlags&bmCmdEcho)
					MotionFlags&=~bmCmdEcho;
				else
					MotionFlags|=bmCmdEcho;
				bGoodCmd=TRUE;
			}
		}else
		if(mystrcmp(strAT, "ATSTA"))
		{
			if(bCmpEnd)
			{
				byteTxD[0]=0;
				byteTxD[1]=0;
				if(MotionFlags2&bm2PirRecheck)
				{
					MotionFlags2&=~bm2PirRecheck;
					byteTxD[0]=1;
				}
				if(MotionFlags&bmIntPirStaCmd)
				{
					MotionFlags&=~bmIntPirStaCmd;
					byteTxD[1]=8;
				}
				if(getPinBtn==RESET)
				{
					if(nPressed>=TIME_LONGPRESS)
						byteTxD[1]+=7;
					else
						if(nPressed>=TIME_MIDPRESS)
							byteTxD[1]+=5;
						else
							if(nPressed>=TIME_SHORTPRESS)
								byteTxD[1]+=3;
							else
									byteTxD[1]+=1;
				}

				nInt=Lux_GetReading(LUX_I2CCmd_AutoRes);
				byteTxD[0]=ToChar09AF(byteTxD[0]);
				byteTxD[1]=ToChar09AF(byteTxD[1]);
				byteTxD[2]=ToChar09AF((nInt>>12)&0x0F);
				byteTxD[3]=ToChar09AF((nInt>>8)&0x0F);
				byteTxD[4]=ToChar09AF((nInt>>4)&0x0F);
				byteTxD[5]=ToChar09AF(nInt&0x0F);
				byteTxD[6]=0;
				
				myputs(byteTxD, 6, FALSE);
				bGoodCmd=TRUE;
			}
		}else
		if(mystrcmp(strAT, "ATRST"))
		{
			if(bCmpEnd)
			{
				myputs(STR_FWVER, 15, FALSE);
				bGoodCmd=TRUE;
				WWDG->CR|=0x80;
				WWDG->CR&=~0x40;
			}
		}else
		if(mystrcmp(strAT, "ATDEF"))
		{
			if(bCmpEnd)
			{
				nLuxLevel=DEF_LUXLEVEL;
				Lux_SetMTreg();
				nPirHoldTime=DEF_PIRHOLDTIME;
				nPirLevel=DEF_PIRLEVEL;
				nLowBatTime=DEF_LOWBATTIME;
				WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
				WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
				WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
				WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
				Pir_SetConfig(TRUE);
				myputs(STR_FWVER, 15, FALSE);
				bGoodCmd=TRUE;
			}
		}else
		if(mystrcmp(strAT, "ATLED="))
		{
			if(bCmpEnd||nlenstrAT!=9)
			{
			}else
			{
				bGoodCmd=TRUE;
				byteTxD[0]=strAT[6];
				byteTxD[1]=strAT[7];
				byteTxD[2]=strAT[8];
				byteTxD[3]=0;
				myputs(byteTxD, 3, FALSE);

				byteTxD[4]=FromChar09AF(strAT[6])&3;
				offPinLedGreen;
				switch(byteTxD[4])
				{
					case 0:
						MotionFlags&=~bmLedGreenFlash;
						MotionFlags&=~bmLedGreen2Hz;
						break;
					case 1:
						MotionFlags&=~bmLedGreenFlash;
						MotionFlags&=~bmLedGreen2Hz;
						onPinLedGreen;
						break;
					case 2:
					case 3:
						onPinLedGreen;
						MotionFlags|=bmLedGreenFlash;
						if(byteTxD[4]==2)
							MotionFlags&=~bmLedGreen2Hz;
						else
							MotionFlags|=bmLedGreen2Hz;
						break;
				}
				
				byteTxD[4]=(FromChar09AF(strAT[6])>>2)&3;
				offPinLedRed;
				switch(byteTxD[4])
				{
					case 0:
						MotionFlags&=~bmLedRedFlash;
						MotionFlags&=~bmLedRed2Hz;
						break;
					case 1:
						MotionFlags&=~bmLedRedFlash;
						MotionFlags&=~bmLedRed2Hz;
						onPinLedRed;
						break;
					case 2:
					case 3:
						onPinLedRed;
						MotionFlags|=bmLedRedFlash;
						if(byteTxD[4]==2)
							MotionFlags&=~bmLedRed2Hz;
						else
							MotionFlags|=bmLedRed2Hz;
						break;
				}
				if((strAT[6]&0x0F)==0)
					MotionFlags|=bmHalt;
				else
				{
					nDelayTime=((FromChar09AF(strAT[7])<<4)+(FromChar09AF(strAT[8]))<<2);
					if(nDelayTime!=0)
					{
						bcmdLed=TRUE;
						MotionFlags|=bmLedDelay;
					}
				}
			}
		}else
		if(mystrcmp(strAT, "ATPIR"))
		{
			if(bCmpEnd)
			{
				bGoodCmd=TRUE;
			}else
			{
				if(mystrcmp(strAT, "ATPIRHDTM="))
				{
					if(bCmpEnd||nlenstrAT!=18)
					{
					}else
					{
						// ATPIRHDTM=hh:mm:ss
						u8 i,j,k;
						u8* time;
						for(i = 0; i < 7; i += 3)
						{
							for(j =0; j < 2; j++)
							{
								byteTxD[k] = FromChar09AF(strAT[i + j + 10]);//byteTxD[4]: temp variable
								k++;
							}
						}


						// update pir wake up
						pirModule.hr = byteTxD[0]*10 + byteTxD[1];
						pirModule.min = byteTxD[2]*10 + byteTxD[3];
						pirModule.sec = byteTxD[4]*10 + byteTxD[5];
						time = &pirModule.hr;
						for(i = 0; i < 3; i++)
						{
							 WriteEeprom(EEPROM_PIRWAKEUP_HR+i,*time);
							 time++;
						}
						
						nPirHoldTime = pirModule.sec - 1;
						if(nPirHoldTime>MAX_PIRHOLDTIME)
						{
							nPirHoldTime = MAX_PIRHOLDTIME;
						}
	
						Pir_SetConfig(TRUE);
						WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
						bGoodCmd=TRUE;
						
					}
				}else
				if(mystrcmp(strAT, "ATPIRSSLV="))
				{
					if(bCmpEnd||nlenstrAT!=11)
					{
					}else
					{
						byteTxD[4]=FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
						if((byteTxD[4]>=1)&&(byteTxD[4]<=8))
						{
							nPirLevel=byteTxD[4];
							Pir_SetConfig(TRUE);
							if((nPirLevel==0)||(nPirLevel>MAX_PIRLEVEL))
							{
								nPirLevel=DEF_PIRLEVEL;
							}
							WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
							bGoodCmd=TRUE;
						}
					}
				}
			}
			if(bGoodCmd)
			{
				TD_Delay01ms(100);
				Pir_GetConfig();
				TD_Delay01ms(100);
				Pir_GetConfig();
				byteTxD[0]=ToChar09AF(nPirLevel);
				byteTxD[1]=ToChar09AF(nPirHoldTime);
				byteTxD[2]=0;
				myputs(byteTxD, 2, FALSE);
			}
		}else
		if(mystrcmp(strAT, "ATLUX"))
		{
			if(bCmpEnd)
			{
				bGoodCmd=TRUE;
			}else
			{
				if(mystrcmp(strAT, "ATLUXSSLV="))
				{
					if(bCmpEnd||nlenstrAT!=11)
					{
					}else
					{
						byteTxD[4]=FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
						if((byteTxD[4]>=1)&&(byteTxD[4]<=8))
						{
							nLuxLevel=byteTxD[4];
							Lux_SetMTreg();
							if((nLuxLevel==0)||(nLuxLevel>MAX_LUXLEVEL))
							{
								nLuxLevel=DEF_LUXLEVEL;
							}
							WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
							bGoodCmd=TRUE;
						}
					}
				}
			}
			if(bGoodCmd)
			{
//				myputs("ATLUX[x] got!");
				byteTxD[0]=ToChar09AF(nLuxLevel);
				byteTxD[1]=0;
				myputs(byteTxD, 1, FALSE);
			}
		}else
		if(mystrcmp(strAT, "ATLOWBAT"))
		{
			if(bCmpEnd)
			{
				bGoodCmd=TRUE;
			}else
			{
				if(mystrcmp(strAT, "ATLOWBAT="))
				{
					if(bCmpEnd||nlenstrAT!=11)
					{
					}else
					{
						byteTxD[4]=(FromChar09AF(strAT[9])<<4)+FromChar09AF(strAT[10]);  //byteTxD[4]: temp variable
						if(byteTxD[4]!=0)
						{
							nLowBatTime=byteTxD[4];
							if((nLowBatTime==0)||(nLowBatTime>MAX_LOWBATTIME))
							{
								nLowBatTime=DEF_LOWBATTIME;
							}
							WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
							bGoodCmd=TRUE;
						}
					}
				}
			}
			if(bGoodCmd)
			{
				RTC_SetWakeupPeriod(nLowBatTime + 1);
				MotionFlags2|=bm2LowBat;
				byteTxD[0]=ToChar09AF(nLowBatTime>>4);
				byteTxD[1]=ToChar09AF(nLowBatTime&0x0F);
				byteTxD[2]=0;
				myputs(byteTxD, 2, FALSE);
			}
		}
	}

	if(!bGoodCmd)
		myputs(STR_BADCMD, 7, FALSE);
	if((!(MotionFlags&bmBtnDown))&&(!bcmdLed))
	{
		MotionFlags|=bmHalt;
	}
}
	
void TD_Init(bool bInit)
{
	disableInterrupts();
	if(!bInit)
	{
		Lux_SendCmd(LUX_I2CCmd_PowerDown);
		GPIO_Init(GPIOC, GPIO_Pin_0, GPIO_Mode_Out_PP_High_Fast);  //I2C_SDA
		GPIO_Init(GPIOC, GPIO_Pin_1, GPIO_Mode_Out_PP_High_Fast);  //I2C_SCL
		offPinLedGreen;
		offPinLedRed;
	}
	CLK_PeripheralClockConfig(CLK_Peripheral_USART1,bInit);//USART1时钟;
	CLK_PeripheralClockConfig(CLK_Peripheral_TIM2,bInit);//TIM2时钟;
	CLK_PeripheralClockConfig(CLK_Peripheral_I2C1,bInit);//IIC1时钟;
	
		EXTI_SelectPort(EXTI_Port_B);
//		EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Rising);  //test PB0
		EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Falling);  //PB0-btn
		EXTI_SetPinSensitivity(EXTI_Pin_3, EXTI_Trigger_Falling);  //PB3-host wakeup
		EXTI_SetPinSensitivity(EXTI_Pin_7, EXTI_Trigger_Rising);  //PB7-PIR 1 triggers INT
		EXTI_ClearITPendingBit(EXTI_IT_Pin0);
		EXTI_ClearITPendingBit(EXTI_IT_Pin3);
		EXTI_ClearITPendingBit(EXTI_IT_Pin7);
		
		intPinBtn;  //PB0 Button
		//GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_IT);  //TempSensor AIN
		//GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_IT);  //TempSensor PW?
		intPinHostWakeUp; //PB3
		GPIO_Init(GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Fast);  //NC with host
		GPIO_Init(GPIOB, GPIO_Pin_5, GPIO_Mode_Out_PP_High_Fast);  //INT to host
		GPIO_Init(GPIOB, GPIO_Pin_6, GPIO_Mode_Out_PP_Low_Fast);  //Motion SERIN
//		oPinPirDoci;  //pull down to low at least 100ns to clear PIR INT
//		clrPinPirDoci;
//		TD_Delay01ms(100);
//		intPinPirDoci; //PB7 DOCI
	
	if(bInit)
	{
		GPIO_Init(GPIOC, GPIO_Pin_0, GPIO_Mode_In_PU_No_IT);  //I2C_SDA
		GPIO_Init(GPIOC, GPIO_Pin_1, GPIO_Mode_In_PU_No_IT);  //I2C_SCL
		GPIO_Init(GPIOC, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Slow);  //LightSensor DVI
		GPIO_Init(GPIOC, GPIO_Pin_5, GPIO_Mode_Out_PP_High_Fast);  //USART1 TxD
		GPIO_Init(GPIOC, GPIO_Pin_6, GPIO_Mode_In_PU_No_IT);  //USART1 RxD
		
		I2C_Init(I2C1,100, 0, I2C_Mode_I2C,I2C_DutyCycle_2, I2C_Ack_Enable, I2C_AcknowledgedAddress_7bit);
		I2C_Cmd(I2C1,ENABLE);
		setPinLuxDVI;
		Lux_SendCmd(LUX_I2CCmd_PowerOn);
	
	//	Lux_SetReg(LUX_I2CCmd_PowerDown);
	
		TIM2_TimeBaseInit(TIM2_Prescaler_64,TIM2_CounterMode_Up,62500);  //0.25s
		TIM2_ITConfig(TIM2_IT_Update, ENABLE);
		TIM2_ARRPreloadConfig(ENABLE);
		TIM2_Cmd(ENABLE);
	
		SYSCFG_REMAPDeInit();
		SYSCFG_REMAPPinConfig(REMAP_Pin_USART1TxRxPortC, ENABLE);
		USART_Init(USART1,(uint32_t)9600, USART_WordLength_8b, USART_StopBits_1,USART_Parity_No, (USART_Mode_TypeDef)(USART_Mode_Tx | USART_Mode_Rx));
		USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);

//		USART_ClearFlag(USART1, USART_FLAG_RXNE);
		USART_Cmd(USART1, ENABLE);
		Lux_SetMTreg();
		TD_Delay01ms(20);
		Lux_GetReading(LUX_I2CCmd_AutoRes);
}
	Pir_SetConfig(bInit);
	enableInterrupts(); 
}

void TD_Delay01ms(u8 d)  //unit: 0.1ms
{
	u8 i;
	for(;d>0;d--)
	{
		for(i=0;i<200;i++) ;
	}
}

int main() 
{ 
	CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_1);
  CLK_RTCClockConfig(CLK_RTCCLKSource_LSI, CLK_RTCCLKDiv_1);
  CLK_PeripheralClockConfig(CLK_Peripheral_RTC, ENABLE);
	//RTC_WakeUpCmd(DISABLE);
	RTC_WakeUpClockConfig(RTC_WakeUpClock_CK_SPRE_16bits);
	
	FLASH_SetProgrammingTime(FLASH_ProgramTime_Standard);
	MotionFlags=bmStartup;
	nTCount=0;
	GPIO_Init(GPIOA, GPIO_Pin_2, GPIO_Mode_Out_OD_HiZ_Slow);  //out: Red LED init off
	GPIO_Init(GPIOA, GPIO_Pin_3, GPIO_Mode_Out_OD_Low_Slow);  //out: Green LED init on
/*		putchar(ToChar09AF(nPirHoldTime>>4));
		putchar(ToChar09AF(nPirHoldTime&0x0F));
		putchar(0x30+nPirLevel);
		putchar(0x30+nLuxLevel);*/

	TD_Init(TRUE);
	ReadEeprom();
//		myputs("X\x0C Com1 good...");
	intPinPirDoci;
	
	while(1)
	{
		TD_Delay01ms(20);
//			putchar(ToChar09AF((MotionFlags>>8)&0x0F));
		if(MotionFlags&bmHalt)
		{
			MotionFlags&=~bmHalt;
			if(MotionFlags&bmCmdEcho)
			{
				singleWord = 'z';
				myputs(&singleWord, 1, TRUE);
			}
			TD_Delay01ms(20);
			TD_Init(FALSE);
//		oPinPirDoci;  //pull down to low at least 100ns to clear PIR INT
//		clrPinPirDoci;
//			TD_Delay01ms(200);
			intPinPirDoci;
			halt();// 进入停机模式
//		oPinPirDoci;  //pull down to low at least 100ns to clear PIR INT
//		clrPinPirDoci;
			TD_Init(TRUE);// 系统初始化函数，醒来时执行
			TD_Delay01ms(200);
			if(MotionFlags&bmCmdEcho)	
			{
				singleWord = ',';
				myputs(&singleWord, 1, TRUE);
			}
			intPinPirDoci;
//			onPinLedGreen;nTCount=0;MotionFlags|=bmStartup;
		}else 
		{
			if(MotionFlags&bmIntPir)  //1116 for hw test
			{
				intPinPirDoci;

//				setPinPB4;
				if(MotionFlags&bmCmdEcho)
				{
					singleWord = 'x';
					myputs(&singleWord, 1, TRUE);
				}
				singleWord = 'p';
				myputs(&singleWord, 1, TRUE);
				TD_Delay01ms(100);
//				clrPinPB4;
				MotionFlags&=~bmIntPir;
			}
	
			if(MotionFlags&bmNeedAtCmd)
			{
				clrPinMyIntn;
				if(MotionFlags&bmCmdEcho)
				{
					singleWord= 'a';
					myputs(&singleWord, 1, TRUE);
				}
				MotionFlags&=~bmNeedAtCmd;
			}
			if(MotionFlags&bmValidCmd)
			{
				MotionFlags&=~bmValidCmd;
				setPinMyIntn;
				ParseAtCmd();
			}
			if(MotionFlags&bmHostWakeUp) //Host wants to send AT
			{
				if(getPinHostWakeUp!=RESET)
				{
					MotionFlags&=~bmHostWakeUp;
					intPinHostWakeUp;
				}
			}
			if(MotionFlags&bmBtnDown)
			{
				if(MotionFlags&bmCmdEcho)
				{
					singleWord = 'y';
					myputs(&singleWord, 1, TRUE);
				}
				TD_Delay01ms(250);
				TD_Delay01ms(250);
				TD_Delay01ms(250);  //debounce 75ms
				if(getPinBtn==RESET)
				{
					if(!(MotionFlags&bmBtnDownConfirmed))
					{
						nTCount=0;
						MotionFlags|=bmStartup;
						onPinLedGreen;
			
						MotionFlags|=bmBtnDownConfirmed;
						MotionFlags|=bmNeedAtCmd;
						nPressed=0;
					}
				}else
				{
					MotionFlags&=~bmBtnDown;
					MotionFlags&=~bmBtnDownConfirmed;
					MotionFlags|=bmNeedAtCmd;
					intPinBtn;
				}
			}
		}
	}
	return 0;
}

INTERRUPT_HANDLER(ISR_Btn,8)  //PB0
{
  RTC_WakeUpCmd(DISABLE);
	MotionFlags2&=~bm2LowBat;
	
	iPinBtn;
	if(MotionFlags&bmBtnDown)
	{
	}else
	{
		MotionFlags|=bmBtnDown;
		MotionFlags|=bmNeedAtCmd;
	}
	EXTI_ClearITPendingBit(EXTI_IT_Pin0);
}

INTERRUPT_HANDLER(ISR_HostWakeUp,11)  //PB3
{
  RTC_WakeUpCmd(DISABLE);
	MotionFlags2&=~bm2LowBat;
	
	iPinHostWakeUp;
	MotionFlags|=bmHostWakeUp;
	MotionFlags|=bmNeedAtCmd;
	EXTI_ClearITPendingBit(EXTI_IT_Pin3);
}

INTERRUPT_HANDLER(ISR_RtcWakeUp,4)  //For low battery mode
{
	if(MotionFlags2&bm2LowBat)
	{
		nDelayTime=3;
		MotionFlags|=bmLedRedFlash;
		MotionFlags|=bmLedDelay;
	}
	else
	{
		if(RTC_UpdateClk(&pirModule) == TRUE)
		{
			MotionFlags|=bmNeedAtCmd;
			MotionFlags2|=bm2PirRecheck;
			RTC_WakeUpCmd(DISABLE);	// stop rtc		
		}
		else
		{
			MotionFlags|=bmHalt; 	// continue for sleep mode
		}
		
	}
	RTC_ClearITPendingBit(RTC_IT_WUT);
}

INTERRUPT_HANDLER(ISR_Pir,15)  //PB7 Rising Edge to INT
{
  RTC_WakeUpCmd(DISABLE);
	MotionFlags2&=~bm2LowBat;

	oPinPirDoci;  //pull down to low at least 100ns to clear PIR INT
	clrPinPirDoci;
	if(pirModule.timerTrigger == FALSE)
	{
		// first time trigger
		MotionFlags|=bmIntPir;
		MotionFlags|=bmIntPirStaCmd;
		MotionFlags|=bmNeedAtCmd;
		pirModule.timerTrigger = TRUE;
	}
	else
	{
		MotionFlags|=bmHalt; 	// continue for sleep mode
	}

	// re-trigger during 
	RTC_Reset(&pirModule);
	RTC_UpdateClk(&pirModule);

//	iPinPirDoci;
	EXTI_ClearITPendingBit(EXTI_IT_Pin7);
}

INTERRUPT_HANDLER(ISR_Timer2,19)  //0.25s
{
	if (TIM2_GetITStatus(TIM2_IT_Update) != RESET)
	{
		nTCount++;
		if((nTCount==4)&&(MotionFlags&bmStartup))
		{
			offPinLedGreen;
			MotionFlags&=~bmStartup;
		}	
		if(MotionFlags&bmLedRedFlash)
		{
			if((MotionFlags&bmLedRed2Hz)||((MotionFlags&(~bmLedRed2Hz))&&(nTCount%2)))
			{
				togPinLedRed;
			}
		}
		if(MotionFlags&bmLedGreenFlash)
		{
			if((MotionFlags&bmLedGreen2Hz)||((MotionFlags&(~bmLedGreen2Hz))&&(nTCount%2)))
			{
				togPinLedGreen;
			}
		}
		if(MotionFlags&bmBtnDownConfirmed)
		{
			nPressed++;
			if((nPressed==TIME_LONGPRESS)||(nPressed==TIME_MIDPRESS)||(nPressed==TIME_SHORTPRESS))
				MotionFlags|=bmNeedAtCmd;
		}
		if(MotionFlags&bmLedDelay)
		{
			nDelayTime--;
			if(nDelayTime==0)
			{
				MotionFlags&=~bmLedDelay;
				MotionFlags&=(~bmLedRedFlash)&(~bmLedRed2Hz)&(~bmLedGreenFlash)&(~bmLedGreen2Hz);
				offPinLedGreen;
				offPinLedRed;
				if(MotionFlags2&bm2LowBat)
						MotionFlags|=bmHalt;
			}
		}
		TIM2_ClearITPendingBit(TIM2_IT_Update);
	}
}

INTERRUPT_HANDLER(ISR_Uart1Rx,28)
{
	/***** enter *****
	Windows:	\r\n
	Unix: 		\n
	******************/

	if(USART1->SR & USART_FLAG_RXNE)
	{
		u8 dataTemp;
		dataTemp = USART1->DR;	// read register to clear RXNE
		
		if(dataTemp == 0x0D)
		{
			*strxBuf = 0;	// insert NULL
			strxBuf++;
			*strxBuf = dataTemp;
			strxAT=strAT;
			strxBuf=strBuf;
			nlenstrAT=0;
			while(*strxBuf!=0)
			{
				*strxAT=*strxBuf;
				strxBuf++;
				strxAT++;
				nlenstrAT++;
			}
			*strxAT=0;
			strxBuf=strBuf;
			MotionFlags|=bmValidCmd;
		}
		else if(dataTemp == 0x0A)
		{
			if(strBuf[nlenstrAT+1] == 0x0D)
			{
				strBuf[nlenstrAT+2] = dataTemp;
			}
		}
		else
		{
			*strxBuf =  dataTemp;	

			if((strxBuf-strBuf)<(MAX_STRLEN-1))
			{
				strxBuf++;
			}

		}
	}
}




