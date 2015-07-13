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
# 2015-05-04: Updated with <lib/1plus.tap>, <lib/plot.tap>,
#   <lib/noname.tap>.
# 2015-05-06: Updated after the recent changes in the Afera library.
# 2015-05-11: Updated after the recent changes in the Afera library.
# 2015-05-12: Updated after the recent changes in the Afera library.
# 2015-05-16: New: backup recipe.
# 2015-07-08: Changed backup recipe to use xz.
# 2015-07-09: Added <tron_0xf.szx> to the backup recipe.
# 2015-07-12: Updated with <lib/rdrop.tap>.

################################################################
# Requirements

# Gforth
# 	<http://gnu.org/software/gforth/>
#
# bin2code
#   <http://metalbrain.speccy.org/link-eng.htm>.
#
# fsb
# 	<http://programandala.net/en.program.fsb.html>
#
# head (part of the GNU core utilities)
#
# pbm2scr
# 	<http://programandala.net/en.program.pbm2scr.html>

################################################################

VPATH = ./:src:lib:tmp
MAKEFLAGS = --no-print-directory

.ONESHELL :

.PHONEY : all
all : tron_0xf_compiling.tap

clean:
	rm -f tron_0xf_compiling.tap ; \
	rm -f tap/*.tap

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

tap/%.tap : src/%.fsb
	fsb2abersoft  $< && \
	mv src/$*.tap tap/

library_tapes=$(wildcard lib/*.tap)
program_tapes=$(wildcard tap/*.tap)

#		lib/lowersys.tap \
#		lib/bank.tap \
#		lib/16kramdisks.tap \
		

#		@make tap/$$(basename $${source%%.fsb}).tap ;

tron_0xf_compiling.tap : \
	$(library_tapes) \
	$(program_tapes) \
	graph/score_digits.tap \
	graph/frame_graphs.tap \
	graph/title.tap
	for source in $$(ls -1 src/*.fsb) ; do \
		make tap/$$(basename $${source%%.fsb}).tap ; \
	done ; \
	cat \
		sys/abersoft_forth.tap \
		lib/loader.tap \
		lib/afera.tap \
		lib/upperc.tap \
		lib/uppers.tap \
		lib/2r.tap \
		lib/caseins.tap \
		lib/traverse.tap \
		lib/flags.tap \
		lib/cell.tap \
		lib/at-fetch.tap \
		lib/plusscreen.tap \
		lib/scroll.tap \
		lib/pick.tap \
		lib/move.tap \
		lib/strings.tap \
		lib/csb.tap \
		lib/csb-256.tap \
		lib/s-plus.tap \
		lib/time.tap \
		lib/dot-s.tap \
		lib/tape.tap \
		lib/defer.tap \
		lib/value.tap \
		lib/notequals.tap \
		lib/akey.tap \
		lib/inkeyq.tap \
		lib/buffercol.tap \
		lib/unloop.tap \
		lib/point.tap \
		lib/plot.tap \
		lib/noname.tap \
		lib/qexit.tap \
		lib/rdrop.tap \
		tap/tron_0xf.file_*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		graph/score_digits.tap \
		graph/frame_graphs.tap \
		graph/title.tap \
		> tron_0xf_compiling.tap

# XXX OLD	
#		lib/cswap.tap \
#		lib/color.tap \
#		lib/dump.tap \

# ##############################################################
# Backups

backup:
	tar -cJf backups/$$(date +%Y%m%d%H%M)_tron_0xf.tar.xz \
		Makefile \
		src/*.fsb \
		README.md \
		tron_0xf.szx \
		old/*

