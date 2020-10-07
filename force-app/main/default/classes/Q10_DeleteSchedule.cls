public with sharing class Q10_DeleteSchedule {
    public Q10_DeleteSchedule() {
    List<CronTrigger> cron = [select id from CronTrigger where CronJobDetail.Name Like 's%'];
    for(CronTrigger c:cron){
        system.abortJob(c.id);
    }
    
    }
}