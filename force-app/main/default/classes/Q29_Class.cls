public with sharing class Q29_Class {
    public static void Q29_method() {
        List<OpportunityLineItem> opp=[SELECT totalPrice from OpportunityLineItem where Name 
        LIKE '%Gandhiji Chasma%' And OpportunityId IN(select id from Opportunity where 
        StageName='Closed Won')];
        Decimal sum=0;
        for(OpportunityLineItem Oppo:opp){
            sum+=oppo.TotalPrice;
        }
        System.debug(sum);
    }
}