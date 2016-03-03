#!/bin/sh

# Launcher to open the TAP file of Tron 0xF with the Fuse emulator
# on ZX Spectrum 128K.

# This file is part of
# Tron 0xF
# A ZX Spectrum game written in fig-Forth with Abersoft Forth
# http://programandala.net/en.program.tron_0xf.html

# 2015-03-27: Start.
# 2016-03-03: Modified. Renamed.

fuse \
  --machine 128 \
  --no-divide \
  --tape tron_0xf_compiling.tap \
  --speed 100 \
  &
