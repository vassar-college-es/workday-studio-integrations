<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
    xmlns:wd="urn:com.workday/bsvc">
    <xsl:output indent="no" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="record.four.first"/>
    <xsl:param name="record.four.last"/>
    <xsl:param name="record.four.empid"/>
    <xsl:param name="record.four.cc_num"/>
    <xsl:param name="transaction.file"/>
    <xsl:param name="CorpAccount"/>

    
    <xsl:param name="file.number"/>
    <xsl:param name="current.date"/>
    <xsl:param name="file.name.no.extension"/>
    
    
    
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

    <!-- Transaction Data -->
                        <wd:Expense_Credit_Card_Transaction_Data>
                            <wd:Transaction_Number>
<!--                                 <xsl:value-of select="File/Record_05/trans_num"/>  -->
                                <xsl:value-of select="File/Record_05/Key_05"/>
                            </wd:Transaction_Number>
                            
                            <wd:Transaction_Date>
                                <xsl:value-of select="substring(File/Record_05/trans_date,5,4)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/trans_date,1,2)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/trans_date,3,2)"/>
                            </wd:Transaction_Date>
                            
                            <wd:Billing_Date>
                                <xsl:value-of select="substring(File/Record_05/post_date,5,4)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/post_date,1,2)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/post_date,3,2)"/>
                            </wd:Billing_Date>
                            
                            <wd:Posted_Date>
                                <xsl:value-of select="substring(File/Record_05/post_date,5,4)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/post_date,1,2)"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="substring(File/Record_05/post_date,3,2)"/>
                            </wd:Posted_Date>
                            
                            <wd:Merchant_Code><xsl:value-of select="File/Record_05/mer_cd"/></wd:Merchant_Code>
                            <wd:Market_Code><xsl:value-of select="File/Record_05/trans_type_cd"/></wd:Market_Code>  <!--    XXXXXXXXXXXXXXXXXXXXXX  LOGIC TO IMPLEMENT -->
                            <wd:Supplier_Reference_Number><xsl:value-of select="File/Record_05/supp_ref"/></wd:Supplier_Reference_Number>
                            <wd:DUNS_Number_for_Supplier></wd:DUNS_Number_for_Supplier>
                            
                            <!-- Evaluate the transaction type code . When even = transaction in debit When  odd  = transaction in credit (negative amounts) -->
                            <xsl:choose>
                                <xsl:when test= "File/Record_05/trans_type_cd mod 2 " >  
                                    <wd:Amount><xsl:value-of select='format-number(((File/Record_05/src_amount) div -100),"#.00" )' /></wd:Amount>    
                                    <wd:Tax_Amount><xsl:value-of select='format-number(((File/Record_05/tax_amt) div -100),"#.00" )' /></wd:Tax_Amount>                                
                                </xsl:when>
                                <xsl:otherwise> 
                                    <wd:Amount><xsl:value-of select='format-number(((File/Record_05/src_amount) div 100),"#.00" )' /></wd:Amount>  
                                    <wd:Tax_Amount><xsl:value-of select='format-number(((File/Record_05/tax_amt) div 100),"#.00" )' /></wd:Tax_Amount>
                                </xsl:otherwise>
                            </xsl:choose>   
                            
                            <wd:Sales_Taxes_Collected><xsl:value-of select="File/Record_05/tax_incl"/></wd:Sales_Taxes_Collected>
                            <wd:Source_Currency_Reference><wd:ID wd:type="Currency_Numeric_Code"><xsl:value-of select="number(File/Record_05/src_cur_cd)"/></wd:ID></wd:Source_Currency_Reference>
                            <wd:Currency_Exchange_Rate><xsl:value-of select="File/Record_05/exch_rate"/></wd:Currency_Exchange_Rate>  
                            
                            <!-- Evaluate the transaction type code . When even = transaction in debit When  odd  = transaction in credit (negative amounts) -->
                            <xsl:choose>
                                <xsl:when test= "File/Record_05/trans_type_cd mod 2 " >  
                                    <wd:Converted_Amount><xsl:value-of select='format-number(((File/Record_05/amt) div -100),"#.00" )' /></wd:Converted_Amount>  
                                    <wd:Converted_Tax_Amount><xsl:value-of select='format-number(((File/Record_05/tax_amt) div -100),"#.00" )'/></wd:Converted_Tax_Amount>
                                </xsl:when>
                                <xsl:otherwise>
                                    <wd:Converted_Amount><xsl:value-of select='format-number(((File/Record_05/amt) div 100),"#.00" )' /></wd:Converted_Amount>  
                                    <wd:Converted_Tax_Amount><xsl:value-of select='format-number(((File/Record_05/tax_amt) div 100),"#.00" )'/></wd:Converted_Tax_Amount>
                                </xsl:otherwise>
                            </xsl:choose> 
                            <wd:Converted_Currency_Reference>
                                <wd:ID wd:type="Currency_Numeric_Code"><xsl:value-of select="number(File/Record_05/bill_cur_cd)"/></wd:ID>
                            </wd:Converted_Currency_Reference>
                            
                            <wd:Transaction_Type_Code><xsl:value-of select="File/Record_05/trans_type_cd"/></wd:Transaction_Type_Code>                            
                             
                            <wd:Charge_Description_Line_1><xsl:value-of select="normalize-space(File/Record_05/mer_name)"/></wd:Charge_Description_Line_1>
                            
                            <wd:Charge_Description_Line_2></wd:Charge_Description_Line_2>
                            <wd:Cost_Center_Reference></wd:Cost_Center_Reference>
                            <wd:Purchase_Order_Number><xsl:value-of select="normalize-space(File/Record_05/Purch_Ord_Num)"/></wd:Purchase_Order_Number>
                            <wd:Release_Number></wd:Release_Number>
                            <wd:Expense_Credit_Card_Token></wd:Expense_Credit_Card_Token>
                            
                            <wd:Corporate_Account_Reference>
                                <!--  <wd:ID wd:type="Corporate_Credit_Card_Account_ID"><xsl:value-of select="normalize-space(File/Record_05/corp_account)"/></wd:ID>-->
                                <wd:ID wd:type="Corporate_Credit_Card_Account_ID"><xsl:value-of select="$CorpAccount"/></wd:ID>
                            </wd:Corporate_Account_Reference>
                            
                            <wd:Employee_ID><xsl:value-of select="$record.four.empid"/></wd:Employee_ID> 
                            <wd:Cardholder_Name><xsl:value-of select="normalize-space(concat($record.four.first, ' ', $record.four.last))"/></wd:Cardholder_Name>
                            <!-- <wd:Account_Number><xsl:value-of select="xxxxxxxxxxxx"/><xsl:value-of select="normalize-space(File/Record_05/acct_num)"/></wd:Account_Number> -->
                            <wd:Account_Number><xsl:value-of select="concat('xxxxxxxxxxxx', normalize-space(File/Record_05/acct_num))" /></wd:Account_Number>
                            
                            <wd:Charge_Description><xsl:value-of select="normalize-space(File/Record_05/charge_desc)"/></wd:Charge_Description>
                            
                            <!-- Hotel Stuff -->
                            <!-- <wd:Number_of_Days_or_Nights>12678967.54</wd:Number_of_Days_or_Nights> 
		                        <wd:Credit_Card_Merchant_Name><xsl:value-of select="normalize-space(mer_name)"/></wd:Credit_Card_Merchant_Name>
		                        <wd:Credit_Card_Merchant_Location><xsl:value-of select="normalize-space(mer_loc)"/></wd:Credit_Card_Merchant_Location>
                        		<wd:Arrival_Date>2013-09-09</wd:Arrival_Date>
		                		<wd:Departure_Date>2013-09-09</wd:Departure_Date>
		                		<wd:Reference_Number>abcdef</wd:Reference_Number>
		                		<wd:Participant_Name>abcdef</wd:Participant_Name>
		                		<wd:Daily_Rate>12678967.54</wd:Daily_Rate>-->
                            
                            <!-- Airline Stuff -->
                            <!--<wd:Domestic>true</wd:Domestic>
				                <wd:Ticket_Number>abcdef</wd:Ticket_Number>
				                <wd:Class_of_Service>abcdef</wd:Class_of_Service>
				                <wd:Air_Routing>abcdef</wd:Air_Routing>
				                <wd:Air_Carrier_Code>abcdef</wd:Air_Carrier_Code> -->
                            <wd:Origination_City><xsl:value-of select="normalize-space(File/Record_05/mer_city)"/></wd:Origination_City>
                            <wd:Origination_State><xsl:value-of select="normalize-space(File/Record_05/mer_state)"/></wd:Origination_State>
                            <wd:Origination_Country><xsl:value-of select="normalize-space(File/Record_05/mer_country)"/></wd:Origination_Country>
                            <wd:Destination_City><xsl:value-of select="normalize-space(File/Record_05/mer_city)"/></wd:Destination_City>
                            <wd:Destination_State><xsl:value-of select="normalize-space(File/Record_05/mer_state)"/></wd:Destination_State>
                            <wd:Destination_Country><xsl:value-of select="normalize-space(File/Record_05/mer_country)"/></wd:Destination_Country>
                            <!--<wd:Class_of_Service_Reference>
		                    		<wd:ID wd:type="Class_of_Service_Value">abcdef</wd:ID>
		                		</wd:Class_of_Service_Reference> -->
                            <wd:Credit_Card_Merchant_Name><xsl:value-of select="normalize-space(File/Record_05/mer_name)"/></wd:Credit_Card_Merchant_Name>
                            <wd:Credit_Card_Merchant_Location><xsl:value-of select="normalize-space(File/Record_05/mer_city)"/></wd:Credit_Card_Merchant_Location>
                            <!--<wd:Credit_Card_Transaction_Status_Reference>
		                            <wd:ID wd:type="Expense_Status_ID">NEW</wd:ID>
		                        </wd:Credit_Card_Transaction_Status_Reference>-->
                            
                            <!-- BEGIN  Credit_Card_Transaction_Line_Data -->
                            <xsl:for-each select="/File/wd:Credit_Card_Transaction_Line_Data">
                                <wd:Credit_Card_Transaction_Line_Data>
                                    <wd:Credit_Card_Transaction_Line_ID><xsl:value-of select="normalize-space(wd:Credit_Card_Transaction_Line_ID)"/></wd:Credit_Card_Transaction_Line_ID>
<!--                                     <wd:Purchase_Order_Line_Number><xsl:value-of select="normalize-space(wd:Purchase_Order_Line_Number)"/></wd:Purchase_Order_Line_Number>  -->
                                    
                                    <wd:Item_Description><xsl:value-of select="normalize-space(wd:Item_Description)"/></wd:Item_Description>
                                    <!--<wd:UNSPSC_code>12678967.54</wd:UNSPSC_code> -->
                                    <wd:UPC><xsl:value-of select="normalize-space(wd:UPC)"/></wd:UPC>
                                    <wd:Vendor_Part_Number><xsl:value-of select="normalize-space(wd:Vendor_Part_Number)"/></wd:Vendor_Part_Number>
                                    <wd:Quantity><xsl:value-of select="normalize-space(wd:Quantity)"/></wd:Quantity>
                                    <!--<wd:Unit_of_Measure_Reference>
			                        <wd:ID wd:type="UN_CEFACT_Common_Code_ID"><xsl:value-of select="normalize-space()"></wd:ID>
			                        </wd:Unit_of_Measure_Reference> -->
			                        
							<!--  Check Unit of Measure against Integration Map -->
						                    <xsl:variable name="uomValue"
				                                   	select="normalize-space(wd:Unit_of_Measure_Reference)"/>
				                    		<xsl:variable name="uomInternalValue"
				                    		select="is:integrationMapReverseLookup('creditcard_uom', $uomValue)"/> 
										
											<xsl:if test="$uomInternalValue != ''">
				                   <wd:Unit_of_Measure_Reference>
				                            		<wd:ID wd:type="UN_CEFACT_Common_Code_ID"><xsl:value-of select="$uomInternalValue"/></wd:ID>
				                   </wd:Unit_of_Measure_Reference> 
				                           
				                    	   </xsl:if>
				                    	   
				                    	   
<!-- 				                   <xsl:choose> -->
<!--                                            <xsl:when test="$uomInternalValue != ''"> -->
<!--                                                 <wd:Unit_of_Measure_Reference> -->
<!-- 				                            		<wd:ID wd:type="UN_CEFACT_Common_Code_ID"><xsl:value-of select="$uomInternalValue"/></wd:ID> -->
<!-- 				                                </wd:Unit_of_Measure_Reference>  -->
<!--                                            </xsl:when> -->
<!--                                        <xsl:otherwise> -->
<!--                                               <wd:Unit_of_Measure_Reference> -->
<!-- 				                            		<wd:ID wd:type="UN_CEFACT_Common_Code_ID"><xsl:value-of select="''"/></wd:ID> -->
<!-- 				                               </wd:Unit_of_Measure_Reference>  -->
<!--                                    </xsl:otherwise> -->
<!--                                   </xsl:choose> -->
				                    	  
			                        
			                        <wd:Unit_Price><xsl:value-of select="normalize-space(format-number(wd:Unit_Price,'#.00'))"/></wd:Unit_Price>
                                    <wd:Extended_Amount><xsl:value-of select="normalize-space(format-number(wd:Extended_Amount,'#.00'))"/></wd:Extended_Amount>
                                    <wd:Tax_Rate><xsl:value-of select="normalize-space(wd:Tax_Rate)"/></wd:Tax_Rate>
                                    <wd:Tax_Amount><xsl:value-of select="normalize-space(format-number(wd:Tax_Amount,'#.00'))"/></wd:Tax_Amount>
                                    <!-- <wd:Freight_Amount>12678967.54</wd:Freight_Amount>
			                        <wd:Handling_Amount>12678967.54</wd:Handling_Amount> -->
                                    <wd:Discount_Amount><xsl:value-of select="normalize-space(format-number(wd:Discount_Amount,'#.00'))"/></wd:Discount_Amount>
                                    <!-- <wd:Flat_Rate_Amount>12678967.54</wd:Flat_Rate_Amount>
			                        <wd:Lost_or_Damaged_Items_Amount>12678967.54</wd:Lost_or_Damaged_Items_Amount>
			                        <wd:One_Time_Miscellaneous_Charges_Amount>12678967.54</wd:One_Time_Miscellaneous_Charges_Amount>
			                        <wd:Other_Charges_Amount>12678967.54</wd:Other_Charges_Amount>
			                        <wd:Miscellaneous_Charges_Amount>12678967.54</wd:Miscellaneous_Charges_Amount>
			                        <wd:Miscellaneous_Charges_Description>abcdef</wd:Miscellaneous_Charges_Description> -->
                                </wd:Credit_Card_Transaction_Line_Data>
                            </xsl:for-each>
                            <!-- END   Credit_Card_Transaction_Line_Data -->       
                            
                            <!-- No mapping with VCF file -->
<!--                             <wd:Name_Match_Data> -->
<!--                             <wd:Confidence_Percentage>12678967.54</wd:Confidence_Percentage> --> 
<!--                             <wd:Merchant_Reference><wd:ID wd:type="Applicant_ID"><xsl:value-of select="$root/CardAcceptor_5001/CardAcceptorId"/></wd:ID></wd:Merchant_Reference> --> 
<!--                             <wd:Origination_City_Reference><wd:ID wd:type="Applicant_ID">abcdef</wd:ID></wd:Origination_City_Reference> --> 
<!--                             <wd:Destination_City_Reference><wd:ID wd:type="Applicant_ID">abcdef</wd:ID></wd:Destination_City_Reference> --> 
<!--                             <wd:Supplier_Reference><wd:ID wd:type="Supplier_Reference_ID"><xsl:value-of select="File/Record_05/supp_ref"/></wd:ID></wd:Supplier_Reference> -->
<!--                        </wd:Name_Match_Data>    -->
                            
                        </wd:Expense_Credit_Card_Transaction_Data>
                    </wd:Expense_Credit_Card_Transaction_File_Data>
                </wd:Credit_Card_Transaction_Header__HV__Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>
    
</xsl:stylesheet>

