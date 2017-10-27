<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
    xmlns:xdiff="urn:com.workday/esb/xdiff" xmlns:wd="urn:com.workday/bsvc"
    xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:this="urn.com.workday/this" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output indent="yes" method="xml" />
    <xsl:strip-space elements="*" />
    
    <xsl:param name="benefit_plan"/>
    
    
    <xsl:template match="/">
        <wd:root>
            <xsl:for-each select="wd:Get_Benefit_Individual_Rates_Response/wd:Response_Data/wd:Benefit_Individual_Rate">
                
               <xsl:sort select="position()" order="descending" />
              <!--    <xsl:sort select="wd:Benefit_Individual_Rate_Data/wd:Benefit_Individual_Rate_ID" order="descending" /> --> <!-- ascending or descending? niether seem to get most recent -->
                     
                <xsl:if test="contains(wd:Benefit_Individual_Rate_Reference/@wd:Descriptor, $benefit_plan)">
                	<wd:Benefit_Individual_Rate_ID>
                        <xsl:value-of select="wd:Benefit_Individual_Rate_Data/wd:Benefit_Individual_Rate_ID"/>
                    </wd:Benefit_Individual_Rate_ID>
                    <wd:Employee_PostTax_Amount>
                        <xsl:value-of select="wd:Benefit_Individual_Rate_Data/wd:Employee_PostTax_Amount"/>
                    </wd:Employee_PostTax_Amount>                
                </xsl:if>  
                
            </xsl:for-each>
        </wd:root>
        
    </xsl:template>
    
</xsl:stylesheet>