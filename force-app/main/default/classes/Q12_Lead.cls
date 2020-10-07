global with sharing class Q12_Lead implements Database.Batchable<sObject>{
    String s='';
    public Q12_Lead() {

    }
    global Database.Querylocator start(database.BatchableContext BC){
        return Database.getQueryLocator('select Name from Lead where Phone=null limit 10000');
    }
    global void execute(Database.BatchableContext BC,List<Lead> scope){
       for(Lead l:scope){
          s +=l.Name; 
       }
    }
    global void finish(Database.BatchableContext BC){
     AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
     TotalJobItems, CreatedBy.Email
     FROM AsyncApexJob WHERE Id =
     :BC.getJobId()];
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     mail.setToAddresses(new String[] {a.CreatedBy.Email});
     mail.setSubject('batch program');
     mail.setPlainTextBody(' total job '+a.TotalJobItems+s);
     Messaging.SendEmail(new Messaging.SingleEmailMessage[]{mail}); 
    }
}