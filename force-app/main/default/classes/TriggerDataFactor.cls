@isTest
public with sharing class TriggerDataFactor {
    public Static campaign campaign1(){
        campaign c = new campaign();
        c.Name = 'res';
        insert c;
        PriceBook2 pb = new PriceBook2();
        pb.id = Test.getStandardPricebookId();
        upsert pb;
        Product2 p = new Product2();
         p.name = 'Gandhiji Chasma';
        insert p;
    
        priceBookEntry pbv = [Select id, UnitPrice from priceBookEntry 
        where PriceBook2Id=:Test.getStandardPricebookId() and Product2id=:p.id limit 1];
        Account a  = new Account();
        a.Name = 'CAKurukshetraQ26';
        insert a;
    
        Opportunity op = new Opportunity();
        op.Name = 'nameriss';
        op.AccountId=a.id;
        op.campaignid=c.id;
        op.CloseDate = System.Today().addDays(20);
        op.StageName = 'Need Analysis';
        insert op;
    
        OpportunityLineItem oli1 = new OpportunityLineItem();
        oli1.priceBookEntryid = pbv.id;
        oli1.Opportunityid = op.id;
        oli1.UnitPrice=100;
        oli1.Quantity = 100;
        insert oli1;
        Op.StageName='Closed Won';
        update op;
        return c;
    }
    public Static campaign campaign2(){
        campaign c = new campaign();
        c.Name = 'res';
        insert c;
        Account a  = new Account();
        a.Name = 'CAKurukshetraQ26';
        insert a;
        Opportunity op = new Opportunity();
        op.Name = 'nameriss';
        op.AccountId=a.id;
        op.campaignid=c.id;
        op.CloseDate = System.Today().addDays(20);
        op.StageName = 'Need Analysis';
        insert op;
        return c;
}
public static contact contact(){
    Account a  = new Account();
        a.Name = 'CAQ26';
        insert a;
        contact c = new Contact();
        c.LastName = '12';
        c.AccountId=a.id;
        insert c;
        c.LastName='12';
        update c;
        return c;

}
public static Event_Participent__c EventParticipent(){

    contact c = new Contact();
    c.LastName = '12';
    insert c;
    CustomEvent__c c1 = new CustomEvent__c();
    c1.Name = 'fdas';
    c1.Event_Date__c=system.today();
    insert c1; 
    Event_Participent__c e = new Event_Participent__c();
    e.Contact_Name__c=c.id;
    e.CustomEvent__c = c1.id; 
    insert e;
    return e;
}
public static OpportunityLineItem OpportunityLI(){
    PriceBook2 pb = new PriceBook2();
    pb.id = Test.getStandardPricebookId();
    upsert pb;
    Product2 p = new Product2();
     p.name = 'Gandhiji Chasma';
    insert p;

    priceBookEntry pbv = [Select id, UnitPrice from priceBookEntry 
    where PriceBook2Id=:Test.getStandardPricebookId() and Product2id=:p.id limit 1];
    Account a  = new Account();
    a.Name = 'CAKurukshetraQ26';
    insert a;

    Opportunity op = new Opportunity();
    op.Name = 'nameriss';
    op.AccountId=a.id;
    op.CloseDate = System.Today().addDays(20);
    op.StageName = 'Need Analysis';
    insert op;
    OpportunityLineItem oli1 = new OpportunityLineItem();
    oli1.priceBookEntryid = pbv.id;
    oli1.Opportunityid = op.id;
    oli1.UnitPrice=100;
    oli1.Quantity = 100;
    return oli1;
}
public static List<Plan__c> plan(){
    List<Plan__c> ca = new List<Plan__C>();
    for(Integer i=0;i<9;i++){
        Plan__C c = new Plan__C();
        c.Travel_Hours__c = 4;
        c.Travel_Location__c = 'A;B';
        ca.add(c);
    }
    return ca;

}
}