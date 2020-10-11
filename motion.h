//ZF Created on 2019.5.10 in motion.h

#ifndef _MOTION_
#define _MOTION_
//#include "iostm8l051f3.h"
//#define MOTION_TEST

#define STM8L05X_LD_VL
#undef USE_STDPERIPH_DRIVER
#include "stm8l15x.h"
#include "mystm8l15x_conf.h"
#include "stm8l15x_gpio.h"
#include "stm8l15x_syscfg.h"
#include "stm8l15x_usart.h"
#include "stm8l15x_itc.h"
#include "stm8l15x_rtc.h"
#include "stm8l15x_flash.h"
//#include <stdio.h>

#define MAX_STRLEN 16
#define STR_FWVER "IBBW01_4 200122"
#define STR_BADCMD "BADCMD!"
#define TD_Delay() {for(x=0;x<40;x++) ;}

#define EEPROM_BASE 0x1000
#define EEPROM_PIRHDTM EEPROM_BASE
#define EEPROM_PIRSSLV (EEPROM_BASE+1)
#define EEPROM_LUXSSLV (EEPROM_BASE+2)
#define EEPROM_LOWBATTIME (EEPROM_BASE+3)

#define PIR_PWDOWN 0x38F  //PIR IC: E93196B
//#define DEF_PIRBITS 0xF80
#define DEF_PIRBITS 0x380
//#define DEF_PIRHOLDTIME 3
#define DEF_PIRHOLDTIME 8
#define DEF_PIRLEVEL 4
#define DEF_LUXLEVEL 4
#define DEF_LOWBATTIME 10
#define MAX_PIRHOLDTIME 15
#define MAX_PIRLEVEL 8
#define MAX_LUXLEVEL 8
#define MAX_LOWBATTIME 254

#define LUX_I2CAdd 0x46  //LightSensor: BH1721FVC
#define LUX_I2CCmd_PowerDown 0x0
#define LUX_I2CCmd_PowerOn 0x1
#define LUX_I2CCmd_AutoRes 0x10
#define LUX_I2CCmd_HRes 0x12
#define LUX_I2CCmd_LRes 0x13
#define LUX_I2CCmd_MTregH 0x40
#define LUX_I2CCmd_MTregL 0x60

#define iPinBtn 	GPIO_Init(GPIOB, GPIO_Pin_0, GPIO_Mode_In_PU_No_IT);  //turn off int
#define intPinBtn 	GPIO_Init(GPIOB, GPIO_Pin_0, GPIO_Mode_In_PU_IT);  //to capture press
#define getPinBtn GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_0)

#define iPinHostWakeUp 	GPIO_Init(GPIOB, GPIO_Pin_3, GPIO_Mode_In_PU_No_IT);  //turn off int
#define intPinHostWakeUp 	GPIO_Init(GPIOB, GPIO_Pin_3, GPIO_Mode_In_PU_IT);  //to capture HostWakeUp
#define getPinHostWakeUp GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_3)

#define onPinLedRed GPIO_ResetBits(GPIOA, GPIO_Pin_2)
#define offPinLedRed GPIO_SetBits(GPIOA, GPIO_Pin_2)
#define togPinLedRed GPIO_ToggleBits(GPIOA,GPIO_Pin_2);
#define onPinLedGreen GPIO_ResetBits(GPIOA, GPIO_Pin_3)
#define offPinLedGreen GPIO_SetBits(GPIOA, GPIO_Pin_3)
#define togPinLedGreen GPIO_ToggleBits(GPIOA,GPIO_Pin_3);

#define setPinLuxDVI GPIO_SetBits(GPIOC, GPIO_Pin_4)
#define clrPinLightSensorDVI GPIO_ResetBits(GPIOC, GPIO_Pin_4)

#define oPinPB4 	GPIO_Init(GPIOB, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Fast)  //1116 for hw test
#define setPinPB4 GPIO_SetBits(GPIOB, GPIO_Pin_4)
#define clrPinPB4 GPIO_ResetBits(GPIOB, GPIO_Pin_4)

#define setPinMyIntn GPIO_SetBits(GPIOB, GPIO_Pin_5)
#define clrPinMyIntn GPIO_ResetBits(GPIOB, GPIO_Pin_5)

#define setPinPirSerin GPIO_SetBits(GPIOB, GPIO_Pin_6)
#define clrPinPirSerin GPIO_ResetBits(GPIOB, GPIO_Pin_6)
#define setPinPirDoci GPIO_SetBits(GPIOB, GPIO_Pin_7)
#define clrPinPirDoci GPIO_ResetBits(GPIOB, GPIO_Pin_7)
#define getPinPirDoci GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_7)
//PIR INT/DOCI direction
#define oPinPirDoci 	GPIO_Init(GPIOB, GPIO_Pin_7, GPIO_Mode_Out_PP_Low_Fast);  //out low ready as clock
#define iPinPirDoci 	GPIO_Init(GPIOB, GPIO_Pin_7, GPIO_Mode_In_FL_No_IT);  //in as data
//#define intPinPirDoci 	GPIO_Init(GPIOB, GPIO_Pin_7, GPIO_Mode_In_FL_No_IT);  //no PIR int, for test
#define intPinPirDoci 	GPIO_Init(GPIOB, GPIO_Pin_7, GPIO_Mode_In_FL_IT);  //in 1 as int

//App internal use: MotionFlags
#define bmLedGreenFlash 1  //b0 Led Green, if 2Hz is set, flashing 2Hz else 1Hz
#define bmLedGreen2Hz 2  //b1 Led Green
#define bmLedRedFlash 4  //b2 Led Red
#define bmLedRed2Hz 8  //b3 Led Red
#define bmIntPir 16  //b4 PIR interrupt
#define bmBtnDown 32  //b5 Button pressed
#define bmBtnDownConfirmed 64  //b6 HostWakeUp
#define bmHostWakeUp 128  //b7 HostWakeUp
#define bmNeedAtCmd 0x100  //b8 GotAtCmd
#define bmStartup 0x200  //b9 Startup
#define bmIntPirStaCmd 0x400  //b10 PIR int cleared by ATSTA cmd
#define bmValidCmd 0x800  //b11 Command is valid to deal with 
#define bmLedDelay 0x1000  //b12 set Led delay time before halt
//#define bmWake 0x2000  //b13 if some int has wake the device, to prevent low battery sleep by delayed led flash 
#define bmCmdEcho 0x4000  //b14 To echo AT command for test only
#define bmHalt 0x8000  //b15 Halt

//App internal use: MotionFlags2
#define bm2LowBat 0x1  //b0 Low Battery 
#define bm2PirRecheck 0x2  //b1 Alex wants to add this bit to be sent as b4 in ATSTA response 

#define TIME_LONGPRESS (40)  //10s 4Hz 
#define TIME_MIDPRESS (20)  //5s 4Hz 
#define TIME_SHORTPRESS (8)  //2s 4Hz 

extern u16 MotionFlags,MotionFlags2;
extern u8 nLuxLevel, nPirLevel, nPirHoldTime,nLowBatTime;

extern u8 ToChar09AF(u8 nNum);
extern u8 FromChar09AF(u8 nChar);
extern u8 putchar (u8 c);
extern void myputs(u8 *str);

//periph.c
extern void RTC_SetWakeupPeriod(bool bMode);
extern u16 Lux_GetReading(u8 addr);
extern void Lux_SetMTreg(void);
extern void Lux_SendCmd(u8 cmd);
extern void Pir_GetConfig(void);
extern void Pir_SetConfig(bool bNormal);
extern void ReadEeprom(void);
extern void WriteEeprom(u32 addr, u8 data);

//main.c
extern void TD_Delay01ms(u8 d);

#endif