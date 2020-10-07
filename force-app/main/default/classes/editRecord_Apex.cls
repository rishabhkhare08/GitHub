public with sharing class editRecord_Apex {
    @AuraEnabled
    public static wrapper editCandidate(string recId){
        wrapper wrap = new wrapper();
        try {
        Candidate__c candidateRecord = new Candidate__c();
        candidateRecord = [SELECT Id, Name, Father_Name__c, Mother_Name__c, DOB__c, Aadhar_No__c, Address__c, Email__c, Phone__c, Gender__c, Status__c, About_Me__c FROM Candidate__c where id=:recId LIMIT 10000];
        List<Qualification__c> qualificationList = new List<Qualification__c>();
        qualificationList = [SELECT Id, Candidate__c, Name, Course__c, Year__c, Percentage__c, Board_University__c FROM Qualification__c where Candidate__c=:recId LIMIT 10000];
        List<Experience__c> experienceRecord = new List<Experience__c>();
        experienceRecord = [SELECT Id, Name, joining_Date__c, End_Date__c, Position__c, Candidate__c FROM Experience__c where Candidate__c=:recId LIMIT 10000];
     
       wrap.candidateWrapRecord = candidateRecord;   
       wrap.qualificationWrapList = qualificationList;     
       if(experienceRecord.size()>0) 
       wrap.experienceWrapRecord = experienceRecord;
       return wrap;
        }catch(exception e){
            system.System.debug(e);
            return wrap;
        }  
   }
   @AuraEnabled
   public static void updateRecords(Candidate__c candidateRecord, List <Qualification__c> updateRecList, List<Experience__c> experienceRecord){
    id candidateId = candidateRecord.Id;
    try{
    update candidateRecord;
    }catch (exception e){
    system.System.debug(e);
    }
    try{
        for(Qualification__c insertcanId:updateRecList){
            insertcanId.Candidate__c = candidateId;
            System.debug('insertcanId Year__c..'+ insertcanId.Year__c);
        }
        upsert updateRecList;
        
    }catch (exception e){
        system.System.debug(e);
        }
    try{
        upsert experienceRecord;
    }catch (exception e){
        system.System.debug(e);
        }

   }
   @AuraEnabled
   public static boolean deleteQualificationRow(Qualification__c qualificationRecord){
    if(qualificationRecord != null){   
        system.debug('qualificationRecord>>>>>>>>>>>>>'+qualificationRecord);
    delete qualificationRecord;
       return true;
    }
    else {
        return false;
    }
   }
   public class wrapper{
       @auraEnabled public Candidate__c candidateWrapRecord{get;set;}
       @auraEnabled public List<Qualification__c> qualificationWrapList{get;set;}
       @auraEnabled public List<Experience__c> experienceWrapRecord{get;set;}
   }
   }