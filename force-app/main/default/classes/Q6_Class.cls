public with sharing class Q6_Class {
public static List<Opportunity> Q6_Method(){
    List<Opportunity> opps = [select Name, CloseDate from Opportunity where CloseDate > TODAY];
    for(Opportunity op:opps){
        op.Name=op.Name+'F';
        
    }
     update opps;
     return opps;
}
}