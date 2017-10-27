<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="xsl this xsd"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wd="urn:com.workday/bsvc"
    xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:this="urn:this-stylesheet">
    <xsl:output indent="yes" method="xml"/>
    
    <!-- the following variables are populated during the higher level XML splits-->
    <xsl:param name="file.number"/>
    <xsl:param name="current.date"/>
    <xsl:param name="file.name.no.extension"/>
    
    <xsl:variable name="root" select="wd:Transactions/wd:Expense_Credit_Card_Transaction_File_Data"/>
    
    <!-- XSLT Entry Point Match -->
    <xsl:template match="/">
        
        <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Credit_Card_Transaction_Header__HV__Request xmlns:wd="urn:com.workday/bsvc"
                    wd:Add_Only="false" wd:version="v26.1">
                    <wd:Expense_Credit_Card_Transaction_File_Data>
                        <wd:File_Number>
                            <xsl:value-of select="$file.number"/>
                        </wd:File_Number>
                        <wd:File_Name>
                            <xsl:value-of select="$file.name.no.extension"/>
                        </wd:File_Name>
                        <wd:Report_Create_Date>
                            <xsl:value-of select="$current.date"/>
                        </wd:Report_Create_Date>
                        <wd:Credit_Card_Type_Reference>
                            <wd:ID wd:type="Credit_Card_Type_ID">VISA</wd:ID>
                        </wd:Credit_Card_Type_Reference>
                        
                        <xsl:for-each select="$root/wd:Expense_Credit_Card_Transaction_Data">
                            <xsl:copy>
                                <xsl:apply-templates/>
                            </xsl:copy>
                        </xsl:for-each>                        
                    </wd:Expense_Credit_Card_Transaction_File_Data>
                </wd:Credit_Card_Transaction_Header__HV__Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>

    <xsl:template match="* | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>