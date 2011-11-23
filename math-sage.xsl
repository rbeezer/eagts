<?xml version='1.0'?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">



<!-- Need to specify the path to the docbook.xsl file. Use an absolute or
     relative path name. -->
<xsl:import href="/home/rob/xsl/docbook-xsl/html/chunk.xsl"/>

<xsl:output
   method="xml"
   doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
   doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
   omit-xml-declaration="yes"
   encoding="UTF-8"
   indent="yes" />

<!-- This template element contains the script tags and content that will
     be inserted into the <head> section so that MathJax will work. -->
<xsl:template name="user.head.content">
<!-- This is a MathJax configuration expression. It modifies the
     default MathJax inline delimiters. An alternative is to place
     all MathJax configuration content in a file and use an ENTITY
     reference instead of the literal configuration content as shown below.
     -->
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
        tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]},
        TeX: {
            Macros: {
            rats:  '{\\mathbb{Q}}',
            ints:  '{\\mathbb{Z}}',
            sbs:   '{\\subseteq}',
            aut:  ['{\\mathrm{Aut}(#1)}',1],
            diff:  '{\\setminus}',
            comp: ['{\\overline{#1}}',1],
            pmat: ['{\\pmatrix{#1}}',1],
            seq:  ['{#1_{#2},\\ldots,#1_{#3}}',3],
            sym:  ['{\\DeclareMathOperator{\\Sym}{Sym}\\Sym(#1)}',1],
            al:    '{\\alpha}',
            be:    '{\\beta}',
            de:   ['{\\delta}',0],
            eps:   '{\\epsilon}',
            De:    '{\\Delta}',
            la:    '{\\lambda}',
            th:    '{\\theta}',
            cF:    '{\\mathcal{F}}',
<!--            Re: '{\\mathbb{R}}',
            fld: '{\\mathbb{F}}',
            cok: '{\\mathcal{O}_K}',
            zth: '\\ints[\\theta]',
            sx: '\\mathrm{Sym}(6)',-->
            },
        extensions: ["AMSmath.js", "AMSsymbols.js"]
        },
    });
</script>
<!-- This is the URL to the MathJax Javascript package. In this case the CDN
     site is being used over an Internet connection. This can be modified
     as required if MathJax is installed on the local computer or local
     network or other server. NOTE: Using an ENTITY reference to a file
     with this URL as content won't work. An ENTITY reference as part
     of the value of an attribute (e.g., src="&mathjaxurl;" here is bad XML.
     -->
<script type="text/javascript"
     src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"/>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> 
<link href="http://aimath.org/knowlstyle.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="http://aimath.org/knowl.js"></script>

<!-- <link rel="stylesheet" href="./docbook-free-bsd.css" type="text/css"/> -->

</xsl:template>


<xsl:template match="knowl">
<xsl:element name="a">
<xsl:attribute name="knowl">
<xsl:value-of select="./@src" />
</xsl:attribute>
<xsl:value-of select="." />
</xsl:element>
</xsl:template>


<xsl:template match="lemma">
<strong>Lemma</strong><xsl:apply-templates />
</xsl:template>


<xsl:template match="statement">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="proof">
<strong>Proof</strong><xsl:apply-templates />$\blacksquare$
</xsl:template>



<xsl:template match="displaymath">
\[<xsl:value-of select="." />\]
</xsl:template>




<xsl:template match="sage|sagecode">
<xsl:apply-templates />
</xsl:template>


<!--Copied out of verbatim.xml from DocBook distribution
where it was used for "programlisting"
Will convert CDATA-wrapped Sage code to stuff with entitites-->

<!--input in match can go away once reworked totally-->

<xsl:template match="input|sageinput|sageoutput">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:call-template name="anchor"/>

  <xsl:variable name="div.element">
    <xsl:choose>
      <xsl:when test="$make.clean.html != 0">div</xsl:when>
      <xsl:otherwise>pre</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$shade.verbatim != 0">
    <xsl:message>
      <xsl:text>The shade.verbatim parameter is deprecated. </xsl:text>
      <xsl:text>Use CSS instead,</xsl:text>
    </xsl:message>
    <xsl:message>
      <xsl:text>for example: pre.</xsl:text>
      <xsl:value-of select="local-name(.)"/>
      <xsl:text> { background-color: #E0E0E0; }</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'
                    and $use.extensions != '0'
                    and $linenumbering.extension != '0'">
      <xsl:variable name="rtf">
        <xsl:choose>
          <xsl:when test="$highlight.source != 0">
            <xsl:call-template name="apply-highlighting"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:element name="{$div.element}">
        <xsl:apply-templates select="." mode="common.html.attributes"/>
        <xsl:if test="@width != ''">
          <xsl:attribute name="width">
            <xsl:value-of select="@width"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf" select="$rtf"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:when>
    <xsl:otherwise>
      <xsl:element name="{$div.element}">
        <xsl:apply-templates select="." mode="common.html.attributes"/>
        <xsl:if test="@width != ''">
          <xsl:attribute name="width">
            <xsl:value-of select="@width"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$highlight.source != 0">
            <xsl:call-template name="apply-highlighting"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>



