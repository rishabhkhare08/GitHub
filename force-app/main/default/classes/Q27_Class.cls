public with sharing class Q27_Class {
    public static Integer Q27_method() {
    List<Account> account=[select NumberOfEmployees from Account where Working_In__c includes('ASIA','NA')];
        Integer total=0;
      for(Account a:account){
      if(a.NumberOfEmployees!=null){  
      total+=a.NumberOfEmployees;
    }
 }
    System.debug(total);
    return total;
    }
}