<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:mx="meteorix.com">
    
    <xsl:param name="emp_id"/>    
    <xsl:param name="period_end_date"/>
    <xsl:param name="award_period_start_date"/>
    <xsl:param name="award_category"/>
    <xsl:param name="ws_effective_date"/>
    <xsl:param name="emp_hire_date"/>
    
    
    <xsl:template match="/">
        
        <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            xmlns:cus="urn:com.workday/tenants/super/data/custom">
            <env:Body>
                <wd:Edit_Worker_Additional_Data_Request xmlns:wd="urn:com.workday/bsvc"
                    wd:version="v27.2">
                    <wd:Business_Process_Parameters>
                        <wd:Auto_Complete>true</wd:Auto_Complete>
                        <wd:Run_Now>true</wd:Run_Now>
                        <!--<wd:Comment_Data>
                    <!-\-<wd:Comment>abcdef</wd:Comment>-\->
                    <wd:Worker_Reference>
                        <wd:ID wd:type="Employee_ID">00000175</wd:ID>
                    </wd:Worker_Reference>
                </wd:Comment_Data>-->
                        <!--<wd:Business_Process_Attachment_Data>
                    <wd:File_Name>abcdef</wd:File_Name>
                    <wd:Event_Attachment_Description>abcdef</wd:Event_Attachment_Description>
                    <wd:Event_Attachment_Category_Reference>
                        <wd:ID wd:type="Document_Category__Workday_Owned__ID">abcdef</wd:ID>
                    </wd:Event_Attachment_Category_Reference>
                    <wd:File>base64Binary</wd:File>
                    <wd:Content_Type>abcdef</wd:Content_Type>
                </wd:Business_Process_Attachment_Data>-->
                    </wd:Business_Process_Parameters>
                    <wd:Worker_Custom_Object_Data>                                                
                        <xsl:choose>
                            <xsl:when test="$ws_effective_date != ''">
                                <wd:Effective_Date><xsl:value-of  select="$ws_effective_date"/></wd:Effective_Date>
                            </xsl:when>
                            <xsl:when test="$period_end_date != '' and $period_end_date &gt; mx:formatDate($award_period_start_date)">
                                <wd:Effective_Date><xsl:value-of  select="xsd:date($period_end_date) + xsd:dayTimeDuration('P1D')"/></wd:Effective_Date>
                            </xsl:when>
                            <xsl:when test="$ws_effective_date = '' and mx:formatDate($award_period_start_date) &lt; $emp_hire_date">
                                <wd:Effective_Date><xsl:value-of  select="$emp_hire_date"/></wd:Effective_Date>                        
                            </xsl:when>
                            <xsl:otherwise>
                                <wd:Effective_Date><xsl:value-of  select="xsd:date(mx:formatDate($award_period_start_date))"/></wd:Effective_Date>
                            </xsl:otherwise>
                        </xsl:choose>             
                        
                        <wd:Worker_Reference>
                            <wd:ID wd:type="Employee_ID">
                                <xsl:value-of select="$emp_id"/>                            
                            </wd:ID>
                        </wd:Worker_Reference>
                        <wd:Business_Object_Additional_Data>
                            <cus:studentWorkStudyStatus>
                                <cus:workStudyStatus>
                                    <cus:ID cus:type="ExtendedAlias">
                                        <xsl:if test="$award_category = 'CWS'">
                                            <xsl:text>federalWorkStudy</xsl:text>                                            
                                        </xsl:if>
                                        <xsl:if test="$award_category = 'ISEP'">
                                            <xsl:text>institutionalWorkStudy</xsl:text>
                                        </xsl:if>
                                        <xsl:if test="$award_category = 'NONE'">
                                            <xsl:text>nonWorkStudy</xsl:text>
                                        </xsl:if>       
                                    </cus:ID>
                                </cus:workStudyStatus>
                            </cus:studentWorkStudyStatus>
                        </wd:Business_Object_Additional_Data>
                    </wd:Worker_Custom_Object_Data>
                </wd:Edit_Worker_Additional_Data_Request>
            </env:Body>
        </env:Envelope>
        
        
    </xsl:template>
    
    <xsl:function name="mx:formatDate">
        <xsl:param name="inDate"/>
        
        <xsl:variable name="month">
            <xsl:value-of select="substring-before($inDate, '/')"/>
        </xsl:variable>
        <xsl:variable name="dayandyear">
            <xsl:value-of select="substring-after($inDate, '/')"/>
        </xsl:variable>
        <xsl:variable name="day">
            <xsl:value-of select="substring-before($dayandyear, '/')"/>
        </xsl:variable>
        <xsl:variable name="year">
            <xsl:value-of select="substring-after($dayandyear, '/')"/>
        </xsl:variable>
        
        <xsl:variable name="mm">
            <xsl:choose>
                <xsl:when test="$month &lt; 10">
                    <xsl:value-of select="concat('0', $month)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$month"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dd">
            <xsl:choose>
                <xsl:when test="$day &lt; 10">
                    <xsl:value-of select="concat('0', $day)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$day"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        
        <xsl:value-of select="concat($year, '-', $mm, '-', $dd)"/>
        
    </xsl:function>
    
</xsl:stylesheet>
