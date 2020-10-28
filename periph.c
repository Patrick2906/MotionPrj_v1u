//periph.c
#include "motion.h"

struct RTC_Clk
{
	uint8_t hr;
	uint8_t min;
	uint8_t sec;
}rtcClk;

bool RTC_CheckFinished(const PirModule* pir)
{
	if(pir->timerTrigger == TRUE)
	{
		return FALSE;
	}
	else
	{
		return TRUE;
	}
}

void RTC_Reset(const PirModule* pir)
{
	rtcClk.hr = pir->hr;
	rtcClk.min = pir->min;
	rtcClk.sec = pir->sec;
}

bool RTC_UpdateClk(PirModule* pir)
{
	if((rtcClk.hr != 0) || (rtcClk.min != 0) || (rtcClk.sec != 0))
	{
		u16 newPeriod;
		newPeriod = 3600 + rtcClk.min*60 + rtcClk.sec;
		
		rtcClk.hr--;
		rtcClk.min = 0;
		rtcClk.sec = 0;
		RTC_SetWakeupPeriod(newPeriod);
		return FALSE;
	}
	else
	{
		pir->timerTrigger = FALSE;
		return TRUE;
	}
}

void RTC_SetWakeupPeriod(u16 period)  //true: For low battery mode; false: for PIR recheck
{
	RTC_WakeUpClockConfig(RTC_WakeUpClock_CK_SPRE_16bits);
	RTC_ITConfig(RTC_IT_WUT, ENABLE);
	
  RTC_WakeUpCmd(DISABLE);
  RTC_SetWakeUpCounter(period); 
  RTC_WakeUpCmd(ENABLE);
}

void Lux_SendCmd(u8 cmd)  //no dedicated INT enable/disable which needs the caller to do it
{
	while(I2C_GetFlagStatus(I2C1, I2C_FLAG_BUSY));
	
	I2C_GenerateSTART(I2C1, ENABLE);
	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_MODE_SELECT));/*EV5,主模式*/
	I2C_Send7bitAddress(I2C1, LUX_I2CAdd, I2C_Direction_Transmitter);
	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED));
	I2C_SendData(I2C1, cmd);
	while (!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_BYTE_TRANSMITTED));
	I2C_GenerateSTOP(I2C1, ENABLE);
}

void Lux_SetMTreg()  //nLuxLevel:1..8
{
	u8 nLevel=(nLuxLevel-1)<<2;
//	disableInterrupts();
	Lux_SendCmd(LUX_I2CCmd_PowerDown);
	TD_Delay01ms(5);
	Lux_SendCmd(LUX_I2CCmd_MTregH+nLevel);  //LUX_I2CCmd_MTregL needn't be done, always 0
	TD_Delay01ms(5);
	Lux_SendCmd(LUX_I2CCmd_PowerOn);
//	enableInterrupts();
}

u16 Lux_GetReading(u8 cmd)
{
	u16 d2b=0;
//	disableInterrupts();
	Lux_SendCmd(cmd);
	TD_Delay01ms(5);
	
	I2C_GenerateSTART(I2C1, ENABLE);
	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_MODE_SELECT));/*EV5,主模式*/
	I2C_Send7bitAddress(I2C1, LUX_I2CAdd, I2C_Direction_Receiver);
	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED));
	while(!I2C_CheckEvent(I2C1,I2C_EVENT_MASTER_BYTE_RECEIVED));
	d2b=I2C_ReceiveData(I2C1);
	I2C_AcknowledgeConfig(I2C1,ENABLE);
	while(!I2C_CheckEvent(I2C1, I2C_EVENT_MASTER_BYTE_RECEIVED));
	d2b=(d2b<<8)+I2C_ReceiveData(I2C1);
	I2C_AcknowledgeConfig(I2C1,ENABLE);
	I2C_GenerateSTOP(I2C1, ENABLE);
//printf("in Lux_GetReading:%x\r\n ",d2b);
//	enableInterrupts();
	return d2b;
}

//via pin of DOCI
void Pir_GetConfig(void)  //using global nPirLevel
{
	u8 i,x,bytePir[5],byteTxD[12];
	u8 nPirHoldTimeReg=0;
	nPirLevel=0;
	
//	disableInterrupts();
	oPinPirDoci;
	clrPinPirDoci;
	
	setPinPirDoci;  //start a reading
	TD_Delay01ms(1);
	bytePir[0]=0;
	for(i=0;i<7;i++) //b39..b33)
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			bytePir[0]|=(0x80>>i);
	}
	bytePir[0]=bytePir[0]>>1;  //7bits shift right to aligh low 7bits
	bytePir[1]=0;
	for(i=0;i<8;i++) //b32..b25)
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			bytePir[1]|=(0x80>>i);
	}

	for(i=0;i<3;i++) //b24..22 nPirLevel (b24..b17) UPPER 3bits
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			nPirLevel|=(0x4>>i);
	}
	bytePir[2]=0;
	for(i=0;i<5;i++) //b21..17 nPirLevel LOWER 5bits=00000
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			bytePir[2]|=(0x80>>i);
	}
	for(i=0;i<4;i++) //nPirHoldTimeReg 4bits  b16..13
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			nPirHoldTimeReg|=(0x8>>i);
	}
	
	
	bytePir[3]=0;
	for(i=0;i<4;i++) //b12..9
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			bytePir[3]|=(0x8>>i);
	}
	bytePir[4]=0;
	for(i=0;i<8;i++) //b8..1
	{
		oPinPirDoci;
		clrPinPirDoci;
		setPinPirDoci;
		iPinPirDoci;
		TD_Delay();
		if(getPinPirDoci!=RESET)
			bytePir[4]|=(0x80>>i);
	}
	
	oPinPirDoci;  //give following bits
	clrPinPirDoci;
	TD_Delay01ms(2);
	intPinPirDoci;
	nPirLevel=8-nPirLevel;
	nPirHoldTime=nPirHoldTimeReg;
//	enableInterrupts();
	/*-----------------
myputs("GetPIR:");
				byteTxD[0]=ToChar09AF(bytePir[0]>>4);
				byteTxD[1]=ToChar09AF(bytePir[0]&0x0F);
				byteTxD[2]=ToChar09AF(bytePir[1]>>4);
				byteTxD[3]=ToChar09AF(bytePir[1]&0x0F);
				byteTxD[4]=ToChar09AF(nPirLevel);
				byteTxD[5]=ToChar09AF(bytePir[2]>>4);
				byteTxD[6]=ToChar09AF(bytePir[2]&0x0F);
				byteTxD[7]=ToChar09AF(nPirHoldTimeReg);
				byteTxD[8]=ToChar09AF(bytePir[3]&0x0F);
				byteTxD[9]=ToChar09AF(bytePir[3]>>4);
				byteTxD[10]=ToChar09AF(bytePir[4]&0x0F);
				byteTxD[11]=0;
				myputs(byteTxD);
//----------------*/
}

void Pir_SetConfig(bool bNormal)  //using global nPirLevel(1..8), nPirHoldTimeReg=0
{
	u8 i,nLevel=(8-nPirLevel)<<5;
	u8 npht=nPirHoldTime;
	u16 nremain=DEF_PIRBITS;
//	u16 nremain=bNormal?DEF_PIRBITS:PIR_PWDOWN;
	
//	oPinPirDoci;  //clear possible int
//	clrPinPirDoci;

	clrPinPirSerin;
	TD_Delay01ms(10);
	for(i=0;i<15;i++) //bypass first 15bits (b39..b25)
	{
		setPinPirSerin;
		TD_Delay01ms(1);//0.5ms>t>0.06ms
		clrPinPirSerin;
	}
	for(i=0;i<8;i++) //nPirLevel 8bits (b24..b17)
	{
		setPinPirSerin;
		if(nLevel&(0x80>>i))	
			setPinPirSerin;
		else
			clrPinPirSerin;
			
		TD_Delay01ms(1);//0.5ms>t>0.06ms
		clrPinPirSerin;
	}
	for(i=0;i<4;i++) //4bits  b16..13
	{
		setPinPirSerin;
		if(npht&(0x8>>i))	
			setPinPirSerin;
		else
			clrPinPirSerin;
			
		TD_Delay01ms(1);//0.5ms>t>0.06ms
		clrPinPirSerin;
	}
//	if(bDefault)
	{
		for(i=0;i<12;i++) // b12..1
		{
			setPinPirSerin;
			if(nremain&(0x800>>i))	
				setPinPirSerin;
			else
				clrPinPirSerin;
				
			TD_Delay01ms(1);//0.5ms>t>0.06ms
			clrPinPirSerin;
		}
	}
	setPinPirSerin;
	TD_Delay01ms(6);//t=0.6ms lock input data without having to input remaining
	clrPinPirSerin;
//	intPinPirDoci;
}

void ReadEeprom()
{
	nPirHoldTime=FLASH_ReadByte(EEPROM_PIRHDTM);
	nPirLevel=FLASH_ReadByte(EEPROM_PIRSSLV);
	nLuxLevel=FLASH_ReadByte(EEPROM_LUXSSLV);
	nLowBatTime=FLASH_ReadByte(EEPROM_LOWBATTIME);
	
	if((nPirHoldTime==0)||(nPirHoldTime>MAX_PIRHOLDTIME))
	{
		nPirHoldTime=DEF_PIRHOLDTIME;
		WriteEeprom(EEPROM_PIRHDTM, nPirHoldTime);
	}
	if((nPirLevel==0)||(nPirLevel>MAX_PIRLEVEL))
	{
		nPirLevel=DEF_PIRLEVEL;
		WriteEeprom(EEPROM_PIRSSLV, nPirLevel);
	}
	if((nLuxLevel==0)||(nLuxLevel>MAX_LUXLEVEL))
	{
		nLuxLevel=DEF_LUXLEVEL;
		WriteEeprom(EEPROM_LUXSSLV, nLuxLevel);
	}
	if((nLowBatTime==0)||(nLowBatTime>MAX_LOWBATTIME))
	{
		nLowBatTime=DEF_LOWBATTIME;
		WriteEeprom(EEPROM_LOWBATTIME, nLowBatTime);
	}
}

void WriteEeprom(u32 addr, u8 data)
{
  FLASH_Unlock(FLASH_MemType_Data);
  while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET)  ;  /* Wait until Data EEPROM area unlocked flag is set*/
	FLASH_ProgramByte(addr, data);
	while(!(FLASH_GetFlagStatus(FLASH_FLAG_EOP)));
  FLASH_Lock(FLASH_MemType_Data);
}
	