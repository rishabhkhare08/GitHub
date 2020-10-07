global class Q3_batchAbortSchedule {
    global Q3_batchAbortSchedule(){
      CronTrigger cronlist = new CronTrigger();
        cronlist = [SELECT Id, State FROM CronTrigger where CronJobDetail.Name='JobName'];
       system.abortJob(cronlist.id);
    }
}