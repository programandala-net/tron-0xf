# Makefile
#
# This file is part of Tron
# (http://programandala.net/es.programa.tron.html)
#
# 2015-03-23: Start.
# 2015-03-24: 4th part of the sources.
# 2015-03-28: Partial TAPs are hold in the tmp directory. 

################################################################
# Requirements

# fsb
# (http://programandala.net/en.program.fsb.html)

################################################################
# Config

VPATH = ./:tmp
MAKEFLAGS = --no-print-directory

.PHONY: all
all : tron.tap

clean:
	rm -f tron.tap
	rm -f tron.file_*.tap
	rm -f tmp/tron.file_*.tap

################################################################
# XXX TODO

#%.tap : %.fsb
#	fsb2abersoft $< && mv -f $*.tap tmp/
#tron.tap : $(wildcard tron.file_*.tap)
#	cat abersoft_forth.tap tmp/tron.file_*.tap > tron.tap

################################################################
# XXX TMP -- Temporary method

tron.file_0.tap : tron.file_0.fsb
	fsb2abersoft tron.file_0.fsb
	mv -f tron.file_0.tap tmp/
tron.file_1.tap : tron.file_1.fsb
	fsb2abersoft tron.file_1.fsb
	mv -f tron.file_1.tap tmp/
tron.file_2.tap : tron.file_2.fsb
	fsb2abersoft tron.file_2.fsb
	mv -f tron.file_2.tap tmp/
tron.file_3.tap : tron.file_3.fsb
	fsb2abersoft tron.file_3.fsb
	mv -f tron.file_3.tap tmp/
tron.file_4.tap : tron.file_4.fsb
	fsb2abersoft tron.file_4.fsb
	mv -f tron.file_4.tap tmp/
tron.file_5.tap : tron.file_5.fsb
	fsb2abersoft tron.file_5.fsb
	mv -f tron.file_5.tap tmp/

tron.tap : \
    tron.file_0.tap \
    tron.file_1.tap \
    tron.file_2.tap \
    tron.file_3.tap \
    tron.file_4.tap \
    tron.file_5.tap
	cat abersoft_forth.tap tmp/tron.file_*.tap > tron.tap
