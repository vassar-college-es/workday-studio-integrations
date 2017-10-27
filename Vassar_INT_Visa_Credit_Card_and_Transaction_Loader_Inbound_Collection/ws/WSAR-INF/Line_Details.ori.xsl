<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="Key_05"/>
    
   
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
            <xsl:variable name="seven_record_node">
            <xsl:copy-of select="/File/Transaction/Record_07[Key_07 = $Key_05]/*"/>
        </xsl:variable>
            <Transaction>
                
                <Key_07><xsl:value-of select="$seven_record_node/Key_07"/></Key_07>
                <acct_num><xsl:value-of select="$seven_record_node/acct_num"/></acct_num>
                <seq_num><xsl:value-of select="$seven_record_node/seq_num"/></seq_num>
                <item_seq><xsl:value-of select="$seven_record_node/item_seq"/></item_seq>
                <Purc_item_line_num><xsl:value-of select="$seven_record_node/Purc_item_line_num"/></Purc_item_line_num>
                <item_desc><xsl:value-of select="$seven_record_node/item_desc"/></item_desc>
                <UPC><xsl:value-of select="$seven_record_node/UPC"/></UPC>
                <product_code><xsl:value-of select="$seven_record_node/product_code"/></product_code>
                <item_quantity>
                    <xsl:if
                        test="string-length($seven_record_node/item_quantity) > 0">
                        <xsl:value-of select='format-number((($seven_record_node/item_quantity) div 10000),"#.00")'/>
                    </xsl:if>
                </item_quantity>
                <measure_code><xsl:value-of select="$seven_record_node/measure_code"/></measure_code>
                <!-- <Unit_Price><xsl:value-of select="Record_07/unit_cost"/></Unit_Price>  -->
                <Unit_Price>
                        <xsl:if
                        test="string-length($seven_record_node/unit_cost) > 0"> 
                        <xsl:value-of select="$seven_record_node/unit_cost div 10000"/>
                    </xsl:if> 
                </Unit_Price>
                <Ext_Amt>
                    <xsl:if
                        test="string-length($seven_record_node/Ext_Amt) > 0">
                        <xsl:value-of select="$seven_record_node/Ext_Amt div 100"/>
                    </xsl:if>
                </Ext_Amt>
                <Tax_Rate>
                    <xsl:if
                        test="string-length($seven_record_node/Tax_Rate) > 0">
                        <xsl:value-of select="$seven_record_node/Tax_Rate div 10000"/>
                    </xsl:if>
                </Tax_Rate>
                <unit_tax>
                    <xsl:if
                        test="string-length($seven_record_node/unit_tax) > 0">
                        <xsl:value-of select="$seven_record_node/unit_tax div 100" />
                    </xsl:if>
                </unit_tax>
                <unit_discnt>
                    <xsl:if
                        test="string-length($seven_record_node/unit_discnt) > 0">
                        <xsl:value-of select="$seven_record_node/unit_discnt div 100" />
                    </xsl:if>
                </unit_discnt>  
            </Transaction>
     
    </xsl:template>
</xsl:stylesheet>






