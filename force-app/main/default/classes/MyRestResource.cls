@RestResource(urlMapping='/callRest/*')
global with sharing class MyRestResource {

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
  
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('Accountid>>>'+accountId);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
  
  @HttpPost
    global static String doPost() {
         System.debug('POST>>>>>');
        RestRequest request = RestContext.request;
        String method;
        String getret;
       method=RestContext.request.params.get('method');
      
        if(method == 'getRecords'){
            getret=getRecords();
        }
        return getret;
  
    }
    
    
    
   public static String getRecords(){
        
        return 'from getRecords';
    }
}