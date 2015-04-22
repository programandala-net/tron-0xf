# Makefile
#
# This file is part of Tron 0xF
# (http://programandala.net/en.program.tron_0xf.html)
#
# 2015-03-23: Start.
# 2015-03-24: 4th part of the sources.
# 2015-03-28: Partial TAPs are hold in the tmp directory. 
# 2015-03-30: Two recipes only, no individual files specified any more.
# 2015-04-02: Updated.
# 2015-04-19: Updated.

################################################################
# Requirements

# fsb (http://programandala.net/en.program.fsb.html)
# Gforth
# bin2code

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

lib/%.tap : lib/%.fsb
	fsb2abersoft  $<

src/%.tap : src/%.fsb
	fsb2abersoft  $<

# XXX OLD
# source_files=$(wildcard src/*.fsb)
# source_lib_files=$(wildcard lib/*.fsb)
# sources: $(source_files) $(source_lib_files)
# 	for source in $$(ls -1 src/*.fsb) ; do
# 		@make $$(basename $${source} .fsb).tap ;
# 	done
# 	for source in $$(ls -1 lib/*.fsb) ; do
# 		@make $$(basename $${source} .fsb).tap ;
# 	done

library_tapes=$(wildcard lib/*.tap)
program_tapes=$(wildcard src/*.tap)

# XXX Note: dot-s.tap, cswap.tap and dump.tap are included only for debugging
# and will be removed.

tron_0xf.tap : \
	$(library_tapes) \
	$(program_tapes) \
	graph/score_digits.tap \
	graph/frame_graphs.tap
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
		lib/strings.tap \
		lib/time.tap \
		lib/random.tap \
		lib/dot-s.tap \
		lib/cswap.tap \
		lib/dump.tap \
		lib/tape.tap \
		lib/defer.tap \
		lib/value.tap \
		lib/key.tap \
		lib/buffercol.tap \
		src/tron_0xf.file_0[1-9].*.tap \
		src/tron_0xf.file_[1-9]?.*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		graph/score_digits.tap \
		graph/frame_graphs.tap \
		> tron_0xf.tap
