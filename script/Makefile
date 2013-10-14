# Prerequisites
#    install         (system tool to make directories)
#    xsltproc        (xml/xsl text processor)

XSL = /home/rob/mathbook/mathbook/xsl
CSS = /home/rob/mathbook/mathbook/css
SRC = /home/rob/books/eagts/eagts/src
SCRATCH = /tmp/eagts-scratch

VERSION = testing

HTMLOUT = $(SCRATCH)/$(VERSION)
PDFOUT  = $(SCRATCH)/$(VERSION)

SAGE = /sage/sage-5.12/sage


test:
	install -d $(HTMLOUT)
	cp $(CSS)/mathbook.css $(HTMLOUT)
	cd $(HTMLOUT); \
	xsltproc --xinclude  $(XSL)/mathbook-html.xsl $(SRC)/eagts.xml

latex:
	install -d $(PDFOUT)
	cd $(PDFOUT); \
	xsltproc --xinclude  $(XSL)/mathbook-latex.xsl $(SRC)/eagts.xml > eagts.tex; \
	pdflatex eagts.tex; \
	pdflatex eagts.tex

