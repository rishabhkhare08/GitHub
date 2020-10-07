public class CreateContactController {
@AuraEnabled
public static Boolean createContact (Contact contactRecord) {
try {
insert contactRecord;
return true;
} catch(Exception ex) {
return false;
}
}
@AuraEnabled
public static List<Account> searchAccountmethod(String search){
search = search+'%';
return [SELECT Id, Name FROM Account WHERE Name LIKE :search LIMIT 10];
}
}