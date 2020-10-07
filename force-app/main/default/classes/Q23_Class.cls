public with sharing class Q23_Class {
    public static List<Account> Q23_method() {
        List<Opportunity> op = [SELECT AccountId FROM Opportunity where 
        Id IN(SELECT OpportunityId from OpportunityLineItem where Quantity>100)];
set<ID> ids = new set<ID>();
for(Opportunity o: op){
ids.add(o.AccountId);    
}
List<Account> acc = [select Name from Account where Id =:ids];
for(Account a: acc){
System.debug(a.Name);    
}
return acc;
    }
}