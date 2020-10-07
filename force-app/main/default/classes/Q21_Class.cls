public with sharing class Q21_Class {
  public static List<Contact> Q21_method(){
    List<Attachment> attachmentList = new List<Attachment>();
    attachmentList = [SELECT Body, ParentId, Name FROM Attachment WHERE ParentId IN 
    (SELECT Id from Account WHERE Name='CAKurukshetra abv') ];
    List<Contact> contactList = new List<Contact>();
    contactList=[SELECT Id,AccountId from Contact WHERE AccountId =: attachmentList[0].ParentId];
    
    List<Attachment> attachmentListToInsert= new List<Attachment>();
    
    for(Contact con : contactList)
    {
        for(Attachment at : attachmentList)
        {
            Attachment obj = new Attachment();
            obj.Body = at.Body;
            obj.ParentId = con.Id;
            obj.Name = at.Name;
            attachmentListToInsert.add(obj);
        }
    }
    insert(attachmentListToInsert);
    return contactList;
  }
}