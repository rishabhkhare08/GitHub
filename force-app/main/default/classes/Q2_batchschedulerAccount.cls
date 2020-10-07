global class Q2_batchschedulerAccount implements Schedulable{
    global void execute(SchedulableContext SC){
        Q1_batchDeleteAccount deleteacc = new Q1_batchDeleteAccount();
        Database.executeBatch(deleteacc);
    }
}