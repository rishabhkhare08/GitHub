public class ContactProgram {
    public static void beforeInsertMethod(List<Contact> contactList){
        set<id> ids = new set<id>();
        set<id> accids = new set<id>();
        Set<Account> accountset = new Set<Account>();
        for(Contact iteratecon: contactList){
            if(iteratecon.AccountId!=null && iteratecon.OwnerId!=null){
                ids.add(iteratecon.OwnerId);
                accids.add(iteratecon.AccountId);
            }
        }
        List<Account> accaddress = [select id, Billingcity, BillingState, BillingPostalcode, BillingCountry, Multiple_Contact__c from Account where id IN:accids limit 10000];
        Map<id,Account> accountMap=new Map<id,Account>();
        for(Account c:accaddress){
            if(!accountMap.containsKey(c.Id)){
                accountMap.put(c.Id,c);
            }
        }
        List<User> userAddress = [Select id, city, State, Postalcode, country from user where id IN:ids limit 10000];
        for(Contact iteratecon:contactList){
            if(iteratecon.AccountId!=null && iteratecon.OwnerId!=null){
                if(String.isBlank(iteratecon.MailingCity) && String.isBlank(iteratecon.MailingState) && 
                   String.isBlank(iteratecon.MailingPostalCode) && String.isBlank(iteratecon.MailingCountry)){
                       for(User iterateuser:userAddress){
                           iteratecon.MailingCity=iterateuser.city;
                           iteratecon.Same_Country_as_User_Company__c=true;
                           iteratecon.MailingState=iterateuser.State;
                           iteratecon.MailingPostalcode=iterateuser.PostalCode;
                           iteratecon.MailingCountry=iterateuser.Country;
                           if(accountMap.containskey(iteratecon.AccountId)){
                               Account a=accountMap.get(iteratecon.AccountId);
                               a.id=iteratecon.AccountId;
                               a.BillingCity=iterateuser.City;
                               a.BillingCountry=iterateuser.Country;
                               a.BillingPostalCode=iterateuser.PostalCode;
                               a.BillingState=iterateuser.State;
                               accountMap.put(iteratecon.AccountId,a);
                           }
                           
                       }  
                   }
            }
        }
        
        update accountMap.Values(); 
    }
    public static void multiContactMethod(List<Contact> contactlist){
         set<id> ids = new set<id>();
        set<id> accids = new set<id>();
        Set<Account> accountset = new Set<Account>();
        for(Contact iteratecon: contactList){
            if(iteratecon.AccountId!=null){
                accids.add(iteratecon.AccountId);
            }
        }

        List<Account> accountlist = [select id, Multiple_Contact__c from Account limit 10000];
        List<Contact> oldcontactlist = [select id, Accountid from Contact where AccountId in:accids limit 10000];
        //map contain old records of contact
        Map<id,List<Contact>> oldContactMap = new Map<id,List<Contact>>();
        for(Contact con:oldcontactlist){
            if(!oldContactMap.Containskey(con.Accountid)){
                oldContactMap.put(con.Accountid, new List<Contact>());
            }
            oldContactMap.get(con.Accountid).add(con);
        }//map contain inserting contact record
         for(Contact con:contactlist){
            if(!oldContactMap.Containskey(con.Accountid)){
                oldContactMap.put(con.Accountid, new List<Contact>());
            }
            oldContactMap.get(con.Accountid).add(con);
        }//map contain account record
        Map<id,Boolean> accountMap = new Map<id,Boolean>();
         for(Account a:accountlist){
            if(!accountMap.Containskey(a.id)){
                accountMap.put(a.id,a.Multiple_Contact__c);
            }
        }
           for(Contact iteratecon:contactlist){
                   Integer count=0;  
               if(oldContactMap.containskey(iteratecon.AccountId)){
                   //check if account id exist in contact and get the multiple_contact__C checkbox value from account and check it is false or true. 
                   if(oldcontactMap.get(iteratecon.AccountId).size()>=2 && accountMap.get(iteratecon.AccountId)==false){
                       iteratecon.adderror('you can not make contact with this account because it is not allowed multiple account');
                   }   
               }
        }
    }
    public static void sameAccountAddress(List<Contact> contactlist){
        list<Account> accountlist = new List<Account>();
        set<id> accountids = new set<id>();
        for(Contact c:contactlist){
            if(c.Accountid!=null){ 
                accountids.add(c.Accountid);
            }        
        }
        accountlist = [SELECT Id, BillingState, BillingStreet, BillingCity, BillingPostalCode, BillingCountry FROM Account where id IN:accountids];
        Map<id,Account> accountMap = new Map<id,Account>();
        for(Account acc:accountlist){
            if(!accountMap.containskey(acc.id)){
                accountMap.put(acc.id,acc);
            }
        }
      
        for(Contact c:contactlist){
            if(accountMap.containskey(c.Accountid)){
                Account a = accountMap.get(c.Accountid);
                a.BillingStreet=c.MailingStreet;
                a.BillingCity=c.MailingCity;
                a.BillingState=c.MailingState;
                a.BillingPostalCode=c.MailingPostalcode;
                a.BillingCountry=c.MailingCountry;
                accountMap.put(a.id,a);
            }
        }
        update accountMap.values();
    }
    public static void ContactCountryMethod(List<Contact> contactlist){
        set<id> accountids = new set<id>();
        set<id> userids = new set<id>();
        for(Contact c:contactlist){
            if(c.AccountId!=null && c.OwnerId!=null){
                accountids.add(c.Accountid);
                userids.add(c.OwnerId);
            }
        }
        List<Account> accountlist = [select BillingCountry from Account where id IN:accountids];
        List<User> userlist = [select country from User where Id IN:userids];
        for(contact c: contactlist){
            if(c.Same_Country_as_User_Company__c==true){
                for(user iterateUser:userlist){
                    for(Account iterateacc:accountlist){
                        if(c.MailingCountry!=iterateuser.Country && c.MailingCountry!=iterateacc.BillingCountry){
                            c.addError('contact country must be same as User and Company');
                        }
                    }
                }
            }
        }
    }
    public static void afterInsertMethod(List<Contact> con){
        List<Account> acc = new List<Account>();
        List<Account> ac = new List<Account>();
        set<id> ids = new set<id>();
        for(contact c:con){
            ids.add(c.AccountId);
        }
        acc = [select id, Name from Account where id IN:ids];
        for(Contact c:con){   
            for(Account a:acc){
                if(c.AccountId==a.id){
                    if((a.Name.length()+c.LastName.length())<255){
                    a.Name+=' '+c.LastName;
                    ac.add(a);
                }
                }
            }
        }
        if(acc.size()>0){
            update(acc);
            
        }    
    }
    public static void afterUpdateMethod(List<Contact> connew, List<Contact> conold){
        set<id> ids = new set<id>();
        for(Integer i=0;i<connew.size();i++){
            if(connew[i].Accountid!=null){ids.add(connew[i].AccountId);}    
            else if(connew[i].Accountid==null){ids.add(conold[i].AccountId);}
        }
        List<Account> account = new List<Account>();
        List<Account> acc=new List<Account>();
        account=[select Id,Name from Account where id IN:ids limit 10000];
        Map<id,String> oldConMap = new Map<id,String>();
        for(Contact c:conold){
            if(!oldconMap.containsKey(c.id)){
                oldconMap.put(c.id,c.LastName);
            }
        }
        Map<id,String> newConMap = new Map<id,String>();
           for(Contact c:connew){
            if(!newConMap.containsKey(c.id)){
                newConMap.put(c.id,c.LastName);
            }
           
        }
        Map<id,Account> accountMap = new Map<id,Account>();
        for(Account a:account){
            if(!accountMap.containskey(a.id)){
                accountMap.put(a.id,a);
            }
        }
       
        for(Contact c:connew){
            if(oldconMap.containskey(c.id) && newconMap.containskey(c.id) && accountMap.containskey(c.Accountid)){
                if(accountMap.get(c.Accountid).Name.length()<255){
                    string[] s=accountMap.get(c.Accountid).Name.split(' ');
                    String replaceName='';
                    for(String st:s){
                        if(oldconMap.get(c.id).equals(st)){
                            replaceName+=newconMap.get(c.id);
                        }
                        else
                             replaceName+=' '+st;
                    }
                    Account a = accountMap.get(c.Accountid);
                    a.Name = replaceName;
                    accountMap.put(c.accountid,a);
                }
                else{
                  c.adderror('length of account name is exceeding from 255, and saleforce has limit for name field 255 characters');  
                }
            }
        }
        update accountMap.values();
    }
    
    public static void afterDeleteMethod(List<Contact> conold){
        List<Account> acc=new List<Account>();
        set<id> ids= new set<id>();
        for(Contact c:conold){
            ids.add(c.AccountId);
        }
        List<Account> ab = new List<Account>();
        ab=[select id,Name from Account where ID IN:ids];
        for(Account a:ab){
            for(Integer i=0;i<conold.size();i++){
                if(conold[i].AccountId!=null){
                    system.debug(a.Name);
                    a.Name=(a.Name).replaceFirst(conold[i].LastName,'');
                   
                }
            }
        }
        update ab;
    }
}