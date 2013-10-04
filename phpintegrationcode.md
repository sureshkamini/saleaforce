saleaforce
==========
public class OrderItemsctrl 
{
    public static boolean IsApexTest=false;
    @future(callout=true)
    public static void dataget()
    {
        // Request to File server and get Response through HTTP Class
        
            HTTP h=new HTTP();
            HttpRequest req=new HttpRequest();
            req.SetHeader('Connection','Keep-alive');
            req.SetHeader('Content-Type','Application/xml:Charset=UTF-8');
            req.SetMethod('GET');
            req.SetTimeOut(120000);
            req.SetEndPoint('http://sfdcmmr.com/NPRODUCE/Order_Items.php');
            if(IsApexTest==false)
            {
                HttpResponse res=h.send(req);
            }
            insertdata();
      
    }
    public static void insertdata()
    {
        //Initializing mysql Table variable 
        String Item='',Order='',Note='',Quantity='',Type='',Category='',Pack_Size='',UOM='',Description='',Item_id='';
        //Request to File Server and Get Response From that ,the Response will be get like Xml file
        HTTP h=new HTTP();
        HttpRequest req=new HttpRequest();
        req.SetHeader('Connection','Keep-alive');
        req.SetHeader('Content-Type','Application/xml:Charset=UTF-8');
        req.SetMethod('GET');
        req.SetTimeOut(120000);
        req.SetEndPoint('http://sfdcmmr.com/NPRODUCE/Order_Items.xml');
        String res1;
        if(IsApexTest==false)
        {
            HttpResponse res=h.send(req);
            res1=res.getbody();
        }
        else
        {
            res1='<mediummsts><mediummst><MediumId>147</MediumId><MediumName>NewMedium2</MediumName><IsActive>1</IsActive><IsRemoved>0</IsRemoved><aaa>0</aaa><BusinessID>220</BusinessID></mediummst><mediummst><MediumId>146</MediumId><MediumName>NewMedium1</MediumName><IsActive>1</IsActive><IsRemoved>0</IsRemoved><aaa>0</aaa><BusinessID>220</BusinessID></mediummst></mediummsts>';
        }
        // Initializing the XmlStreamReader to read Response as Xml
        
        list<Order_Items__c> prdmstlist=new list<Order_Items__c>();
        if(string.isblank(res1)==false)
        {
                XmlStreamReader reader=new XmlStreamReader(res1);
                //list<lead> leadlist=new list<lead>();
                
                //Create a loop for getting values from Xml file from starting Xml Tag to Ending Xml Tag by using XmlStreamReader Methods
                 while(reader.hasnext())
                {
                    Order_Items__c p=new Order_Items__c();
                    //lead l=new lead();
                    if(reader.getEventType()==XmlTag.START_ELEMENT)  
                    {
                        if(reader.getLocalName()=='Item_id')
                        {
                            Item_id='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Item_id=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Description')
                        {
                            Description='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Description=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='UOM')
                        {
                            UOM='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    UOM=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Pack_Size')
                        {
                            Pack_Size='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Pack_Size=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Category')
                        {
                            Category='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Category=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Type')
                        {
                            Type='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Type=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Quantity')
                        {
                            Quantity='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Quantity=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Note')
                        {
                            Note='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Note=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Order')
                        {
                            Order='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Order=reader.getText();
                                }
                            }
                        }
                        if(reader.getLocalName()=='Item')
                        {
                            Item='';
                            reader.next();
                            if(reader.getEventType()==XmlTag.characters)
                            {
                                if(reader.getText()!=null)
                                {
                                    Item=reader.getText();
                                }
                            }
                             //Assign The Values To SFDC Variables
                            if(Item_id.trim()!='')
                                p.name=Item_id.trim();
                            if(Category.trim()!='')
                                p.Category__c=Category.trim();
                            if(Description.trim()!='')     
                                p.Description__c=Description.trim();
                            if(Item.trim()!='')
                                p.Item_Text__c=Item.trim();
                            if(Note.trim()!='')
                                p.Note__c=Note.trim();
                            if(Order.trim()!='')
                                p.Order_Text__c=Order.trim();
                            if(Pack_Size.trim()!='')
                                p.Pack_Size__c=integer.valueof(Pack_Size.trim());
                            if(Quantity.trim()!='')
                                p.Quantity__c=integer.valueof(Quantity.trim());
                            if(Type.trim()!='')
                                p.Type__c=Type.trim();
                            if(UOM.trim()!='')
                                p.UOM__c=UOM.trim(); 
                            
                          if(p.name!=null || p.name!='')
                            prdmstlist.add(p);
                        }     
                    }
                    reader.next();
                }
        }
            
            
           
        list<Order_Items__c> insertlist=new list<Order_Items__c>();
        list<Order_Items__c> updatelit=new list<Order_Items__c>();
        set<string> prdmstids=new set<string>();
        map<string,Order_Items__c> prdmstmap=new map<string,Order_Items__c>();
        map<string,Order_Items__c> prdmstupdatemap=new map<string,Order_Items__c>();
        set<string> pids=new set<string>();
        for(Order_Items__c mmst:prdmstlist)
        {    
            if(mmst.Name!=null)
                pids.add(mmst.Name);
        }
        for(Order_Items__c mmst:[select id,name,Category__c,Item_Text__c,Order_Text__c,Description__c,Item__c,Note__c,Order__c,Pack_Size__c,Quantity__c,Type__c,UOM__c from Order_Items__c where Name in:pids])
        {
            prdmstmap.put(mmst.Name,mmst);
        }
       if(prdmstlist.size()>0)
       {
            for(Order_Items__c pd1:prdmstlist)
            {
                if(prdmstmap.get(pd1.Name)==null)
                {
                     Order_Items__c lid=new Order_Items__c ();
                     if(pd1.Name!=null)
                        lid.Name=pd1.Name;
                    if(pd1.Description__c!=null)
                        lid.Description__c=pd1.Description__c;                      
                    if(pd1.Item_Text__c!=null)
                        lid.Item_Text__c=pd1.Item_Text__c; 
                    if(pd1.Note__c!=null)
                        lid.Note__c=pd1.Note__c;  
                    if(pd1.Order_Text__c!=null)
                        lid.Order_Text__c=pd1.Order_Text__c;   
                    if(pd1.Pack_Size__c!=null)
                        lid.Pack_Size__c=pd1.Pack_Size__c; 
                    if(pd1.Quantity__c!=null)
                        lid.Quantity__c=pd1.Quantity__c;
                    if(pd1.Type__c!=null)
                        lid.Type__c=pd1.Type__c;                       
                    if(pd1.UOM__c!=null)
                        lid.UOM__c=pd1.UOM__c;
                   insertlist.add(lid);
               }
               else
               {
                    if(prdmstmap.get(pd1.Name)!=null)
                    {
                        Order_Items__c lid=prdmstmap.get(pd1.name);
                        if(pd1.Name!=null)
                            lid.Name=pd1.Name;
                        if(pd1.Description__c!=null)
                        lid.Description__c=pd1.Description__c;
                        if(pd1.Item_Text__c!=null)
                            lid.Item_Text__c=pd1.Item_Text__c;
                        if(pd1.Note__c!=null)
                            lid.Note__c=pd1.Note__c;   
                        if(pd1.Order_Text__c!=null)
                            lid.Order_Text__c=pd1.Order_Text__c;   
                        if(pd1.Pack_Size__c!=null)
                            lid.Pack_Size__c=pd1.Pack_Size__c;    
                        if(pd1.Quantity__c!=null)
                            lid.Quantity__c=pd1.Quantity__c;  
                        if(pd1.Type__c!=null)
                            lid.Type__c=pd1.Type__c; 
                        if(pd1.UOM__c!=null)
                            lid.UOM__c=pd1.UOM__c;
                            updatelit.add(lid);
                    }
                }      
            }
            if(insertlist.size()>0)
            insert insertlist; 
            if(updatelit.size()>0)
                update updatelit;          
       }
   }             
}
