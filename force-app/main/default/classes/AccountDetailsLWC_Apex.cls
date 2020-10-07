public with sharing class AccountDetailsLWC_Apex {
   @AuraEnabled
   public static wrapper accountRelatedList(){
       List<Account> accountList = new List<Account>();
       List<Contact> contactList = new List<contact>();
       List<Opportunity> opportunityList = new List<Opportunity>();
       set<Id> accids = new set<Id>();
       accountList = [SELECT Id, Name, Phone, Rating, Website FROM Account LIMIT 5];
       for(Account a : accountList){
           accids.add(a.Id);
       }
       contactList = [SELECT AccountId, Name, Email, Phone FROM Contact WHERE AccountId =:accids LIMIT 5];
       opportunityList = [SELECT AccountId, CloseDate, StageName, Name FROM Opportunity WHERE AccountId =:accids LIMIT 5];
       wrapper wrap = new wrapper();
       if(accountList.size()>0){
       wrap.accountList = accountList;
       }
       if(contactList.size()>0){
       wrap.contactList = contactList;
       }
       if(opportunityList.size()>0){
       wrap.opportunityList = opportunityList;
       }
       return wrap;
   }
   public class wrapper{
    @AuraEnabled public List<Account> accountList{get;set;}
    @AuraEnabled public List<Contact> contactList{get;set;}
    @AuraEnabled public List<Opportunity> opportunityList{get;set;}
    
   }
}