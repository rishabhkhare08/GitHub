public with sharing class Q32_Class {
    public static void  Q32_method() {
        List<Opportunity> oppor = [select id from Opportunity where AccountId IN(Select Id from Account where Working_In__c='ASIA')];
        List<id> ids = new List<id>();
        for(Opportunity o:oppor){
            ids.add(o.Id);
        }
        decimal total=0;
        List<OpportunityLineItem> oli = [select Quantity from OpportunityLineItem where OpportunityId IN:ids];
        for(OpportunityLineItem o:oli){
            total+=o.Quantity;
        }
        System.debug(total);
    }
}