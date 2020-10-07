global with sharing class Q8_countContact implements Database.Batchable<sObject>{
    public Q8_countContact() {

    }
 global Database.QueryLocator start(Database.BatchableContext BC){
     return Database.getQueryLocator('Select Id, name, Accountid from Contact where AccountId!=null limit 5000');
 }
 global void execute(Database.BatchableContext BC,List<Contact> scope){
     set<id> ids = new set<id>();
     for(Contact c:scope){
      ids.add(c.AccountId);
     }
     List<Account> acclist = [select id, Count__c from Account where id IN:ids];
     Map<id,List<Contact>> countContactMap = new Map<id,List<Contact>>();
     for(Contact c:scope){
         if(!countContactMap.containskey(c.AccountId)){
            countContactMap.put(c.AccountId,new List<Contact>());
         }
         countContactMap.get(c.AccountId).add(c);
     }
     for(Account a:acclist){
        if(countContactMap.containskey(a.id)){
            a.Count__c=countContactMap.get(a.id).size();
        }
     }
     Database.update(acclist,false);
 }
 global void finish(database.BatchableContext BC){
    system.System.debug('completed');
}
}