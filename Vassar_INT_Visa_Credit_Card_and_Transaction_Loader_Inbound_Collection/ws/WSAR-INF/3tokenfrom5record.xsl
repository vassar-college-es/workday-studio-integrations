<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="rec05.acct_num_token"/>
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        <xsl:variable name="three_record_node">
            <xsl:copy-of select="/File/Transaction/Record_03[acct_num_token05 = $rec05.acct_num_token]/*"/>
        </xsl:variable>
        <Record>
            <Long_Token><xsl:value-of select="$three_record_node/acct_num_token"/></Long_Token>
            <Short_Token><xsl:value-of select="$three_record_node/acct_num_token05"/></Short_Token>
        </Record>
  
    </xsl:template>
</xsl:stylesheet>