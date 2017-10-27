<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:mx="meteorix">
    
    <xsl:output indent="yes" method="xml" />
    
    <xsl:param name="effective_date"/>
    <xsl:param name="benefit_plan_id"/>
    <xsl:param name="benefit_event"/>
    <xsl:param name="empl_id"/>
    <xsl:param name="insurance_coverage_level_WID"/>
    
        
    <xsl:template match="/">
        <env:Envelope
            xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Change_Benefits_Request
                    xmlns:wd="urn:com.workday/bsvc"
                    wd:Add_Only="true"
                    wd:version="v26.2">
                    <wd:Business_Process_Parameters>
                        <wd:Auto_Complete>true</wd:Auto_Complete>
                        <wd:Run_Now>true</wd:Run_Now>
                    </wd:Business_Process_Parameters>
                    <wd:Change_Benefits_Data>
                        <wd:Employee_Reference>
                            <wd:ID wd:type="Employee_ID">
                                <xsl:value-of select="$empl_id"/>
                            </wd:ID>
                        </wd:Employee_Reference>
                        <wd:Benefit_Event_Type_Reference>
                            <wd:ID wd:type="Benefit_Event_Type_ID">
                                <xsl:value-of select="$benefit_event"/>
                            </wd:ID>
                        </wd:Benefit_Event_Type_Reference>
                        <wd:Event_Date>
                            <xsl:value-of select="$effective_date"/>
                        </wd:Event_Date>
                        
                        <wd:Benefit_Election_Data>
                            <wd:Coverage_Begin_Date>
                                <xsl:value-of select="$effective_date"/>
                            </wd:Coverage_Begin_Date>
                            <wd:Deduction_Begin_Date>
                                <xsl:value-of select="$effective_date"/>
                            </wd:Deduction_Begin_Date>
                            
                            <wd:Insurance_Election_Data>
                                <wd:Insurance_Coverage_Plan_Reference>
                                    <wd:ID wd:type="Insurance_Coverage_Plan_ID">
                                        <xsl:value-of select="$benefit_plan_id"/>
                                    </wd:ID>
                                </wd:Insurance_Coverage_Plan_Reference>
                                <wd:Coverage_Amount_Reference>
                                    <!--Insurance Election -> Coverage Level -> WID-->
                                    <wd:ID wd:type="WID">
                                        <xsl:value-of select="$insurance_coverage_level_WID"/>
                                    </wd:ID>
                                </wd:Coverage_Amount_Reference>
                            </wd:Insurance_Election_Data>
                            
                            
                            
                        </wd:Benefit_Election_Data>       
                    </wd:Change_Benefits_Data>
                </wd:Change_Benefits_Request>
            </env:Body>
        </env:Envelope>
        
    </xsl:template>
    
    <!--  
    <xsl:function name="mx:formatEffectiveDate">
        <xsl:param name="inputDate"/>
                
        <xsl:variable name="year" select="concat('20', substring($inputDate, 7, 2))"/>
        <xsl:variable name="month" select="substring($inputDate, 1, 2)"/>
        <xsl:variable name="day" select="substring($inputDate, 4, 2)"/>
                
        <xsl:value-of select="concat($year, '-', $month, '-', $day)"/>
        
    </xsl:function> -->
    
</xsl:stylesheet>