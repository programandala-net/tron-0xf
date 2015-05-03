# Makefile

# This file is part of
# Tron 0xF
# A ZX Spectrum game written in fig-Forth with Abersoft Forth

# Copyright (C) 2015 Marcos Cruz (programandala.net)
# License: GPL 3

# http://programandala.net/en.program.tron_0xf.html

################################################################
# History of this file

# 2015-03-23: Start.
# 2015-03-24: 4th part of the sources.
# 2015-03-28: Partial TAPs are hold in the tmp directory. 
# 2015-03-30: Two recipes only, no individual files specified any more.
# 2015-04-02: Updated.
# 2015-04-19: Updated.
# 2015-04-22: Frame graphs file.
# 2015-04-28: Title file.
# 2015-05-03: Updated.

################################################################
# Requirements

# Gforth
# 	<http://gnu.org/software/gforth/>
# bin2code
#   <http://metalbrain.speccy.org/link-eng.htm>.
# fsb
# 	<http://programandala.net/en.program.fsb.html>
# head (part of the GNU core utilities)
# pbm2scr
# 	<http://programandala.net/en.program.pbm2scr.html>

################################################################

VPATH = ./:src:lib:tmp
MAKEFLAGS = --no-print-directory

.ONESHELL :

.PHONEY : all
all : tron_0xf.tap

clean:
	rm -f tron_0xf.tap

clean-src:
	rm -f src/*.tap

clean-lib:
	rm -f lib/*.tap

graph/score_digits.tap : graph/score_digits.fs
	cd graph ; \
	gforth score_digits.fs -e bye ; \
	bin2code score_digits.bin score_digits.tap ; \
	cd -

graph/frame_graphs.tap : graph/frame_graphs.fs
	cd graph ; \
	gforth frame_graphs.fs -e bye ; \
	bin2code frame_graphs.bin frame_graphs.tap ; \
	cd -

graph/title.tap : graph/title.pbm
	cd graph ; \
	pbm2scr title.pbm ; \
 	head --bytes=2048 title.scr > title.bin ; \
	bin2code title.bin title.tap ; \
	cd -

lib/%.tap : lib/%.fsb
	fsb2abersoft  $<

src/%.tap : src/%.fsb
	fsb2abersoft  $<

library_tapes=$(wildcard lib/*.tap)
program_tapes=$(wildcard src/*.tap)

# XXX Note: dot-s.tap, cswap.tap and dump.tap are included only for debugging
# and will be removed.

tron_0xf.tap : \
	$(library_tapes) \
	$(program_tapes) \
	graph/score_digits.tap \
	graph/frame_graphs.tap \
	graph/title.tap
	for source in $$(ls -1 lib/*.fsb src/*.fsb) ; do
		@make $${source%%.fsb}.tap ;
	done
	cat \
		sys/abersoft_forth.tap \
		src/tron_0xf.file_00.loader.tap \
		lib/extend.tap \
		lib/flags.tap \
		lib/cell.tap \
		lib/plusscreen.tap \
		lib/scroll.tap \
		lib/color.tap \
		lib/pick.tap \
		lib/strings.tap \
		lib/upperc.tap \
		lib/time.tap \
		lib/random.tap \
		lib/dot-s.tap \
		lib/cswap.tap \
		lib/dump.tap \
		lib/tape.tap \
		lib/defer.tap \
		lib/value.tap \
		lib/akey.tap \
		lib/inkeyq.tap \
		lib/buffercol.tap \
		lib/at-fetch.tap \
		lib/point.tap \
		src/tron_0xf.file_0[1-9].*.tap \
		src/tron_0xf.file_[1-9]?.*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		graph/score_digits.tap \
		graph/frame_graphs.tap \
		graph/title.tap \
		> tron_0xf.tap
		
