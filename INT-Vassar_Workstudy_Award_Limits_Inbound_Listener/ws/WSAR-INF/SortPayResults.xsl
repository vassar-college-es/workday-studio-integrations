<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
	xmlns:xdiff="urn:com.workday/esb/xdiff" xmlns:wd="urn:com.workday/bsvc"
	xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:this="urn.com.workday/this" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output indent="yes" method="xml" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<wd:root>
			<xsl:for-each select="/env:Envelope/env:Body/wd:Get_Payroll_Results_Response/wd:Response_Data/wd:Payroll_Result">

				<xsl:sort select="wd:Period_End_Date" order="descending" />

				<xsl:if test="not(wd:Off-cycle_Type_Reference)">
				
					<wd:PayPeriodEndDate>
						<xsl:value-of select="wd:Period_End_Date" />
					</wd:PayPeriodEndDate>
				
					<wd:NextPayPeriodStartDate>
						<xsl:value-of select="xs:date(wd:Period_End_Date) + xs:dayTimeDuration('P1D')" />
					</wd:NextPayPeriodStartDate>
					
				</xsl:if>

			</xsl:for-each>
		</wd:root>

	</xsl:template>

</xsl:stylesheet>
