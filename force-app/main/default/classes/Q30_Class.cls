public with sharing class Q30_Class {
    public static void Q30_method() {
        List<Account> acc = [select Id from Account];
        List<Id> account= new List<Id>();
        List<Account> AC = new List<Account>();
        for(Account o:acc){
            account.add(o.Id);
        }
        List<Opportunity> op=[Select AccountID from Opportunity where StageName='Closed Won'];
        List<id> opportunity= new List<id>();
        for(Opportunity o:op){
            opportunity.add(o.AccountId);
        }
        for(Integer j=0;j<acc.size();j++){
            Integer ih=0;
            for(Integer i=0;i<op.size();i++){
                if(account.get(j)==opportunity.get(i)){
                    ih++;
                    if(ih>=2){
                       AC.add([select Name from Account where id=:account.get(j)]);
                        j++;
                        i=0;
                    }
                }
            }
        }
        for(Account a:AC){
            System.debug(a.Name);
        }
    }
}