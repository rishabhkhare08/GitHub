@isTest
public with sharing class BatchTesterClass {
    @isTest static void B1_method(){
        BatchDataFactor.B1_method(5);
        Database.executeBatch(new Q1_batchDeleteAccount());

    }
    @isTest static void B2_method(){
        
        String s2 = '0 0 12 1/1 * ? *';
        Q2_batchschedulerAccount q2 = new Q2_batchschedulerAccount();
        system.schedule('JobName', s2, q2);
    }
    @isTest static void B3_method(){
     B2_method();
     Q3_batchAbortSchedule q3 = new Q3_batchAbortSchedule(); 
     
    }
    @isTest static void B4_method(){
        BatchDataFactor.B4_method();
        Q5_createOppo q2 = new Q5_createOppo();
        Database.executeBatch(q2);
    }
    @isTest static void B5_method(){
        Q5_scheduleOppo q2 = new Q5_scheduleOppo();
        String s2 = '0 0 12 1/1 * ? *';
        system.schedule('JobName', s2, q2);
        
    }
    @isTest static void B6_method(){
        Q6_oppo q2 = new Q6_oppo();
        String s2 = '0 0 6 1/1 * ? *';
        system.schedule('Q6_opportunitycreate', s2, q2);
        
    }
    @isTest static void B7_method(){
        B6_method();
        Q7_DeleteScheduleOppo q3 = new Q7_DeleteScheduleOppo(); 
        
       }
       @isTest static void B8_method(){
        BatchDataFactor.B4_method();
        Q8_countContact q3 = new Q8_countContact(); 
       }
       @isTest static void B9_method(){
        for(Integer i=0;i<12;i++){
            String s12 = '0 '+i*5+' * * * ?';
        Q9_5mins_scheduler q1 = new Q9_5mins_scheduler();
        system.schedule('s'+i, s12, q1);
        }
       }
       @isTest static void B10_method(){
        B9_method();
        Q10_DeleteSchedule q3 = new Q10_DeleteSchedule(); 
       }
       @isTest static void B12_method(){
        BatchDataFactor.CreateLead();
        Q12_Lead q1 = new Q12_Lead(); 
        Database.executeBatch(q1);
        String s2 = '0 0 0 1/1 * ? *';
        Q12_scheduleLead q12 = new Q12_scheduleLead();

       }
}