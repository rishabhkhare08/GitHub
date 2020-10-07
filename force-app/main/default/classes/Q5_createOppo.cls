global with sharing class Q5_createOppo implements Database.Batchable<sObject> {
    public Q5_createOppo() {

    }
global Database.QueryLocator start(Database.BatchableContext BC){
return Database.getQueryLocator('select id,name from account limit 50000');
}
global void execute(Database.BatchableContext BC, List<sObject> Scope){
 List<Opportunity> oppoList = new List<Opportunity>();
 for(Integer i=0;i<5;i++){
     Opportunity op = new Opportunity();
     op.Name = 'batchname'+i;
     op.AccountId = scope[0].id;
     op.StageName='Qualification';
     op.CloseDate=system.Today();
     oppolist.add(op);
}
database.insert(oppolist,false);
}
global void finish(Database.BatchableContext BC){
   system.debug('completed');
}
}