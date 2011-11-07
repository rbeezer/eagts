#
# A sed script to convert Structured LaTeX into Docbook XML
#
# Rob Beezer <beezer@ups.edu>
#
#
####
#
# Miscellaneous TeX-isms
#
####
#
# Throwaway lines, single leading %
#
s/^%$//g
#
# TeX left/right quotes
#
s/``/"/g
s/''/"/g
#
# TeX itself
#
s/\\TeX{}/TeX/g

####
#
# Various Code/Sage Markup
#
####
#
# Environments
#
#   Wrapped in CDATA for protection
#
s/\\begin{verbatim}/<sage>\n<input><![CDATA[/g
s/\\end{verbatim}/]]><\/input>\n<\/sage>/g
s/\\begin{sageblock}/<sage>\n<input><![CDATA[/g
s/\\end{sageblock}/]]><\/input>\n<\/sage>/g
s/\\begin{sageexample}/<sage>\n<input><![CDATA[/g
s/\\end{sageexample}/]]><\/input>\n<\/sage>/g
s/\\begin{center}/<sage>\n<input><![CDATA[/g
s/\\end{center}/]]><\/input>\n<\/sage>/g
#
#   inline code snippets, CDATA not allowed here?
#
s/\\verb|\([^|]*\)|/<code>\1<\/code>/g
s/\\texttt{\([^}]*\)}/<code>\1<\/code>/g





####
#
# Environments
#
####
#
# Paragraph "para"
#
s/\\begin{para}/<para>/g
s/\\end{para}/<\/para>/g
#
# Section "sect" 1=title
#
s/\\begin{sect}{\([^}]*\)}/<sect1>\n<title>\1<\/title>/g
s/\\end{sect}/<\/sect1>/g
#
# Preface "preface"
#
s/\\begin{preface}/<preface xmlns="http:\/\/docbook.org\/ns\/docbook" version="5.0" xml:lang="en" xmlns:xl="http:\/\/www.w3.org\/1999\/xlink"><title>Preface<\/title>/g
s/\\end{preface}/<\/preface>/g
#
# Chapter "chap" 1=title
#
s/\\begin{chap}{\([^}]*\)}/<chapter xmlns="http:\/\/docbook.org\/ns\/docbook" version="5.0" xml:lang="en" xmlns:xl="http:\/\/www.w3.org\/1999\/xlink">\n<title>\1<\/title>/g
s/\\end{chap}/<\/chapter>/g



####
#
# Lists
#
####
#
# List Items "listitem"
#
s/\\begin{enumerate}/<orderedlist>/g
s/\\end{enumerate}/<\/orderedlist>/g
s/\\begin{itemize}/<itemizedlist>/g
s/\\end{itemize}/<\/itemizedlist>/g
s/\\begin{listitem}/<listitem>/g
s/\\end{listitem}/<\/listitem>/g

####
#
# Cross-References, Links
#
####
#
# Raw URL's
#   uses XML XLink specification
#   so need XLink library as xl namespace in each source file
s/\\url{\([^}]*\)}/<link xl:href="\1"><\/link>/g



