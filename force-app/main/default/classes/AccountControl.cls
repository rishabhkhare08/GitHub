public class AccountControl {

public string searchName{get;set;}
public List<Account> accList{get;set;}
public boolean inputText{get;set;}
public boolean outputText{get;set;}
public Account accountid{get;set;}
public Account editAccName{get;set;}
public Account getAcc{get;set;}
public String editid{get;set;}    
public Integer noOfRecords=10;
public Integer records; 
public Integer temp=0;
public Integer temp1=1;
public List<Integer> accli{get;set;} 
public Integer Page{get;set;}    
public List<Account> PageAcc{get;set;}  
    
public AccountControl(){
accList = new List<Account>();
   
inputText = false;
outputText = true;
 List<Account> pageAcc = new List<Account>();
}

public String getParam(String name) {
return ApexPages.currentPage().getParameters().get(name);
}

Public void search(){   
string str = searchName+'%';
string query = 'select id, Name, Phone from Account where Name Like :str ORDER BY Name ASC';
accList = database.query(query);
    List<Integer> accli = new List<Integer>();
    if(acclist.size()>0 && acclist!=null){
        Page=accList.size();  
        if(Math.mod(page,noOfRecords)!=0){
            records=(page/noOfRecords)+1;
        }
        else{
            records=(page/noOfRecords);
        }
        if(page<noOfRecords){
            accli.add(1);    
        }
        else{
           
        for(Integer i=1;i<=records;i++){
            accli.add(i);
        }
        }
        system.debug(page);
        system.debug(accli);
}
}
public void PageResult(){
    List<Account> pageAcc = new List<Account>(); 
    String a = getParam('pages');
    Integer par = Integer.valueOf(a);
    if(page<noOfRecords){
        for(Integer i=0;i<acclist.size();i++){
            pageAcc.add(acclist[i]);
        }
    }else{
    if(temp<par){
        for(Integer j=(temp*noOfrecords);j<(temp1*noOfRecords);j++){
            pageAcc.add(acclist[j]);
        }
            temp=par;
            temp1=par;
    }
    else if(temp>par){
        for(Integer j=(temp*noOfRecords);j>((temp-1)*noOfRecords);j--){
            pageAcc.add(acclist[j]);
        }
            temp=par;
            temp1=par;
    }
    }
    
    system.debug(pageAcc);
    system.debug(temp+' '+temp1);
    }    
public void cancelrecord(){
getacc=null;
search();
}
public void editAccName() {
editid = getParam('editid');
getAcc = [SELECT id, Name, Phone FROM Account WHERE Id=:editid];
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