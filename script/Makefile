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
SCRATCH = /tmp/eagts

HTMLOUT = $(SCRATCH)/html
PDFOUT  = $(SCRATCH)/pdf
DOCTEST = $(SCRATCH)/doctest

SAGE = /sage/sage-6.9/sage
PDFVIEWER = okular
HTMLVIEWER = firefox


html:
	install -d $(HTMLOUT)
	cp -a $(IMAGES) $(HTMLOUT)
	-rm $(HTMLOUT)/*.html
	cd $(HTMLOUT); \
	xsltproc --xinclude --stringparam html.knowl.exercise.inline no $(XSL)/mathbook-html.xsl $(SRC)/eagts.xml

viewhtml:
	$(HTMLVIEWER) $(HTMLOUT)/eagts.html &

pdf:
	install -d $(PDFOUT)
	cp -a $(IMAGES) $(PDFOUT)
	cd $(PDFOUT); \
	xsltproc --xinclude  $(XSL)/mathbook-latex.xsl $(SRC)/eagts.xml > eagts.tex; \
	pdflatex eagts.tex; \
	pdflatex eagts.tex

viewpdf:
	$(PDFVIEWER) $(PDFOUT)/eagts.pdf &

# first doctest writes the file "testlist-eagts.sobj" in current directory
#   this can look suspicious when left behind
doctest:
	install -d $(DOCTEST)
	-rm $(DOCTEST)/*.py
	cd $(DOCTEST); \
	xsltproc --xinclude  --stringparam chunk-level 2 $(XSL)/mathbook-sage-doctest.xsl $(SRC)/eagts.xml; \
	$(SAGE) -tp  *.py

