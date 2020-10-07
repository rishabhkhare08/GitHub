public with sharing class Candidate_apex {
    @AuraEnabled
    public static List<Candidate__c> callCandidate(){
        return[SELECT Id, Name, Father_Name__c, Mother_Name__c, DOB__c, Aadhar_No__c, Address__c, Email__c, Phone__c, Gender__c, Status__c, About_Me__c FROM Candidate__c LIMIT 1000];
    }
    @AuraEnabled
    public static boolean updateCandidate(List<Candidate__c> candidatelist){
       if(candidatelist.size()>0 && !candidatelist.isEmpty()){
           update candidatelist;
           return true;
       }
       else {
           return false;
       }
    }

    @AuraEnabled
    public static boolean deleteRecordMethod(String recId){
        try {
           if(!String.isEmpty(recId)){
                Candidate__c candidateRecord = new Candidate__c();
                candidateRecord = [SELECT Id, Name, Father_Name__c, Mother_Name__c, DOB__c, Aadhar_No__c, Address__c, Email__c, Phone__c, Gender__c, Status__c, About_Me__c FROM Candidate__c where Id=:recId];
                system.debug(candidateRecord);
                List<Qualification__c> qualificationList = new List<Qualification__c>();
                qualificationList = [SELECT Id, Candidate__c, Name, Course__c, Year__c, Percentage__c, Board_University__c FROM Qualification__c where Candidate__c=:recId ];
                system.debug(qualificationList);
                List<Experience__c> experienceRecord = new List<Experience__c>();
                experienceRecord = [SELECT Id, Name, joining_Date__c, End_Date__c, Position__c, Candidate__c FROM Experience__c where Candidate__c=:recId];
                if(qualificationList.size()>0){
                     Database.delete(qualificationList,false);
                }
                
                if(experienceRecord.size()>0){
                    Database.delete(experienceRecord,false);  
                }
               if(candidateRecord != null){
                  delete candidateRecord;
               }
               return true;
            } 
            return false;
            
        }catch(Exception e){
            system.debug('Exception Occured ::'+e.getMessage());
            return false;
        }    
    }
}