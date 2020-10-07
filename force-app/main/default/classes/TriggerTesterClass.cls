@isTest
public with sharing class TriggerTesterClass {
    @isTest static void campaign(){
        campaign o = TriggerDataFactor.campaign1();
        campaign o1 = TriggerDataFactor.campaign2();
        Test.startTest();
        o.Status='Completed';
        Database.update(o, false);
        o1.Status='Completed';
        Database.update(o1, false);
        
        Test.stopTest();
       
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
    }
    @isTest static void contact(){
        contact o = TriggerDataFactor.contact();
        
        Test.startTest();
        Database.update(o, false);
        Database.Delete(o,false);
        Test.stopTest();
}
    @isTest static void Event(){
       Event_Participent__c cs = TriggerDataFactor.EventParticipent();
       Event_Participent__c cv = new Event_Participent__c();
       cv.Contact_Name__c = cs.Contact_Name__c;
       cv.CustomEvent__c = cs.CustomEvent__c;
        Test.startTest();
        Database.insert(cs, false);
        Database.insert(cv, false);
        Test.stopTest();
}
@isTest static void opportunity(){
    opportunityLineItem o = TriggerDataFactor.OpportunityLI();
    Test.startTest();
    Database.insert(o, false);
    Test.stopTest();
}
@isTest static void plsn(){
    List<Plan__c> o = TriggerDataFactor.plan();
    Plan__C c = new Plan__C();
        c.Travel_Hours__c = 4;
        c.Travel_Location__c = 'A;B';
    Test.startTest();
    Database.insert(o, false);
    Database.insert(c, false);
    Test.stopTest();
}
}