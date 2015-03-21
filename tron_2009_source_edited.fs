( Tron )
( Escrito en el fig-Forh de Abersoft Forth, para Sinclair ZX Spectrum. )

( Copyright [C] 1985,2009 Marcos Cruz - http://programandala.net )
( Licencia / License : http://programandala.net/license )

( 1985-04 Versión en fig-Forth del original en Sinclair Basic publicado en "Mi computer", tomo 5, página 1112. ) 
( 2009-05 Creación de este fichero de texto, a partir del fichero de bloques original, con algunos cambios. )

( Este fichero no puede utilizarse directamente en ningún Forth de Spectrum. )
( Se ofrece sólo para facilitar el acceso al código fuente original. )
( El código fuente en el formato original, necesario para ejecutar este programa en Abersoft Forth, está en el fichero tron.tap, disponible en: )
( http://programandala.net/es.programa.tron )

FORTH DEFINITIONS

VOCABULARY TRON
TRON DEFINITIONS

: TASK ;

0 VARIABLE Q
0 VARIABLE P
0 VARIABLE X
0 VARIABLE Y
0 VARIABLE A1
0 VARIABLE B1
0 VARIABLE M
0 VARIABLE N
0 VARIABLE I1
0 VARIABLE J1
0 VARIABLE COL

: NDRAW 
	23678 C@ + SWAP 23677 C@ + SWAP DRAW
	;

: RND 
	23670 @ 75 U* 75 0 D+ OVER OVER U< - - 1 - DUP
	23670 ! U* SWAP DROP 
	;

: INIT
	0 DUP PAPER BORDER CLS
	6 INK ."  MOTO 1=" Q ?
	5 INK ."         MOTO 2=" P ?
	2 INK 8 DUP PLOT 239 0 NDRAW 0 159 NDRAW
	-239 0 NDRAW 0 -159 NDRAW
	40 X ! 88 Y ! 215 M ! 88 N !
	1 A1 ! 0 B1 ! -1 I1 ! 0 J1 !
	7 INK 10 5 AT ." PULSA 0 PARA JUGAR "
	KEY 48 = NOT  IF 
		0 P ! 0 Q ! CLS QUIT 
	ENDIF
	10 5 AT 19 SPACES
	;


: CRASH
	COL @ INK 1 BRIGHT
	175 Y @ - 8 / X @ 8 / AT ."  "
	100 50 DO
		11 I BLEEP
	LOOP
	COL @ 6 =  IF  1 P +!  ELSE  1 Q +!  THEN 
	INIT 
	;

: POKE-XY
	175 Y @ - 8 / 32 *
	X @ 8 /
	+ 22528 + C! 
	;

: POKE-MN
	175 N @ - 8 / 32 *
	M @ 8 / + 22528 + C! 
	;

: MAIN
	BEGIN
		X @ Y @ POINT  IF  6 COL ! CRASH  ENDIF
		M @ N @ POINT  IF  5 COL ! M @ X ! N @ Y ! CRASH  ENDIF
		X @ Y @ PLOT  6 POKE-XY  1 0 BLEEP
		M @ N @ PLOT  5 POKE-MN  1 100 BLEEP
		64510 INP 254 =  IF  0 A1 ! 1 B1 !  ENDIF
		65022 INP 254 =  IF  0 A1 ! -1 B1 !  ENDIF
		65278 INP 251 =  IF  -1 A1 ! 0 B1 !  ENDIF
		65278 INP 247 =  IF  1 A1 ! 0 B1 !  ENDIF
		57342 INP 254 =  IF  0 I1 ! 1 J1 !  ENDIF
		49150 INP 254 =  IF  0 I1 ! -1 J1 !  ENDIF
		32766 INP 251 =  IF  1 I1 ! 0 J1 !  ENDIF
		32766 INP 247 =  IF  -1 I1 ! 0 J1 !  ENDIF
		A1 @ X +! 
		B1 @ Y +! 
		I1 @ M +! 
		J1 @ N +!
	AGAIN 
	;

: TRON 
	INIT MAIN 
	;

0 PAPER  0 BORDER  7 INK  CLS
CR ." TRON (Forth, ZX Spectrum)"
CR ." Copyright (C) 1985,2009 Marcos Cruz (http://programandala.net)"
CR ." Licencia/License: http://programandala.net/license"
CR 
CR ." Cada jugador tiene una moto a velocidad desbocada."
CR ." Su único control la hace girar 90 grados sin frenar."
CR ." Cada moto deja tras de sí una pared sólida de luz."
CR ." El objetivo del juego es hacer estrellarse a la otra moto con el laberinto hecho."
CR
CR ." Teclas:"
CR ." Jugador 1: Q A C X"
CR ." Jugador 2: P ENTER M N"
CR
CR ." Para empezar escribe TRON y pulsa la tecla ENTER"
	
