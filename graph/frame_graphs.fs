#! /usr/bin/env gforth

\ frame_graphs.fs

\ This file is part of
\ Tron 0xF
\ A ZX Spectrum game written in Abersoft Forth

\ This program, written in Forth for Gforth, creates the graphics
\ used in the arena frame.

\ Copyright (C) 2015 Marcos Cruz (programandala.net)
\ License: GPL 3

\ http://programandala.net/en.program.tron_0xf.html

\ 2015-04-22: Start.

\ --------------------------------------------------------------
\ Requirements

fpath path+ ~/forth

require galope/unslurp-file.fs

\ --------------------------------------------------------------
\ Main

8 constant characters  \ characters in the font
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
%00001111 0 >font

%00001111
%00111111
%01111111
%01111111
%01111111
%11111111
%11111111
%11111111 1 >font

%11110000
%11111100
%11111110
%11111110
%11111111
%11111111
%11111111
%11111111 2 >font

%11111111
%11111111
%11111111
%11111111
%11111110
%11111110
%11111100
%11110000 3 >font

%01111111
%01111111
%11111111
%11111111
%01111111
%01111111
%11111111
%11111111 4 >font

%11001100
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111 5 >font

%11111111
%11111111
%11111110
%11111110
%11111111
%11111111
%11111110
%11111110 6 >font

%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%11111111
%00110011 7 >font

font /font s" ~/forth/tron_0xf/graph/frame_graphs.bin" unslurp-file
bye
