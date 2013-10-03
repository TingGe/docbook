<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id: admon.xsl,v 1.2 2008/08/01 01:04:29 dcarver Exp $
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://docbook.sf.net/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->
     
<xsl:template match="*" mode="admon.graphic.width">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template match="note|important|warning|caution|tip">
  <xsl:choose>
    <xsl:when test="$admon.graphics != 0">
      <xsl:call-template name="graphical.admonition"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="nongraphical.admonition"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="admon.graphic">
</xsl:template>

<xsl:template name="graphical.admonition">
  <xsl:variable name="admon.type">
    <xsl:choose>
      <xsl:when test="local-name(.)='note'">note</xsl:when>
      <xsl:when test="local-name(.)='warning'">warning</xsl:when>
      <xsl:when test="local-name(.)='caution'">caution</xsl:when>
      <xsl:when test="local-name(.)='tip'">tip</xsl:when>
      <xsl:when test="local-name(.)='important'">important</xsl:when>
      <xsl:otherwise>note</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="alt">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="$admon.type"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:text>{{</xsl:text>
  <xsl:value-of select="$admon.type"/>
  <xsl:text> |</xsl:text>
  <xsl:if test="title|info/title">
       <xsl:value-of select="(title|info/title)[1]"/>
  </xsl:if>
  <xsl:text> |</xsl:text> 
  <xsl:apply-templates/>
  <xsl:text>}}
  
</xsl:text>

</xsl:template>

<xsl:template name="nongraphical.admonition">
   <xsl:call-template name="graphical.admonition"/>
</xsl:template>

<xsl:template match="note/title"></xsl:template>
<xsl:template match="important/title"></xsl:template>
<xsl:template match="warning/title"></xsl:template>
<xsl:template match="caution/title"></xsl:template>
<xsl:template match="tip/title"></xsl:template>

</xsl:stylesheet>
