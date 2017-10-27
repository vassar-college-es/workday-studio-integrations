<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mx="meteorix">

	<xsl:param name="emp_id" />
	
	<xsl:template match="/">

		<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
			xmlns:xsd="http://www.w3.org/2001/XMLSchema">
			<env:Body>
				<wd:Get_Payroll_Results_Request
					xmlns:wd="urn:com.workday/bsvc" wd:version="v26.0">
					<wd:Request_Criteria>
						<wd:Employee_Reference>
							<wd:ID wd:type="Employee_ID">
								<xsl:value-of select="$emp_id" />
							</wd:ID>
						</wd:Employee_Reference>
						<wd:Period_Selection_Date_Reference>
							<wd:ID wd:type="Period_Date_Indicator">Based On Completed Date</wd:ID>
						</wd:Period_Selection_Date_Reference>
						<wd:Start_Date>
							<xsl:value-of
								select="format-dateTime(current-dateTime() - xs:dayTimeDuration('P90D'), '[Y0001]-[M01]-[D01]')" />
						</wd:Start_Date>
						<wd:End_Date>
							<xsl:value-of
								select="format-dateTime(current-dateTime() + xs:dayTimeDuration('P30D'), '[Y0001]-[M01]-[D01]')" />
						</wd:End_Date>
					</wd:Request_Criteria>
					<wd:Response_Filter>
						<wd:As_Of_Effective_Date>
							<xsl:value-of select="xs:date" />
						</wd:As_Of_Effective_Date>
						<wd:As_Of_Entry_DateTime>
							<xsl:value-of select="xs:dateTime" />
						</wd:As_Of_Entry_DateTime>
						<wd:Page>1</wd:Page>
						<wd:Count>100</wd:Count>
					</wd:Response_Filter>
					<wd:Response_Group>
						<wd:Include_Name_Data>false</wd:Include_Name_Data>
						<wd:Include_National_ID_Data>false</wd:Include_National_ID_Data>


					</wd:Response_Group>
				</wd:Get_Payroll_Results_Request>
			</env:Body>
		</env:Envelope>
	</xsl:template>
</xsl:stylesheet>