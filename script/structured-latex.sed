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
# Throwaway lines, single leading %, nothing else
#
s/^%$//g
#
# Genuine comment lines, leading (multiple) %
# Carry into XML file as XML comments
#
s/^%[%]*\(.*\)$/<!-- \1 -->/g
#
# TeX left/right quotes
#
s/``/"/g
s/''/"/g
#
# Boldness
#
s/\\textbf{\([^}]*\)}/<db:emphasis role="bold">\1<\/db:emphasis>/g
#
# TeX, LaTeX itself
#
s/\\TeX{}/TeX/g
s/\\LaTeX{}/LaTeX/g


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
s/\\verb|\([^|]*\)|/<db:code>\1<\/db:code>/g
s/\\texttt{\([^}]*\)}/<db:code>\1<\/db:code>/g
#
#   Strip leading Sage prompts, remove after edits
s/^[\ ]*sage:\ //g
#
# Structured version
#
s/\\begin{sagecode}/<sagecode>/g
s/\\end{sagecode}/<\/sagecode>/g
/\\begin{sageinput}/ {
    N
    s/\\begin{sageinput}\n/<sageinput><![CDATA[/
}
/\\begin{sageoutput}/ {
    N
    s/\\begin{sageoutput}\n/<sageoutput><![CDATA[/
}
s/\\end{sageinput}/]]><\/sageinput>/g
s/\\end{sageoutput}/]]><\/sageoutput>/g



####
#
# Environments
#
####
#
# Paragraph "para"
#
s/\\begin{para}/<db:para>/g
s/\\end{para}/<\/db:para>/g
#
#
# Boxed Facts "boxedfact"
# (consider caution, note, tip, warning)
#
s/\\begin{boxedfact}{\([^}]*\)}/<db:blockquote>\n<db:title>\1<\/db:title>/g
s/\\end{boxedfact}/<\/db:important>/g
#
# Examples "example"
# (consider caution, note, tip, warning)
#
s/\\begin{example}/<db:example>/g
s/\\end{example}/<\/db:example>/g
#
# Section "sect" 1=title
#
s/\\begin{sect}{\([^}]*\)}/<db:sect1>\n<db:title>\1<\/db:title>/g
s/\\end{sect}/<\/db:sect1>/g
#
# Preface "preface"
#
s/\\begin{preface}/<preface xmlns:db="http:\/\/docbook.org\/ns\/docbook" version="5.0" xml:lang="en" xmlns:xl="http:\/\/www.w3.org\/1999\/xlink"><title>Preface<\/title>/g
s/\\end{preface}/<\/preface>/g
#
# Chapter "chap" 1=title
#
s/\\begin{chap}{\([^}]*\)}/<?xml version="1.0" encoding="UTF-8" ?>\n\n<db:chapter xmlns=""\n xmlns:db="http:\/\/docbook.org\/ns\/docbook" version="5.0" xml:lang="en"\nxmlns:xl="http:\/\/www.w3.org\/1999\/xlink">\n<db:title>\1<\/db:title>/g
s/\\end{chap}/<\/db:chapter>/g




####
#
# Lists
#
####
#
# List Items "listitem"
#
s/\\begin{enumerate}/<db:orderedlist>/g
s/\\end{enumerate}/<\/db:orderedlist>/g
s/\\begin{itemize}/<db:itemizedlist>/g
s/\\end{itemize}/<\/db:itemizedlist>/g
s/\\begin{listitem}/<db:listitem>/g
s/\\end{listitem}/<\/db:listitem>/g


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

####
#
# Images
#
####
#
# \includegraphics, minimal version, ignores optional arguments
#   
s/\\includegraphics{\([^}]*\)}/<db:mediaobject>\n<db:imageobject condition="web"><db:imagedata fileref="\1" format="PNG" scale="80"\/>\n<\/db:imageobject>\n<db:caption><\/db:caption>\n<\/db:mediaobject>/g

####
#
# Definitions, Knowls
#
####
#
# \textsl assumed as definition
# (write a proper definition/knowl macro for TeX)
#  convert to a knowl with generic content
s/\\textsl{\([^}]*\)}/<knowl src="replaceMe.html">\1<\/knowl>/g



####
#
# Math
#
####
#
# math displays are surrounded by \[, \] on lines of their own
# wrap CDATA to protect &, <, >
# ]]> in a TeX expression must be avoided 
# by using a space or a &lt; entity
#
s/^[\ ]*\\\[$/<db:displaymath><![CDATA[/g
s/^[\ ]*\\\]$/]]><\/db:displaymath>/g
#
# Pass through align* and equation environments, 
# but protect contents with CDATA
# Also arrays, but allow variable column specifications
#
s/\\begin{align\*}/\\begin{align*}<![CDATA[/g
s/\\end{align\*}/]]>\\end{align*}/g
s/\\begin{equation}/\\begin{equation}<![CDATA[/g
s/\\end{equation}/]]>\\end{equation}/g
s/\\begin{array}{\([^}]*\)}/\\begin{array}{\1}<![CDATA[/g
s/\\end{array}/]]>\\end{array}/g

####
#
# Theorems/Proofs
#
####
#
s/\\begin{lemma}/<lemma>/g
s/\\end{lemma}/<\/lemma>/g
s/\\begin{statement}/<statement>/g
s/\\end{statement}/<\/statement>/g
s/\\begin{proof}/<proof>/g
s/\\end{proof}/<\/proof>/g

####
#
# Definitions and Knowls
#
####
#
s/\\define{\([^}]*\)}{\([^}]*\)}/<knowl src="\2.html">\1<\/knowl>/g
