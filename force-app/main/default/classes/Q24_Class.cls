public with sharing class Q24_Class {
    public static List<lead> Q24_method() {
        List<Lead> leadList = new List<Lead>();
        DateTime dt = Date.newInstance(2019, 1, 1);
        Integer y = dt.year();
        leadList = [SELECT Name,CreatedDate From Lead WHERE CALENDAR_YEAR(CreatedDate) =: y 
        AND (Records__c = 'Seller' OR Records__c = 'Tenant')];
    return leadList;
    }
}