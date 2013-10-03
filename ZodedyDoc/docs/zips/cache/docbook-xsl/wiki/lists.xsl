<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id: lists.xsl,v 1.2 2008/08/01 01:04:41 dcarver Exp $
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://docbook.sf.net/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template match="itemizedlist">
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:if test="title">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>
    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates 
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>
      <xsl:if test="$css.decoration != 0">
        <xsl:attribute name="type">
          <xsl:call-template name="list.itemsymbol"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@spacing='compact'">
        <xsl:attribute name="compact">
          <xsl:value-of select="@spacing"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates 
            select="listitem
                    |comment()[preceding-sibling::listitem]
                    |processing-instruction()[preceding-sibling::listitem]"/>
</xsl:template>

<xsl:template match="itemizedlist/title">
  <!-- nop -->
</xsl:template>

<xsl:template match="itemizedlist/listitem">
  <xsl:variable name="mark" select="../@mark"/>
  <xsl:variable name="override" select="@override"/>

  <xsl:variable name="usemark">
    <xsl:choose>
      <xsl:when test="$override != ''">
        <xsl:value-of select="$override"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$mark"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="cssmark">
    <xsl:choose>
      <xsl:when test="$usemark = 'opencircle'">circle</xsl:when>
      <xsl:when test="$usemark = 'bullet'">disc</xsl:when>
      <xsl:when test="$usemark = 'box'">square</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$usemark"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:text>* </xsl:text>

  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="orderedlist">
  <xsl:variable name="start">
    <xsl:call-template name="orderedlist-starting-number"/>
  </xsl:variable>

  <xsl:variable name="numeration">
    <xsl:call-template name="list.numeration"/>
  </xsl:variable>

  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="$numeration='arabic'">1</xsl:when>
      <xsl:when test="$numeration='loweralpha'">a</xsl:when>
      <xsl:when test="$numeration='lowerroman'">i</xsl:when>
      <xsl:when test="$numeration='upperalpha'">A</xsl:when>
      <xsl:when test="$numeration='upperroman'">I</xsl:when>
      <!-- What!? This should never happen -->
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Unexpected numeration: </xsl:text>
          <xsl:value-of select="$numeration"/>
        </xsl:message>
        <xsl:value-of select="1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>

    <xsl:if test="title">
      <xsl:call-template name="formal.object.heading"/>
      <xsl:text>
</xsl:text>
    </xsl:if>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates 
        select="*[not(self::listitem
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::listitem)]
                |processing-instruction()[not(preceding-sibling::listitem)]"/>

      	  <xsl:apply-templates 
      		select="listitem
      			|comment()[preceding-sibling::listitem]
      			|processing-instruction()[preceding-sibling::listitem]"/>
</xsl:template>

<xsl:template match="orderedlist/title">
  <!-- nop -->
</xsl:template>

<xsl:template match="orderedlist/listitem">
  <xsl:text># </xsl:text>
    <xsl:if test="@override">
      <xsl:attribute name="value">
        <xsl:value-of select="@override"/>
      </xsl:attribute>
    </xsl:if>

    <!-- we can't just drop the anchor in since some browsers (Opera)
         get confused about line breaks if we do. So if the first child
         is a para, assume the para will put in the anchor. Otherwise,
         put the anchor in anyway. -->
    <xsl:if test="local-name(child::*[1]) != 'para'">
      <xsl:call-template name="anchor"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$show.revisionflag != 0 and @revisionflag">
          <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="orderedlist/listitem" mode="orderedlist-table">
      <xsl:apply-templates select="." mode="item-number"/>
      <xsl:if test="local-name(child::*[1]) != 'para'">
	<xsl:call-template name="anchor"/>
      </xsl:if>

      <xsl:choose>
	<xsl:when test="$show.revisionflag != 0 and @revisionflag">
	    <xsl:apply-templates/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:apply-templates/>
	</xsl:otherwise>
      </xsl:choose>
</xsl:template>

<xsl:template match="variablelist">
  <xsl:variable name="pi-presentation">
    <xsl:call-template name="pi.dbhtml_list-presentation"/>
  </xsl:variable>

  <xsl:variable name="presentation">
    <xsl:choose>
      <xsl:when test="$pi-presentation != ''">
        <xsl:value-of select="$pi-presentation"/>
      </xsl:when>
      <xsl:when test="$variablelist.as.table != 0">
        <xsl:value-of select="'table'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'list'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="list-width">
    <xsl:call-template name="pi.dbhtml_list-width"/>
  </xsl:variable>

  <xsl:variable name="term-width">
    <xsl:call-template name="pi.dbhtml_term-width"/>
  </xsl:variable>

  <xsl:variable name="table-summary">
    <xsl:call-template name="pi.dbhtml_table-summary"/>
  </xsl:variable>

    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:if test="title">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$presentation = 'table'">
        <!-- Preserve order of PIs and comments -->
        <xsl:apply-templates 
          select="*[not(self::varlistentry
                    or self::title
                    or self::titleabbrev)]
                  |comment()[not(preceding-sibling::varlistentry)]
                  |processing-instruction()[not(preceding-sibling::varlistentry)]"/>
          <xsl:if test="$list-width != ''">
            <xsl:attribute name="width">
              <xsl:value-of select="$list-width"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="$table-summary != ''">
            <xsl:attribute name="summary">
              <xsl:value-of select="$table-summary"/>
            </xsl:attribute>
          </xsl:if>
            <xsl:if test="$term-width != ''">
              <xsl:attribute name="width">
                <xsl:value-of select="$term-width"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates mode="varlist-table"
              select="varlistentry
                      |comment()[preceding-sibling::varlistentry]
                      |processing-instruction()[preceding-sibling::varlistentry]"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Preserve order of PIs and comments -->
        <xsl:apply-templates 
          select="*[not(self::varlistentry
                    or self::title
                    or self::titleabbrev)]
                  |comment()[not(preceding-sibling::varlistentry)]
                  |processing-instruction()[not(preceding-sibling::varlistentry)]"/>
          <xsl:apply-templates 
              select="varlistentry
                      |comment()[preceding-sibling::varlistentry]
                      |processing-instruction()[preceding-sibling::varlistentry]"/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="variablelist/title">
  <!-- nop -->
</xsl:template>

<xsl:template match="itemizedlist/titleabbrev|orderedlist/titleabbrev">
  <!--nop-->
</xsl:template>

<xsl:template match="variablelist/titleabbrev">
  <!--nop-->
</xsl:template>

<xsl:template match="listitem" mode="xref">
  <xsl:number format="1"/>
</xsl:template>

<xsl:template match="listitem/simpara" priority="2">
  <!-- If a listitem contains only a single simpara, don't output
       the <p> wrapper; this has the effect of creating an li
       with simple text content. -->
  <xsl:choose>
    <xsl:when test="not(preceding-sibling::*)
                    and not (following-sibling::*)">
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>

</xsl:text>
        <xsl:if test="@role and $para.propagates.style != 0">
           <xsl:apply-templates select="." mode="class.attribute">
             <xsl:with-param name="class" select="@role"/>
           </xsl:apply-templates>
        </xsl:if>

        <xsl:call-template name="anchor"/>
        <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="varlistentry">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates select="term"/>
    <xsl:apply-templates select="listitem"/>
</xsl:template>

<xsl:template match="varlistentry" mode="varlist-table">
  <xsl:variable name="presentation">
    <xsl:call-template name="pi.dbhtml_term-presentation">
      <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="separator">
    <xsl:call-template name="pi.dbhtml_term-separator">
      <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
  </xsl:variable>
    <xsl:call-template name="tr.attributes">
      <xsl:with-param name="rownum">
        <xsl:number from="variablelist" count="varlistentry"/>
      </xsl:with-param>
    </xsl:call-template>
      <xsl:call-template name="anchor"/>
      <xsl:choose>
        <xsl:when test="$presentation = 'bold'">
            <xsl:apply-templates select="term"/>
            <xsl:value-of select="$separator"/>
        </xsl:when>
        <xsl:when test="$presentation = 'italic'">
            <xsl:apply-templates select="term"/>
            <xsl:value-of select="$separator"/>
        </xsl:when>
        <xsl:when test="$presentation = 'bold-italic'">
              <xsl:apply-templates select="term"/>
              <xsl:value-of select="$separator"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="term"/>
          <xsl:value-of select="$separator"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="listitem"/>
</xsl:template>

<xsl:template match="varlistentry/term">
    <xsl:call-template name="anchor"/>
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="position() = last()"/> <!-- do nothing -->
      <xsl:otherwise>
        <!-- * if we have multiple terms in the same varlistentry, generate -->
        <!-- * a separator (", " by default) and/or an additional line -->
        <!-- * break after each one except the last -->
        <xsl:value-of select="$variablelist.term.separator"/>
        <xsl:if test="not($variablelist.term.break.after = '0')">
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="varlistentry/listitem">
  <!-- we can't just drop the anchor in since some browsers (Opera)
       get confused about line breaks if we do. So if the first child
       is a para, assume the para will put in the anchor. Otherwise,
       put the anchor in anyway. -->
  <xsl:if test="local-name(child::*[1]) != 'para'">
    <xsl:call-template name="anchor"/>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="$show.revisionflag != 0 and @revisionflag">
        <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="simplelist">
  <!-- with no type specified, the default is 'vert' -->
  <xsl:call-template name="anchor"/>
    <xsl:call-template name="simplelist.vert">
      <xsl:with-param name="cols">
        <xsl:choose>
          <xsl:when test="@columns">
            <xsl:value-of select="@columns"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template match="simplelist[@type='inline']">
    <xsl:apply-templates select="." mode="class.attribute"/>
  <!-- if dbchoice PI exists, use that to determine the choice separator -->
  <!-- (that is, equivalent of "and" or "or" in current locale), or literal -->
  <!-- value of "choice" otherwise -->
  <xsl:variable name="localized-choice-separator">
    <xsl:choose>
      <xsl:when test="processing-instruction('dbchoice')">
        <xsl:call-template name="select.choice.separator"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- empty -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:for-each select="member">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="position() = last()"/> <!-- do nothing -->
      <xsl:otherwise>
	<xsl:text>, </xsl:text>
	<xsl:if test="position() = last() - 1">
	  <xsl:if test="$localized-choice-separator != ''">
	    <xsl:value-of select="$localized-choice-separator"/>
	    <xsl:text> </xsl:text>
	  </xsl:if>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>

<xsl:template match="simplelist[@type='horiz']">
  <xsl:call-template name="anchor"/>
    <xsl:call-template name="simplelist.horiz">
      <xsl:with-param name="cols">
        <xsl:choose>
          <xsl:when test="@columns">
            <xsl:value-of select="@columns"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template match="simplelist[@type='vert']">
  <xsl:call-template name="anchor"/>
    <xsl:call-template name="simplelist.vert">
      <xsl:with-param name="cols">
        <xsl:choose>
          <xsl:when test="@columns">
            <xsl:value-of select="@columns"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template name="simplelist.horiz">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>

</xsl:template>

<xsl:template name="simplelist.horiz.row">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="curcol">1</xsl:param>

</xsl:template>

<xsl:template name="simplelist.vert">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="rows"
             select="floor((count($members)+$cols - 1) div $cols)"/>

</xsl:template>

<xsl:template name="simplelist.vert.row">
  <xsl:param name="cols">1</xsl:param>
  <xsl:param name="rows">1</xsl:param>
  <xsl:param name="cell">1</xsl:param>
  <xsl:param name="members" select="./member"/>
  <xsl:param name="curcol">1</xsl:param>

</xsl:template>

<xsl:template match="member">
  <xsl:call-template name="anchor"/>
  <xsl:call-template name="simple.xlink">
    <xsl:with-param name="content">
      <xsl:apply-templates/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="procedure">
  <xsl:variable name="param.placement"
                select="substring-after(normalize-space($formal.title.placement),
                                        concat(local-name(.), ' '))"/>

  <xsl:variable name="placement">
    <xsl:choose>
      <xsl:when test="contains($param.placement, ' ')">
        <xsl:value-of select="substring-before($param.placement, ' ')"/>
      </xsl:when>
      <xsl:when test="$param.placement = ''">before</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param.placement"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Preserve order of PIs and comments -->
  <xsl:variable name="preamble"
        select="*[not(self::step
                  or self::title
                  or self::titleabbrev)]
                |comment()[not(preceding-sibling::step)]
                |processing-instruction()[not(preceding-sibling::step)]"/>

    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor">
      <xsl:with-param name="conditional">
        <xsl:choose>
	  <xsl:when test="title">0</xsl:when>
	  <xsl:otherwise>1</xsl:otherwise>
	</xsl:choose>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:if test="title and $placement = 'before'">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>

    <xsl:apply-templates select="$preamble"/>

    <xsl:choose>
      <xsl:when test="count(step) = 1">
          <xsl:apply-templates 
            select="step
                    |comment()[preceding-sibling::step]
                    |processing-instruction()[preceding-sibling::step]"/>
      </xsl:when>
      <xsl:otherwise>
          <xsl:attribute name="type">
            <xsl:value-of select="substring($procedure.step.numeration.formats,1,1)"/>
          </xsl:attribute>
          <xsl:apply-templates 
            select="step
                    |comment()[preceding-sibling::step]
                    |processing-instruction()[preceding-sibling::step]"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="title and $placement != 'before'">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>
</xsl:template>

<xsl:template match="procedure/title">
  <!-- nop -->
</xsl:template>

<xsl:template match="substeps">
  <xsl:variable name="numeration">
    <xsl:call-template name="procedure.step.numeration"/>
  </xsl:variable>

  <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="step">
  <xsl:text># </xsl:text>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="stepalternatives">
  <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="step/title">
    <xsl:text>'''</xsl:text>  <xsl:apply-templates/><xsl:text>'''</xsl:text>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="segmentedlist">
  <xsl:variable name="presentation">
    <xsl:call-template name="pi.dbhtml_list-presentation"/>
  </xsl:variable>

    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>

    <xsl:choose>
      <xsl:when test="$presentation = 'table'">
        <xsl:apply-templates select="." mode="seglist-table"/>
      </xsl:when>
      <xsl:when test="$presentation = 'list'">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="$segmentedlist.as.table != 0">
        <xsl:apply-templates select="." mode="seglist-table"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="segmentedlist/title">
  <xsl:text>'''</xsl:text><xsl:apply-templates/><xsl:text>'''</xsl:text>
</xsl:template>

<xsl:template match="segtitle">
</xsl:template>

<xsl:template match="segtitle" mode="segtitle-in-seg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="seglistitem">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="seg">
  <xsl:variable name="segnum" select="count(preceding-sibling::seg)+1"/>
  <xsl:variable name="seglist" select="ancestor::segmentedlist"/>
  <xsl:variable name="segtitles" select="$seglist/segtitle"/>

  <!--
     Note: segtitle is only going to be the right thing in a well formed
     SegmentedList.  If there are too many Segs or too few SegTitles,
     you'll get something odd...maybe an error
  -->

        <xsl:apply-templates select="$segtitles[$segnum=position()]"
                             mode="segtitle-in-seg"/>
        <xsl:text>: </xsl:text>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="segmentedlist" mode="seglist-table">

</xsl:template>

<xsl:template match="segtitle" mode="seglist-table">

</xsl:template>

<xsl:template match="seglistitem" mode="seglist-table">

</xsl:template>

<xsl:template match="seg" mode="seglist-table">
</xsl:template>

<xsl:template match="seg[1]" mode="seglist-table">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="calloutlist">

</xsl:template>

<xsl:template match="calloutlist/title">
</xsl:template>

<xsl:template match="callout">

</xsl:template>

<xsl:template match="callout/simpara" priority="2">
</xsl:template>

<xsl:template name="callout.arearefs">
</xsl:template>

<xsl:template name="callout.arearef">
  <xsl:param name="arearef"></xsl:param>
  <xsl:variable name="targets" select="key('id',$arearef)"/>
  <xsl:variable name="target" select="$targets[1]"/>

</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="orderedlist-starting-number">
  <xsl:param name="list" select="."/>
  <xsl:variable name="pi-start">
    <xsl:call-template name="pi.dbhtml_start">
      <xsl:with-param name="node" select="$list"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="output-orderedlist-starting-number">
    <xsl:with-param name="list" select="$list"/>
    <xsl:with-param name="pi-start" select="$pi-start"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
