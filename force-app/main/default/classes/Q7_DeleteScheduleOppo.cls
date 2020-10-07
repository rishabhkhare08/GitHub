global with sharing class Q7_DeleteScheduleOppo {
    global Q7_DeleteScheduleOppo() {
     CronTrigger cron  = [select id from CronTrigger where CronJobDetail.Name='Q6_opportunitycreate'];
      System.abortJob(cron.id);
    }
}