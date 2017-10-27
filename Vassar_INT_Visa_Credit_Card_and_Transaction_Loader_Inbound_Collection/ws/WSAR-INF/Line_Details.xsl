
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="Key_05"/>
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
      
            <Transaction>
                
                <Key_07><xsl:value-of select="/Record_07/Key_07"/></Key_07>
                <acct_num><xsl:value-of select="Record_07/acct_num"/></acct_num>
                <seq_num><xsl:value-of select="Record_07/seq_num"/></seq_num>
                <item_seq><xsl:value-of select="Record_07/item_seq"/></item_seq>
                <Purc_item_line_num><xsl:value-of select="Record_07/Purc_item_line_num"/></Purc_item_line_num>
                <item_desc><xsl:value-of select="Record_07/item_desc"/></item_desc> 
                <UPC><xsl:value-of select="Record_07/UPC"/></UPC>
                <product_code><xsl:value-of select="Record_07/product_code"/></product_code>
                <item_quantity>
                    <xsl:if
                        test="string-length(Record_07/item_quantity) > 0">
<!--                         <xsl:value-of select="Record_07/item_quantity div 10000"/> --> 
                        <xsl:value-of select='format-number(((Record_07/item_quantity) div 10000),"#.00")'/>
                    </xsl:if>
                </item_quantity>
                <measure_code><xsl:value-of select="Record_07/measure_code"/></measure_code>
                <!-- <Unit_Price><xsl:value-of select="Record_07/unit_cost"/></Unit_Price>  -->
                <Unit_Price>
                        <xsl:if
                        test="string-length(Record_07/unit_cost) > 0"> 
                        <xsl:value-of select="Record_07/unit_cost div 10000"/>
                    </xsl:if> 
                </Unit_Price>
                <Ext_Amt>
                    <xsl:if
                        test="string-length(Record_07/Ext_Amt) > 0">
                        <xsl:value-of select="Record_07/Ext_Amt div 100"/>
                    </xsl:if>
                </Ext_Amt>
                <Tax_Rate>
                    <xsl:if
                        test="string-length(Record_07/Tax_Rate) > 0">
                        <xsl:value-of select="Record_07/Tax_Rate div 10000"/>
                    </xsl:if>
                </Tax_Rate>
                <unit_tax>
                    <xsl:if
                        test="string-length(Record_07/unit_tax) > 0">
                        <xsl:value-of select="Record_07/unit_tax div 100" />
                    </xsl:if>
                </unit_tax>
                <unit_discnt>
                    <xsl:if
                        test="string-length(Record_07/unit_discnt) > 0">
                        <xsl:value-of select="Record_07/unit_discnt div 100" />
                    </xsl:if>
                </unit_discnt>  
            </Transaction>
     
    </xsl:template>
</xsl:stylesheet>

