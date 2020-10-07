public with sharing class Q20_Class {
public static List<Case> Q20_method(){
    Account accountName = [SELECT Id from Account LIMIT 1];
List<Contact> contactList = [SELECT Id from Contact LIMIT 5];
List<Case> caseList = new List<Case>();
for(Integer i=0; i<5; i++)
{
    Case obj = new Case();
    obj.AccountId = accountName.Id;
    obj.ContactId = contactList[i].Id;
    obj.Origin = 'Phone';
    obj.Reason = 'Feedback';
    obj.Status = 'Working';
    caseList.add(obj);
}
insert (caseList);
return caseList;
}
}