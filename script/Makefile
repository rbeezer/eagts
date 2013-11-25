# This file is part of the book
#
#    Explorations in Algebraic Graph Theory with Sage
#
# Copyright (C) 2010-2013  Robert A. Beezer, Chris Godsil
# See the file COPYING for copying conditions.

# Prerequisites
#    install         (system tool to make directories)
#    xsltproc        (xml/xsl text processor)

XSL = /home/rob/mathbook/mathbook/xsl
CSS = /home/rob/mathbook/mathbook/css
SRC = /home/rob/books/eagts/eagts/src
IMAGES = $(SRC)/images
SCRATCH = /tmp/eagts-scratch

VERSION = testing

HTMLOUT = $(SCRATCH)/$(VERSION)
PDFOUT  = $(SCRATCH)/$(VERSION)

SAGE = /sage/sage-5.12/sage


html:
	install -d $(HTMLOUT)
	cp $(CSS)/mathbook.css $(HTMLOUT)
	cp -a $(IMAGES) $(HTMLOUT)
	cd $(HTMLOUT); \
	xsltproc --xinclude  $(XSL)/mathbook-html.xsl $(SRC)/eagts.xml

pdf:
	install -d $(PDFOUT)
	cp -a $(IMAGES) $(PDFOUT)
	cd $(PDFOUT); \
	xsltproc --xinclude  $(XSL)/mathbook-latex.xsl $(SRC)/eagts.xml > eagts.tex; \
	pdflatex eagts.tex; \
	pdflatex eagts.tex

viewpdf:
	evince $(PDFOUT)/eagts.pdf &

doctest:
	install -d $(SCRATCH)
	xsltproc --xinclude  $(XSL)/mathbook-sage-doctest.xsl $(SRC)/eagts.xml > $(SCRATCH)/eagts_doctest.py
	$(SAGE) -t  $(SCRATCH)/eagts_doctest.py

