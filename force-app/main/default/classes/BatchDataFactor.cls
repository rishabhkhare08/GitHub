@isTest
public with sharing class BatchDataFactor {
    public static void B1_method(Integer num){
        List<Account> acc = new List<Account>();
        for(Integer i=0;i<num;i++){
            Account a = new Account();
            a.name = 'Batch';
            acc.add(a);
        }
        insert acc;
    }
    public static void B4_method(){
    Account a = new Account();
    a.Name = 'rshi';
    insert a;
    List<Contact> con = new List<contact>();
    for(Integer i=0;i<5;i++){
        contact c = new Contact();
        c.LastName = 'fs';
        con.add(c);
    }
   
    }
    public static void CreateLead(){
        Lead l = new Lead();
        l.LastName='dd';
        l.Company = 'sd';
        insert l;
    }
}