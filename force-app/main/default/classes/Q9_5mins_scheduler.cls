global with sharing class Q9_5mins_scheduler  implements Schedulable{
global void execute(SchedulableContext SC){
    Q8_countContact q8 = new Q8_countContact();
    Database.executeBatch(q8);
}
}