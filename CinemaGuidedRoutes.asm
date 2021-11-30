; ========================================================================================
; ==========================      ETEC Aristóteles Ferreira.    ==========================
; =======================         Prof.: Silvio C. da Silva.           ===================
; =========      Aluno/Autor: John Kennedy Loria Segundo - N# 12 - Turma 3A3     =========
; =================    CinemaGuidedRoutes.asm - ver. 2.0 data: 06/10/14  =================                       
; ========================================================================================


		ORG 0000H				    ;Início do programa no endereço de memoria 0000h
	
	MOV	P0, #00H				    ;Limpa Port0
	MOV	P1, #00H				    ;Limpa Port1
	MOV	P2, #0FFH				    ;Seta  Port2
	
	SCAN:						    ;Rotina SCAN
		MOV	P0, #00H			    ;Move 00h para P0
		MOV	P1, #00H			    ;Move 00h para P1
		MOV	A, P2				    ;Move P2 para o ACC
		JNB	P2.0, DIREITA			;Compara P2.0, se 0 -> DIREITA (Dipswitch 1)
		JNB	P2.7, ESQUERDA			;Compara P2.7, se 0 -> ESQUERDA (Dipswitch 8)
		JNB	P2.3, EMERGENCIA		;Compara P2.3, se 0 -> EMERGENCIA (Dipswitch 4)
		SJMP	SCAN				;Volta para SCAN
	
	
	DIREITA:					    ;Rotina DIREITA
		MOV	P0, #00111100B			;Joga 00111100B em P0
		MOV	P1, #00111100B			;Joga 00111100B em P1
		SJMP	SCAN				;Volta para SCAN
	
	ESQUERDA:					    ;Rotina ESQUERDA
		MOV	P0, #00001111B			;Joga 00001111B em P0
		MOV	P1, #00001111B			;Joga 00001111B em P1
		SJMP	SCAN				;Volta para SCAN
		
	EMERGENCIA:					    ;Rotina EMERGENCIA (Seqüência "Abre")
		CLR	P3.7				    ;Aciona o buzzer/sirene (Port3.7)
		MOV	P0, #00100001B			;Move 00100001B para Port0
		MOV	P1, #00100001B			;Move 00100001B para Port1	
							
		MOV	P0, #00101101B			;Aqui está sendo iníciado a seqüência "Abre"
		ACALL	TEMPO0				;Chamada de subrotina de tempo
		MOV	P1, #00101101B			;Aqui está sendo repetido a seqüência "Abre" no Port1
		ACALL	TEMPO0				;Chamada de subrotina de tempo
							
		MOV	P0, #00110011B			;Move 00110011B no Port0 (Rotina "Abre")
		ACALL	TEMPO0				;Chamada de subrotina de tempo
		MOV	P1, #00110011B			;Move 00110011B no Port1 (Rotina "Abre")
		ACALL	TEMPO0				;Chamada de subrotina de tempo
							
		MOV	P0, #00100001B			;Move 00100001B para Port0 (Rotina "Abre")
		ACALL	TEMPO0				;Chamada de subrotina de tempo
		MOV	P1, #00100001B			;Move 00100001B para Port1 (Rotina "Abre")
		ACALL	TEMPO0				;Chamada de subrotina de tempo
		
		SJMP	EMERGENCIA			;Volta para o início da rotina EMERGENCIA
				
							            ; ----------------------------
			TEMPO0:	MOV	R3, #3		    ;|	        				  |
			VOLTA2:	MOV	R4, #250	    ;|     Subrotina de tempo	  |
			VOLTA1:	MOV	R5, #250	    ;|	    					  |
							            ;|           0,33 S           |
				DJNZ	R5, $		    ;|		  			          |
				DJNZ	R4, VOLTA1	    ;|	    					  |
				DJNZ	R3, VOLTA2	    ; ----------------------------
			RET

	END						;Fim do programa