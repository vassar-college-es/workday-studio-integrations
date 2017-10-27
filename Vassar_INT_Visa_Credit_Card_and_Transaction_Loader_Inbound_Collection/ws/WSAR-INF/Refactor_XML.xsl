<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="record.type"/>
    <xsl:param name="eight.record"/>
    <xsl:param name="nine.record"/>
    
<!--     Created by F.Meyer Workday  -->
<!--     Modified by F.Meyer for PWS specific requirements :  -->
   
<!-- added a variable to hold  XML reserved characters '&' . When found in Description text , it is replaced by space-->
    <xsl:variable name="RemoveSpecialChar">&amp;</xsl:variable>
    
<!-- Changed the substring on Credit card Account number to be on the last 6 digits instead of 4, due to employees with identical last 4 digit CC number    -->

    <!-- XSLT Entry Point Match -->
    <xsl:template match="/Transaction">		
    
        
        <xsl:choose>
            <xsl:when test="$eight.record = false() and $nine.record = false()">
                <Transaction>
                    <record_type>
                        <xsl:value-of select="$record.type"/>
                    </record_type>
                    
                     <xsl:if test="$record.type = '03'">
                       <Record_03>
                       <corp_num>
                            <xsl:value-of select="normalize-space(Field14)"/>
                        </corp_num>
                        <acct_num>
                            <xsl:value-of select="normalize-space(substring(Field2,13,4))"/>
                        </acct_num>
                        <acct_num_token>
                            <!--  <xsl:value-of select="normalize-space(Field2)"/>-->
                            <xsl:value-of select="normalize-space(Field1)"/>
                        </acct_num_token>
                        <acct_num_token05>
                            <xsl:value-of select="normalize-space(Field2)"/>                            
                        </acct_num_token05>
                        <account_type>
                        <xsl:value-of select="normalize-space(Field13)"/>
                        </account_type>
                        <expire_date>
                            <xsl:value-of select="normalize-space(Field7)"/>
                        </expire_date>
                        <spending_limit>
                            <xsl:value-of select="normalize-space(Field9)"/>
                        </spending_limit>
                        <trans_spending_limit>
                            <xsl:value-of select="normalize-space(Field12)"/>
                        </trans_spending_limit>
                        <status_code>
                            <xsl:value-of select="normalize-space(Field20)"/>
                        </status_code>
                        <status_date>
                            <xsl:value-of select="normalize-space(Field22)"/>
                        </status_date>
                         <ReasonStatusCode>
                            <xsl:value-of select="normalize-space(Field21)"/>
                        </ReasonStatusCode>
                        <efft_date>
                            <xsl:value-of select="normalize-space(Field4)"/>
                        </efft_date>
                        </Record_03>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '04'">
                       <Record_04>
                        <acct_num>
                            <xsl:value-of select="normalize-space(substring(Field2,13,4))"/>
                        </acct_num>
                         <acct_num_token>
                            <xsl:value-of select="normalize-space(Field2)"/>
                        </acct_num_token>
                        <first_name>
                            <xsl:value-of select="normalize-space(Field4)"/>
                        </first_name>
                        <last_name>
                            <xsl:value-of select="normalize-space(Field5)"/>
                        </last_name>
                        <emp_id>
                            <!--  <xsl:value-of select="normalize-space(Field22)"/>-->
                            <xsl:value-of select="normalize-space(substring(Field16,4,6))"/>
                        </emp_id>
                        <cc_num>
                            <xsl:value-of select="normalize-space(substring(Field2,13,4))"/>
                        </cc_num>
                        </Record_04>
                    </xsl:if>
                    
                    <xsl:if test="$record.type = '05'">
                        <Record_05>
                      
                         <Key_05>
                            <xsl:value-of select="normalize-space(substring(Field1,11,6))"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field2)"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field3)"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field4)"/>
                        </Key_05>
                        <acct_num>
                            <xsl:value-of select="normalize-space(substring(Field1,13,4))"/>
                        </acct_num>
                         <acct_num_6digits>
                            <xsl:value-of select="normalize-space(substring(Field1,11,6))"/>
                        </acct_num_6digits>
                         <acct_num_token>
                            <xsl:value-of select="normalize-space(Field1)"/>
                        </acct_num_token>
                        <trans_num>
                            <xsl:value-of select="normalize-space(Field3)"/>
                        </trans_num>
                         <trans_date>
                            <xsl:value-of select="normalize-space(Field18)"/>
                        </trans_date>
                        <bill_date>
                            <xsl:value-of select="normalize-space(Field52)"/>
                        </bill_date>
                        <post_date>
                            <xsl:value-of select="normalize-space(Field2)"/>
                        </post_date>
                        <seq_num>
                        <xsl:value-of select="normalize-space(Field4)"/>
                        </seq_num>
                        <mer_cd>
                            <xsl:value-of select="normalize-space(Field16)"/>
                        </mer_cd>
                        <src_amount>
                            <xsl:value-of select="normalize-space(Field13)"/>
                        </src_amount>
                        <amt>
                            <xsl:value-of select="normalize-space(Field14)"/>
                        </amt>
                        <tax_amt>
                            <xsl:value-of select="normalize-space(Field20)"/>
                        </tax_amt>
                        <tax_incl>
                            <xsl:value-of select="normalize-space(Field35)"/>
                        </tax_incl>
                        <src_cur_cd>
                            <xsl:value-of select="normalize-space(Field15)"/>
                        </src_cur_cd>
                        <exch_rate>
                        <xsl:value-of select="normalize-space(Field63)"/>
                        </exch_rate>
                        <bill_cur_cd>
                            <xsl:value-of select="normalize-space(Field19)"/>
                        </bill_cur_cd>
                        <trans_type_cd>
                            <xsl:value-of select="normalize-space(Field17)"/>
                        </trans_type_cd>
                        <supp_ref>
                            <xsl:value-of select="normalize-space(Field6)"/>
                        </supp_ref>
                        <Purch_Ord_Num>
                            <xsl:value-of select="normalize-space(Field26)"/>
                        </Purch_Ord_Num>
                        <mer_name>
                            <xsl:value-of select="translate(normalize-space(Field8),$RemoveSpecialChar,' ')"/> 
                        </mer_name>
                        <mer_city>
                            <xsl:value-of select="normalize-space(Field9)"/>
                        </mer_city>
                        <mer_state>    
                            <xsl:value-of select="normalize-space(Field10)"/>
                        </mer_state>
                        <mer_country>    
                            <xsl:value-of select="normalize-space(Field11)"/>
                        </mer_country>
                        <charge_desc>
                            <xsl:value-of select="translate(normalize-space(Field32),$RemoveSpecialChar,' ')"/> 
                        </charge_desc>
                        <corp_account>
                            <xsl:value-of select="normalize-space(Field42)"/>
                        </corp_account>
                       </Record_05>
                    </xsl:if>
                    
                     <xsl:if test="$record.type = '07'"> 
                         <Record_07> 
                          
                         <Key_07> 
                             <xsl:value-of select="normalize-space(substring(Field1,11,6))"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field2)"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field3)"/><xsl:text>-</xsl:text><xsl:value-of select="normalize-space(Field4)"/> 
                         </Key_07> 
                         <acct_num> 
                             <xsl:value-of select="normalize-space(substring(Field1,13,4))"/> 
                         </acct_num> 
                          <acct_num_6digits> 
                             <xsl:value-of select="normalize-space(substring(Field1,11,6))"/> 
                         </acct_num_6digits> 
                         <post_date> 
                             <xsl:value-of select="normalize-space(Field2)"/> 
                         </post_date> 
                         <trans_num> 
                             <xsl:value-of select="normalize-space(Field3)"/> 
                         </trans_num> 
                         <seq_num> 
                         <xsl:value-of select="normalize-space(Field4)"/> 
                         </seq_num> 
                         <item_seq> 
                             <xsl:value-of select="normalize-space(Field5)"/> 
                         </item_seq> 
                         <Purc_item_line_num> 
                             <xsl:value-of select="translate(normalize-space(Field20),$RemoveSpecialChar,' ')"/> 
                         </Purc_item_line_num> 
                         <item_desc> 
                             <xsl:value-of select="translate(normalize-space(Field8),$RemoveSpecialChar,' ')"/>  
                         </item_desc> 
                          <UPC> 
                             <xsl:value-of select="translate(normalize-space(Field7),$RemoveSpecialChar,' ')"/>  
                         </UPC> 
                         <product_code> 
                             <xsl:value-of select="translate(normalize-space(Field18),$RemoveSpecialChar,' ')"/> 
                         </product_code> 
                         <item_quantity> 
                             <xsl:value-of select="normalize-space(Field9)"/> 
                         </item_quantity> 
                         <measure_code> 
                             <xsl:value-of select="normalize-space(Field11)"/> 
                         </measure_code> 
                         <unit_cost> 
                             <xsl:value-of select="normalize-space(Field10)"/> 
                         </unit_cost> 
                         <Ext_Amt> 
                             <xsl:value-of select="normalize-space(Field17)"/> 
                         </Ext_Amt> 
                         <Tax_Rate> 
                             <xsl:value-of select="normalize-space(Field15)"/> 
                         </Tax_Rate> 
                         <unit_tax> 
                             <xsl:value-of select="normalize-space(Field12)"/> 
                         </unit_tax> 
                         <unit_discnt> 
                             <xsl:value-of select="normalize-space(Field16)"/> 
                         </unit_discnt>
                         </Record_07> 
                     </xsl:if>       
                    
<!--                     <xsl:if test="$record.type = '09'"> -->
<!--                          <Processor_Key_09> -->
<!--                             <xsl:value-of select="normalize-space(Field32)"/> -->
<!--                         </Processor_Key_09> -->
<!--                         <lodging_nts> -->
<!--                             <xsl:value-of select="normalize-space(Field22)"/> -->
<!--                         </lodging_nts> -->
<!--                         <ticket_num> -->
<!--                             <xsl:value-of select="normalize-space(Field9)"/> -->
<!--                         </ticket_num> -->
<!--                         <arrvl_dt> -->
<!--                         	<xsl:value-of select="normalize-space(Field6)"/> -->
<!--                         </arrvl_dt> -->
<!--                         <daily_rt> -->
<!--                         	<xsl:value-of select="normalize-space(Field7)"/> -->
<!--                         </daily_rt> -->
<!--                     </xsl:if> -->
                    
<!--                     <xsl:if test="$record.type = '14'"> -->
<!--                         <Processor_Key_14> -->
<!--                             <xsl:value-of select="normalize-space(Field25)"/> -->
<!--                         </Processor_Key_14> -->
<!--                         <trans_num> -->
<!--                             <xsl:value-of select="normalize-space(Field3)"/> -->
<!--                         </trans_num> -->
<!--                         <ticket_num> -->
<!--                             <xsl:value-of select="normalize-space(Field9)"/> -->
<!--                         </ticket_num> -->
<!--                     </xsl:if> -->
                    
<!--                     <xsl:if test="$record.type = '15'"> -->
<!--                         <Processor_Key_15> -->
<!--                             <xsl:value-of select="normalize-space(Field25)"/> -->
<!--                         </Processor_Key_15> -->
<!--                         <trans_num> -->
<!--                             <xsl:value-of select="normalize-space(Field3)"/> -->
<!--                         </trans_num> -->
<!--                         <domestic_ind> -->
<!--                             <xsl:value-of select="normalize-space(Field26)"/> -->
<!--                         </domestic_ind> -->
<!--                         <carrier_code> -->
<!--                             <xsl:value-of select="normalize-space(Field7)"/> -->
<!--                         </carrier_code> -->
<!--                         <service_class> -->
<!--                             <xsl:value-of select="normalize-space(Field8)"/> -->
<!--                         </service_class> -->
<!--                         <carrier_ref> -->
<!--                         	<xsl:value-of select="normalize-space(Field13)"/> -->
<!--                         </carrier_ref> -->
<!--                     </xsl:if> -->
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