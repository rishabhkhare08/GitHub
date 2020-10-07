public with sharing class PopoverAccountSchema {
    @AuraEnabled(cacheable=true)
    public static List<String> getAccountSchema(){
        String[] types = new String[]{'Account'};
        List<String> accountLabelList = new List<String>();
        String fieldApi;
        Map<String,Schema.SObjectField> mapkey;
// Make the describe call
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        for(Schema.DescribeSobjectResult res : results) {
            mapkey = (map<String,Schema.SObjectField>)res.fields.getMap();
        }
        for(String key : mapkey.keySet()){
            String accountLabel = (String.ValueOf(mapkey.get(key).getDescribe().getLabel()));
            accountLabelList.add(accountLabel);
    }
    System.debug(accountLabelList);
    return accountLabelList;
}
}