public with sharing class Q2_Class {
   public static List<Contact> Q2_Method(){
    Database.SaveResult[] result;
    List<Contact> con = new List<Contact>();
    List<Account> accs = [select Id from Account];
    for(integer i=0;i<10;i++){
        Contact co = new Contact();
        co.LastName='Name'+i;
        co.AccountId=accs[i].Id;
        con.add(co);
    }
    insert con;         
   return con;
}
}