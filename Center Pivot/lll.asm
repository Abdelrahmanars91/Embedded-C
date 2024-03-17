
_newline:

;lll.c,21 :: 		void newline()
;lll.c,23 :: 		UART1_Write(13); // Carriage Return
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lll.c,24 :: 		UART1_Write(10); // Line Feed
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;lll.c,25 :: 		delay_ms(100);
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
;lll.c,26 :: 		}
	RETURN
; end of _newline

_main:

;lll.c,28 :: 		void main()
;lll.c,30 :: 		T1CON = 0b00000011; // Prescaler (1:1), TOCS =1 for counter mode
	MOVLW      3
	MOVWF      T1CON+0
;lll.c,31 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;lll.c,32 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
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
;lll.c,33 :: 		Lcd_Init();  //LCD initiation
	CALL       _Lcd_Init+0
;lll.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lll.c,36 :: 		Lcd_Cmd(_LCD_CLEAR);//
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lll.c,37 :: 		LCD_out(1,1,"Temp:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lll+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,38 :: 		lcd_out(2,1,"H:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_lll+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,39 :: 		lcd_out(2,10,"l:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_lll+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,40 :: 		ADC_Init();
	CALL       _ADC_Init+0
;lll.c,41 :: 		while(1){
L_main2:
;lll.c,42 :: 		Temp = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;lll.c,43 :: 		Temp=Temp*0.488;
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
;lll.c,44 :: 		wordToStr(Temp,Temps);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _temps+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;lll.c,45 :: 		lcd_out(1,12,Temps);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temps+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,47 :: 		UART1_Write_Text(Temps);
	MOVLW      _temps+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,48 :: 		UART1_Write_Text(" c");
	MOVLW      ?lstr4_lll+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,50 :: 		newline();
	CALL       _newline+0
;lll.c,51 :: 		TMR1L=0;
	CLRF       TMR1L+0
;lll.c,52 :: 		TMR1H=0;
	CLRF       TMR1H+0
;lll.c,53 :: 		delay_ms(1000);
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
;lll.c,54 :: 		T1= TMR1H;
	MOVF       TMR1H+0, 0
	MOVWF      _T1+0
	CLRF       _T1+1
	CLRF       _T1+2
	CLRF       _T1+3
;lll.c,55 :: 		T1=T1<<8;
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
;lll.c,56 :: 		T1=T1|TMR1L;  // OR OPERATION
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
;lll.c,57 :: 		Humidity=569.91301651-0.0775253895*T1 ;
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
;lll.c,58 :: 		intToStr(Humidity,Humiditys);
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _Humiditys+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;lll.c,59 :: 		Lcd_Out(2,3,Humiditys);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _Humiditys+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,61 :: 		UART1_Write_Text(Humiditys);
	MOVLW      _Humiditys+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,62 :: 		UART1_Write_Text(" %");
	MOVLW      ?lstr5_lll+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,63 :: 		newline();
	CALL       _newline+0
;lll.c,64 :: 		Light = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _light+0
	MOVF       R0+1, 0
	MOVWF      _light+1
;lll.c,65 :: 		Light=(Light*.0197)/5*100;  // Multiply with a constant
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
;lll.c,66 :: 		wordToStr(Light, Lights);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _lights+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;lll.c,69 :: 		lcd_out(2,12,Lights);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lights+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lll.c,71 :: 		UART1_Write_Text(lights);
	MOVLW      _lights+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,72 :: 		UART1_Write_Text(" l");
	MOVLW      ?lstr6_lll+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;lll.c,73 :: 		newline();
	CALL       _newline+0
;lll.c,74 :: 		}}
	GOTO       L_main2
	GOTO       $+0
; end of _main
