# Makefile
#
# This file is part of Tron
# (http://programandala.net/es.programa.tron.html)
#
# 2015-03-23: Start.
# 2015-03-24: 4th part of the sources.

################################################################
# Requirements

# fsb
# (http://programandala.net/en.program.fsb.html)

################################################################
# Config

VPATH = ./
MAKEFLAGS = --no-print-directory

.PHONY: all
all: tron.tap

clean:
	rm -f tron.file_*.tap

################################################################

tron.file_0.tap : tron.file_0.fsb
	fsb2abersoft tron.file_0.fsb

tron.file_1.tap : tron.file_1.fsb
	fsb2abersoft tron.file_1.fsb

tron.file_2.tap : tron.file_2.fsb
	fsb2abersoft tron.file_2.fsb

tron.file_3.tap : tron.file_3.fsb
	fsb2abersoft tron.file_3.fsb

tron.tap : \
	tron.file_0.tap \
	tron.file_1.tap \
	tron.file_2.tap \
	tron.file_3.tap
	cat tron.file_?.tap > tron.tap


