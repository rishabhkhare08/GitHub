global with sharing class Q6_oppo implements Schedulable {
  global void execute(SchedulableContext SC){
        Database.executeBatch(new Q5_createOppo());
  }
}