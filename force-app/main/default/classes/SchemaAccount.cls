public with sharing class SchemaAccount {
@AuraEnabled
 public static List<wrapper> getAccountField(String sobjectName){
String[] types = new String[]{sobjectName};
List<wrapper> wrapperList = new List<wrapper>();
String fieldApi;
Map<String,Schema.SObjectField> mapkey;
// Make the describe call
Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
// For each returned result, get some info
for(Schema.DescribeSobjectResult res : results) {
    System.debug(res);
    mapkey = (map<String,Schema.SObjectField>)res.fields.getMap();
}
for(String key : mapkey.keySet()){
    fieldApi=String.ValueOf(mapkey.get(key));
    String accountLabel = (String.ValueOf(mapkey.get(key).getDescribe().getLabel()));
    String accountType = (String.ValueOf(mapkey.get(key).getDescribe().getType()));
    List<Schema.PicklistEntry> PicklistEntry = new List<Schema.PicklistEntry>();  
    List<String> picklistValue = new List<string>();
    List<String> multiPicklistValue = new List<string>();
    List<String> multiPicklistLabels = new List<string>();
    boolean isLookup = false;
    if(accountType == 'DOUBLE' || accountType == 'PHONE' || accountType == 'CURRENCY'){
        accountType = 'Number';
    }
    else if(accountType == 'STRING'){
        accountType = 'Text';
    }
    else if(accountType == 'BOOLEAN'){
        accountType = 'Checkbox';
    }
    else if(accountType == 'PICKLIST'){
        PicklistEntry = mapkey.get(key).getDescribe().getPicklistValues();
        for(Schema.PicklistEntry pick : PicklistEntry){
            picklistValue.add(String.valueOf(pick.getValue()));
        }
    }
    else if(accountType == 'MULTIPICKLIST'){
        PicklistEntry = mapkey.get(key).getDescribe().getPicklistValues();
        for(Schema.PicklistEntry pick : PicklistEntry){
            multiPicklistValue.add(String.valueOf(pick.getValue()));   
        }
    }
    else if(accountType == 'REFERENCE'){
        if(mapkey.get(key).getDescribe().Name == 'AccountId'){
            system.debug('>>>>>>>>>>>>>>>>>>>>>>'+mapkey.get(key).getDescribe().Name);
            isLookup = true;
        }
    }
    wrapper wrap = new wrapper(accountLabel, accountType, picklistValue, multiPicklistValue, isLookup, fieldApi);
    wrapperList.add(wrap);
}
system.debug(wrapperList);
return wrapperList;
}
@AuraEnabled (cacheable=true)
public static List<Account> getAccount(String accountName){
    List<Account> accountList = new List<Account>();
    String accName = '%'+accountName+'%';
    accountList =[SELECT Id, Name FROM Account WHERE Name LIKE :accName LIMIT 5];
    system.debug(accountList);
    return accountList;
}
@AuraEnabled
public static String saveContactRecord(String sobjectName, map<String,object> saveRecord){
    System.debug('>>>>>>>>>>'+String.valueOf(saveRecord));
    String[] types = new String[]{sobjectName};
    sObject sobj = Schema.getGlobalDescribe().get(sobjectName).newSObject();
    // Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
    for(String s:saveRecord.keySet()){
        Schema.SobjectField theField = Schema.getGlobalDescribe().get(sobjectName).getDescribe().fields.getMap().get(s);
        String type = String.valueOf(Schema.getGlobalDescribe().get(sobjectName).getDescribe().fields.getMap().get(s).getDescribe().getType());
        if(type == 'DATE'){
            sobj.put(theField, Date.valueOf(String.valueOf(saveRecord.get(s))));
        }
        else if(type == 'BOOLEAN'){
            sobj.put(theField, Boolean.valueOf(saveRecord.get(s)));
        }
        else if(type == 'MULTIPICKLIST'){
            system.debug('------------------------'+String.valueOf(saveRecord.get(s)));
            String sb = String.valueOf(saveRecord.get(s)); 
            String ri='';
            List<String> multi = new List<string>(sb.split(','));
            for(Integer i=0;i<multi.size();i++){
              ri = ri+multi[i];
              if(i<multi.size()-1){
                  ri+=';';
              }
            }
             sobj.put(theField,ri);
             Account acc = [SELECT Working_In__c From Account  WHERE Working_In__c!=null LIMIT 1];
             System.debug(acc);
            system.debug(sobj);
        }
        else{
            sobj.put(theField,String.valueOf(saveRecord.get(s)));
        }
    }
   
    System.debug(sobj);
    try{
   insert sobj;
   return 'success';
    }
    catch(Exception e){
     return e.getMessage();
    }
}
public class wrapper{
   @AuraEnabled public String accountLabel{get;set;}
   @AuraEnabled public String accountFieldType{get;set;}
   @AuraEnabled public boolean isPicklist{get;set;}
   @AuraEnabled public boolean isLookup{get;set;}
   @AuraEnabled public String fieldApi{get;set;}
   @AuraEnabled public boolean isMultiPicklist{get;set;}
   @AuraEnabled public List<String> picklistValue{get;set;}
   @AuraEnabled public List<String> multiPicklistValue{get;set;}
   //@AuraEnabled public List<String> accountFieldType{get;set;}
   public wrapper(String accountLabel, String accountType, List<String> picklistValue, List<String> multiPicklistValue, boolean isLookup, String fieldApi){
    this.accountLabel = accountLabel;
    accountFieldType = accountType;
    this.fieldApi = fieldApi;
    this.isLookup = isLookup;
    if(picklistValue.size()>0){
        isPicklist = true;
        this.picklistValue = picklistValue;
    }
    else if(multiPicklistValue.size()>0){
        isMultiPicklist = true;
        this.multiPicklistValue = multiPicklistValue;
    }
    else{
        isPicklist = false;
    }
   } 
 } 
}