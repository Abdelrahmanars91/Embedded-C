
_newline:

;3.c,21 :: 		void newline()
;3.c,23 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;3.c,24 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;3.c,25 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_newline0:
	DECFSZ     R13+0, 1
	GOTO       L_newline0
	DECFSZ     R12+0, 1
	GOTO       L_newline0
	NOP
	NOP
;3.c,26 :: 		}
	RETURN
; end of _newline

_main:

;3.c,28 :: 		void main()
;3.c,30 :: 		T1CON = 0b00000011; // Prescaler (1:1), TOCS =1 for counter mode
	MOVLW      3
	MOVWF      T1CON+0
;3.c,31 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;3.c,32 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	NOP
	NOP
;3.c,33 :: 		Lcd_Init();  //LCD initiation
	CALL       _Lcd_Init+0
;3.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;3.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);//
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;3.c,37 :: 		LCD_chr(1,1,'T');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;3.c,38 :: 		lcd_out(2,1,"H:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;3.c,39 :: 		lcd_out(2,10,"l:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;3.c,40 :: 		ADC_Init();
	CALL       _ADC_Init+0
;3.c,41 :: 		TRISD=0B11110000;
	MOVLW      240
	MOVWF      TRISD+0
;3.c,42 :: 		TRISB.F6=0;
	BCF        TRISB+0, 6
;3.c,43 :: 		while(1){
L_main2:
;3.c,44 :: 		Temp = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;3.c,45 :: 		Temp=Temp*0.488;
	CALL       _Word2Double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      219
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Word+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;3.c,46 :: 		wordToStr(Temp,Temps);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _temps+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;3.c,47 :: 		lcd_out(1,12,Temps);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temps+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;3.c,49 :: 		UART1_Write_Text(Temps);
	MOVLW      _temps+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,50 :: 		UART1_Write_Text(" c");
	MOVLW      ?lstr3_3+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,52 :: 		newline();
	CALL       _newline+0
;3.c,53 :: 		TMR1L=0;
	CLRF       TMR1L+0
;3.c,54 :: 		TMR1H=0;
	CLRF       TMR1H+0
;3.c,55 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;3.c,56 :: 		T1= TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      _T1+0
	CLRF       _T1+1
	CLRF       _T1+2
	CLRF       _T1+3
;3.c,57 :: 		T1=T1<<8;
	MOVF       _T1+2, 0
	MOVWF      R0+3
	MOVF       _T1+1, 0
	MOVWF      R0+2
	MOVF       _T1+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	MOVWF      _T1+0
	MOVF       R0+1, 0
	MOVWF      _T1+1
	MOVF       R0+2, 0
	MOVWF      _T1+2
	MOVF       R0+3, 0
	MOVWF      _T1+3
;3.c,58 :: 		T1=T1|TMR1L;  // OR OPERATION
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	IORWF      R0+2, 1
	IORWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _T1+0
	MOVF       R0+1, 0
	MOVWF      _T1+1
	MOVF       R0+2, 0
	MOVWF      _T1+2
	MOVF       R0+3, 0
	MOVWF      _T1+3
;3.c,59 :: 		Humidity=569.91301651-0.0775253895*T1 ;
	CALL       _Longword2Double+0
	MOVLW      162
	MOVWF      R4+0
	MOVLW      197
	MOVWF      R4+1
	MOVLW      30
	MOVWF      R4+2
	MOVLW      123
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      111
	MOVWF      R0+0
	MOVLW      122
	MOVWF      R0+1
	MOVLW      14
	MOVWF      R0+2
	MOVLW      136
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _Humidity+0
	MOVF       R0+1, 0
	MOVWF      _Humidity+1
	MOVF       R0+2, 0
	MOVWF      _Humidity+2
	MOVF       R0+3, 0
	MOVWF      _Humidity+3
;3.c,60 :: 		intToStr(Humidity,Humiditys);
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _Humiditys+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;3.c,61 :: 		Lcd_Out(2,3,Humiditys);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _Humiditys+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;3.c,62 :: 		PORTB.F6=0;                 if(Temp>50){Humidity>300;
	BCF        PORTB+0, 6
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       _Temp+0, 0
	SUBLW      50
L__main15:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;3.c,63 :: 		PORTD=0;
	CLRF       PORTD+0
;3.c,64 :: 		}
	GOTO       L_main6
L_main5:
;3.c,66 :: 		PORTB.F6=1;
	BSF        PORTB+0, 6
;3.c,67 :: 		PORTD=0X08;
	MOVLW      8
	MOVWF      PORTD+0
;3.c,68 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;3.c,69 :: 		PORTD=0X0c;
	MOVLW      12
	MOVWF      PORTD+0
;3.c,70 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
	NOP
;3.c,71 :: 		PORTD=0X04;
	MOVLW      4
	MOVWF      PORTD+0
;3.c,72 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	NOP
	NOP
;3.c,73 :: 		PORTD=0X06;
	MOVLW      6
	MOVWF      PORTD+0
;3.c,74 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
	NOP
;3.c,75 :: 		PORTD=0X02;
	MOVLW      2
	MOVWF      PORTD+0
;3.c,76 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	NOP
	NOP
;3.c,77 :: 		PORTD=0X03;
	MOVLW      3
	MOVWF      PORTD+0
;3.c,78 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	NOP
	NOP
;3.c,79 :: 		PORTD=0X01;
	MOVLW      1
	MOVWF      PORTD+0
;3.c,80 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	NOP
	NOP
;3.c,81 :: 		PORTD=0X09;
	MOVLW      9
	MOVWF      PORTD+0
;3.c,82 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	NOP
	NOP
;3.c,83 :: 		}
L_main6:
;3.c,84 :: 		UART1_Write_Text(Humiditys);
	MOVLW      _Humiditys+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,85 :: 		UART1_Write_Text(" %");
	MOVLW      ?lstr4_3+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,86 :: 		newline();
	CALL       _newline+0
;3.c,87 :: 		Light = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _light+0
	MOVF       R0+1, 0
	MOVWF      _light+1
;3.c,88 :: 		Light=(Light*.0197)/5*100;  // Multiply with a constant
	CALL       _Word2Double+0
	MOVLW      229
	MOVWF      R4+0
	MOVLW      97
	MOVWF      R4+1
	MOVLW      33
	MOVWF      R4+2
	MOVLW      121
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Word+0
	MOVF       R0+0, 0
	MOVWF      _light+0
	MOVF       R0+1, 0
	MOVWF      _light+1
;3.c,89 :: 		wordToStr(Light, Lights);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _lights+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;3.c,92 :: 		lcd_out(2,12,Lights);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lights+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;3.c,94 :: 		UART1_Write_Text(lights);
	MOVLW      _lights+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,95 :: 		UART1_Write_Text(" l");
	MOVLW      ?lstr5_3+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;3.c,96 :: 		newline();
	CALL       _newline+0
;3.c,97 :: 		}}
	GOTO       L_main2
	GOTO       $+0
; end of _main
