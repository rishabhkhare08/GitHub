Public class TestClassVF
{
Public list<Account> accList{get;set;}
Public Id editList{get;set;}
public String name { get; set; }
Public String selectedAccountId{get;set;}
public String u {get;set;}
Public TestClassVF(ApexPages.StandardController controller)
{
accList = new list<Account>();
//accList =[SELECT Id, Name, Type, Description FROM Account limit 100];
u = apexpages.currentpage().getparameters().get('SObj');
System.debug(u);
}
public void home()
{
accList = new list<Account>();
string searchquery='select Id,Name,Type,Description from '+u;
accList = Database.query(searchquery);
}
Public void saveRecord()
{
Update accList;
editList = null;
}
public PageReference searchAccount()
{
string searchquery='select Id,Name,Type,Description from '+u+' where name like \'%'+name+'%\'';
accList = Database.query(searchquery);
System.debug(accList);
return null;
}
}