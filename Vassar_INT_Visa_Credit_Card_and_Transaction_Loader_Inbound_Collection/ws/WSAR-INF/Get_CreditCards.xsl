<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
<!--     <xsl:variable name="root" select="/CorporateEntity"/> -->
    <xsl:param name="CorporateAccountNumber"/>
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Get_Expense_Credit_Cards_Request xmlns:wd="urn:com.workday/bsvc"
                    wd:version="v26.1">
                    <wd:Request_Criteria>
                        <wd:Corporate_Credit_Card_Account_Reference>

<!--                                 <wd:ID wd:type="Corporate_Credit_Card_Account_ID"> <xsl:value-of select="$CorporateAccountNumber"/> </wd:ID> -->

                        </wd:Corporate_Credit_Card_Account_Reference>
                    </wd:Request_Criteria>
                     <wd:Response_Filter>
                     <wd:Count>999</wd:Count>
                    </wd:Response_Filter>
                    
                </wd:Get_Expense_Credit_Cards_Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>
</xsl:stylesheet>