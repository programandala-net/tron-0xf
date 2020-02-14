# Makefile

# This file is part of
# Tron 0xF
# A ZX Spectrum game written in fig-Forth with Abersoft Forth

# http://programandala.net/en.program.tron_0xf.html

# Copyright (C) 2015,2016,2020 Marcos Cruz (programandala.net)

# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and
# this notice are preserved.  This file is offered as-is, without any
# warranty.

# Last modified 202002142049.
# See change log at the end of the file.

# ==============================================================
# Requirements

# Gforth
# 	<http://gnu.org/software/gforth/>
# bin2code
#   <http://metalbrain.speccy.org/link-eng.htm>.
# fsb
# 	<http://programandala.net/en.program.fsb.html>
# head
# 	Part of the GNU core utilities.
# pbm2scr
# 	<http://programandala.net/en.program.pbm2scr.html>

# ==============================================================

VPATH = ./:src:lib
MAKEFLAGS = --no-print-directory

VERSION = $(shell grep version\# src/tron_0xf.file_01.data.fsb | sed -e "s/.\+s\" \(.\+\)+.\+/\1/")
TARGET = target/tron_0xf_v$(VERSION)_compilable.tap

.ONESHELL:

.PHONEY: all
all: $(TARGET)

clean:
	rm -f $(TARGET) ; \
	rm -f tmp/*

# ==============================================================
# Make TAP files from the graphics

tmp/score_digits.tap: graph/score_digits.fs
	cd graph ; \
	gforth score_digits.fs -e bye ; \
	bin2code score_digits.bin ../$@ ; \
	rm -f score_digits.bin ; \
	cd -

tmp/udg.tap: graph/udg.fs
	cd graph ; \
	gforth udg.fs -e bye ; \
	bin2code udg.bin ../$@ ; \
	rm -f udg.bin ; \
	cd -

tmp/title.tap: graph/title.pbm
	cd graph ; \
	pbm2scr title.pbm ; \
 	head --bytes=2048 title.scr > title.bin ; \
	bin2code title.bin ../$@ ; \
	rm -f title.scr title.bin ; \
	cd -

# ==============================================================
# Make TAP files from the program sources

tmp/%.tap: src/%.fsb
	fsb-abersoft  $< && \
	mv src/$*.tap tmp/

# ==============================================================
# Make the main TAP file

library_tapes=$(wildcard lib/*.tap)
program_tapes=$(wildcard tmp/*.tap)

$(TARGET): \
	$(library_tapes) \
	$(program_tapes) \
	tmp/score_digits.tap \
	tmp/udg.tap \
	tmp/title.tap
	for source in $$(ls -1 src/*.fsb) ; do \
		make tmp/$$(basename $${source%%.fsb}).tap ; \
	done ; \
	cat \
		sys/abersoft_forth.tap \
		lib/loader.tap \
		lib/afera.tap \
		lib/lowersys.tap \
		lib/move.tap \
		lib/hi-to-top.tap \
		lib/hi-to.tap \
		lib/upperc.tap \
		lib/2r.tap \
		lib/uppers.tap \
		lib/caseins.tap \
		lib/traverse.tap \
		lib/flags.tap \
		lib/cell.tap \
		lib/at-fetch.tap \
		lib/plusscreen.tap \
		lib/scroll.tap \
		lib/strings.tap \
		lib/csb.tap \
		lib/pick.tap \
		lib/s-plus.tap \
		lib/ms.tap \
		lib/tape.tap \
		lib/defer.tap \
		lib/value.tap \
		lib/notequals.tap \
		lib/inkeyq.tap \
		lib/akey.tap \
		lib/buffercol.tap \
		lib/unloop.tap \
		lib/color.tap \
		lib/point.tap \
		lib/plot.tap \
		lib/noname.tap \
		lib/qexit.tap \
		lib/rdrop.tap \
		tmp/tron_0xf.file_*.tap \
		graph/font.tap \
		graph/font.esperanto_characters.tap \
		graph/font.spanish_characters.tap \
		tmp/score_digits.tap \
		tmp/udg.tap \
		tmp/title.tap \
		> $(TARGET)

# XXX -- Optional modules, for debugging
#		lib/dot-s.tap \
		lib/cswap.tap \
#		lib/dump.tap \

# ==============================================================
# Backups

backup:
	tar -cJf backups/$$(date +%Y%m%d%H%M)_tron_0xf.tar.xz \
		Makefile \
		src/*.fsb \
		graph/font.* \
		graph/*.fs \
		graph/*.pbm \
		README.* \
		tron_0xf.szx

# ==============================================================
# Packages for distribution

.PHONEY: packages
packages: tarball zipball

tarball:
	cd .. ; \
	tar \
		-czf tron_0xf/tron_0xf.tar.gz \
		tron_0xf/LICENSE.txt \
		tron_0xf/Makefile \
		tron_0xf/README.* \
		tron_0xf/TO-DO.* \
		tron_0xf/graph/* \
		tron_0xf/lib/* \
		tron_0xf/src/*.fsb \
		tron_0xf/tron_0xf.szx \
		tron_0xf/$(TARGET) ; \
	cd -

zipball:
	cd .. ; \
	zip -9 tron_0xf/tron_0xf.zip \
		tron_0xf/LICENSE.txt \
		tron_0xf/Makefile \
		tron_0xf/README.* \
		tron_0xf/TO-DO.* \
		tron_0xf/graph/* \
		tron_0xf/lib/* \
		tron_0xf/src/*.fsb \
		tron_0xf/tron_0xf.szx \
		tron_0xf/$(TARGET) ; \
	cd -

# ==============================================================
# Change log

# 2015-03-23: Start.
#
# 2015-03-24: 4th part of the sources.
#
# 2015-03-28: Partial TAPs are hold in the tmp directory.
#
# 2015-03-30: Two recipes only, no individual files specified any more.
#
# 2015-04-02: Updated.
#
# 2015-04-19: Updated.
#
# 2015-04-22: Frame graphs file.
#
# 2015-04-28: Title file.
#
# 2015-05-03: Updated.
#
# 2015-05-04: Updated with <lib/1plus.tap>, <lib/plot.tap>, <lib/noname.tap>.
#
# 2015-05-06: Updated after the recent changes in the Afera library.
#
# 2015-05-11: Updated after the recent changes in the Afera library.
#
# 2015-05-12: Updated after the recent changes in the Afera library.
#
# 2015-05-16: New: `backup` recipe.
#
# 2015-07-08: Changed `backup` recipe to use xz.
#
# 2015-07-09: Added <tron_0xf.szx> to the backup recipe.
#
# 2015-07-12: Updated with <lib/rdrop.tap>.
#
# 2015-07-15: Updated the `backup` recipe.
#
# 2015-07-17: Added tarball and zipball recipes for distribution package. File
# license. The `clean` recipe includes the graphics.
#
# 2015-07-18: Updated the `backup` recipe with the sources of the graphs.
#
# 2016-02-03: Fixed the tarball recipe: <tron_0xf_compiling.*> was missing.
#
# 2016-03-02: Added <TO-DO.adoc>.
#
# 2020-02-14: Update: remove <old>, which has been deleted, from the backups;
# rename <tap> to <tmp>. Make all of the temporary TAP files in the <tmp>
# directory. Add the current version (extracted from the sources) to the name
# of the target file.

