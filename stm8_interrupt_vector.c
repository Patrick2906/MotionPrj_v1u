/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */

typedef void @far (*interrupt_handler_t)(void);
extern @far @interrupt void ISR_Btn(void);  //PB0
extern @far @interrupt void ISR_HostWakeUp(void);  //PB3
extern @far @interrupt void ISR_RtcWakeUp(void);  //period=10s
extern @far @interrupt void ISR_Pir(void);  //PB7
extern @far @interrupt void ISR_Timer2(void);  //period=0.25s
extern @far @interrupt void ISR_Uart1Rx(void);  

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt (void)
{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
	return;
}

extern void _stext();     /* startup routine */

struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, NonHandledInterrupt}, /* trap  */
	{0x82, NonHandledInterrupt}, /* irq0  */
	{0x82, NonHandledInterrupt}, /* irq1  */
	{0x82, NonHandledInterrupt}, /* irq2  */
	{0x82, NonHandledInterrupt}, /* irq3  */
	{0x82, ISR_RtcWakeUp}, /* irq4  */
	{0x82, NonHandledInterrupt}, /* irq5  */
	
//	{0x82, NonHandledInterrupt}, /* irq6  */
//	{0x82, NonHandledInterrupt}, /* irq7  */
	//{0x82, NonHandledInterrupt}, /* irq8  */
	//{0x82, NonHandledInterrupt}, /* irq9  */
	//{0x82, NonHandledInterrupt}, /* irq10 */
	//{0x82, NonHandledInterrupt}, /* irq11 */
	//{0x82, NonHandledInterrupt}, /* irq12 */
	//{0x82, NonHandledInterrupt}, /* irq13 */
	//{0x82, NonHandledInterrupt}, /* irq14 */
	//{0x82, NonHandledInterrupt}, /* irq15 */
{0x82, NonHandledInterrupt},  //(interrupt_handler_t)EXTIB_G_IRQHandler},      /* irq6 - External IT PORTB / PORTG interrupt*/
  {0x82, NonHandledInterrupt},			/* irq7 - External IT PORTD / PORTH interrupt */
  {0x82, ISR_Btn},			/* irq8 - External IT PIN0 interrupt */
  {0x82, NonHandledInterrupt},			/* irq9 - External IT PIN1 interrupt */
  {0x82, NonHandledInterrupt},			/* irq10 - External IT PIN2 interrupt */
//  {0x82, NonHandledInterrupt},		  /* irq11 - External IT PIN3 interrupt */
  {0x82, ISR_HostWakeUp},		  /* irq11 - External IT PIN3 interrupt */
  {0x82, NonHandledInterrupt},      /* irq12 - External IT PIN4 interrupt */
  {0x82, NonHandledInterrupt},      /* irq13 - External IT PIN5 interrupt */
  {0x82, NonHandledInterrupt},      /* irq14 - External IT PIN6 interrupt */
//  {0x82, NonHandledInterrupt},      /* irq15 - External IT PIN7 interrupt */
  {0x82, ISR_Pir},      /* irq15 - External IT PIN7 interrupt */
	
	
	{0x82, NonHandledInterrupt}, /* irq16 */
	{0x82, NonHandledInterrupt}, /* irq17 */
	{0x82, NonHandledInterrupt}, /* irq18 */
	{0x82, ISR_Timer2}, /* irq19 */
	{0x82, NonHandledInterrupt}, /* irq20 */
	{0x82, NonHandledInterrupt}, /* irq21 */
	{0x82, NonHandledInterrupt}, /* irq22 */
	{0x82, NonHandledInterrupt}, /* irq23 */
	{0x82, NonHandledInterrupt}, /* irq24 */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, ISR_Uart1Rx}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};
