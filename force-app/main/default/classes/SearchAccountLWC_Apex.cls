public with sharing class SearchAccountLWC_Apex {
    @AuraEnabled
    public static List<wrapper> getAccount(){
        List<wrapper> wrapperList = new List<wrapper>();
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Id, Name, Rating, Phone, Website, Industry FROM Account LIMIT 5];
        for(Account acc : accountList){
            wrapper wrap = new wrapper();
            wrap.accountRecord = acc;
            wrap.show = false;
            wrapperList.add(wrap);
        }
        return wrapperList;
    }
    @AuraEnabled
    public static String updateRecord(Account getAccountRecord){
      
        System.debug(getAccountRecord);
        try {
            update getAccountRecord;  
            String res = 'SUCCESS';  
            return res;
        } catch (Exception e) {
            return e.getMessage();
        }
        
    }  
    @AuraEnabled
    public static String deleteRecord(String Id){
        System.debug('>>>>>'+Id);
        List<Account> accountList = new List<Account>();
        accountList = [SELECT Name FROM Account WHERE id=:Id];
    try{
    delete accountList[0];
    return 'SUCCESS';    
    }catch(Exception e){
        return e.getMessage();
    }
    }
    public class wrapper{
        @AuraEnabled public Account accountRecord{get;set;}
        @AuraEnabled public Boolean show{get;set;}
           
    }
}