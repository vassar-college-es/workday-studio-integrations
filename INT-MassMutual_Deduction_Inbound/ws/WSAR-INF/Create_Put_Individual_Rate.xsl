<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:mx="meteorix">
    
    <xsl:output indent="yes" method="xml" />
    
    <xsl:param name="ee_contrib"/>
    <xsl:param name="current_indiv_rate_id"/>
    
    <xsl:template match="/">
        <env:Envelope
            xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Put_Benefit_Individual_Rate_Request
                    xmlns:wd="urn:com.workday/bsvc"
                    wd:version="v26.2">
                    <wd:Benefit_Individual_Rate_Reference>
                        <wd:ID wd:type="Benefit_Individual_Rate_ID">
                            <xsl:value-of select="$current_indiv_rate_id"/>
                        </wd:ID>
                    </wd:Benefit_Individual_Rate_Reference>
                    <wd:Benefit_Individual_Rate_Data>
                        <wd:Benefit_Individual_Rate_ID>
                            <xsl:value-of select="$current_indiv_rate_id"/>
                        </wd:Benefit_Individual_Rate_ID>
                          
              
                        
                   
                        
                       <wd:Employee_PostTax_Amount>
                            <xsl:value-of select="$ee_contrib"/>
                        </wd:Employee_PostTax_Amount>
                     
                        
                    </wd:Benefit_Individual_Rate_Data>
                </wd:Put_Benefit_Individual_Rate_Request>
            </env:Body>
        </env:Envelope>   
    </xsl:template>
   
</xsl:stylesheet>