@RestResource(urlMapping='/calculatorLeadRest/*')
global with sharing class CalculatorLeadRestApex {
    @HttpPost
    global static String doPost(){
        RestRequest request = RestContext.request;
        String returnValue;
        String method = RestContext.request.params.get('method');
        List<Lead> leadList = new List<Lead>(); 
        Lead leadRecord = new Lead();
        Calculator__c CalculatorRecord = new Calculator__c();
        List<Calculator__c> calculatorList = new List<Calculator__c>();
        if(method == 'createLead'){
            String requestBody = request.requestbody.toString();
            Map<String, Object> leadMap = (map<string, Object>) JSON.deserializeUntyped(requestBody);
            for(String leadKey : leadMap.keySet()){
                String getLead = String.valueOf(leadMap.get(leadKey));            
                leadRecord = (Lead)JSON.deserialize(getLead, Lead.class);
                leadList.add(leadRecord);
            }      
            returnValue=createLead(leadList);
        }
        else if(method == 'createCalculator'){
            String requestBody = request.requestbody.toString();
            CalculatorRecord = (Calculator__c)JSON.deserialize(requestBody, Calculator__c.class);
            returnValue=createCalcualtor(CalculatorRecord);
       }
       return returnValue; 
    }
    public static String createLead(List<Lead> leadList){
        String setreturn;
        try{
            insert leadList;
            setreturn = 'inserted successfull';
            return setreturn;
        }
        catch(Exception e){
            system.debug('the returned error is '+e.getMessage());
            return e.getMessage();
        }
       }
       public static String createCalcualtor(Calculator__c CalculatorRecord){
        String setreturn;
       try{
           if(CalculatorRecord != null){
                Database.insert(CalculatorRecord);
                setreturn = 'inserted successfull';
             }
             return setreturn;
       }catch(Exception e){
           System.debug('the returned error is '+e.getMessage());
           return e.getMessage();
       }
    }
}