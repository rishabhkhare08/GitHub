public with sharing class SearchContactController {
    @AuraEnabled
   public static List<Contact> search_apex(String searchKey){
    searchKey = searchKey+'%';
    return Database.query('SELECT Id, Name, Phone, Accountid, Email FROM Contact Where Name LIKE \''+searchKey+'\'LIMIT 10');
   } 
}