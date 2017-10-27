<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <!--  <xsl:param name="rec05.acct_num_token"/>   -->
    <!--  <xsl:param name="rec03.acct_num_token05"/> -->
    <xsl:param name="tokenfor5.long.token"/>

    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        <xsl:variable name="four_record_node">
            <xsl:copy-of select="/File/Transaction/Record_04[acct_num_token = $tokenfor5.long.token]/*"/>
        </xsl:variable>
        <Record>
            <First_Name><xsl:value-of select="$four_record_node/first_name"/></First_Name>
            <Last_Name><xsl:value-of select="$four_record_node/last_name"/></Last_Name>
            <emp_id><xsl:value-of select="normalize-space($four_record_node/emp_id)"/></emp_id>
            <CreditCard_number><xsl:value-of select="normalize-space($four_record_node/cc_num)"/></CreditCard_number>
        </Record>
  
    </xsl:template>
</xsl:stylesheet>
