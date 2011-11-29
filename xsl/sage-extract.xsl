<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:db="http://docbook.org/ns/docbook" db:version="5.0" xml:lang="en"
xmlns="">


<xsl:output method="text"/>


<xsl:template match="/">
<xsl:text>r"""
</xsl:text>
<xsl:apply-templates select="/db:chapter/db:sect1/sagecode" />
<xsl:text>"""
</xsl:text>
</xsl:template>


<xsl:template match="sagecode">
<xsl:text>
::

</xsl:text>
<xsl:apply-templates select="./sageinput" />
<xsl:apply-templates select="./sageoutput" />
<xsl:text>
</xsl:text>
</xsl:template>


<xsl:template match="sageinput">
<xsl:call-template name="prependPrompt" />
</xsl:template>


<xsl:template match="sageoutput">
<xsl:call-template name="prependTab" />
</xsl:template>


<xsl:template name="prependPrompt">
  <xsl:param name="pText" select="."/>

  <xsl:if test="string-length($pText)">
   <xsl:choose>
     <xsl:when test="substring($pText,1,1)=' '">
     <xsl:text>    ...   </xsl:text>
     </xsl:when>
     <xsl:otherwise>
     <xsl:text>    sage: </xsl:text>
     </xsl:otherwise>
   </xsl:choose> 
<!--   <if test="substring($pText,1,1)=' '">
     <text>    sage: </text>
   </if>-->
   <xsl:value-of select="substring-before($pText, '&#xA;')"/>
   <xsl:text>&#xA;</xsl:text>

   <xsl:call-template name="prependPrompt">
    <xsl:with-param name="pText"
      select="substring-after($pText, '&#xA;')"/>
   </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="prependTab">
  <xsl:param name="pText" select="."/>

  <xsl:if test="string-length($pText)">
   <xsl:text>    </xsl:text>
   <xsl:value-of select="substring-before($pText, '&#xA;')"/>
   <xsl:text>&#xA;</xsl:text>

   <xsl:call-template name="prependTab">
    <xsl:with-param name="pText"
      select="substring-after($pText, '&#xA;')"/>
   </xsl:call-template>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>