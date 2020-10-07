public with sharing class TestWrapper {
 public List<Account> acc = new List<Account>();
 public List<contact> con = new List<contact>();
 public List<wrapper> wrap = new List<wrapper>();

 public List<wrapper> gettestMethodWrap(){
    acc=[SELECT Name From Account LIMIT 10];
    set<id> ids = new set<id>();
    for(Account a:acc){
      ids.add(a.id);
    }
    con = [SELECT LastName FROM contact LIMIT 10];
    System.debug(acc);
    System.debug(con);
     for(Integer i=0;i<10;i++){
       wrap.add(new wrapper(acc[i].Name,con[i].LastName));
     }
     System.debug(wrap);
     return wrap;
 }
 public class wrapper{
     public String Aname{get;set;}
     public String Cname{get;set;}
 public wrapper(String Name, String LastName){
  Aname=Name;
  Cname=LastName;
 }
}
}