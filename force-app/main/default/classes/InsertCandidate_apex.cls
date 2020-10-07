public with sharing class InsertCandidate_apex {
    @AuraEnabled

    public static boolean candidateData(Candidate__c candidateRecord, List <Qualification__c> updateRecList, Experience__c experienceRecord){ 
        try{
                if(candidateRecord !=null){
                    upsert candidateRecord;
                }
               system.debug('inserted');
               String candidateId = candidateRecord.Id;
               
                   for(Qualification__c q:updateRecList){
                        q.Candidate__c= candidateId;
                   }                 
                if(updateRecList.size()>0){
                     upsert updateRecList;
                }      
               if(experienceRecord != null){
                experienceRecord.Candidate__c = candidateId;
                upsert experienceRecord;
               }
           }
           catch(Exception e){
               system.debug('exception>>>>>'+e);
               return false;
           }
           return true; 
    }   
 }