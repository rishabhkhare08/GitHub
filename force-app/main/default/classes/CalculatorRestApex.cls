@RestResource(urlMapping='/calculatorLead/*')
global with sharing class CalculatorRestApex {
    @HttpPost
    global static String getPost(){
        RestRequest request = RestContext.request;
        String method;
        String Lead_FirstName;
        String Lead_LastName;
        String Lead_Company;
        String  Lead_Status;

        String  Cal_Name;
        String Cal_LeadId;
        Decimal Cal_Amount;
        Date Cal_period;
        decimal Cal_Rate;

        String getret;
       method=RestContext.request.params.get('method');
      
       
      if(method == 'createLead'){
         Lead_FirstName = RestContext.request.params.get('FirstName');
         Lead_LastName = RestContext.request.params.get('LastName');
         Lead_Company = RestContext.request.params.get('Company');
         Lead_Status = RestContext.request.params.get('Status');
         getret = createLead(Lead_FirstName, Lead_LastName, Lead_Company, Lead_Status);
      }
      else if(method == 'createCalculator'){
         Cal_LeadId = RestContext.request.params.get('Cal_LeadId');
         Cal_Amount =decimal.valueOf(RestContext.request.params.get('Cal_Amount'));
         Cal_Name = RestContext.request.params.get('Cal_Name');
         Cal_period =Date.valueOf(RestContext.request.params.get('Cal_period'));
         Cal_Rate = decimal.valueOf(RestContext.request.params.get('Cal_Rate'));
         getret = createCalcualtor(Cal_LeadId, Cal_Amount, Cal_Name, Cal_period, Cal_Rate);
      }
      return getret;
    }
    public static string createLead(String FirstName, String LastName, String Company, String Status ){
     Lead insertLead = new Lead();
     insertLead.FirstName = FirstName;
     insertLead.LastName = LastName;
     insertLead.Company = Company;
     insertLead.Status = Status;
     try{
     insert insertLead;
     }catch(Exception e){
         system.debug('the returned error is '+e.getMessage());
         return e.getMessage();
     }
    return insertLead.Id;
    }
   public static String createCalcualtor( String Cal_LeadId, Decimal Cal_Amount, String Cal_Name, date Cal_period, decimal Cal_Rate){
    Calculator__c insertCalculator = new Calculator__c();
    insertCalculator.LeadId__c = Cal_LeadId;
    insertCalculator.Amount__c = Cal_Amount;
    insertCalculator.Period__c = Cal_period;
    insertCalculator.Rate__c = Cal_Rate;
    insertCalculator.Name = Cal_Name;
   try{
    insert insertCalculator;
    return insertCalculator.Id;
   }catch(Exception e){
       System.debug('the returned error is '+e.getMessage());
       return e.getMessage();
   }
   }
}