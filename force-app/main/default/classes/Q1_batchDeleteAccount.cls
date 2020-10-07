global class Q1_batchDeleteAccount implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT id from Account Where CreatedDate = Last_n_days:10');
    } 
    global void execute(Database.BatchableContext BC, List<sObject> Scope){
        Database.delete(scope,False);
        
    }
    global void finish(Database.BatchableContext BC){
        AsyncApexJob ab = [select id from AsyncApexJob where ID =:BC.getJobId()];
        system.debug(ab.id);
    }
}