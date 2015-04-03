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

# fsb
# (http://programandala.net/en.program.fsb.html)

################################################################
# Config

VPATH = ./:src:lib:tmp
MAKEFLAGS = --no-print-directory

.ONESHELL :

.PHONY: all
all : tron.tap

clean:
	rm -f tron_0xf.tap
	rm -f src/*.tap
	rm -f lib/*.tap

################################################################
# XXX TODO

#%.tap : %.fsb
#	fsb2abersoft $< && mv -f $*.tap tmp/
#tron.tap : $(wildcard tron.file_*.tap)
#	cat abersoft_forth.tap tmp/tron.file_*.tap > tron.tap

################################################################
# XXX TMP -- Temporary method

library_sources=$(wildcard lib/*.fsb)
library_tapes=$(wildcard lib/*.tap)
program_sources=$(wildcard src/*.fsb)
program_tapes=$(wildcard src/*.tap)

# --------------------------------------------------------------
# XXX When this recipe is used, and tron.tap
# depends on $(library_tapes) and $(program_tapes),
# everything works fine BUT only as long as the
# TAP files already exist. When they exist, they
# are updated; when they are missing, they are
# not created.

%.tap : %.fsb
	fsb2abersoft  $<

# XXX this works too:
# lib/%.tap : lib/%.fsb
# 	fsb2abersoft  $<

# XXX This is a temporary solution, required after clean:

remake: $(library_sources) $(program_sources)
	for source in $$(ls -1 lib/*.fsb) ; do \
		fsb2abersoft  $$source ; \
	done ; \
	for source in $$(ls -1 src/*.fsb) ; do \
		fsb2abersoft  $$source ; \
	done


# --------------------------------------------------------------
# XXX When this loop is used, and tron.tap depends
# on library, all library files are always rebuilt:
# library: $(library_sources)
# 	cd lib ; \
# 	for source in $$(ls -1 *.fsb) ; do \
# 		fsb2abersoft  $$source ; \
# 	done ; \
# 	cd -


# --------------------------------------------------------------
# Main

tron.tap : \
	$(library_tapes) \
	$(program_tapes)
	cat abersoft_forth.tap \
		lib/extend.tap \
		lib/strings.tap \
		lib/time.tap \
		lib/random.tap \
		lib/dot-s.tap \
		lib/dump.tap \
		lib/tape.tap \
		src/tron_0xf.file_*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		> tron_0xf.tap
