global with sharing class Q12_scheduleLead implements Schedulable {
    global void execute(SchedulableContext SC){
        Q12_Lead q12 = new Q12_Lead();
        Database.executeBatch(q12);
    }
}