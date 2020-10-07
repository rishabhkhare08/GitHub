public class TrigerAccount {
    public static void AccountMethod(List<Account> ls){
        List<Contact> con = new List<Contact>();
        for(Account a:ls){
        for(Integer j=0;j<ls.size();j++){
            if(ls[j].NumberOfEmployees>0){
                for(Integer i=0;i<ls[j].NumberOfEmployees;i++){
                    contact c = new Contact();
                    c.LastName='risi'+i;
                    c.AccountId=ls[j].id;
                    con.add(c);
                }
            }
        }
          } 
        if(con.size()>0){
            insert con;
        }
    }
    public static void createContactOppCaseMethod(List<Account> accountList){
        set<id> ids = new Set<id>();
        for(Account acc:accountList){
            ids.add(acc.id);
        }
        List<Contact> contactlist = [select id, AccountId from Contact where AccountID IN:ids];
        List<Case> caselist = new List<Case>();   
        for(Contact con:contactlist){
            Case newcase = new Case();
            newcase.AccountId = con.AccountId;
            newcase.ContactId = con.id;
            caselist.add(newcase);
        }
        List<Opportunity> opportuniytList = new List<Opportunity>();
        for(Contact con:contactlist){
            Opportunity oppo = new Opportunity();
            oppo.AccountId  =con.Accountid;
            oppo.Name = 'trigger';
            oppo.StageName='Closed Lost';
            oppo.CloseDate = system.today();
            opportuniytList.add(oppo);
        }
        insert opportuniytList;
        insert caselist;
    }
    public static void multiContactMethod(List<Account> accountList){
        for(Account a:accountList){
            if(a.multiple_contact__c!=true){
                a.addError('you can not insert multiple contact');
            }
        }
    }
    
}