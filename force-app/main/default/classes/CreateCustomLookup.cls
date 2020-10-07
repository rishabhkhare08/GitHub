public with sharing class CreateCustomLookup {
        @AuraEnabled
        public static List<SObject> findRecords_Apex (String searchKey, String sobjectApi) {
        return Database.query('SELECT Id, Name FROM ' + sobjectApi + ' WHERE Name LIKE \'' + searchKey + '%\'');
        }
}