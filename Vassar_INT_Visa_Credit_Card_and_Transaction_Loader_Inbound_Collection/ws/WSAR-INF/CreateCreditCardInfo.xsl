<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="xsl this xsd"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wd="urn:com.workday/bsvc"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:this="urn:this-stylesheet">
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:param name="CreditCardState"/>
    <xsl:param name="CorporateAccountNumber"/>
    <xsl:param name="CC.empid"/>
    <xsl:param name="CC.firstname"/>
    <xsl:param name="CC.lastname"/>
    <xsl:param name="CorpBillingCurrCode"/>
    <xsl:param name="rec03.acct_num_token"/>
    <xsl:param name="rec03.acct_num_token05"/>
    <xsl:param name="CC.expire.date"/>
    <xsl:param name="CC.spending_limit"/>
    <xsl:param name="ExpenseCreditCardID"/>
    <xsl:param name="CC.status.date"/>
    <xsl:param name="CC.status_code"/>
    
    
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Put_Expense_Credit_Card_Request xmlns:wd="urn:com.workday/bsvc" wd:Add_Only="1"
                    wd:version="v26.1">
                 
                        <wd:Expense_Credit_Card_Data>
                        
                        	
                        	
                            <wd:Corporate_Credit_Card_Account_Reference>
                                <!--Zero or more repetitions:-->
                                <wd:ID wd:type="Corporate_Credit_Card_Account_ID">
                                    <xsl:value-of select="$CorporateAccountNumber"/>
                                </wd:ID>
                            </wd:Corporate_Credit_Card_Account_Reference>
                           
                            <wd:Employee_Reference wd:Descriptor="Employee_ID">
                                <wd:ID wd:type="Employee_ID">
                                    <xsl:value-of select="$CC.empid"/></wd:ID>
                            </wd:Employee_Reference>
                            
                            <wd:Credit_Card_Description><xsl:value-of select="$rec03.acct_num_token05"/></wd:Credit_Card_Description>
                            
                            
                            <wd:Last_4_Digits_of_Credit_Card_Number>
                                <xsl:value-of select="Record_03/acct_num"/>
                            </wd:Last_4_Digits_of_Credit_Card_Number>
                            
                            <wd:Credit_Card_Expiration_Date>
                            	 <xsl:value-of select="substring($CC.expire.date,5,4)"/>
                                 <xsl:text>-</xsl:text>
                                 <xsl:value-of select="substring($CC.expire.date,1,2)"/>
                                 <xsl:text>-</xsl:text>
                                 <xsl:value-of select="substring($CC.expire.date,3,2)"/>
                            </wd:Credit_Card_Expiration_Date>
                             
                            <wd:Monthly_Limit>
                                <xsl:value-of select="$CC.spending_limit" />  
                            </wd:Monthly_Limit>
                            
                            <wd:Transaction_Limit>
                                <xsl:value-of select="$CC.spending_limit" />  
                            </wd:Transaction_Limit>
                            
<!--                              <wd:Billing_Currency_Reference> -->
<!--                                 <wd:ID wd:type="Currency_Numeric_Code"> -->
<!--                                     <xsl:value-of -->
<!--                                         select="$CorpBillingCurrCode"/> -->
<!--                                 </wd:ID> -->
<!--                             </wd:Billing_Currency_Reference> -->
                            
                            <wd:Cancel_Date>
                                <xsl:if
                                    test="$CC.status_code = '3'">
<!--                                     <xsl:value-of select="Record_03/status_date"/> -->
                                     <xsl:value-of select="substring($CC.status.date,5,4)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring($CC.status.date,1,2)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring($CC.status.date,3,2)"/>
                                </xsl:if>
                            </wd:Cancel_Date>
                            
                            <wd:Cardmember_Embossed_Name>
                                <xsl:value-of
                                    select="$CC.firstname"/><xsl:text> </xsl:text><xsl:value-of select="$CC.lastname"/>
                            </wd:Cardmember_Embossed_Name>
                            
                            <wd:Document_Status_Reference>
                                <wd:ID wd:type="Document_Status_ID">
                                    <xsl:value-of select="$CreditCardState"/>
                                </wd:ID>
                            </wd:Document_Status_Reference>
                        
							                   
                        </wd:Expense_Credit_Card_Data>
         
                </wd:Put_Expense_Credit_Card_Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>   
</xsl:stylesheet>