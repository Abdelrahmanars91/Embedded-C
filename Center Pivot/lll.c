// LCD module connections
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;
// End LCD module connections
unsigned Temp;
char temps[10];
unsigned light;
char lights[10];
float Humidity;  char Humiditys[10];
unsigned long T1;
 void newline()
 {
 UART1_Write(13); // Carriage Return
 UART1_Write(10); // Line Feed
 delay_ms(100);
}
///////////////////////////////////////////
  void main()
  {
 T1CON = 0b00000011; // Prescaler (1:1), TOCS =1 for counter mode
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize
  Lcd_Init();  //LCD initiation
  Lcd_Cmd(_LCD_CURSOR_OFF);

  Lcd_Cmd(_LCD_CLEAR);//
  LCD_out(1,1,"Temp:");
  lcd_out(2,1,"H:");
    lcd_out(2,10,"l:");
  ADC_Init();
  while(1){
  Temp = ADC_Read(0);
  Temp=Temp*0.488;
  wordToStr(Temp,Temps);
  lcd_out(1,12,Temps);

UART1_Write_Text(Temps);
UART1_Write_Text(" c");
//uart1_write("\n");
 newline();
  TMR1L=0;
  TMR1H=0;
  delay_ms(1000);
  T1= TMR1H;
  T1=T1<<8;
  T1=T1|TMR1L;  // OR OPERATION
Humidity=569.91301651-0.0775253895*T1 ;
  intToStr(Humidity,Humiditys);
  Lcd_Out(2,3,Humiditys);

UART1_Write_Text(Humiditys);
UART1_Write_Text(" %");
 newline();
  Light = ADC_Read(1);
  Light=(Light*.0197)/5*100;  // Multiply with a constant
  wordToStr(Light, Lights);
 // Lcd_Cmd(_LCD_CLEAR);
 // lcd_out(2,1,"light:");
  lcd_out(2,12,Lights);

 UART1_Write_Text(lights);
  UART1_Write_Text(" l");
 newline();
   }}