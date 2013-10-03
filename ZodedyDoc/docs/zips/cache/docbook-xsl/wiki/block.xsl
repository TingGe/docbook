<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id: block.xsl,v 1.2 2008/08/01 01:04:32 dcarver Exp $
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://docbook.sf.net/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->
<!-- What should we do about styling blockinfo? -->

<xsl:template match="blockinfo|info">
  <!-- suppress -->
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="block.object">
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="para">
  <xsl:call-template name="paragraph">
    <xsl:with-param name="class">
      <xsl:if test="@role and $para.propagates.style != 0">
        <xsl:value-of select="@role"/>
      </xsl:if>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:if test="position() = 1 and parent::listitem">
        <xsl:call-template name="anchor">
          <xsl:with-param name="node" select="parent::listitem"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="paragraph">
  <xsl:param name="class" select="''"/>
  <xsl:param name="content"/>

  <xsl:variable name="p">
      <xsl:call-template name="dir"/>
      <xsl:copy-of select="$content"/>
    <xsl:text>

</xsl:text>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$html.cleanup != 0">
      <xsl:call-template name="unwrap.p">
        <xsl:with-param name="p" select="$p"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$p"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="simpara">
  <!-- see also listitem/simpara in lists.xsl -->
  
    <xsl:if test="@role and $para.propagates.style != 0">
      <xsl:apply-templates select="." mode="class.attribute">
        <xsl:with-param name="class" select="@role"/>
      </xsl:apply-templates>
    </xsl:if>

    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
    <xsl:text>
    
</xsl:text>
    
</xsl:template>

<xsl:template match="formalpara">
  <xsl:call-template name="paragraph">
    <xsl:with-param name="class">
      <xsl:if test="@role and $para.propagates.style != 0">
        <xsl:value-of select="@role"/>
      </xsl:if>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- Only use title from info -->
<xsl:template match="formalpara/info">
  <xsl:apply-templates select="title"/>
</xsl:template>

<xsl:template match="formalpara/title|formalpara/info/title">
  <xsl:variable name="titleStr">
      <xsl:apply-templates/>
  </xsl:variable>
  <xsl:variable name="lastChar">
    <xsl:if test="$titleStr != ''">
      <xsl:value-of select="substring($titleStr,string-length($titleStr),1)"/>
    </xsl:if>
  </xsl:variable>
  
  <xsl:text>'''</xsl:text>
    <xsl:copy-of select="$titleStr"/>
    <xsl:if test="$lastChar != ''
                  and not(contains($runinhead.title.end.punct, $lastChar))">
      <xsl:value-of select="$runinhead.default.title.end.punct"/>
    </xsl:if>
  <xsl:text>'''
</xsl:text>
</xsl:template>

<xsl:template match="formalpara/para">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="blockquote">
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:if test="@lang or @xml:lang">
      <xsl:call-template name="language.attribute"/>
    </xsl:if>
    <xsl:call-template name="anchor"/>

    <xsl:choose>
      <xsl:when test="attribution">
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&lt;blockquote></xsl:text>
          <xsl:apply-templates select="." mode="class.attribute"/>
          <xsl:apply-templates/>
        <xsl:text>&lt;/blockquote>

</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="blockquote/title|blockquote/info/title">
     <xsl:text>'''</xsl:text>
        <xsl:apply-templates/>
     <xsl:text>'''</xsl:text>
</xsl:template>

<xsl:template match="epigraph">
    <xsl:apply-templates select="." mode="class.attribute"/>
      <xsl:apply-templates select="para|simpara|formalpara|literallayout"/>
</xsl:template>

<xsl:template match="attribution">
    <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="abstract|sidebar">
    <xsl:call-template name="anchor"/>
    <xsl:call-template name="formal.object.heading">
      <xsl:with-param name="title">
        <xsl:apply-templates select="." mode="title.markup">
          <xsl:with-param name="allow-anchors" select="'1'"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="abstract/title|sidebar/title">
</xsl:template>

<xsl:template match="sidebar/sidebarinfo|sidebar/info"/>

<!-- ==================================================================== -->

<xsl:template match="msgset">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgentry">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="simplemsgentry">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msg">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msgmain">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgmain/title">
  <xsl:text>'''</xsl:text><xsl:apply-templates/><xsl:text>'''</xsl:text>
</xsl:template>

<xsl:template match="msgsub">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgsub/title">
  <xsl:text>'''</xsl:text><xsl:apply-templates/><xsl:text>'''</xsl:text>
</xsl:template>

<xsl:template match="msgrel">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgrel/title">
  <xsl:text>'''</xsl:text><xsl:apply-templates/><xsl:text>'''</xsl:text>
</xsl:template>

<xsl:template match="msgtext">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msginfo">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msglevel">
    <xsl:text>
'''</xsl:text>
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgLevel'"/>
      </xsl:call-template>
    <xsl:text>'''</xsl:text>
    <xsl:apply-templates/>
<xsl:text>

</xsl:text>
</xsl:template>

<xsl:template match="msgorig">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgOrig'"/>
      </xsl:call-template>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgaud">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'msgset'"/>
        <xsl:with-param name="name" select="'MsgAud'"/>
      </xsl:call-template>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="msgexplan">
  <xsl:call-template name="block.object"/>
</xsl:template>

<xsl:template match="msgexplan/title">
  <xsl:apply-templates/>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="revhistory">
    <xsl:apply-templates select="." mode="class.attribute"/>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
      <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revhistory/revision">
</xsl:template>

<xsl:template match="revision/revnumber">
</xsl:template>

<xsl:template match="revision/date">
</xsl:template>

<xsl:template match="revision/authorinitials">
</xsl:template>

<xsl:template match="revision/authorinitials[1]" priority="2">
</xsl:template>

<xsl:template match="revision/revremark">
</xsl:template>

<xsl:template match="revision/revdescription">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="ackno">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="highlights">
</xsl:template>

<!-- ==================================================================== -->

</xsl:stylesheet>
