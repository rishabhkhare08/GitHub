public with sharing class GetAccountLWC {
    @AuraEnabled
    public static Account getAccountRecord(){
        Account accountRecord = new Account();
        accountRecord = [SELECT Id, Bank_Name__c, IFSC_Code__c, Name, Address__c, Total_Amount__c FROM Account WHERE Id =: '0012v00002yEDPmAAO'];
        return accountRecord;
    }
}