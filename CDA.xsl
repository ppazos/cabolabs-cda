<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
    <!-- CDA document -->
    <xsl:variable name="textEncoding">ISO-8859-1</xsl:variable>
    <xsl:variable name="tableWidth">50%</xsl:variable>
    <xsl:variable name="title">
        <xsl:choose>
            <xsl:when test="//n1:ClinicalDocument/n1:title">
                <xsl:value-of select="//n1:ClinicalDocument/n1:title"/>
            </xsl:when>
            <xsl:when test="//n1:ClinicalDocument/n1:code/@displayName">
                <xsl:value-of select="//n1:ClinicalDocument/n1:code/@displayName"/>
            </xsl:when>
            <xsl:otherwise>Clinical Document</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates select="n1:ClinicalDocument"/>
    </xsl:template>

    <xsl:template match="n1:ClinicalDocument">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset={$textEncoding}"/>
                <!-- <meta name='Generator' content='&CDA-Stylesheet;'/> -->
                <xsl:comment> Do NOT edit this HTML directly, it was generated via an XSLt transformation from the original release 2 CDA Document. </xsl:comment>
                <xsl:comment>Derived from HL7 Finland R2 Tyylitiedosto: Tyyli_R2_B3_01.xslt</xsl:comment>
                <xsl:comment>Updated by Calvin E. Beebe, Mayo Clinic - Rochester Mn. </xsl:comment>
                <xsl:comment>Updated by Keith W. Boone, Dictaphone - Burlington, MA </xsl:comment>
                <xsl:comment>Updated by Kai U. Heitmann, Heitmann Consulting &amp; Service, NL for VHitG, Germany </xsl:comment>
                <xsl:comment>Updated by René Spronk, translate back to English-language labels</xsl:comment>
                <xsl:comment>Updated by Dick Donker, Philips Medical Systems include linkHtml</xsl:comment>
                <xsl:comment>Updated by Tony Schaller, medshare GmbH, for HL7 affiliate Switzerland</xsl:comment>
                <xsl:comment xml:space="preserve">Updated by Alexander Henket, E.Novation B.V.
                    - added meta tag that includes the encoding of the rendered document
                    - changed/updated the BottomLine to include every header participation, except those behind Encounter
                    - changed "Attending physician" at the top of the document. Only displayed if available, and now includes
                       Location if present too
                    - added support for all? missing attributes from NarrativeBlock, including all styleCodes
                    - added CSS class for inserted text with overline and underline and a tooltip
                    - changed the way the title is retrieved by also checking ClinicalDocument/code/@displayName
                    - changed names and addresses so they follow all parts as present instead of a few in arbitrary order
                    - Lots of minor bug fixes
                    - Known issue: footNote/footNoteRef and most Acts on the header not supported
                </xsl:comment>
                <title>
                    <xsl:value-of select="$title"/>
                </title>
                <style type="text/css" media="screen">
                    body {
                        color: #003366;
                        font-size: 12px;
                        line-height: normal;
                        font-family: Verdana, Arial, sans-serif;
                        margin: 10px;
                        scrollbar-3dlight-color: #EEEEEE;
                        scrollbar-arrow-color: #003366;
                        scrollbar-darkshadow-color: #EEEEEE;
                        scrollbar-face-color: #EEEEEE;
                        scrollbar-highlight-color: #003366;
                        scrollbar-shadow-color: #003366;
                        scrollbar-track-color: #EEEEEE;
                    }
                    a {
                        color: #0099ff;
                        text-decoration: none;
                    }
                    table {
                        font-size: 10pt;
                        background-repeat: no-repeat;
                        border: 2px #bacd0c;
                        line-height: 10pt;
                        border-width: 0;
                        border-color: #eeeeee
                    }
                    .input {
                        color: #003366;
                        font-size: 10pt;
                        font-family: Verdana, Arial, sans-serif;
                        background-color: #ffffff;
                        border: solid 1px
                    }
                    h1 {
                        font-size: 12pt;
                    }
                    h2 {
                        font-size: 11pt;
                    }
                    .revision_insert {
                        text-decoration: underline overline;
                    }</style>
            </head>
            <body>
                <table style="width: 100%">
                    <tr bgcolor="#3399ff">
                        <td width="15%" valign="top">
                            <span style="color:white;font-weight:bold;">
                                <xsl:text>Patient:</xsl:text>
                            </span>
                        </td>
                        <td width="45%" valign="top">
                            <span style="color:white;font-weight:bold; ">
                                <xsl:call-template name="getName">
                                    <xsl:with-param name="name" select="n1:recordTarget/n1:patientRole/n1:patient/n1:name"/>
                                </xsl:call-template>
                            </span>
                        </td>
                        <td width="10%" align="right" valign="top">
                            <span style="color:white; ">
                                <xsl:text>DOB:</xsl:text>
                            </span>
                        </td>
                        <td width="30%" valign="top">
                            <span style="color:white; ">
                                <xsl:call-template name="formatDate">
                                    <xsl:with-param name="date" select="n1:recordTarget/n1:patientRole/n1:patient/n1:birthTime/@value"/>
                                </xsl:call-template>
                            </span>
                        </td>
                    </tr>
                    <tr bgcolor="#ccccff">
                        <td valign="top"> </td>
                        <td valign="top">
                            <xsl:call-template name="getContactInfo">
                                <xsl:with-param name="contact" select="n1:recordTarget/n1:patientRole"/>
                            </xsl:call-template>
                        </td>
                        <td valign="top" align="right">
                            <xsl:text>Patient-ID:</xsl:text>
                        </td>
                        <td valign="top">
                            <xsl:apply-templates select="n1:recordTarget/n1:patientRole/n1:id" mode="getIDs"/>
                        </td>
                    </tr>
                    <tr bgcolor="#ccccff">
                        <td valign="top">
                            <xsl:text>Created on:</xsl:text>
                        </td>
                        <td valign="top">
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="n1:effectiveTime/@value"/>
                            </xsl:call-template>
                        </td>
                        <td valign="top" align="right">
                            <xsl:text>Gender:</xsl:text>
                        </td>
                        <td valign="top">
                            <xsl:variable name="sex" select="n1:recordTarget/n1:patientRole/n1:patient/n1:administrativeGenderCode/@code"/>
                            <xsl:choose>
                                <xsl:when test="$sex='M'">Male</xsl:when>
                                <xsl:when test="$sex='F'">Female</xsl:when>
                                <xsl:when test="$sex='U'">Undifferentiated</xsl:when>
                                <xsl:otherwise>Unknown</xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                    <xsl:if test="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:assignedPerson/n1:name">
                        <tr bgcolor="#ccccff">
                            <td valign="top">
                                <xsl:text>Attending physician:</xsl:text>
                            </td>
                            <td valign="top">
                                <xsl:call-template name="getName">
                                    <xsl:with-param name="name" select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:assignedPerson/n1:name"/>
                                </xsl:call-template>
                                <br/>
                                <xsl:call-template name="getContactInfo">
                                    <xsl:with-param name="contact" select="n1:componentOf/n1:encompassingEncounter/n1:responsibleParty/n1:assignedEntity/n1:representedOrganization"/>
                                </xsl:call-template>
                            </td>
                            <td valign="top" align="right">
                                <xsl:text>Location:</xsl:text>
                            </td>
                            <td valign="top">
                                <xsl:apply-templates select="n1:componentOf/n1:encompassingEncounter/n1:location/n1:healthCareFacility/n1:code" mode="getText"/>
                            </td>
                        </tr>
                    </xsl:if>
                </table>
                <hr/>
                <h2>
                    <xsl:value-of select="$title"/>
                </h2>
                <xsl:apply-templates select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
                <hr/>
                <xsl:call-template name="bottomline"/>
            </body>
        </html>
    </xsl:template>

    <!-- Get from a code originalText, displayName or code -->
    <xsl:template match="n1:code" mode="getText">
        <xsl:choose>
            <xsl:when test="n1:originalText">
                <xsl:value-of select="n1:originalText"/>
            </xsl:when>
            <xsl:when test="@displayName">
                <xsl:value-of select="@displayName"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@code"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Get all IDs  -->
    <xsl:template match="n1:id" mode="getIDs">
        <table width="100%" cellspacing="0" cellpadding="0">
            <xsl:for-each select="../n1:id">
                <tr>
                    <td width="40%" align="left">
                        <xsl:value-of select="./@extension"/>
                    </td>
                    <td width="60%" align="left">
                        <xsl:value-of select="./@root"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- Get a Name  -->
    <!--
        20090415: (AH) Now handles data type as given in XML, including mixed content,
        instead of calling fixed parts in arbitrary order. It is also possible to activate
        a tooltip on the name that lists the IDs this person has. Deactivated that because
        it can be annoying when used in production.
    -->
    <xsl:template name="getName">
        <xsl:param name="name"/>
        <!--span>
            <xsl:attribute name="title">
                <xsl:for-each select="$name/../../n1:id">
                    <xsl:text>ID: </xsl:text>
                    <xsl:value-of select="@extension"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@root"/>
                    <xsl:text>)</xsl:text>
                    <br/>
                </xsl:for-each>
            </xsl:attribute-->
        <xsl:for-each select="$name/node()">
            <xsl:if test="name() = 'suffix' or substring-after(name(),':') = 'suffix'">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
            <xsl:if test="name() = 'given' or substring-after(name(),':') = 'given'">
                <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:for-each>
        <!--/span-->
    </xsl:template>

    <!-- getLastFirstName: derived from Switzerland stylesheet but not called right now -->
    <xsl:template name="getLastFirstName">
        <xsl:param name="name"/>
        <xsl:choose>
            <xsl:when test="$name/n1:family">
                <xsl:value-of select="$name/n1:family"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$name/n1:given"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$name"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  Format Date: outputs a date in Month Day, Year form -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:variable name="month" select="substring ($date, 5, 2)"/>
        <xsl:choose>
            <xsl:when test="$month='01'">
                <xsl:text>January </xsl:text>
            </xsl:when>
            <xsl:when test="$month='02'">
                <xsl:text>February </xsl:text>
            </xsl:when>
            <xsl:when test="$month='03'">
                <xsl:text>March</xsl:text>
            </xsl:when>
            <xsl:when test="$month='04'">
                <xsl:text>April </xsl:text>
            </xsl:when>
            <xsl:when test="$month='05'">
                <xsl:text>May </xsl:text>
            </xsl:when>
            <xsl:when test="$month='06'">
                <xsl:text>June </xsl:text>
            </xsl:when>
            <xsl:when test="$month='07'">
                <xsl:text>July </xsl:text>
            </xsl:when>
            <xsl:when test="$month='08'">
                <xsl:text>August </xsl:text>
            </xsl:when>
            <xsl:when test="$month='09'">
                <xsl:text>September </xsl:text>
            </xsl:when>
            <xsl:when test="$month='10'">
                <xsl:text>October </xsl:text>
            </xsl:when>
            <xsl:when test="$month='11'">
                <xsl:text>November </xsl:text>
            </xsl:when>
            <xsl:when test="$month='12'">
                <xsl:text>December </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="substring ($date, 7, 1)='0'">
                <xsl:value-of select="substring ($date, 8, 1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring ($date, 7, 2)"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="substring ($date, 1, 4)"/>
    </xsl:template>

    <!-- nonXMLBody -->
    <xsl:template match="n1:component/n1:nonXMLBody">
        <xsl:choose>
            <!-- if there is a reference, use that in an IFRAME -->
            <xsl:when test="n1:text/n1:reference">
                <iframe name="nonXMLBody" id="nonXMLBody" WIDTH="100%" HEIGHT="66%" src="{n1:text/n1:reference/@value}"/>
            </xsl:when>
            <xsl:when test="n1:text/@mediaType='text/plain'">
                <pre>
                    <xsl:value-of select="n1:text/text()"/>
                </pre>
            </xsl:when>
            <xsl:when test="n1:text/@mediaType='application/pdf'">
                <embed type="application/pdf" name="nonXMLBody" id="nonXMLBody" WIDTH="100%" HEIGHT="400" src="{n1:text/n1:reference/@value}">
                    <xsl:attribute name="src">
                        <xsl:text>data:application/pdf;base64,</xsl:text><xsl:value-of select="n1:text/text()"/>
                    </xsl:attribute>
                </embed>
            </xsl:when>
            <xsl:when test="n1:text/@mediaType='text/html'">
              <div WIDTH="100%" HEIGHT="66%">
                 <!--
                 <xsl:copy-of select="n1:text/n1:html/n1:body/n1:div"/>
                 -->
                 <!--<xsl:apply-templates select="n1:text"/>-->
                 <xsl:apply-templates/>
              </div>
            </xsl:when>
            <xsl:otherwise>
                <center>Cannot display the text</center>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- StructuredBody -->
    <xsl:template match="n1:component/n1:structuredBody">
        <xsl:apply-templates select="n1:component/n1:section"/>
    </xsl:template>

    <!-- Component/Section -->
    <xsl:template match="n1:component/n1:section">
        <xsl:apply-templates select="n1:title">
            <xsl:with-param name="code" select="n1:code/@code"/>
        </xsl:apply-templates>
        <ul>
            <xsl:apply-templates select="n1:text"/>
            <xsl:if test="n1:component/n1:section">
                <div>
                    <br/>
                    <xsl:apply-templates select="n1:component/n1:section"/>
                </div>
            </xsl:if>
        </ul>
    </xsl:template>

    <!--  Title -->
    <xsl:template match="n1:title">
        <xsl:param name="code" select="''"/>
        <span style="font-weight:bold;" title="{$code}">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <!--  Text -->
    <xsl:template match="n1:text">
        <xsl:apply-templates/>
    </xsl:template>

    <!--   paragraph  -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:paragraph">
        <p>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!--   linkHtml  -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:linkHtml">
        <xsl:element name="a">
            <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!--   line break  -->
    <xsl:template match="n1:br">
        <br/>
    </xsl:template>

    <!--  Content w/ deleted text is hidden -->
    <xsl:template match="n1:content[@revised='delete']"/>

    <!--   content  -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:content">
        <span>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!--   list  -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:list">
        <!-- caption -->
        <xsl:if test="n1:caption">
            <span style="font-weight:bold; ">
                <xsl:apply-templates select="n1:caption"/>
            </span>
        </xsl:if>
        <!-- item -->
        <xsl:choose>
            <xsl:when test="@listType='ordered'">
                <ol>
                    <xsl:apply-templates select="." mode="handleStyleCode"/>
                    <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
                    <xsl:for-each select="n1:item">
                        <li>
                            <xsl:apply-templates select="." mode="handleStyleCode"/>
                            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
                            <xsl:apply-templates/>
                        </li>
                    </xsl:for-each>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <!-- list is unordered -->
                <ul>
                    <xsl:apply-templates select="." mode="handleStyleCode"/>
                    <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
                    <xsl:for-each select="n1:item">
                        <li>
                            <xsl:apply-templates select="." mode="handleStyleCode"/>
                            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
                            <xsl:apply-templates/>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  caption  -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:caption">
        <xsl:apply-templates select="." mode="handleStyleCode"/>
        <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
        <xsl:apply-templates/>
        <xsl:text>: </xsl:text>
    </xsl:template>

    <!-- tables -->
    <xsl:template match="n1:table/@*|n1:thead/@*|n1:tfoot/@*|n1:tbody/@*|n1:colgroup/@*|n1:col/@*|n1:tr/@*|n1:th/@*|n1:td/@*">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <!-- table -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:table">
        <table>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <!-- thead -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:thead">
        <thead>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </thead>
    </xsl:template>

    <!-- tfoot -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:tfoot">
        <tfoot>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </tfoot>
    </xsl:template>

    <!-- tbody -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:tbody">
        <tbody>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </tbody>
    </xsl:template>

    <!-- colgroup -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:colgroup">
        <colgroup>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </colgroup>
    </xsl:template>

    <!-- col -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:col">
        <col>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </col>
    </xsl:template>

    <!-- tr -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:tr">
        <tr bgcolor="#ffff66">
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <!-- th -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:th">
        <th bgcolor="#ffd700">
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </th>
    </xsl:template>

    <!-- td -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:td">
        <td>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </td>
    </xsl:template>

    <!-- table/caption -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 attributes -->
    <xsl:template match="n1:table/n1:caption">
        <caption>
            <xsl:apply-templates select="." mode="handleStyleCode"/>
            <xsl:apply-templates select="." mode="handleOtherStyleCodes"/>
            <xsl:apply-templates/>
        </caption>
    </xsl:template>

    <!-- RenderMultiMedia

    this currently only handles GIF's and JPEG's.  It could, however,
    be extended by including other image MIME types in the predicate
    and/or by generating <object> or <applet> tag with the correct
    params depending on the media type  @ID  =$imageRef  referencedObject
    -->
    <xsl:template match="n1:renderMultiMedia">
        <xsl:variable name="imageRef" select="@referencedObject"/>
        <xsl:choose>
            <xsl:when test="//n1:regionOfInterest[@ID=$imageRef]">
                <!-- Here is where the Region of Interest image referencing goes -->
                <xsl:if test="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg']">
                    <br clear="all"/>
                    <xsl:element name="img">
                        <xsl:attribute name="src">
                            <xsl:value-of select="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value/n1:reference/@value"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <!-- Here is where the direct MultiMedia image referencing goes -->
                <xsl:if test="//n1:observationMedia[@ID=$imageRef]/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg']">
                    <br clear="all"/>
                    <xsl:element name="img">
                        <xsl:attribute name="src">
                            <xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value/n1:reference/@value"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--    Stylecode processing -->
    <!-- 20090415: (AH) Now supports all allowable CDAr2 style codes -->
    <xsl:template match="*" mode="handleStyleCode">
        <xsl:if test="@styleCode">
            <xsl:attribute name="style">
                <xsl:if test="contains(@styleCode,'Bold')">
                    <xsl:text>font-weight:bold;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Italics')">
                    <xsl:text>font-style: italic;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Underline')">
                    <xsl:text>text-decoration: underline;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Emphasis')">
                    <xsl:text>font-weight:bold; font-style: italic;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Lrule')">
                    <xsl:text>border-left-width: 5px; border-left-style: solid;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Rrule')">
                    <xsl:text>border-right-width: 5px; border-right-style: solid;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Toprule')">
                    <xsl:text>border-top-width: 5px; border-top-style: solid;</xsl:text>
                </xsl:if>
                <xsl:if test="contains(@styleCode,'Botrule')">
                    <xsl:text>border-bottom-width: 5px; border-bottom-style: solid;</xsl:text>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="contains(@styleCode,'Arabic')">
                        <xsl:text>list-style: arabic;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'LittleRoman')">
                        <xsl:text>list-style: lower-roman;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'BigRoman')">
                        <xsl:text>list-style: upper-roman;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'LittleAlpha')">
                        <xsl:text>list-style: lower-alpha;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'BigAlpha')">
                        <xsl:text>list-style: upper-alpha</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'Disc')">
                        <xsl:text>list-style: disc;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'Circle')">
                        <xsl:text>list-style: circle;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(@styleCode,'Square')">
                        <xsl:text>list-style: square;</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- Other style attribute processing -->
    <!-- 20090415: (AH) New: does all other allowable CDAr2 style codes and ID -->
    <xsl:template match="*" mode="handleOtherStyleCodes">
        <!-- General stuff -->
        <xsl:if test="@ID">
            <xsl:attribute name="id">
                <xsl:value-of select="@ID"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@IDREF">
            <xsl:attribute name="idref">
                <xsl:value-of select="@IDREF"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@language">
            <xsl:attribute name="lang">
                <xsl:value-of select="@language"/>
            </xsl:attribute>
        </xsl:if>

        <!-- Table stuff -->
        <xsl:if test="@border">
            <xsl:attribute name="border">
                <xsl:value-of select="@border"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@frame">
            <xsl:attribute name="frame">
                <xsl:value-of select="@frame"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@rules">
            <xsl:attribute name="rules">
                <xsl:value-of select="@rules"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test=". = n1:table">
            <xsl:choose>
                <xsl:when test="@cellpadding">
                    <xsl:attribute name="cellpadding">
                        <xsl:value-of select="@cellpadding"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="cellpadding">
                        <xsl:text>1</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test=". = n1:table">
            <xsl:choose>
                <xsl:when test="@cellspacing">
                    <xsl:attribute name="cellspacing">
                        <xsl:value-of select="@cellspacing"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="cellspacing">
                        <xsl:text>4</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="@span">
            <xsl:attribute name="span">
                <xsl:value-of select="@span"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@summary">
            <xsl:attribute name="summary">
                <xsl:value-of select="@summary"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@width">
            <xsl:attribute name="width">
                <xsl:value-of select="@width"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@align">
            <xsl:attribute name="align">
                <xsl:value-of select="@align"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@valign">
            <xsl:attribute name="valign">
                <xsl:value-of select="@valign"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@char">
            <xsl:attribute name="char">
                <xsl:value-of select="@char"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@charoff">
            <xsl:attribute name="charoff">
                <xsl:value-of select="@charoff"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@abbr">
            <xsl:attribute name="abbr">
                <xsl:value-of select="@abbr"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@scope">
            <xsl:attribute name="scope">
                <xsl:value-of select="@scope"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@headers">
            <xsl:attribute name="headers">
                <xsl:value-of select="@headers"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@axis">
            <xsl:attribute name="axis">
                <xsl:value-of select="@axis"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@colspan">
            <xsl:attribute name="colspan">
                <xsl:value-of select="@colspan"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="@rowspan"/>
            </xsl:attribute>
        </xsl:if>

        <!-- Text stuff -->
        <xsl:if test="@revised">
            <xsl:attribute name="class">
                <xsl:text>revision_</xsl:text>
                <xsl:value-of select="@revised"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>inserted</xsl:text>
            </xsl:attribute>
        </xsl:if>

        <!-- LinkHTML stuff -->
        <xsl:if test="@name">
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@rel">
            <xsl:attribute name="rel">
                <xsl:value-of select="@rel"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@href">
            <xsl:attribute name="href">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title">
                <xsl:value-of select="@title"/>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="@rev">
            <xsl:attribute name="rev">
                <xsl:value-of select="@rev"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- superscript -->
    <xsl:template match="n1:sup">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- subscript -->
    <xsl:template match="n1:sub">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>

    <!--  Contact Information -->
    <xsl:template name="getContactInfo">
        <xsl:param name="contact"/>
        <xsl:apply-templates select="$contact/n1:addr"/>
        <xsl:if test="$contact/n1:addr and $contact/n1:telecom">
            <br/>
        </xsl:if>
        <xsl:apply-templates select="$contact/n1:telecom"/>
    </xsl:template>

    <!-- addr -->
    <!--
        20090415: (AH) Now handles data type as given in XML, including mixed content,
        instead of calling fixed parts in arbitrary order.
    -->
    <xsl:template match="n1:addr">
        <xsl:if test="position() > 1">
            <br/>
        </xsl:if>
        <xsl:for-each select="node()">
            <xsl:choose>
                <xsl:when test="name() = 'streetName' or substring-after(name(),':') = 'streetName'">
                    <xsl:value-of select="."/>
                    <xsl:if test="../n1:houseNumber">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="../n1:houseNumber"/>
                    </xsl:if>
                    <xsl:if test="../n1:additionalLocator">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="../n1:additionalLocator"/>
                    </xsl:if>
                    <br/>
                </xsl:when>
                <xsl:when
                    test="((name() = 'houseNumber' or substring-after(name(),':') = 'houseNumber') or
                    (name() = 'additionalLocator' or substring-after(name(),':') = 'additionalLocator')) and
                    not(../n1:streetName)">
                    <xsl:value-of select="."/>
                    <br/>
                </xsl:when>
                <xsl:when
                    test="((name() = 'houseNumber' or substring-after(name(),':') = 'houseNumber') or
                    (name() = 'additionalLocator' or substring-after(name(),':') = 'additionalLocator'))"/>
                <xsl:when test="name() = 'city' or substring-after(name(),':') = 'city'">
                    <xsl:value-of select="."/>
                    <xsl:if test="../n1:state">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="../n1:state"/>
                        <br/>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="(name() = 'state' or substring-after(name(),':') = 'state') and not(../n1:city)">
                    <xsl:value-of select="."/>
                    <br/>
                </xsl:when>
                <xsl:when test="name() = 'state' or substring-after(name(),':') = 'state'"/>
                <xsl:otherwise>
                    <xsl:if test="string-length(./text()) > 0">
                        <xsl:value-of select="."/>
                        <br/>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- telecom -->
    <xsl:template match="n1:telecom">
        <xsl:variable name="type" select="substring-before(@value, ':')"/>
        <xsl:variable name="value" select="substring-after(@value, ':')"/>
        <xsl:if test="$type">
            <xsl:call-template name="translateCode">
                <xsl:with-param name="code" select="$type"/>
            </xsl:call-template>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="$value"/>
            <xsl:if test="@use">
                <xsl:text> (</xsl:text>
                <xsl:call-template name="translateCode">
                    <xsl:with-param name="code" select="@use"/>
                </xsl:call-template>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <br/>
        </xsl:if>
    </xsl:template>

    <!--  Bottomline  -->
    <!-- 20090415: (AH) Now lists every partipation -->
    <xsl:template name="bottomline">
        <table width="100%" cellspacing="1" cellpadding="5">
            <!-- Consent taken from Swiss stylesheet -->
            <xsl:if test="/n1:ClinicalDocument/n1:authorization/n1:consent/n1:code/n1:originalText">
                <tr>
                    <td width="20%" bgcolor="#3399ff" valign="top">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Consent:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:value-of select="/n1:ClinicalDocument/n1:authorization/n1:consent/n1:code/n1:originalText"/>
                    </td>
                </tr>
                <tr>
                    <td width="20%" bgcolor="#3399ff" valign="top">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Custodian organization:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
                            </xsl:call-template>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:if>
            <xsl:for-each select="/n1:ClinicalDocument/n1:author">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Author:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:if test="n1:assignedAuthor/n1:representedOrganization/n1:name">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:assignedAuthor/n1:representedOrganization/n1:name"/>
                            </xsl:call-template>
                            <br/>
                        </xsl:if>
                        <xsl:if test="n1:assignedAuthor/n1:assignedPerson/n1:name">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:assignedAuthor/n1:assignedPerson/n1:name"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="n1:assignedAuthoringDevice">
                            <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
                        </xsl:if>
                        <xsl:text> on </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:time/@value"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:choose>
                            <xsl:when test="n1:assignedAuthor">
                                <xsl:call-template name="getContactInfo">
                                    <xsl:with-param name="contact" select="n1:assignedAuthor"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="getContactInfo">
                                    <xsl:with-param name="contact" select="n1:assignedAuthor/n1:representedOrganization"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:authenticator">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Authenticator: </xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:authenticator/n1:assignedEntity/n1:assignedPerson/n1:name"/>
                        </xsl:call-template>
                        <xsl:text> on </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:time/@value"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:assignedEntity"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:legalAuthenticator">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Legal Authenticator:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                        </xsl:call-template>
                        <xsl:text> on </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:time/@value"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:assignedEntity"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:custodian">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Custodian:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:if test="n1:assignedCustodian/n1:representedCustodianOrganization">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
                            </xsl:call-template>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:assignedCustodian/n1:representedCustodianOrganization"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:informant">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Informant:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:if test="n1:assignedEntity/n1:assignedPerson|n1:relatedEntity/n1:relatedPerson">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name|n1:relatedEntity/n1:relatedPerson/n1:name"/>
                            </xsl:call-template>
                            <xsl:if test="n1:relatedEntity/n1:code">
                                <xsl:text> (</xsl:text>
                                <xsl:call-template name="translateCode">
                                    <xsl:with-param name="code" select="n1:relatedEntity/n1:code/@code"/>
                                </xsl:call-template>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:assignedEntity|n1:relatedEntity"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:dataEnterer">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Data enterer:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                        </xsl:call-template>
                        <xsl:text> on </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="n1:time/@value"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:informationRecipient">
                <tr>
                    <td width="20%" bgcolor="#3399ff">
                        <span style="color:white;font-weight:bold; ">
                            <xsl:text>Information Recipient:</xsl:text>
                        </span>
                    </td>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:if test="n1:intendedRecipient/n1:informationRecipient">
                            <xsl:call-template name="getName">
                                <xsl:with-param name="name" select="n1:intendedRecipient/n1:informationRecipient/n1:name"/>
                            </xsl:call-template>
                            <xsl:if test="n1:intendedRecipient/n1:receivedOrganization">
                                <br/>
                                <xsl:value-of select="n1:intendedRecipient/n1:receivedOrganization/n1:name"/>
                            </xsl:if>
                        </xsl:if>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td width="80%" bgcolor="#ccccff" valign="top">
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:intendedRecipient/n1:receivedOrganization"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="/n1:ClinicalDocument/n1:participant">
                <xsl:sort select="@typeCode"/>
                <xsl:choose>
                    <xsl:when test="@typeCode='HLD'">
                        <xsl:call-template name="payer"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="."/>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- payer -->
    <xsl:template name="payer">
        <table width="100%">
            <xsl:for-each select="/n1:ClinicalDocument/n1:participant[@typeCode='HLD']">
                <tr>
                    <td>
                        <span style="font-weight:bold; ">
                            <xsl:text>Insured: </xsl:text>
                        </span>
                    </td>
                    <td>
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:associatedEntity/n1:associatedPerson/n1:name"/>
                        </xsl:call-template>
                    </td>
                    <td>
                        <span style="font-weight:bold; ">
                            <xsl:text>Insurer: </xsl:text>
                        </span>
                    </td>
                    <td>
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:associatedEntity/n1:scopingOrganization/n1:name"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td>
                        <span style="font-weight:bold; ">
                            <xsl:text>ID:</xsl:text>
                        </span>
                        <xsl:value-of select="n1:associatedEntity/n1:id/@extension"/>
                        <br/>
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:associatedEntity"/>
                        </xsl:call-template>
                    </td>
                    <td/>
                    <td>
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:associatedEntity/n1:scopingOrganization"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr> </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- participant -->
    <xsl:template match="n1:participant">
        <tr>
            <td width="20%" bgcolor="#3399ff" rowspan="2">
                <span style="font-weight:bold; ">
                    <xsl:call-template name="translateParticipationType">
                        <xsl:with-param name="code">
                            <xsl:value-of select="@typeCode"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:text>:</xsl:text>
                </span>
            </td>
            <td width="80%" bgcolor="#ccccff" valign="top">
                <xsl:call-template name="getName">
                    <xsl:with-param name="name" select="n1:associatedEntity/n1:associatedPerson/n1:name"/>
                </xsl:call-template>
                <xsl:text> (</xsl:text>
                <xsl:for-each select="n1:associatedEntity/n1:code">
                    <xsl:if test="position() > 1">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:call-template name="translateCode">
                        <xsl:with-param name="code" select="@code"/>
                    </xsl:call-template>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
                <br/>
                <xsl:call-template name="getContactInfo">
                    <xsl:with-param name="contact" select="n1:associatedEntity"/>
                </xsl:call-template>
            </td>
        </tr>
        <tr>
            <td width="80%" bgcolor="#ccccff" valign="top">
                <xsl:call-template name="getName">
                    <xsl:with-param name="name" select="n1:associatedEntity/n1:scopingOrganization/n1:name"/>
                </xsl:call-template>
                <br/>
                <xsl:call-template name="getContactInfo">
                    <xsl:with-param name="contact" select="n1:associatedEntity/n1:scopingOrganization"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <!-- performer -->
    <xsl:template name="performer">
        <table width="100%">
            <xsl:for-each select="//n1:serviceEvent/n1:performer">
                <tr>
                    <td>
                        <span style="font-weight:bold; ">
                            <xsl:call-template name="translateCode">
                                <xsl:with-param name="code" select="n1:functionCode/@code"/>
                            </xsl:call-template>
                        </span>
                    </td>
                    <td>
                        <xsl:call-template name="getName">
                            <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                        </xsl:call-template>
                        <xsl:text> (</xsl:text>
                        <xsl:call-template name="translateCode">
                            <xsl:with-param name="code" select="n1:assignedEntity/n1:code/@code"/>
                        </xsl:call-template>
                        <xsl:text>) </xsl:text>
                    </td>
                </tr>
                <tr>
                    <td/>
                    <td>
                        <xsl:call-template name="getContactInfo">
                            <xsl:with-param name="contact" select="n1:assignedEntity"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- translateCode -->
    <!-- 20090419: (AH) Fixed the way an unknown code is displayed. Now shows the value contained -->
    <xsl:template name="translateCode">
        <xsl:param name="code"/>
        <!--xsl:value-of select="document('voc.xml')/systems/system[@root=$code/@codeSystem]/code[@value=$code/@code]/@displayName"/-->
        <!--xsl:value-of select="document('codes.xml')/*/code[@code=$code]/@display"/-->
        <xsl:choose>
            <!-- lookup table Telecom URI -->
            <xsl:when test="$code='http'">
                <xsl:text>Web</xsl:text>
            </xsl:when>
            <xsl:when test="$code='mailto'">
                <xsl:text>Email</xsl:text>
            </xsl:when>
            <xsl:when test="$code='tel'">
                <xsl:text>Tel</xsl:text>
            </xsl:when>
            <xsl:when test="$code='fax'">
                <xsl:text>Fax</xsl:text>
            </xsl:when>
            <xsl:when test="$code='HP' or $code='H'">
                <xsl:text>Home</xsl:text>
            </xsl:when>
            <xsl:when test="$code='HV'">
                <xsl:text>Vacation home</xsl:text>
            </xsl:when>
            <xsl:when test="$code='WP'">
                <xsl:text>Work</xsl:text>
            </xsl:when>
            <xsl:when test="$code='PUB'">
                <xsl:text>Public</xsl:text>
            </xsl:when>
            <xsl:when test="$code='PG'">
                <xsl:text>Pager</xsl:text>
            </xsl:when>
            <xsl:when test="$code='MC'">
                <xsl:text>Mobile</xsl:text>
            </xsl:when>
            <xsl:when test="$code='EC'">
                <xsl:text>Emergency</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$code"/>
                <xsl:text>?</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- translatePartipationType -->
    <!-- 20090419: (AH) New. Ties names to ParticipationType concepts -->
    <xsl:template name="translateParticipationType">
        <xsl:param name="code"/>
        <xsl:choose>
            <xsl:when test="ADM">Admitter</xsl:when>
            <xsl:when test="ATND">Attender</xsl:when>
            <xsl:when test="CALLBCK">Callback contact</xsl:when>
            <xsl:when test="CON">Consultant</xsl:when>
            <xsl:when test="DIS">Discharger</xsl:when>
            <xsl:when test="ESC">Escort</xsl:when>
            <xsl:when test="REF">Referrer</xsl:when>
            <xsl:when test="AUT">Author</xsl:when>
            <xsl:when test="INF">Informant</xsl:when>
            <xsl:when test="TRANS">Transcriber</xsl:when>
            <xsl:when test="ENT">Data enterer</xsl:when>
            <xsl:when test="WIT">Witness</xsl:when>
            <xsl:when test="CST">Custodian</xsl:when>
            <xsl:when test="DIR">Direct target</xsl:when>
            <xsl:when test="BBY">Baby</xsl:when>
            <xsl:when test="CSM">Consumable</xsl:when>
            <xsl:when test="DEV">Device</xsl:when>
            <xsl:when test="NRD">Non-reuseable device</xsl:when>
            <xsl:when test="RDV">Reusable device</xsl:when>
            <xsl:when test="DON">Donor</xsl:when>
            <xsl:when test="EXPAGNT">Exposure agent</xsl:when>
            <xsl:when test="EXPART">Exposure participation</xsl:when>
            <xsl:when test="EXPTRGT">Exposure target</xsl:when>
            <xsl:when test="EXSRC">Exposure source</xsl:when>
            <xsl:when test="PRD">Product</xsl:when>
            <xsl:when test="SBJ">Subject</xsl:when>
            <xsl:when test="SPC">Specimen</xsl:when>
            <xsl:when test="IND">Indirect target</xsl:when>
            <xsl:when test="BEN">Beneficiary</xsl:when>
            <xsl:when test="CAGNT">Causative agent</xsl:when>
            <xsl:when test="COV">Coverage target</xsl:when>
            <xsl:when test="GUAR">Guarantor party</xsl:when>
            <xsl:when test="HLD">Holder</xsl:when>
            <xsl:when test="RCT">Record target</xsl:when>
            <xsl:when test="RCV">Receiver</xsl:when>
            <xsl:when test="IRCP">Information recipient</xsl:when>
            <xsl:when test="NOT">Urgent notification contact</xsl:when>
            <xsl:when test="PRCP">Primary information recipient</xsl:when>
            <xsl:when test="REFB">Referred by</xsl:when>
            <xsl:when test="REFT">Referred to</xsl:when>
            <xsl:when test="TRC">Tracker</xsl:when>
            <xsl:when test="LOC">Location</xsl:when>
            <xsl:when test="DST">Destination</xsl:when>
            <xsl:when test="ELOC">Entry location</xsl:when>
            <xsl:when test="ORG">Origin</xsl:when>
            <xsl:when test="RML">Remote</xsl:when>
            <xsl:when test="VIA">Via</xsl:when>
            <xsl:when test="PRF">Performer</xsl:when>
            <xsl:when test="DIST">Distributor</xsl:when>
            <xsl:when test="PPRF">Primary performer</xsl:when>
            <xsl:when test="SPRF">Secondary performer</xsl:when>
            <xsl:when test="RESP">Responsible party</xsl:when>
            <xsl:when test="VRF">Verifier</xsl:when>
            <xsl:when test="AUTHEN">Authenticator</xsl:when>
            <xsl:when test="LA">Legal authenticator</xsl:when>
            <xsl:otherwise>
                <xsl:text>Participant</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
</xsl:stylesheet>
