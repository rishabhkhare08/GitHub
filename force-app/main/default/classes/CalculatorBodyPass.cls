@RestResource(urlMapping = '/calculatorGetBody/*')
global with sharing class CalculatorBodyPass {
   @HttpPost
   global static String getPost(){
       String method;
       String lead_FirstName;
       String lead_LastName;
       String lead_Company;
       String  lead_Status;

       String  cal_Name;
       String cal_LeadId;
       Decimal cal_Amount;
       Date cal_period;
       decimal cal_Rate;
       String getret;
       RestRequest req = RestContext.request;
       System.debug('JSON STRING>>>>>>>>>'+req.requestBody);

       Map<String, Object> leadVsCalculatorMap = (map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
       method = String.valueOf(leadVsCalculatorMap.get('method'));
       if(method == 'createLead'){
           lead_FirstName = String.valueOf(leadVsCalculatorMap.get('FirstName'));
           lead_LastName =  String.valueOf(leadVsCalculatorMap.get('LastName'));
           lead_Company =   String.valueOf(leadVsCalculatorMap.get('Company'));
           lead_Status =    String.valueOf(leadVsCalculatorMap.get('Status'));
           getret = createLead(lead_FirstName, lead_LastName, lead_Company, lead_Status);
        }
        else if(method == 'createCalcualtor'){
           cal_LeadId = String.valueOf(leadVsCalculatorMap.get('Cal_LeadId'));
           cal_Amount =decimal.valueOf(String.valueOf(leadVsCalculatorMap.get('Cal_Amount')));
           cal_Name = String.valueOf(leadVsCalculatorMap.get('Cal_Name'));
           cal_period =Date.valueOf(String.valueOf(leadVsCalculatorMap.get('Cal_period')));
           cal_Rate = decimal.valueOf(String.valueOf(leadVsCalculatorMap.get('Cal_Rate')));
           getret = createCalcualtor(cal_LeadId, cal_Amount, cal_Name, cal_period, cal_Rate);
        }
   return getret;
}
public static string createLead(String firstName, String lastName, String company, String status ){
    Lead insertLead = new Lead();
    insertLead.FirstName = firstName;
    insertLead.LastName = lastName;
    insertLead.Company = company;
    insertLead.Status = status;
    try{
     insert insertLead;
    } catch(Exception e){
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