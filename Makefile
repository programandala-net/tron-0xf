# Makefile
#
# This file is part of Tron 0xF
# (http://programandala.net/es.programa.tron.html)
#
# 2015-03-23: Start.
# 2015-03-24: 4th part of the sources.
# 2015-03-28: Partial TAPs are hold in the tmp directory. 
# 2015-03-30: Two recipes only, no individual files specified any more.
# 2015-04-02: Updated.

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
	rm -f src/*.tap
	rm -f lib/*.tap

# library_sources=$(wildcard lib/*.fsb)
# program_sources=$(wildcard src/*.fsb)
# graph_sources=$(wildcard graph/*.fs)
program_tapes=$(wildcard src/*.tap)
library_tapes=$(wildcard lib/*.tap)

graph/score_digits.tap : graph/score_digits.fs
	cd graph ; \
	gforth score_digits.fs -e bye ; \
	bin2code score_digits.bin score_digits.tap ; \
	cd -

lib/%.tap : lib/%.fsb
	fsb2abersoft  $<

src/%.tap : src/%.fsb
	fsb2abersoft  $<

tron_0xf.tap : \
	$(library_tapes) \
	$(program_tapes) \
	graph/score_digits.tap
	for source in $$(ls -1 lib/*.fsb src/*.fsb) ; do
		@make $${source%%.fsb}.tap ;
	done ;
	@make graph/score_digits.tap
	cat abersoft_forth.tap \
		src/tron_0xf.loader.tap \
		lib/extend.tap \
		lib/strings.tap \
		lib/time.tap \
		lib/random.tap \
		lib/dot-s.tap \
		lib/dump.tap \
		lib/tape.tap \
		lib/defer.tap \
		src/tron_0xf.file_*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		graph/score_digits.tap \
		> tron_0xf.tap
