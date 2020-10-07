public with sharing class AccountRelatedContact {
  @AuraEnabled
  public static List<Contact> showContact(){
      List<Contact> contactlist = new List<Contact>();
      contactlist = [SELECT Name, Title, Email, Phone FROM Contact WHERE AccountId ='0012v00002oof2sAAA' LIMIT 10];
      return contactlist;
}
}