<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0"
    xmlns:mx="meteorix">
    
    <xsl:param name="emp_id"/>
    <xsl:param name="fed_ws_memo_input_amount"/>
    <xsl:param name="fed_ws_memo_input_earning_code"/>
    <xsl:param name="fed_ws_memo_recent_pay_input_id"/>
    <xsl:param name="fed_ws_memo_input_recent_start_date"/> 
    <xsl:param name="run_category"/>
    <xsl:param name="period_end_date"/>
    
    
    <xsl:template match="/">
        
        <env:Envelope
            xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Submit_Payroll_Input_Request
                    xmlns:wd="urn:com.workday/bsvc"
                    wd:version="v26.0">
                    <wd:Payroll_Input_Data>
                        
                        <wd:Payroll_Input_ID > 
                            <xsl:value-of select="$fed_ws_memo_recent_pay_input_id"/>
                        </wd:Payroll_Input_ID >
                        
                        <wd:Batch_ID> 
                            <xsl:value-of select="concat('WSBatch',format-dateTime(current-dateTime(),'[Y01][M01][D01]'))"/>
                        </wd:Batch_ID>
                        
                        <wd:Ongoing_Input>true</wd:Ongoing_Input>
                        
                        <wd:Start_Date>
                            <xsl:value-of select="$fed_ws_memo_input_recent_start_date"/>
                        </wd:Start_Date>
                        
                                             
                          
                        <xsl:choose>
                            <xsl:when test="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]')  &gt; $fed_ws_memo_input_recent_start_date and $period_end_date &gt; $fed_ws_memo_input_recent_start_date">
                              <!--
                                <wd:End_Date>
                                    <xsl:value-of select="current-dateTime()"/>
                                </wd:End_Date>
                               -->
                                <wd:End_Date>
                                	<xsl:value-of select="$period_end_date"/>
                                </wd:End_Date>
                            </xsl:when>
                            <xsl:otherwise>
                                <wd:End_Date>
                                    <xsl:value-of select="$fed_ws_memo_input_recent_start_date"/>
                                </wd:End_Date>
                            </xsl:otherwise>
                        </xsl:choose>
                       
                        
                        <wd:Run_Category_Reference>
                            <wd:ID wd:type="Run_Category_ID">
                                <xsl:value-of select="$run_category"/>
                            </wd:ID>
                        </wd:Run_Category_Reference>
                        
                        <wd:Worker_Reference>
                            <wd:ID wd:type="Employee_ID"><xsl:value-of select="$emp_id"/></wd:ID>
                        </wd:Worker_Reference>
                        
                        <wd:Earning_Reference>
                            <wd:ID wd:type="Earning_Code"><xsl:value-of select="$fed_ws_memo_input_earning_code" /></wd:ID>
                        </wd:Earning_Reference>
                        
                        <wd:Amount><xsl:value-of select="$fed_ws_memo_input_amount"/></wd:Amount>
                                                
                        
                        <wd:Adjustment>false</wd:Adjustment>
                        
                    </wd:Payroll_Input_Data>
                </wd:Submit_Payroll_Input_Request>
            </env:Body>
        </env:Envelope>
        
    </xsl:template>        
</xsl:stylesheet>