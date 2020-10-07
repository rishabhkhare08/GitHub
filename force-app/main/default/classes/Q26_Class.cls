public with sharing class Q26_Class {
    public static List<Account>  Q26_method() {
        List<OpportunityLineItem> oli=[select Opportunityid from OpportunityLineItem];
        set<id>Accids = new Set<Id>();
        List<Opportunity> opp = [select id, AccountId,name from Opportunity where AccountId!=null];
        for(Opportunity o: opp){
            Integer i=0;
            for(OpportunityLineItem ol:oli){
                if(ol.OpportunityId==o.Id){
                    i++;
                    if(i>=2){
                        accids.add(o.Accountid);
                    }
                }
            }
        }
        List<Account> acc =[Select Name from Account where id IN:accids];
        for(Account a:acc){
            System.debug(a.Name);
        }
        return acc;
    }
}