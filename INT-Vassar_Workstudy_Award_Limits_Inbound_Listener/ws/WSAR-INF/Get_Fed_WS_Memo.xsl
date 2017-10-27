<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mx="meteorix.com" version="2.0">
    
    <xsl:param name="emp_id"/>
    <xsl:param name="federal_ws_memo_code"/>
    <xsl:param name="award_period_start_date"/>
    <xsl:param name="award_period_end_date"/>
    
    <xsl:param name="input"/>
    <xsl:param name="award_start_date"/>
    <xsl:param name="award_end_date"/>
    <xsl:param name="is_award_current_year"/>
    
    <xsl:template match="/">
        
        <env:Envelope
            xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Get_Submit_Payroll_Inputs_Request
                    xmlns:wd="urn:com.workday/bsvc"
                    wd:version="v26.0">
                    <wd:Request_Criteria>
                        <wd:Worker_Reference>
                            <wd:ID wd:type="Employee_ID"><xsl:value-of select="$emp_id"/></wd:ID>
                        </wd:Worker_Reference>
                        
                        <wd:Earning_Reference>
                            <wd:ID wd:type="Earning_Code"><xsl:value-of select="$federal_ws_memo_code"/></wd:ID>
                        </wd:Earning_Reference>
                        
                        <!--  
                        <xsl:choose>
                        	<xsl:when test="$is_award_current_year">
                        		<wd:Start_Date><xsl:value-of  select="current-date()"/></wd:Start_Date>
                        	</xsl:when>
                        	<xsl:otherwise>
                        		<wd:Start_Date><xsl:value-of  select="xsd:date($award_start_date)"/></wd:Start_Date>
                        	</xsl:otherwise>
                        </xsl:choose>
                        -->
                        
                        <xsl:choose>
                        	<xsl:when test="$is_award_current_year">
                        		<wd:Start_Date><xsl:value-of  select="current-date()"/></wd:Start_Date>
                        	</xsl:when>
                        	<xsl:otherwise>
                        		<wd:Start_Date><xsl:value-of  select="xsd:date(mx:formatDate($award_period_start_date))"/></wd:Start_Date>
                        	</xsl:otherwise>
                        </xsl:choose>
                        
                        <!--
                        <wd:Start_Date><xsl:value-of  select="xsd:date(mx:formatDate($award_period_start_date))"/></wd:Start_Date>
                        -->
                        
                       <xsl:choose>
                       		<xsl:when test="xsd:date(mx:formatDate($award_period_start_date)) = xsd:date(mx:formatDate($award_period_end_date))">
                        		<wd:End_Date><xsl:value-of  select="xsd:date(mx:formatDate($award_period_start_date)) + xsd:yearMonthDuration('P1Y') - xsd:dayTimeDuration('P1D')"/></wd:End_Date>
                        	</xsl:when>
                        	<xsl:otherwise>
                        		<wd:End_Date><xsl:value-of  select="xsd:date(mx:formatDate($award_period_end_date))"/></wd:End_Date>
                        	</xsl:otherwise>
                       	</xsl:choose>
                        
                        <wd:Open-Ended_Ongoing_Inputs>false</wd:Open-Ended_Ongoing_Inputs >
                        
                       
                                                             
                    </wd:Request_Criteria>
                </wd:Get_Submit_Payroll_Inputs_Request>
            </env:Body>
        </env:Envelope>
        
    </xsl:template>
    
    <xsl:function name="mx:formatDate">
        <xsl:param name="inDate" />
        
        <xsl:variable name="month">
            <xsl:value-of select="substring-before($inDate,'/')"/>
        </xsl:variable>
        <xsl:variable name="dayandyear">
            <xsl:value-of select="substring-after($inDate,'/' )"/>
        </xsl:variable>
        <xsl:variable name="day">
            <xsl:value-of select="substring-before($dayandyear,'/' )"/>
        </xsl:variable>
        <xsl:variable name="year">
            <xsl:value-of select="substring-after($dayandyear,'/' )"/>
        </xsl:variable>
        
        <xsl:variable name="mm">
            <xsl:choose>
            <xsl:when test="$month &lt; 10">
                <xsl:value-of select="concat('0',$month)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$month"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dd">
            <xsl:choose>
                <xsl:when test="$day &lt; 10">
                    <xsl:value-of select="concat('0',$day)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$day"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        
        <xsl:value-of select="concat($year,'-',$mm,'-',$dd)" />        
        
    </xsl:function>
        
</xsl:stylesheet>