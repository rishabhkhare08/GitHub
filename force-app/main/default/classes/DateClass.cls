public class DateClass {
   public void opportunityMethod(){
        String[] name = new List<String>{'Rishabh','shivam',
    'Rajat','nishchal','Shubham','Mohit','Kashish','Amit','Rio','Berlin',
            'SRK','Manoj','Cloud','analogy','Class','Salman','Data','Ajay','akshay','Amir'}; 
        
          integer[] day = new List<integer>{2,4,5,4,2,12,21,30,26,20,25,13,14,15,16,17,18,19,22,23};
              
            integer[] month = new List<integer>{01,02,03,04,05,06,07,08,09,10,11,12};
                
                integer[] year = new List<integer>{1997,1998,1999,2000,2001,2002,2004,2005};
                    
                    String[] stage = new List<String>{'prospecting','Qualification','Needs Analysis',
                        'Value Propositon','Id decision Makers','perception Analysis','Proposal/Price Quote',
                        'Negotiation/Review','Closed Won','Closed Lost'};
                            
      List<Opportunity> opps = new List<Opportunity>();
       integer j=0,k=0,h=0;
       for(integer i=0;i<20;i++){           
          Opportunity op = new Opportunity();
           op.Name = name[i];
           if(j<12){
           op.CloseDate = date.newInstance(year[h], month[j], day[i]);
           j++;
               if(j==11){
               j=0;
               h++;
               }
           }
           op.StageName = 'prospecting'; 
           
           opps.add(op);
       }
       insert opps;
    }
}