<?xml version="1.0"?>

<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform">

<output method="text"/>

<template match="/">
<text>r"""
</text>
<apply-templates select="/chapter/sect1/sagecode" />
<text>"""
</text>
</template>



<!--<template name="gonzo">
<text>blatzo</text>
</template>-->

<!--<template match="chapter">
OMG
<text>chappo</text>
</template>-->

<!--<template match="sagecode">
<text>blatzo</text>
</template>-->


<template match="sagecode">
<text>
::

</text>
<apply-templates select="./sageinput" />
<apply-templates select="./sageoutput" />
<text>
</text>
</template>

<template match="sageinput">
<call-template name="prependPrompt" />
</template>

<template match="sageoutput">
<call-template name="prependTab" />
</template>


<template name="prependPrompt">
  <param name="pText" select="."/>

  <if test="string-length($pText)">
   <choose>
     <when test="substring($pText,1,1)=' '">
     <text>    ...   </text>
     </when>
     <otherwise>
     <text>    sage: </text>
     </otherwise>
   </choose>
  
  
<!--   <if test="substring($pText,1,1)=' '">
     <text>    sage: </text>
   </if>-->
   <value-of select="substring-before($pText, '&#xA;')"/>
   <text>&#xA;</text>

   <call-template name="prependPrompt">
    <with-param name="pText"
      select="substring-after($pText, '&#xA;')"/>
   </call-template>
  </if>
</template>

<template name="prependTab">
  <param name="pText" select="."/>

  <if test="string-length($pText)">
   <text>    </text>
   <value-of select="substring-before($pText, '&#xA;')"/>
   <text>&#xA;</text>

   <call-template name="prependTab">
    <with-param name="pText"
      select="substring-after($pText, '&#xA;')"/>
   </call-template>
  </if>
</template>



</stylesheet>