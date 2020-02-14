#! /usr/bin/env gforth

\ score_digits.fs

\ This program, written in Forth for Gforth, creates the double-heigth
\ score digits used in Tron 0xF.

\ This file is part of
\ Tron 0xF
\ A ZX Spectrum game written in Abersoft Forth

\ Copyright (C) 2015,2020 Marcos Cruz (programandala.net)
\ Licencia/Permesilo/License: GPL 3

\ http://programandala.net/en.program.tron_0xf.html

\ --------------------------------------------------------------
\ History of this file

\ 2015-04-02: Start.
\
\ 2015-04-05: First working version.
\
\ 2015-04-27: Relative path for the output file. `unslurp-file` is
\ pasted instead of required.
\
\ 2020-02-14: Update the source style.

\ --------------------------------------------------------------
\ Requirements

\ From the Galope library
\ (http://programandala.net/en.program.galope.html):

: unslurp-file  ( ca1 len1 ca2 len2 -- )
  w/o create-file throw >r
  r@ write-file throw
  r> close-file throw ;
  \ Save a memory region to a file.
  \ ca1 len1 = content to write to the file
  \ ca2 len2 = filename

\ --------------------------------------------------------------
\ Main

10 constant characters \ characters in the font
8 constant /character  \ bytes per character
characters 2 * /character * chars constant /font
create font /font allot
font constant top-font
font characters /character * + constant bottom-font

: (>font)  ( b a n scan -- ) 8 swap - swap /character * + + c! ;
  \ Save a character scan into the font.
  \ b = character scan
  \ a = address of the half font (top or bottom)
  \ n = position of the character in the font (0 is the first)
  \ scan = 0..7

: >font  ( b0..b15 n -- )
  { character }
  9 1 do bottom-font character i (>font) loop
  9 1 do top-font character i (>font)    loop ;
  \ Save a character definition into the font.
  \ b0..b7 = 8 scans of the top half of the character
  \ b8..b15 = 8 scans of the bottom half of the character
  \ n = position of the character in the font (0 is the first)

\ --------------------------------------------------------------
\ Graphics

%00000000
%11111110
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10111110
0 >font

%00000000
%00011110
%00010010
%00010010
%01110010
%01000010
%01000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%11111110
1 >font

%00000000
%11111110
%00000010
%00000010
%00000010
%00000010
%00001110
%00001000
%00111000
%00100000
%00100000
%11100000
%10000000
%10000000
%10000000
%11111110
2 >font

%00000000
%11111110
%00000010
%00000010
%00000010
%00000010
%00011110
%00010000
%00011110
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%11111110
3 >font

%00000000
%10001110
%10001010
%10001010
%10001010
%10001010
%10001010
%11111010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%11111110
4 >font

%00000000
%11111110
%10000000
%10000000
%10000000
%10000000
%10000000
%11111110
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%11111110
5 >font

%00000000
%11111110
%10000000
%10000000
%10000000
%10000000
%10000000
%10111110
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%11111110
6 >font

%00000000
%11111110
%00000010
%00000010
%00001110
%00001000
%00001000
%00111000
%00100000
%00100000
%11100000
%10000000
%10000000
%10000000
%10000000
%10000000
7 >font

%00000000
%11111110
%10000010
%10000010
%10000010
%10000010
%10000000
%11111110
%00000010
%10000010
%10000010
%10000010
%10000010
%10000010
%10000010
%11111110
8 >font

%00000000
%11111110
%10000010
%10000010
%10000010
%10000010
%10000010
%11111010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%00000010
%11111110
9 >font

font /font s" ./score_digits.bin" unslurp-file
bye
