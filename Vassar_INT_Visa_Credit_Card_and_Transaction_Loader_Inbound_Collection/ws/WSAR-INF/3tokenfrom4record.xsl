<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="rec03.acct_num_token05"/>
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        <xsl:variable name="four_record_node">
            <xsl:copy-of select="/File/Transaction/Record_03[acct_num_token05 = $rec03.acct_num_token05]/*"/>
        </xsl:variable>
        <Record>
            <FourRec_Short_Token><xsl:value-of select="$four_record_node/acct_num_token05"/></FourRec_Short_Token>
        </Record>
  
    </xsl:template>
</xsl:stylesheet>