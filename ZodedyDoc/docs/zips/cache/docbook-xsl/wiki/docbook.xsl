<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="db ng exsl exslt"
                version='1.0'>
                
<xsl:import href="../html/docbook.xsl"/>
<xsl:include href="block.xsl"/>
<xsl:include href="sections.xsl"/>
<xsl:include href="lists.xsl"/>
<xsl:include href="component.xsl"/>
<xsl:include href="formal.xsl"/>
<xsl:include href="inline.xsl"/>
<xsl:include href="xref.xsl"/>
<xsl:include href="graphics.xsl"/>
<xsl:include href="verbatim.xsl"/>

<!-- Note this is specific to Eclipsepedia and Fedora -->
<xsl:include href="admon.xsl"/>

<xsl:output method="text" encoding="UTF-8"/>

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="programlisting screenshot"/>

<!-- ********************************************************************
     $Id: docbook.xsl,v 1.3 2008/08/01 01:04:29 dcarver Exp $
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://docbook.sf.net/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->


<xsl:param name="stylesheet.result.type" select="'html'"/>
<xsl:param name="htmlhelp.output" select="0"/>
<xsl:param name="generate.toc"/>


<!-- ==================================================================== -->

<xsl:key name="id" match="*" use="@id|@xml:id"/>
<xsl:key name="gid" match="*" use="generate-id()"/>

<!-- ==================================================================== -->

<xsl:template match="*">
  <xsl:message>
    <xsl:text>Element </xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text> in namespace '</xsl:text>
    <xsl:value-of select="namespace-uri(.)"/>
    <xsl:text>' encountered</xsl:text>
    <xsl:if test="parent::*">
      <xsl:text> in </xsl:text>
      <xsl:value-of select="name(parent::*)"/>
    </xsl:if>
    <xsl:text>, but no template matches.</xsl:text>
  </xsl:message>

  <span style="color: red">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="name(.)"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&lt;/</xsl:text>
    <xsl:value-of select="name(.)"/>
    <xsl:text>&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="para/text()">
  <xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template name="body.attributes"/>

<xsl:template name="head.content"/>

<xsl:template name="output.html.stylesheets"/>

<!-- ============================================================ -->

<xsl:template match="*" mode="head.keywords.content"/>

<!-- ============================================================ -->

<xsl:template name="system.head.content"/>

<!-- ============================================================ -->

<xsl:template name="user.preroot">
  <!-- Pre-root output, can be used to output comments and PIs. -->
  <!-- This must not output any element content! -->
</xsl:template>

<xsl:template name="user.head.content">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template name="user.header.navigation">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template name="user.header.content">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template name="user.footer.content">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template name="user.footer.navigation">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template match="*" mode="process.root">
  <xsl:variable name="doc" select="self::*"/>
  <xsl:call-template name="user.preroot"/>
  <xsl:call-template name="root.messages"/>
   <xsl:call-template name="system.head.content">
     <xsl:with-param name="node" select="$doc"/>
   </xsl:call-template>
   <xsl:call-template name="head.content">
     <xsl:with-param name="node" select="$doc"/>
   </xsl:call-template>
   <xsl:call-template name="user.head.content">
     <xsl:with-param name="node" select="$doc"/>
   </xsl:call-template>
   <xsl:call-template name="body.attributes"/>
   <xsl:call-template name="user.header.content">
     <xsl:with-param name="node" select="$doc"/>
   </xsl:call-template>
   <xsl:apply-templates select="."/>
   <xsl:call-template name="user.footer.content">
     <xsl:with-param name="node" select="$doc"/>
   </xsl:call-template>
  <xsl:value-of select="$html.append"/>
</xsl:template>

<xsl:template name="root.messages">
  <!-- redefine this any way you'd like to output messages -->
  <!-- DO NOT OUTPUT ANYTHING FROM THIS TEMPLATE -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="chunk">
  <xsl:param name="node" select="."/>
  <!-- The default is that we are not chunking... -->
  <xsl:text>0</xsl:text>
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
