#!/bin/sh

# bmp2scr.sh
# A wrapper for Marian Vetenau's BMP2SCR.

# This file is part of
# Tron 0xF
# A ZX Spectrum game written in Abersoft Forth

# http://programandala.net/en.program.tron_0xf.html

# 2015-04-26: Start.

# --------------------------------------------------------------
# Requirements

# Windows BMP to Spectrum SCR converter, by Marian Veteanu (c) VMA soft.

# dosbox, an x86 DOS emulator.

# --------------------------------------------------------------
#        Windows BMP to Spectrum SCR converter
#         Autor: Marian Veteanu  (c) VMA soft
#
#   Sintax: BMP2SCR <filename> [options]
#
#   <filename> is a 256x192xB&W .BMP file (6206 bytes)
#              or a 256x192x256 .BMP file (50230 bytes)
#
#   General options:
#       /I   : inverse pixels from image
#       /F   : use FLASH attr
#       /Gxx : use GRID type xx (bright colors pattern)
#       /Cxx : use compression type xx (see documentation)
#                   xx=0 -> STORE (default)
#                   xx=1 -> SIMPLE RLE
#                   xx=2 -> RLE
#
#   B/W image options:
#       /Kxx : use INK color xx
#       /Pxx : use PAPER color xx
#       /B   : use BRIGHT attr
#
#   Color image options:
#       /Axx : screen atributes options
#                   xx=0 -> don't use BRIGHT
#                   xx=1 -> use PAPER to set BRIGH
#                   xx=2 -> use INK to set BRIGHT
# --------------------------------------------------------------

# Arguments:
#   $1 = BMP file to convert

dosbox -c "MOUNT h $(pwd)" -c "h:" \
  -c "bmp2scr.exe $1"
