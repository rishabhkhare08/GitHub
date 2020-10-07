public with sharing class AccountDetailsWrapper {
Public List<Account> accountList{get;set;}
public List<Contact> contactList{get;set;}
public List<Opportunity> opptList{get;set;}
public Map<id,List<Contact>> AccountidVsContactListMap{get;set;}
public Map<id,List<Opportunity>> AccountidVsopptMap{get;set;}
public List<wrapper> wrapperlist{get;set;}
//public List<opptwrapper> opptwrapperlist{get;set;}
    
    public List<wrapper> getAccountDetailsWrapper(){
        AccountidVsContactListMap = new Map<id,List<Contact>>();
        AccountidVsopptMap = new Map<id,List<Opportunity>>();
        
        //opptwrapperlist = new List<opptwrapper>();
        //conwrapperlist = new List<conwrapper>();
        accountList = new List<Account>();
        contactList = new List<Contact>();
        opptList = new List<Opportunity>();
        
        accountList =[SELECT Name, Rating, Industry, phone, Website FROM Account LIMIT 5];
        set<id> ids = new set<id>();
    if(!accountList.isEmpty() && accountList.size()>0){
       
        for(Account a:accountList){
         ids.add(a.id);
        }
    }
        contactList = [SELECT Name, Email, phone, Accountid FROM Contact WHERE AccountID IN:ids LIMIT 10000];
         opptList = [SELECT StageName, Name, CloseDate, AccountID FROM Opportunity WHERE AccountID IN:ids LIMIT 10000];
        if(!accountList.isEmpty() && !contactList.isEmpty() &&accountList.size()>0 && contactList.size()>0){
              for(Contact c:contactList){
                if(!AccountidVsContactListMap.containskey(c.Accountid)){
              AccountidVsContactListMap.put(c.Accountid, new List<Contact>());
          }
          AccountidVsContactListMap.get(c.Accountid).add(c);
       }
}
else {
    System.debug('List is Null');
}
if(!accountList.isEmpty() && !opptList.isEmpty() && opptList.size()>0 &&accountList.size()>0){
        for(Opportunity op:opptList){
            if(!AccountidVsopptMap.containskey(op.Accountid)){
                AccountidVsopptMap.put(op.Accountid, new List<Opportunity>());
            }
            AccountidVsopptMap.get(op.Accountid).add(op);
         }
      }
      else {
        System.debug('List is Null');
        system.debug(AccountidVsContactListMap);
    }
    List<wrapper> wrapperlist = new List<wrapper>();
      for(Account a:accountList){
        wrapper wp = new wrapper();
          if(AccountidVsContactListMap.containskey(a.id) && AccountidVsopptMap.containskey(a.id)){
            wp.conrecord = AccountidVsContactListMap.get(a.id);
            wp.opptrecord = AccountidVsopptMap.get(a.id);
            wp.acc = a;
          }
          else if(AccountidVsContactListMap.containskey(a.id)){
            wp.conrecord = AccountidVsContactListMap.get(a.id);
            wp.acc=a;
          }
          else if(AccountidVsopptMap.containskey(a.id)){
            wp.opptrecord = AccountidVsopptMap.get(a.id);
            wp.acc=a;
          }
          else{
              wp.acc=a;
          }
          wrapperlist.add(wp);

      }
      for(Integer i=0;i<5;i++)
      System.debug(wrapperlist[i]);
       return wrapperlist;
    }
    // for(Account a: accountList){
    //     if(AccountidVsContactListMap.containskey(a.id)){
    //        for(conwrapper c: AccountidVsContactListMap.get(a.id)){
    //              conwrapperlist.add(c);
    //        }
    //     }
    // }
    //     for(Account a: accountList){
    //         if(AccountidVsopptMap.containskey(a.id)){
    //            for(opptwrapper op: AccountidVsopptMap.get(a.id)){
    //                  opptwrapperlist.add(op);
    //            }
    //         }
    // }
    // System.debug(opptwrapperlist);

    
    // public class conwrapper{
    //     public String Phone{get;set;}
    //     public String CName{get;set;} 
    //     public String Aname{get;set;}
    //    public String Email{get;set;}
    //    public id AccountID{get;set;}
    //     public conwrapper(Account acc, Contact con){
    //           Phone = con.Phone;
    //           CName = con.Name;
    //           AName = acc.Name;
    //           Email = con.Email;
    //           AccountID = con.AccountID;
    //         }
    // }
    // public class opptwrapper{
    //     public String StageName{get;set;}
    //     public Date CloseDate{get;set;}
    //     public String AName{get;set;}
    //     public String Name{get;set;}
    //     public id AccountID{get;set;}

    //     public opptwrapper(Account acc, Opportunity opp){
    //         StageName = opp.StageName;
    //         CloseDate = opp.CloseDate;
    //         Name = opp.Name;
    //         AName = acc.Name;
    //         AccountID = opp.AccountID;
    //     }

    // }
   
}