#! /usr/bin/env gforth

\ udg.fs

\ This file is part of
\ Tron 0xF
\ A ZX Spectrum game written in Abersoft Forth

\ This program, written in Forth for Gforth, creates the user defined
\ graphics.

\ Copyright (C) 2015 Marcos Cruz (programandala.net)
\ License: GPL 3

\ http://programandala.net/en.program.tron_0xf.html

\ 2015-04-22: Start, with the frame graphics.
\
\ 2015-07-18: Added the key names. Renamed the file. Pasted
\ `unslurp-file` instead of including it, because Galope is not
\ published yet.

\ --------------------------------------------------------------
\ Requirements

fpath path+ ~/forth

\ From the Galope library
\ (http://programandala.net/en.program.galope.html):

\ Copyright (C) 2013,2014 Marcos Cruz (programandala.net)

\ 2013-11-28: First version, 'unslurp', after Gforth's 'slurp-file'.
\ 2014-02-21: Renamed to 'unslurp-file'.

: unslurp-file  ( ca1 len1 ca2 len2 -- )
  \ ca1 len1 = content to write to the file
  \ ca2 len2 = filename
  w/o create-file throw >r
  r@ write-file throw
  r> close-file throw
  ;

\ --------------------------------------------------------------
\ Main

12 constant characters  \ characters in the UDG set
8 constant /character   \ bytes per character
characters /character * chars constant /font
create font /font allot

: (>font)  ( b a n scan -- )
  \ Save a character scan into the font.
  \ b = character scan
  \ a = address of the font
  \ n = position of the character in the font (0 is the first)
  \ scan = 1..8
  8 swap -  swap /character * + + c!
  ;
: >font  ( b0..b7 n -- )
  \ Save a character definition into the font.
  \ b0..b7 = scans
  \ n = position of the character in the font (0 is the first)
  { character }
  9 1 do  font character i (>font)  loop
  ;

\ --------------------------------------------------------------
\ Graphics

%11111111
%11111111
%11111111
%11111111
%01111111
%01111111
%00111111
%00001111 0 >font  \ frame bottom left corner

%00001111
%00111111
%01111111
%01111111
%01111111
%11111111
%11111111
%11111111 1 >font  \ frame top left corner

%11110000
%11111100
%11111110
%11111110
%11111111
%11111111
%11111111
%11111111 2 >font  \ frame top rigth corner

%11111111
%11111111
%11111111
%11111111
%11111110
%11111110
%11111100
%11110000 3 >font  \ frame bottom rigth corner

%01111111
%01111111
%11111111
%11111111
%01111111
%01111111
%11111111
%11111111 4 >font  \ frame left border

%11001100
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111 5 >font  \ frame top border

%11111111
%11111111
%11111110
%11111110
%11111111
%11111111
%11111110
%11111110 6 >font  \ frame right border

%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%00110011 7 >font  \ frame bottom border

%11101111
%10001000
%10001000
%10001111
%10000001
%10000001
%11101111
%00000000 8 >font  \ Caps Shift key name

%11100000
%10000000
%10000000
%11001111
%10001001
%10001001
%11101001
%00000000 9 >font  \ Enter key name

%11100000
%10000000
%10000000
%11101111
%00101001
%00101001
%11101111
%00001000 10 >font  \ Space key name

%11101111
%10001000
%10001000
%11101111
%00100001
%00100001
%11101111
%00000000 11 >font  \ Symbol Shift key name

font /font s" ~/forth/tron_0xf/graph/udg.bin" unslurp-file
bye
