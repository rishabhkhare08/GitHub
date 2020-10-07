public with sharing class UploadAttachment {
    @AuraEnabled
    public static List<wrapper> uploadNow(){  
                List<ContentDocument> contentList = [SELECT Id, FileType, Title,ContentSize, createddate, lastmodifieddate FROM ContentDocument WHERE createddate=today];
                if(contentList.size()>0){
                    List<wrapper> cnList = new List<wrapper>(); 
                    String size='';
                    date lastModified;
                    date createdate;                                   
                for(ContentDocument cn:contentList){
                if(cn.ContentSize<=1024){
                   size = cn.ContentSize+' '+'bytes';
                }
                else if(cn.ContentSize>1024 && cn.ContentSize<=1024*1024){
                    Integer div = (cn.contentSize/1024);
                    size = div+' '+'KB';
                }
                lastModified = cn.LastModifiedDate.date();
                createdate = cn.LastModifiedDate.date();
                cnList.add(new wrapper(cn.Id,cn.FileType,cn.Title,size,lastModified,createdate));
            }
            return cnList;
        }
        return null;
    }
    @AuraEnabled
    public static void deleteRecord(List<SObject> records){
        system.debug(records);
        Set<Id> ids = new Set<Id>();
        for(Integer i=0;i<records.size();i++){
           ids.add(records[i].Id);
        }
        system.debug(ids);
        List<ContentDocument> contentList = [SELECT Id, FileType, Title,ContentSize, createddate, lastmodifieddate FROM ContentDocument WHERE Id IN:ids]; 
        system.debug(contentList);
      delete contentList;
    }
    @AuraEnabled
    public static List<wrapper> upload(List<string> documentId,String recordid){  
        List<wrapper> cnList = new List<wrapper>();
        if(documentId.size()>0){
            for(String str:documentId){
                String size='';
                date lastModified;
                date createdate;
                ContentDocument cn = [SELECT id, FileType, Title,ContentSize, createddate, lastmodifieddate FROM ContentDocument WHERE id =:str];
                if(cn.ContentSize<=1024){
                   size = cn.ContentSize+' '+'bytes';
                }
                else if(cn.ContentSize>1024 && cn.ContentSize<=1024*1024){
                    Integer div = (cn.contentSize/1024);
                    size = div+' '+'KB';
                }
                lastModified = cn.LastModifiedDate.date();
                createdate = cn.LastModifiedDate.date();
                cnList.add(new wrapper(cn.Id,cn.FileType,cn.Title,size,lastModified,createdate));
                cn.ParentId = recordid;
            }
            return cnList;
        }
        return null;
    }
    public class wrapper{
        @AuraEnabled public Boolean check{get;set;}
        @AuraEnabled public String Id{get;set;}
        @AuraEnabled public date modifiedDate{get;set;}
        @AuraEnabled public date createDate {get;set;}
        @AuraEnabled public String fileType {get;set;}
        @AuraEnabled public String title {get;set;}
        @AuraEnabled public String contentSize {get;set;}
        @AuraEnabled public List<String> errorIdList {get;set;}
        public wrapper(String id,String FileType, String Title, String size, date lastModified, date createdate){
           this.modifiedDate = lastModified;
           this.check = false;
           this.createDate = createdate;
           this.fileType = FileType;
           this.title = Title;
           this.contentSize = size;
           this.Id = id;
        }
    }
}