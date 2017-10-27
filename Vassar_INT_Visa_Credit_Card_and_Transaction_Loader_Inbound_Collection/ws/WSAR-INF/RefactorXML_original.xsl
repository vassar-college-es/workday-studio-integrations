<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="record.type"/>
    <xsl:param name="eight.record"/>
    <xsl:param name="nine.record"/>
    
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/Transaction">		
        <!--<Previous_Year_Data>
            <xsl:for-each-group select="wd:Report_Data/wd:Report_Entry/wd:Payroll_Result_Lines__Completed_" group-by="wd:Pay_Component_Code">
                <Data_Entry>
                    <Earn_Code><xsl:value-of select="current-grouping-key()"/></Earn_Code>
                    <Year><xsl:value-of select="current-group()[1]/wd:Year"/></Year>
                    <Amount><xsl:value-of select="format-number(sum(current-group()/wd:Balance_YTD_for_Worker), '####.##')"/></Amount>
                    <Description><xsl:value-of select="current-group()[1]/wd:Pay_Component_Name"/></Description>
                </Data_Entry>
            </xsl:for-each-group>
        </Previous_Year_Data>-->
        <xsl:choose>
            <xsl:when test="$eight.record = false() and $nine.record = false()">
                <Transaction>
                    <record_type>
                        <xsl:value-of select="$record.type"/>
                    </record_type>
                    <xsl:if test="$record.type = '04'">
                        <acct_num>
                            <xsl:value-of select="Field2"/>
                        </acct_num>
                        <first_name>
                            <xsl:value-of select="Field4"/>
                        </first_name>
                        <last_name>
                            <xsl:value-of select="Field5"/>
                        </last_name>
                        <emp_id>
                            <xsl:value-of select="Field13"/>
                        </emp_id>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '05'">
                        <trans_num>
                            <xsl:value-of select="Field3"/>
                        </trans_num>
                        <acct_num>
                            <xsl:value-of select="Field1"/>
                        </acct_num>
                        <trans_date>
                            <xsl:value-of select="Field18"/>
                        </trans_date>
                        <bill_date>
                            <xsl:value-of select="Field52"/>
                        </bill_date>
                        <post_date>
                            <xsl:value-of select="Field2"/>
                        </post_date>
                        <mer_cd>
                            <xsl:value-of select="Field16"/>
                        </mer_cd>
                        <src_amount>
                            <xsl:value-of select="Field13"/>
                        </src_amount>
                        <amt>
                            <xsl:value-of select="Field14"/>
                        </amt>
                        <tax_amt>
                            <xsl:value-of select="Field20"/>
                        </tax_amt>
                        <tax_incl>
                            <xsl:value-of select="Field34"/>
                        </tax_incl>
                        <src_cur_cd>
                            <xsl:value-of select="Field15"/>
                        </src_cur_cd>
                        <bill_cur_cd>
                            <xsl:value-of select="Field19"/>
                        </bill_cur_cd>
                        <trans_type_cd>
                            <xsl:value-of select="Field17"/>
                        </trans_type_cd>
                        <supp_ref>
                            <xsl:value-of select="Field6"/>
                        </supp_ref>
                        <mer_name>
                            <xsl:value-of select="Field8"/>
                        </mer_name>
                        <mer_loc>
                            <xsl:value-of select="Field9"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="Field10"/>
                        </mer_loc>
                        <charge_desc>
                            <xsl:value-of select="Field32"/>
                        </charge_desc>
                        <corp_account>
                            <xsl:value-of select="Field42"/>
                        </corp_account>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '07'">
                        <item_seq>
                            <xsl:value-of select="Field5"/>
                        </item_seq>
                        <item_desc>
                            <xsl:value-of select="Field8"/>
                        </item_desc>
                        <product_code>
                            <xsl:value-of select="Field18"/>
                        </product_code>
                        <item_quantity>
                            <xsl:value-of select="Field9"/>
                        </item_quantity>
                        <measure_code>
                            <xsl:value-of select="Field11"/>
                        </measure_code>
                        <unit_cost>
                            <xsl:value-of select="Field10"/>
                        </unit_cost>
                        <unit_tax>
                            <xsl:value-of select="Field12"/>
                        </unit_tax>
                        <unit_discnt>
                            <xsl:value-of select="Field16"/>
                        </unit_discnt>
                        
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '09'">
                        <lodging_nts>
                            <xsl:value-of select="Field22"/>
                        </lodging_nts>
                        <ticket_num>
                            <xsl:value-of select="Field9"/>
                        </ticket_num>
                        <arrvl_dt>
                        	<xsl:value-of select="Field6"/>
                        </arrvl_dt>
                        <daily_rt>
                        	<xsl:value-of select="Field7"/>
                        </daily_rt>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '14'">
                        <trans_num>
                            <xsl:value-of select="Field3"/>
                        </trans_num>
                        <ticket_num>
                            <xsl:value-of select="Field9"/>
                        </ticket_num>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '15'">
                        <trans_num>
                            <xsl:value-of select="Field3"/>
                        </trans_num>
                        <domestic_ind>
                            <xsl:value-of select="Field26"/>
                        </domestic_ind>
                        <carrier_code>
                            <xsl:value-of select="Field7"/>
                        </carrier_code>
                        <service_class>
                            <xsl:value-of select="Field8"/>
                        </service_class>
                        <carrier_ref>
                        	<xsl:value-of select="Field13"/>
                        </carrier_ref>
                    </xsl:if>
                </Transaction>
            </xsl:when>
            <xsl:when test="$eight.record = true()">
                <Transaction>
                    <record_type>
                        <xsl:text>8</xsl:text>
                    </record_type>
                </Transaction>
            </xsl:when>
            <xsl:when test="$nine.record = true()">
                <Transaction>
                    <record_type>
                        <xsl:text>9</xsl:text>
                    </record_type>
                </Transaction>
            </xsl:when>
        </xsl:choose>
        
            
        <!--</xsl:if>-->
        
        
    </xsl:template>
</xsl:stylesheet>