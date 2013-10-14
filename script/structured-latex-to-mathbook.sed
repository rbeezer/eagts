#
# A sed script to convert Structured LaTeX into MathBook XML
#
# Rob Beezer <beezer@ups.edu>
#
# 2013/09/27  Updates for MathBook changes
#
####
#
# Miscellaneous Sage-isms
#
####

# Sage syntax for generators, K.<x>, is invalid XML
# so replace with entity for left angle bracket
# Do this early, so it doesn't hit .< byaccident
#
s/\.</\.\&lt;/g

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
# TeX dashes
# Convert ndash, before writing comments
#
s/--/<ndash \/>/g
s/---/<mdash \/>/g
#
# Genuine comment lines, leading (multiple) %
# Carry into XML file as XML comments
#
s/^%[%]*\(.*\)$/<!-- \1 -->/g
#
# TeX left/right quotes
#
s/``/<q>/g
s/''/<\/q>/g
#
#
# Boldness
#
s/\\textbf{\([^}]*\)}/<em>\1<\/em>/g
#
# TeX, LaTeX itself
#
s/\\TeX{}/<TeX \/>/g
s/\\LaTeX{}/<LaTeX \/>/g

#
# Alignment in equation displays uses &= typically
# so replace with entity for ampersand
#
s/\&=/\&amp;=/g



####
#
# Various Code/Sage Markup
#
####
#
# Environments
#
#   No CDATA protection, hand-edit matrices w/ <![CDATA[  ]]>
#
s/\\begin{verbatim}/<sage>\n<input>/g
s/\\end{verbatim}/<\/input>\n<\/sage>/g
s/\\begin{sageblock}/<sage>\n<input>/g
s/\\end{sageblock}/<\/input>\n<\/sage>/g
s/\\begin{sageexample}/<sage>\n<input>/g
s/\\end{sageexample}/<\/input>\n<\/sage>/g
s/\\begin{center}/<sage>\n<input>/g
s/\\end{center}/<\/input>\n<\/sage>/g
#
#   inline code snippets
#
s/\\verb|\([^|]*\)|/<c>\1<\/c>/g
s/\\texttt{\([^}]*\)}/<c>\1<\/c>/g
#
#   Strip leading Sage prompts, remove after edits
s/^[\ ]*sage:\ //g
#
# Structured version
#
s/\\begin{sagecode}/<sage>/g
s/\\end{sagecode}/<\/sage>/g
# /\\begin{sageinput}/ {
#     N
#     s/\\begin{sageinput}\n/<input>/
# }
# /\\begin{sageoutput}/ {
#     N
#     s/\\begin{sageoutput}\n/<output>/
# }
s/\\begin{sageinput}/<input>/g
s/\\end{sageinput}/<\/input>/g
s/\\begin{sageoutput}/<output>/g
s/\\end{sageoutput}/<\/output>/g



####
#
# Environments
#
####
#
# Paragraph "para"
#
s/\\begin{para}/<p>/g
s/\\end{para}/<\/p>/g
#
#
# Boxed Facts "boxedfact"
# (consider caution, note, tip, warning)
#
s/\\begin{boxedfact}{\([^}]*\)}/<blockquote>\n<title>\1<\/title>/g
s/\\end{boxedfact}/<\/blockquote>/g
#
# Examples "example"
# (consider caution, note, tip, warning)
#
s/\\begin{example}/<example>/g
s/\\end{example}/<\/example>/g
#
# Section "sect" 1=title
#
s/\\begin{sect}{\([^}]*\)}/<section>\n<title>\1<\/title>/g
s/\\end{sect}/<\/section>/g
#
# Preface "preface"
#
s/\\begin{preface}/<?xml version="1.0" encoding="UTF-8" ?>\n\n<preface id="preface" filebase="preface">/g
s/\\end{preface}/<\/preface>/g
#
# Chapter "chap" 1=title, 2=basename-for-html-files
#
s/\\begin{chap}{\([^}]*\)}{\([^}]*\)}/<?xml version="1.0" encoding="UTF-8" ?>\n\n<chapter id="\2" filebase="\2">\n<title>\1<\/title>/g
s/\\end{chap}/<\/chapter>/g




####
#
# Lists
#
####
#
# List Items "listitem"
#
s/\\begin{enumerate}/<ol>/g
s/\\end{enumerate}/<\/ol>/g
s/\\begin{itemize}/<ul>/g
s/\\end{itemize}/<\/ul>/g
s/\\begin{listitem}/<li>/g
s/\\end{listitem}/<\/li>/g


####
#
# Cross-References, Links
#
####
#
# Raw URL's
#   convert to URL tag for raw external URLs
s/\\url{\([^}]*\)}/<url href="\1" \/>/g

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
#  convert to term tag, could be a knowl
s/\\textsl{\([^}]*\)}/<term>\1<\/term>/g
s/\\define{\([^}]*\)}{\([^}]*\)}/<term>\1<\/term>/g



####
#
# Math
#
####
#
# Inline math is in paired $'s
# Convert to paired \(, \)
#
s/\$\([^$]*\)\$/\\(\1\\)/g
#
# math displays are surrounded by \[, \] on lines of their own
# wrap CDATA to protect &, <, >
# ]]> in a TeX expression must be avoided 
# by using a space or a &lt; entity
#
s/^[\ ]*\\\[$/<me>/g
s/^[\ ]*\\\]$/<\/me>/g
#
# Pass through align* and equation environments, 
# but protect contents with CDATA
# Also arrays, but allow variable column specifications
#
s/\\begin{align\*}/<md>/g
s/\\end{align\*}/<\/md>/g
s/\\begin{equation}/<me>/g
s/\\end{equation}/<\/me>/g
s/\\begin{array}{\([^}]*\)}/<md>\1/g
s/\\end{array}/<\/md>/g

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


