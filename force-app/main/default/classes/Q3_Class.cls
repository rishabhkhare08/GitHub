public with sharing class Q3_Class {
  public static List<Opportunity> Q3_method(){
    String[] name = new List<String>{'Rishabh','shivam',
    'Rajat','nishchal','Shubham','Mohit','Kashish','Amit','Rio','Berlin',
            'SRK','Manoj','Cloud','analogy','Class','Salman','Data','Ajay','akshay','Amir'}; 
                    String[] stage = new List<String>{'prospecting','Qualification','Needs Analysis',
                        'Value Propositon','Id decision Makers','perception Analysis','Proposal/Price Quote',
                        'Negotiation/Review','Closed Won','Closed Lost'};
                            
      List<Opportunity> opps = new List<Opportunity>();
       integer j=0,k=0,h=0;
       for(integer i=0;i<20;i++){           
          Opportunity op = new Opportunity();
           op.Name = name[i];
           op.CloseDate = System.Today().addDays(30);
          
           op.StageName = 'prospecting'; 
           
           opps.add(op);
       }
       insert opps;
       return opps;
  }
}