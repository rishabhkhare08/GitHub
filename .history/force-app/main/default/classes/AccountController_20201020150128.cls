public class AccountController {

public string searchName{get;set;}
public List<Account> accList{get;set;}
public boolean inputText{get;set;}
public boolean outputText{get;set;}
public Account accountid{get;set;}
public Account editAccName{get;set;}
public Account getAcc{get;set;}
public String editid{get;set;}    
public Integer Offset=0;
public Integer Limitset;   
public AccountController(){
accList = new List<Account>();
inputText = false;
outputText = true;
}

public String getParam(String name) {
return ApexPages.currentPage().getParameters().get(name);
}

Public void search(){
string str = searchName+'%';
string query = 'select id, Name, Phone from Account where Name Like :str';
accList = database.query(query);
}
public void cancelrecord(){
getacc=null;
search();
}
public void editAccName() {
editid = getParam('accountid');
getAcc = [SELECT id,Name,Phone FROM Account WHERE Id=:editid];
}

public void saveAccName(){  
    String editid = getParam('accountid1');
    Account updateAcc = new Account();
    for(Account accObj:accList){
        if(accObj.Id == editid){
            updateAcc.Id = accObj.Id;
            updateAcc.Name=accObj.Name;
            updateAcc.Phone=accObj.Phone;
        }   
    }
update updateAcc;

getAcc = null;
}
}