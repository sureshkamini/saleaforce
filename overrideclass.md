saleaforce
==========
class

public class NewAccOverride
{
    public account ac{get;set;}
    
    Public NewAccOverride(ApexPages.StandardController controller)
    {
        ac=new account();
    }
    
    public pagereference contunive()
    {
        
            if(ac.Record_Type_of_new_record__c=='Generator')
            {
              PageReference pr = new PageReference('https://c.na14.visual.force.com/apex/Generatorvf?sfdc.tabName=01rd00000006Fop');
              pr.setRedirect(true);
              return pr;  
            }
            else if(ac.Record_Type_of_new_record__c=='Collector')
            {
                 PageReference pr1 = new PageReference('https://c.na14.visual.force.com/apex/collectorvfNew?sfdc.tabName=01rd00000007Fo8');
                 pr1.setRedirect(true);
                 return pr1;  
            }
            else return null;
         
      } 
      
    public pagereference cancel()
    {
             PageReference pr2 = new PageReference('https://na14.salesforce.com/001/o');
             pr2.setRedirect(true);
             return pr2;   
    }
   
}
