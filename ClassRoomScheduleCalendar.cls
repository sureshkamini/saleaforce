global with sharing class ClassRoomScheduleCalendar
{   
    public string Studentaccountid=apexpages.currentpage().getparameters().get('id');
    public string Purchaseid=apexpages.currentpage().getparameters().get('purchaseid');
    public string StaringDate=apexpages.currentpage().getparameters().get('SelectedDate');  
    public string daystoshowpar=apexpages.currentpage().getparameters().get('daystoshow');  
    public string eventData{get;set;}
    public Classes_Packages__c instrct{get;set;}
    public list<selectoption> ClassRooms{get;set;}
    public list<selectoption> privateClassRooms{get;set;}
    public string[] instructorname{get;set;}
    public string classroomid{get;set;}
    public string privateclassroomid{get;set;}
    public map<string,string> StrToIntTimeMap=new map<string,string>{'4 AM'=>'4:0:00','4.15 AM'=>'4:15:00','4.30 AM'=>'4:30:00','4.45 AM'=>'4:45:00','5 AM'=>'5:0:00','5.15 AM'=>'5:15:00','5.30 AM'=>'5:30:00','5.45 AM'=>'5:45:00','6 AM'=>'6:0:00','6.15 AM'=>'6:15:00','6.30 AM'=>'6:30:00','6.45 AM'=>'6:45:00','7 AM'=>'7:0:00','7.15 AM'=>'7:15:00','7.30 AM'=>'7:30:00','7.45 AM'=>'7:45:00','8 AM'=>'8:0:00','8.15 AM'=>'8:15:00','8.30 AM'=>'8:30:00','8.45 AM'=>'8:45:00','9 AM'=>'9:0:00','9.15 AM'=>'9:15:00','9.30 AM'=>'9:30:00','9.45 AM'=>'9:45:00','10 AM'=>'10:0:00','10.15 AM'=>'10:15:00','10.30 AM'=>'10:30:00','10.45 AM'=>'10:45:00','11 AM'=>'11:0:00','11.15 AM'=>'11:15:00','11.30 AM'=>'11:30:00','11.45 AM'=>'11:45:00','12 PM'=>'12:0:00','12.15 PM'=>'12:15:00','12.30 PM'=>'12:30:00','12.45 PM'=>'12:45:00','1 PM'=>'13:0:00','1.15 PM'=>'13:15:00','1.30 PM'=>'13:30:00','1.45 PM'=>'13:45:00','2 PM'=>'14:0:00','2.15 PM'=>'14:15:00','2.30 PM'=>'14:30:00','2.45 PM'=>'14:45:00','3 PM'=>'15:0:00','3.15 PM'=>'15:15:00','3.30 PM'=>'15:30:00','3.45 PM'=>'15:45:00','4 PM'=>'16:0:00','4.15 PM'=>'16:15:00','4.30 PM'=>'16:30:00','4.45 PM'=>'16:45:00','5 PM'=>'17:0:00','5.15 PM'=>'17:15:00','5.30 PM'=>'17:30:00','5.45 PM'=>'17:45:00','6 PM'=>'18:0:00','6.15 PM'=>'18:15:00','6.30 PM'=>'18:30:00','6.45 PM'=>'18:45:00','7 PM'=>'19:0:00','7.15 PM'=>'19:15:00','7.30 PM'=>'19:30:00','7.45 PM'=>'19:45:00','8 PM'=>'20:0:00','8.15 PM'=>'20:15:00','8.30 PM'=>'20:30:00','8.45 PM'=>'20:45:00','9 PM'=>'21:0:00','9.15 PM'=>'21:15:00','9.30 PM'=>'21:30:00','9.45 PM'=>'21:45:00','10 PM'=>'22:0:00','10.15 PM'=>'22:15:00','10.30 PM'=>'22:30:00','10.45 PM'=>'22:45:00','11 PM'=>'23:0:00','0 AM'=>'23:59:00','1 AM'=>'23:59:00'}; 
    public integer Sday{get;set;}
    public integer Smonth{get;set;}
    public integer Syear{get;set;}
    public integer daystoshow{get;set;}
    public Month getMonth() { return month; } 
    private Month month;
    public string recordtypeid{get;set;}
    public string clspackdate{get;set;}
    public string clspackstarttime{get;set;}
    public string clspackendtime{get;set;}
    public string instructorid{get;set;}
    public Date d;
    public string allusername{get;set;}
    PUBLIC list<calEvent> events{get;set;}
    public Classes_Packages__c clspak{get;set;}
    public list<selectoption> recordtypes{get;set;}
    public list<skilltype> skilltypes{get;set;}
    public map<string,string> recordtypemap;
    public list<selectoption> Filterby{get;set;}
    public string filterstr{get;set;}
    public boolean isfilter{get;set;}
    public map<string,Class_Room__c> Classroommap;
    public list<Selectoption> instructorpicklist{get;set;}
    public list<Selectoption> instructorpicklist2{get;set;}
    public list<Selectoption> Bookedbylist{get;set;}
    public list<Selectoption> selectinstructorlist{get;set;}
    public list<Selectoption> filterclassroomlist{get;set;}
    public string[] selectedistructorids{get;set;}
    public string[] filterclassroomids{get;set;}
    public string instidd{get;set;}
    public string subinstidd{get;set;}
    public string bookedbyid{get;set;}
    public boolean isfirstconstrucotr;
    public void filterbymeth()
    {
        instrct=new Classes_Packages__c();
        if(filterstr=='Filter by Instructor')
            isfilter=false;
        else    isfilter=true;
        selectedistructorids=new string[]{};
        filterclassroomids=new string[]{};
        search();
    }
    public void previous()
    {
         d = d.adddays(-daystoshow);
         Sday=d.day();
         Smonth=d.month();
         Syear=d.year();
         pageLoad();
            
    }
    public void calnext()
    {
       
         d = d.adddays(daystoshow);
         
         Sday=d.day();
         Smonth=d.month();
         Syear=d.year();
          pageLoad();  
    }
    public void today()
    {
         d = system.today();
         Sday=d.day();
         Smonth=d.month();
         Syear=d.year();
         daystoshow=1;
           pageLoad();
    }
    public void oneday()
    {
        daystoshow=1;
        //pageLoad();
    }
    public void threedays()
    {
        daystoshow=3;
         //pageLoad();
    }
    public void workweek()
    {
        daystoshow=5;
         pageLoad();
    }
    public void fullweek()
    {
        daystoshow=7;
        pageLoad();
    }
    public void monthview()
    {
        daystoshow=30;
        pageLoad();
    }
    public void next() 
    { 
    addMonth(1);
    pageLoad();
    }
    public void prev() 
    { 
    addMonth(-1); 
    pageLoad();
    }
    private void addMonth(Integer val) 
    { 
        Date d = month.getFirstDate();
        d = d.addMonths(val);
        setMonth(d);
    }
    public List<Month.Week> getWeeks() { 
    system.assert(month!=null,'month is null');
    return month.getWeeks();
    }
    private void setMonth(Date d) 
    { 
        month = new Month(d);  
        system.assert(month != null); 
    
        Date[] da = month.getValidDateRange();  // gather events that fall in this month
        // merge those events into the month class
    }
    
    public ClassRoomScheduleCalendar() 
    {
        isfirstconstrucotr=false;
        instructorpicklist=new list<selectoption>();
        instructorpicklist2=new list<selectoption>();
        selectinstructorlist=new list<selectoption>();
        filterclassroomlist=new list<selectoption>();
        instructorpicklist.add(new selectoption('','--None--'));
        instructorpicklist2.add(new selectoption('','--None--'));
        Bookedbylist=new list<selectoption>();
        Bookedbylist.add(new selectoption('','--None--'));
        for(Counselor__c consol:[select id,name from Counselor__c])
        {
            Bookedbylist.add(new selectoption(consol.id,consol.name));
        }
        //selectinstructorlist.add(new selectoption('','All'));
        //filterclassroomlist.add(new selectoption('','All'));
        selectedistructorids=new string[]{};
        filterclassroomids=new string[]{};
        //for(Instructor__c inst:[select id,name from instructor__c])
            
        isfilter=false;
        Filterby=new list<selectoption>();
        Filterby.add(new selectoption('Filter by Instructor','Filter by Instructor'));
        Filterby.add(new selectoption('Filter by Dance Style','Filter by Dance Style'));
        filterstr='Filter by Instructor';
        instructorname=new string[]{};
        instrct=new Classes_Packages__c();
        clspak=new Classes_Packages__c();
        if(Purchaseid!=null)
        recordtypeid='Private Lessons';
        if(Studentaccountid!=null)
        clspak.Student__c=Studentaccountid;
        clspak.of_Weeks__c=1;
        Searchclassroom();
        /*ClassRooms=new list<selectoption>();
        privateClassRooms=new list<selectoption>();
        ClassRooms.add(new selectoption('','--None--'));
        privateClassRooms.add(new selectoption('','--None--'));
        Classroommap=new map<string,Class_Room__c>();
        for(Class_Room__c clroom:[select id,name,Allocated_Private_Lessons__c,Maximum_Allowed_Private_Lessons__c from Class_Room__c])
        {
            if(clroom.Maximum_Allowed_Private_Lessons__c!=null)
            {
                if(clroom.Allocated_Private_Lessons__c==null)
                    clroom.Allocated_Private_Lessons__c=0;
                if(clroom.Maximum_Allowed_Private_Lessons__c>clroom.Allocated_Private_Lessons__c)  
                privateClassRooms.add(new selectoption(clroom.id,clroom.name));
                Classroommap.put(clroom.id,clroom);
            }
            ClassRooms.add(new selectoption(clroom.id,clroom.name));
        }*/
        if(StaringDate==null)
        {
            d = system.today();
            string[] SateSplit =string.valueof(d).split('-');
            StaringDate=SateSplit[1]+'/'+SateSplit[2]+'/'+SateSplit[0];
            Sday=d.day();
            Smonth=d.month();
            Syear=d.year();
        }
        else
        {
            d=date.parse(StaringDate);
            Sday=d.day();
            Smonth=d.month();
            Syear=d.year();
        }
        recordtypes=new list<selectoption>();
        recordtypemap=new map<string,string>();
        recordtypes.add(new selectoption('','--None--'));
        
        for(recordtype rt:[select id,name from recordtype where sobjecttype='Classes_Packages__c' and isactive=true order by name])
        {
            recordtypemap.put(rt.name,rt.id);
            recordtypes.add(new selectoption(rt.name,rt.name));
        }
        
        if(daystoshowpar==null)
            daystoshow=1;  
        else daystoshow=integer.valueof(daystoshowpar);
       // d = system.today();  // default to today
         
        allusername='[';
        
        Integer mo = d.month();
        setMonth(d);
         /*  skilltypes=new list<skilltype>();
           Schema.DescribeFieldResult fieldResult =Instructor__c.Dance_Style_Specialties__c.getDescribe();
           List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
           for( Schema.PicklistEntry f : ple)
           {
               skilltype skill=new skilltype();
               skill.skillname=f.getValue();
               if(skill.skillname=='Argentine Tango')
               skill.Selectskill=true;
               skilltypes.add(skill);
           }      
           
           integer i=0;
           IntegerUserMap=new map<string,integer>();
           instructorids=new set<string>();
           for(Instructor__c instr11:[select id,name,Nickname__c,Dance_Style_Specialties__c from Instructor__c where Nickname__c!=null and Active__c='Yes' order by Nickname__c])
            {
                instructorpicklist.add(new selectoption(instr11.id,instr11.name));
                selectinstructorlist.add(new selectoption(instr11.id,instr11.name));
                if(allusername=='[')
                    allusername=allusername+'\''+instr11.Nickname__c+'\'';
                else allusername=allusername+','+'\''+instr11.Nickname__c+'\'';
                instructorids.add(instr11.id);
                IntegerUserMap.put(instr11.Nickname__c,i);
                i++;
            }
            allusername=allusername+']';
            */
    }
    public string skillname='';
    public set<string> skillnames;
    public set<string> instructorids;
    public map<string,integer> IntegerUserMap;
    public void searchInstructor()
    {
        IntegerUserMap=new map<string,integer>();
        allusername='[]';
        skillnames=new set<string>();
        skillname='Argentine Tango';
        instructorids=new set<string>();
        /*if(skilltypes.size()>0)
        {
            integer count=1;  
            for(skilltype st:skilltypes)
            {
                if(st.Selectskill==true)
                {
                    skillnames.add(st.skillname);
                  
                }
                
            }
            clspak.Dance_Style__c=skillname;
            skillname=skillname+';';
        }*/
        ClassRooms=new list<selectoption>();
        instructorname=null;
        ClassRooms.add(new selectoption('','--None--'));
        if(instrct.Dance_Style__c!=null)
        { 
            
            system.debug(instrct.Dance_Style__c);
           
            string executeinstruct='select id,name from Instructor__c';
            if(instrct.Dance_Style__c!=null)
            {
                executeinstruct=executeinstruct+' where Dance_Style_Specialties__c=\''+instrct.Dance_Style__c+'\'';
                if(instrct.Sub_Dance_Style__c!=null)
                    executeinstruct=executeinstruct+' and Sub_Dance_Style__c=\''+instrct.Sub_Dance_Style__c+'\'';
                //Eventlist=database.query(Eventsql);
            }
            for(Instructor__c instr:database.query(executeinstruct))
            {
                system.debug(instr);
                ClassRooms.add(new selectoption(instr.id,instr.name));
                
            }
            allusername=allusername+']';
            system.debug(skillname);
            system.debug(allusername);
            system.debug(instructorids);
        }
        
        //pageLoad();
    }
    @RemoteAction
    global static string getinstructername(integer iid,list<string> unamlist) 
    {
        system.debug('inside get username loop'+unamlist[iid]);
        //if(unamMap.get(uId)!=null)
        //uuName= unamMap.get(uId);
        string uuName='';
        if(unamlist[iid]!=null)
            uuName= unamlist[iid];    
        Instructor__c tm=[select id,name,Nickname__c from Instructor__c  where Nickname__c=:uuName and Active__c='Yes' limit 1];
        
        //return tm.User__c; 
        
         return tm.id+'@'+tm.name;     
       
    }
    public pagereference clearfilter()
    {
        pagereference calenderpage=new pagereference('/apex/ClassRoomScheduleCalendar');
        calenderpage.setredirect(true);
        return calenderpage;
    }
    public void changescheduledate()
    {
        string scheduledate=apexpages.currentpage().getparameters().get('sddate');
        
        d=date.parse(scheduledate);
            Sday=d.day();
            Smonth=d.month();
            Syear=d.year();
            pageLoad();
    }
    public void Searchclassroom()
    {
        ClassRooms=new list<selectoption>();
        privateClassRooms=new list<selectoption>();
        ClassRooms.add(new selectoption('','--None--'));
        privateClassRooms.add(new selectoption('','--None--'));
        Classroommap=new map<string,Class_Room__c>();
        for(Class_Room__c clroom:[select id,name,Allocated_Private_Lessons__c,Maximum_Allowed_Private_Lessons__c from Class_Room__c order by Sorting_Order__c,name])
        {
            if(clroom.Maximum_Allowed_Private_Lessons__c!=null)
            {
                if(clroom.Allocated_Private_Lessons__c==null)
                    clroom.Allocated_Private_Lessons__c=0;
                if(clroom.Maximum_Allowed_Private_Lessons__c>clroom.Allocated_Private_Lessons__c)  
                privateClassRooms.add(new selectoption(clroom.id,clroom.name));
                Classroommap.put(clroom.id,clroom);
            }
            ClassRooms.add(new selectoption(clroom.id,clroom.name));
            
        }
    }
    public void changerecordtype()
    {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Errrr'+recordtypeid));
        if(recordtypeid=='Private Lessons')
            clspak.recordtypeid='01228000000Zsd3';
            
    }
    public void search()
    {
        integer i=0;
        IntegerUserMap=new map<string,integer>();
        instructorids=new set<string>();
        allusername='[';
        string errormsg='';
        //if(filterstr=='Filter by Instructor')
        //{
            /*if(selectedistructorids.size()==0)
                errormsg='Please select Instructor';*/
           /* string queryinclue='select id,name,Dance_Style_Specialties__c,Nickname__c from Instructor__c where name!=null';
            
            if(instrct.Dance_Style__c!=null)
                queryinclue=queryinclue+' and Dance_Style_Specialties__c=\''+instrct.Dance_Style__c+'\'';
            if(instrct.Sub_Dance_Style__c!=null)
                queryinclue=queryinclue+' and Sub_Dance_Style__c includes(\''+instrct.Sub_Dance_Style__c+'\')';
            queryinclue=queryinclue+' and Nickname__c!=null and Active__c=\'Yes\' order by Nickname__c';   
            
            for(Instructor__c instr11:database.query(queryinclue))
            {
                if(isfirstconstrucotr==false)
                {
                    instructorpicklist.add(new selectoption(instr11.id,instr11.name));
                    instructorpicklist2.add(new selectoption(instr11.id,instr11.name));
                    selectinstructorlist.add(new selectoption(instr11.id,instr11.name));
                    
                }
                    if(allusername=='[')
                        allusername=allusername+'\''+instr11.Nickname__c+'\'';
                    else allusername=allusername+','+'\''+instr11.Nickname__c+'\'';
                    instructorids.add(instr11.id);
                    IntegerUserMap.put(instr11.Nickname__c,i);
                    i++;
             }*/
             
             string classroomquery='select id,name from Class_Room__c where name!=null';
             if(filterclassroomids.size()>0)
            {
                if(filterclassroomids[0]!='')
                    classroomquery=classroomquery+' and id=:filterclassroomids'; 
                
            }
            classroomquery=classroomquery+' order by Sorting_Order__c,Name';
             for(Class_Room__c clsroom:database.query(classroomquery))
             {
                 if(isfirstconstrucotr==false)
                 filterclassroomlist.add(new selectoption(clsroom.id,clsroom.name));
                 if(i<6)
                 {
                    if(allusername=='[')
                        allusername=allusername+'\''+clsroom.name+'\'';
                    else allusername=allusername+','+'\''+clsroom.name+'\'';
                    instructorids.add(clsroom.id);
                    IntegerUserMap.put(clsroom.id,i);
                }
                    i++;
             }
             isfirstconstrucotr=true;
        //}
        /*else if(filterstr=='Filter by Dance Style')
        {
            if(instrct.Dance_Style__c==null)
                errormsg='Please select Dance Style';
            else if(instrct.Sub_Dance_Style__c==null) 
                errormsg='Please select Sub Dance Style';
        }*/
        if(filterclassroomids.size()<7)
        {
            /*if(selectedistructorids.size()>0)
            {
                for(Instructor__c instr11:[select id,name,Dance_Style_Specialties__c,Nickname__c from Instructor__c where id=:selectedistructorids and Active__c='Yes' and Nickname__c!=null order by Nickname__c])
                {
                    if(allusername=='[')
                        allusername=allusername+'\''+instr11.Nickname__c+'\'';
                    else allusername=allusername+','+'\''+instr11.Nickname__c+'\'';
                    instructorids.add(instr11.id);
                    IntegerUserMap.put(instr11.Nickname__c,i);
                    i++;
                }
           }
           else  if(instrct.Dance_Style__c!=null && instrct.Sub_Dance_Style__c!=null)
           {
                string queryinclue='select id,name,Dance_Style_Specialties__c,Nickname__c from Instructor__c';
                queryinclue=queryinclue+' where Dance_Style_Specialties__c=\''+instrct.Dance_Style__c+'\'';
                queryinclue=queryinclue+' and Sub_Dance_Style__c includes(\''+instrct.Sub_Dance_Style__c+'\') and Nickname__c!=null and Active__c=\'Yes\' order by Nickname__c';
                
                for(Instructor__c instr11:database.query(queryinclue))
                {
                    if(allusername=='[')
                        allusername=allusername+'\''+instr11.Nickname__c+'\'';
                    else allusername=allusername+','+'\''+instr11.Nickname__c+'\'';
                    instructorids.add(instr11.id);
                    IntegerUserMap.put(instr11.Nickname__c,i);
                    i++;
                }
           }
          */
                   }
        else ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,'First 6 class rooms of dance programs will be displayed in Calendar only'));
        allusername=allusername+']';
        pageLoad();
        
        clspak.Dance_Style__c=instrct.Dance_Style__c;
        clspak.Sub_Dance_Style__c=instrct.Sub_Dance_Style__c;
        
    }
     public void nextinstructor()
    {    
    
          con.next();
           integer i=0;
            allusername='[';
            instructorids=new set<string>();
           // string ssq='select id,name,Nickname__c from Instructor__c where Nickname__c!=null and Active__c=\'Yes\' order by Nickname__c limit 5 offset '+offsetvalue;
            for(Class_Room__c  Classrm:(List<Class_Room__c>)con.getRecords())
            {
                    if(allusername=='[')
                        allusername=allusername+'\''+Classrm.name+'\'';
                    else allusername=allusername+','+'\''+Classrm.name+'\'';
                    instructorids.add(Classrm.id);
                    IntegerUserMap.put(Classrm.name,i);
                    i++;
                    
            }
          
            allusername=allusername+']';
            pageLoad();
       
    }
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name FROM Class_Room__c where name!=null order by Sorting_Order__c,Name limit 100 ]));
                // sets the number of records in each page set
                con.setPageSize(6);
            }
            return con;
        }
        set;
    }
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
     public void first() {
         con.first();
     }

     // returns the last page of records
     public void last() {
         con.last();
     }

    public void previousInstructor() {
          con.previous();
         integer i=0;
         instructorids=new set<string>();
        allusername='[';
        // string ssq='select id,name,Nickname__c from Instructor__c where Nickname__c!=null and Active__c=\'Yes\' order by Nickname__c limit 5 offset '+offsetvalue;
        for(Class_Room__c  Classrm:(List<Class_Room__c>)con.getRecords())
        {
                if(allusername=='[')
                    allusername=allusername+'\''+Classrm.Name+'\'';
                else allusername=allusername+','+'\''+Classrm.Name+'\'';
                instructorids.add(Classrm.id);
                IntegerUserMap.put(Classrm.Name,i);
                i++;
               
        }
        
        allusername=allusername+']';
        pageLoad();
     }

    public PageReference pageLoad() 
    {
        Transient list<Classes_Packages__c> Eventlist=new list<Classes_Packages__c>();
        events = new list<calEvent>();
        
        String Eventsql='select id,Rental_Floor_Fees__c,Class_Room_Ids__c,Class_Type__c,Instructor_2__c,Instructor_2__r.name,Instructor_2__r.Nickname__c,Schedule_Start_Time__c,Schedule_End_Time__c,Class_Rooms__c,recordtype.name,of_Students_Allowed__c,Dance_Style__c,Class_Room__c,Class_Room__r.name,Sub_Dance_Style__c,name,End_Time__c,Start_Time__c,Instructor__r.name,Instructor__r.Nickname__c,Description__c,Skill_Level__c,Date__c,Instructor__c,Class_Location__c from Classes_Packages__c where Schedule_Start_Time__c!=null and Schedule_End_Time__c!=null and Class_Room_Ids__c!=null and Instructor__r.name!=\'Unassigned\' and Instructor_2__r.name!=\'Unassigned\'';
            Date EventStartDate,EventEndDate;
            EventStartDate=d.adddays(-3);
            system.debug(EventStartDate);
            EventEndDate=d.toStartOfWeek().adddays(daystoshow+10);
            system.debug(EventEndDate);
           //Eventsql=Eventsql+' and recordtype.name!=\'Private Lessons\'';
                Eventsql=Eventsql+' and  (DAY_ONLY(Schedule_Start_Time__c)>='+string.valueof(EventStartDate)+' and DAY_ONLY(Schedule_Start_Time__c)<='+string.valueof(EventEndDate)+') order by name';
            //and Class_Room_Ids__c=:instructorids  Eventsql=Eventsql+' and (Instructor__c=:instructorids or Instructor_2__c=:instructorids) and Instructor__c!=null and (Date__c>='+string.valueof(EventStartDate)+' and Date__c<='+string.valueof(EventEndDate)+') order by name';
            Eventlist=database.query(Eventsql);
       
           
        /*else if(instructorids.size()>0)
        {
            Eventsql=Eventsql+' and Instructor__c=:instructorids';
            Eventlist=database.query(Eventsql);
        }*/
        set<string> Privatedanceprogramids=new set<string>();
        map<string,Registered_Classes__c> Registermap=new map<string,Registered_Classes__c>();
        for(Classes_Packages__c clsp:Eventlist)
        {
            if(clsp.recordtype.name=='Private Lessons' || clsp.recordtype.name=='Rental & Floor' || clsp.recordtype.name=='Intro Classes' )
            {
                Privatedanceprogramids.add(clsp.id);
            }
        }
        for(Registered_Classes__c regcls:[select id,name,Account__r.name,Class_Package_Type__c,Purchased_Classes__r.Payment_Plan__c,Classes_Package__c,Purchased_Classes__r.Status__c,Validate__c,Checkin__c from Registered_Classes__c where Classes_Package__c=:PrivatedanceprogramidS and Purchased_Classes__r.Remove__c=false and Remove1__c=false and (Status__c='Scheduled to be taken' or Status__c='Taken Checked in & validated' or Status__c='Taken Checked in & waiting for validation') ])
        {
            Registermap.put(regcls.Classes_Package__c,regcls);
        }  
        for(Classes_Packages__c ev:Eventlist)
        {
            system.debug(ev);
            for(string clsroom:ev.Class_Room_Ids__c.split(','))
            {
                system.debug(ev.Class_Room_Ids__c);
                system.debug(clsroom);
                
                system.debug(instructorids);
                if(instructorids.contains(clsroom.trim())==true)
                {
                    string tit='Created Event';
                
                        calEvent myEvent = new calEvent();
                        if(ev.recordtype.name=='Group Classes')
                        {
                            myEvent.ColorCode='#9AC0CD';      
                            events.add(myEvent);
                        }  
                        else if(ev.recordtype.name=='Private Lessons'  && Registermap.get(ev.id)!=null)
                        {
                            myEvent.ColorCode='#BBA3D0'; 
                            
                            myEvent.CustomerName=ev.Dance_Style__c;
                           
                            myEvent.ServiceSiteName=Registermap.get(ev.id).Purchased_Classes__r.Status__c;
                            if(Registermap.get(ev.id).Purchased_Classes__r.Payment_Plan__c!=null)
                            myEvent.ServiceSite=Registermap.get(ev.id).Purchased_Classes__r.Payment_Plan__c;
                            else if(Registermap.get(ev.id).Class_Package_Type__c=='Private Lessons')
                                             myEvent.ServiceSite='Payment in Full';
                                        else myEvent.ServiceSite=Registermap.get(ev.id).Class_Package_Type__c;
                            if(Registermap.get(ev.id).Validate__c==true)
                                myEvent.Orderedby='True';
                            else myEvent.Orderedby='False';
                            if(Registermap.get(ev.id).Checkin__c==true)
                                myEvent.GoogleLink='True';
                            else myEvent.GoogleLink='False';
                            myEvent.Summory=ev.Class_Rooms__c;
                            events.add(myEvent);
                            
                        }
                        else if(ev.recordtype.name=='Rental & Floor' && Registermap.get(ev.id)!=null)
                        {
                            myEvent.ColorCode='#ccfff2'; 
                            
                            myEvent.CustomerName=Registermap.get(ev.id).Account__r.name;
                           // myEvent.CustomerName='ddd';
                            myEvent.ServiceSiteName=Registermap.get(ev.id).Purchased_Classes__r.Status__c;
                            myEvent.ServiceSite=ev.Rental_Floor_Fees__c;
                            
                            //myEvent.Summory=ev.Class_Rooms__c;
                            events.add(myEvent);
                            
                        }
                        else if(ev.recordtype.name=='Workshops')
                        {
                            myEvent.ColorCode='#ffc966';
                            events.add(myEvent);
                        }
                        else if(ev.recordtype.name=='Intro Classes' && Registermap.get(ev.id)!=null)
                        {
                            myEvent.ColorCode='#008000';
                            events.add(myEvent);
                        }
                        else if(ev.recordtype.name=='Dance Parties/Practices')
                        {
                            myEvent.ColorCode='#FFFFAD';
                            events.add(myEvent);
                        }
                        myEvent.imagelink='';
                        if(ev.recordtype.name!='Private Lessons' && ev.recordtype.name!='Rental & Floor')
                        {
                            myEvent.CustomerName=ev.Dance_Style__c;
                            myEvent.ServiceSiteName=ev.Sub_Dance_Style__c;
                            myEvent.ServiceSite=ev.Instructor__r.name;
                            if(ev.Instructor_2__c!=null)
                                myEvent.Orderedby=ev.Instructor_2__r.name;
                            myEvent.GoogleLink=string.valueof(ev.of_Students_Allowed__c);
                            myEvent.Summory=ev.Class_Rooms__c;
                        }
                    
                    
                   // myEvent.ServiceSite=ev.Instructor__r.name;
                    myEvent.eId= ev.id;
                   // myEvent.EventName=ev.name;
                    if(ev.name.indexof('\'')>=0)
                    {
                         
                        myEvent.EventName= ev.name.replace('\'', '');
                        myEvent.title=myEvent.EventName; 
                        
                    }
                   
                    else myEvent.EventName=ev.name;
                    myEvent.title=myEvent.EventName; 
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,''+myEvent.EventName));
                    myEvent.isevent=ev.recordtype.name;
                    myEvent.TeamName=ev.recordtype.name;
                   /* myEvent.CustomerName=ev.Dance_Style__c;
                    myEvent.ServiceSiteName=ev.Sub_Dance_Style__c;
                    myEvent.GoogleLink=string.valueof(ev.of_Students_Allowed__c);
                    myEvent.Summory=ev.Class_Rooms__c;*/
                   /*
                    if(ev.StartDateTime.hour()<12)
                    {
                        if(ev.StartDateTime.minute()!=0)
                            myEvent.StartTime=string.valueof(ev.StartDateTime.hour())+' '+string.valueof(ev.StartDateTime.minute())+' AM';
                        else myEvent.StartTime=string.valueof(ev.StartDateTime.hour())+' AM';
                    }
                    else 
                    {
                        if(ev.StartDateTime.minute()!=0)
                            myEvent.StartTime=string.valueof(ev.StartDateTime.hour()-12)+' '+string.valueof(ev.StartDateTime.minute())+' PM';
                        else myEvent.StartTime=string.valueof(ev.StartDateTime.hour()-12)+' PM';
                    }
                    
                    if(ev.EndDateTime.hour()<12)
                    {
                        if(ev.EndDateTime.minute()!=0)
                            myEvent.EndTime=string.valueof(ev.EndDateTime.hour())+' '+string.valueof(ev.EndDateTime.minute())+' AM';
                        else myEvent.EndTime=string.valueof(ev.EndDateTime.hour())+' AM';
                    }
                    else 
                    {
                        if(ev.EndDateTime.minute()!=0)
                            myEvent.EndTime=string.valueof(ev.EndDateTime.hour()-12)+' '+string.valueof(ev.EndDateTime.minute())+' PM';
                        else myEvent.EndTime=string.valueof(ev.EndDateTime.hour()-12)+' PM';
                    }*/
                    list<string> addresslist=new list<string>();
                    
                    myEvent.Todaydate=string.valueof(ev.date__c);
                    
                    integer addcount=1;   
                    for(string ssaddress:addresslist)     
                    {
                        if(addcount!=addresslist.size())
                            myEvent.location=myEvent.location+ssaddress+', ';
                        else myEvent.location=myEvent.location+ssaddress;
                        addcount++;
                    }
                    datetime StartTime,EndTime;
                    //if(StrToIntTimeMap.get(ev.Start_Time__c)!=null)
                    //{
                        //StartTime=datetime.valueof(string.valueof(ev.Date__c)+' '+StrToIntTimeMap.get(ev.Start_Time__c));
                       
                        myEvent.sYr=ev.Schedule_Start_Time__c.year();
                        myEvent.sMn=ev.Schedule_Start_Time__c.month();
                        myEvent.sDd=ev.Schedule_Start_Time__c.day();
                        myEvent.sH=ev.Schedule_Start_Time__c.hour();
                        myEvent.sM=ev.Schedule_Start_Time__c.minute();
                        
                    //}
                        
                    //if(StrToIntTimeMap.get(ev.End_Time__c)!=null)
                    //{
                        //EndTime=datetime.valueof(string.valueof(ev.Date__c)+' '+StrToIntTimeMap.get(ev.End_Time__c));
                        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,''+EndTime));
                        myEvent.eYr=ev.Schedule_End_Time__c.year();
                        myEvent.eMn=ev.Schedule_End_Time__c.month();
                        myEvent.eDd=ev.Schedule_End_Time__c.day();
                        myEvent.eH=ev.Schedule_End_Time__c.hour();
                        myEvent.eM=ev.Schedule_End_Time__c.minute();
                        
                        //events.add(myEvent);
                   // }
                        
                    
                   
                    myEvent.uRL=ev.id;
                    myEvent.userId=ev.id;
                    //if(ev.Instructor__c!=null)
                    if(IntegerUserMap.get(clsroom.trim())!=null)
                    myEvent.userName=IntegerUserMap.get(clsroom.trim());
                    
                    // myEvent.userName=OppMap.get(ev.WhatId).owner.name;
                    
                    if(ev.description__c!=null)
                        myEvent.description=ev.description__c.replace('\r\n', ' ').replace('\r\n', ' ').replace('\n', ' ').replace('\r', ' ').replace('\'', ' ');
                    system.debug(ev.description__c);
                    system.debug(ev.id);
                }
           }
            
                    
                
        }
      
         return null;   
    }
    public pagereference save1()
    {
        if(recordtypeid!=null && recordtypemap.get(recordtypeid)!=null)
        {
                if(instructorid!=null)
                {
                    clspak.Date__c=date.parse(clspackdate);
                    clspak.recordtypeid=recordtypemap.get(recordtypeid);
                    if(recordtypeid=='Private Lessons' && clspak.Student__c!=null)
                    {
                        clspak.Name='Private Lesson_'+[select id,name from Account where id=:clspak.Student__c limit 1].name;
                    }
                    clspak.Start_Time__c=clspackstarttime;
                    clspak.End_Time__c=   clspackendtime; 
                    if(clspak.of_Weeks__c==null)
                        clspak.of_Weeks__c=1;   
                    clspak.Instructor__c=instidd;
                    if(subinstidd!=null)
                    clspak.Instructor_2__c=subinstidd;
                    if(bookedbyid!=null)
                        clspak.Counselor__c=bookedbyid;
                    /*if(instructorid!=null)
                    {clspak.Instructor__c=instructorid;}*/
                    if(classroomid!=null)
                    clspak.Class_Room__c=classroomid;
                        
                    
                   
                   // pagereference pr=new pagereference('/apex/ScheduleCalendarpage?dance='+instrct.Dance_Style_Specialties__c+'&subdance'+instrct.Sub_Dance_Style__c+'&instrs='+instructorname);
                    //pr.setredirect(true);
                   // return pr;
                   if(recordtypeid=='Private Lessons' && Classroommap.get(privateclassroomid)!=null)
                   {
                       clspak.Class_Room__c=privateclassroomid;
                       if(Classroommap.get(privateclassroomid).Allocated_Private_Lessons__c==null)
                           Classroommap.get(privateclassroomid).Allocated_Private_Lessons__c=1;
                       else Classroommap.get(privateclassroomid).Allocated_Private_Lessons__c=Classroommap.get(privateclassroomid).Allocated_Private_Lessons__c+1;
                       update Classroommap.get(privateclassroomid);
                   }
                    insert clspak;
                    pageLoad();
                    
                }
                else 
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,'Please Select Instructor.')); 
                    
                }
          
            
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,'Please Select Record Type.')); 
            
        }
        clspak=new Classes_Packages__c();
        instructorid='';
        recordtypeid='';
        privateclassroomid='';
        Searchclassroom();
         return null;
    }
    public void cancel()
    {
        clspak=new Classes_Packages__c();
        instructorid='';
        recordtypeid='';
        privateclassroomid='';
         if(Purchaseid!=null)
        recordtypeid='Private Lessons';
        if(Studentaccountid!=null)
        clspak.Student__c=Studentaccountid;
    }
    public void update2()
    {
        string cpid=apexpages.currentpage().getparameters().get('CPid');
        string UpdateStartDate=apexpages.currentpage().getparameters().get('UStartDate');
        string UpdateStartTime=apexpages.currentpage().getparameters().get('Ustarttime');
        string UpdateEndTime=apexpages.currentpage().getparameters().get('Uendtime');
        string Instructorid=apexpages.currentpage().getparameters().get('Instructorid');
        if(cpid!=null)
        {
            Classes_Packages__c cpack=[select id,name from Classes_Packages__c where id=:cpid];
            cpack.Start_Time__c=UpdateStartTime;
            cpack.End_Time__c=UpdateEndTime;
            cpack.Date__c=date.valueof(UpdateStartDate);
            cpack.Instructor__c=Instructorid;
            update cpack;
        }
    }
    public pagereference deletemeth()
    {
        string delid=apexpages.currentpage().getparameters().get('delid');
        system.debug(delid);
        if(delid!=null && delid!='undefined')
        {
             Classes_Packages__c   ccc=[select id from Classes_Packages__c  where id=:delid];
            delete ccc;
           
            integer count=0;
            for(calEvent evv:events)
            {
                if(evv.eid==delid)
                    break;
              count++;      
            }
            events.remove(count);
            
        }
        pageLoad();
        return null;
    }
    
    //Class to hold calendar event data
      public class calEvent
    {
        public string TeamName{get;set;}
        public string EventName{get;set;}
        public string isevent{get;set;}
        public String title {get;set;}
        public string eid{get;set;}
        public string Summory{get;set;}
        public string CustomerName{get;set;}
        public string ColorCode{get;set;}
        public string GoogleLink{get;set;}
        public string ServiceSite{get;set;}
        public string Accountid{get;set;}
        public string ServiceSiteName{get;set;}
        public string Orderedby{get;set;}
        public string imagelink{get;set;}
        public integer sYr{get;set;}
        public integer sMn{get;set;}
        public integer sDd{get;set;}
        public integer sH{get;set;}
        public integer sM{get;set;}
        
        public integer eYr{get;set;}
        public integer eMn{get;set;}
        public integer eDd{get;set;}
        public integer eH{get;set;}
        public integer eM{get;set;}
        
        Public integer userName{get;set;}
        
        Public string uRL{get;set;}
        public string userId{get;set;}
        public datetime startString{get;set;}
        public datetime endString{get;set;}
        public string StartTime{get;set;}
        public string EndTime{get;set;}
        public string Todaydate{get;set;}
        public string Location{get;set;}
        public string description{get;set;}
        public string ebcolor{get;set;}
        public calEvent()
        {
            ebcolor='';
            imagelink='';
            ServiceSiteName='';
            Orderedby='';
            ServiceSite='';
            Accountid='';
            Summory='';
            CustomerName='';
            TeamName='';
            EventName='';
            isevent='';
            description='';
            StartTime='';
            EndTime='';
            Todaydate='';
            Location='';
            title='';
            eid='';
            sYr=0;
            sMn=0;
            sDd=0;
            sH=0;
            sM=0;
            eYr=0;
            eMn=0;
            eDd=0;
            eH=0;
            eM=0;
            uRL='';
            userId='';
            userName=0;
            ColorCode='';
            GoogleLink='';
            //startString='';
            //endString='';
        }
    }
    public class skilltype
    {
        public boolean Selectskill{get;set;}
        public string skillname{get;set;}
        public skilltype()
        {
            skillname='';
            Selectskill=false;
        }
    }
   
}