saleaforce
==========
hi

<apex:page extensions="NewAccOverride" standardController="Account">
    <apex:form ><br/>
    <table width="100%"><tr><td width="5%">
    <apex:image value="/img/icon/people16.png" width="40px" style="vertical-align:middle" /></td>
     <td width="50%">  New Account<br/>
      <font size="5"> Select Account Record Type</font></td>
      <td width="80%" style="text-align:right;text-color:blue"><a color="blue" href="https://help.salesforce.com/htviewhelpdoc?err=1&id=account_recordtype.htm&siteLang=en_US" target="_blank" title="Help for this Page (New Window)">Help for this Page</a>&nbsp;  <apex:image value="/img/func_icons/util/help16.png"  style="vertical-align:middle"  title="Help for this Page (New Window)"/></td></tr></table><br/><br/>
        <font size="2"> Select a record type for the new account. To skip this page in the future, change your record type settings on your personal setup page. </font><br/><br/><br/><br/>
            <apex:pageBlock title="Select Account Record Type">
                <apex:pageBlockSection >
                    <apex:inputField value="{!ac.Record_Type_of_new_record__c}" required="true"/>
                </apex:pageBlockSection><br/><br/>
             <center>   <apex:commandButton value="Continue" action="{!contunive}"/> <apex:commandButton value="Cancel" action="{!cancel}"/></center>
            </apex:pageBlock>
       
    </apex:form>
</apex:page>
