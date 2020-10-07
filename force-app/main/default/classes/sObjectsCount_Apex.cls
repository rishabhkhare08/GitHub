public with sharing class sObjectsCount_Apex {
@AuraEnabled(cacheable=true)
public static List<wrapper> getSobjectsRecord(List<String> sObjectsList){
    System.System.debug(sObjectsList);
    if(sObjectsList.size()>0){
      List<wrapper> wrapperList = new List<wrapper>();
        for(String sobjectName:sObjectsList){
            wrapper wrap = new wrapper();
                integer count= Database.countQuery('select count() from '+sobjectName+'');
                wrap.sobjectName = sobjectName;
                wrap.totalCount = count;
                wrapperList.add(wrap);
    }
    return wrapperList; 
}
return null; 
}
@AuraEnabled
public static List<SchemaWrapper> getSObjectSchema(String name){
    List<SchemaWrapper> sobjectFieldList = new List<SchemaWrapper>();
    Map<String, Schema.SObjectField> mapOfFieldVsAPIName =Schema.getGlobalDescribe().get(name).getDescribe().fields.getMap();
    for(String key: mapOfFieldVsAPIName.keySet()){
        SchemaWrapper schemawrap = new SchemaWrapper();   
        schemawrap.Name=(String.valueOf(mapOfFieldVsAPIName.get(key).getDescribe().getLabel()));
        schemawrap.fieldType=String.valueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType());
        sobjectFieldList.add(schemawrap);
    }
    return sobjectFieldList;
}
public class SchemaWrapper{
    @AuraEnabled public String Name{get;set;}
    @AuraEnabled public String fieldType{get;set;}
    public SchemaWrapper(){
    }
}
@AuraEnabled(cacheable=false)
public static List<pickWrapper> getPicklistValue(String fieldLabel,String objectname){
    List<pickWrapper> picklistValueAndType = new List<pickWrapper>();
    List<String> picklistValue = new List<String>();
    System.debug('<<<<>>>>>>>>><<'+objectname+''+fieldLabel);
    Map<String, Schema.SObjectField> mapOfFieldVsAPIName =Schema.getGlobalDescribe().get(objectname).getDescribe().fields.getMap();
    for(String key: mapOfFieldVsAPIName.keySet()){
        if(String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType()) == 'PICKLIST' && String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getLabel()) == fieldLabel){
        List<Schema.PicklistEntry> PicklistEntry = new List<Schema.PicklistEntry>();   
        PicklistEntry = mapOfFieldVsAPIName.get(key).getDescribe().getPicklistValues();
        for(Schema.PicklistEntry pick : PicklistEntry){
            picklistValue.add(String.valueOf(pick.getLabel()));
        }
        pickWrapper pickwrap = new pickWrapper(picklistValue,String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType()));
        picklistValueAndType.add(pickwrap);
    }
    else if( String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getLabel()) == fieldLabel){
        pickWrapper pickwrap = new pickWrapper(null,String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType()));
        picklistValueAndType.add(pickwrap);
    }
    }
    System.debug(picklistValueAndType);
    return picklistValueAndType;
}
@AuraEnabled
public static List<groupWrapper> getGroupByCode(String sobjectname,String label, String operator, String value){
    Map<String,String> conditions = new Map<String,String>();
    conditions.put('equals','=');
    conditions.put('not equal to','!=');
    conditions.put('less than','<');
    conditions.put('greater than','>');
    conditions.put('less or equal','<=');
    conditions.put('starts with','Like %');
    conditions.put('greater or equal','>=');
    conditions.put('contains','LIKE');
    conditions.put('does not contain','NOT LIKE');
    conditions.put('starts with','LIKE %');
    String fieldname;
    String type;
   
    Map<String, String> apiVsValueMap = new Map<String,String>();
    Map<String, Schema.SObjectField> mapOfFieldVsAPIName =Schema.getGlobalDescribe().get(sobjectname).getDescribe().fields.getMap();
    for(String key: mapOfFieldVsAPIName.keySet()){
        if(String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getLabel()) == label){
          fieldname = String.valueOf(mapOfFieldVsAPIName.get(key));
          type = String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType());
        List<Schema.PicklistEntry> PicklistEntry = new List<Schema.PicklistEntry>();   
        PicklistEntry = mapOfFieldVsAPIName.get(key).getDescribe().getPicklistValues();
        for(Schema.PicklistEntry pick : PicklistEntry){
           if(!apiVsValueMap.containskey(String.valueOf(pick.getValue()))){
               apiVsValueMap.put(String.valueOf(pick.getValue()),String.valueOf(pick.getLabel()));
           }
        }
    }
}
    List<String> picklistValue = new List<String>();
    List<groupWrapper> wrapperlist = new List<groupWrapper>();
    system.System.debug(operator+' '+value);
    if(sobjectname!=null && label!=null && (operator == null||operator=='') && (value==null||value=='')){
        if(conditions.containskey(operator)){
            operator = conditions.get(operator);
        }
        if(operator == 'LIKE'){
            value =  '\'%' + value + '%\'';
            System.debug(value);
        }
        else if(operator == 'NOT LIKE'){
            value =  '\'%' + value + '%\'';
            fieldname = 'not '+fieldname;
            operator = 'LIKE';
        }
        else if(operator == 'LIKE %'){
            value =  '\'' + value + '%\'';
            operator = 'LIKE';
        }
        else if(type == 'STRING' || type == 'PICKLIST'){
            value = '\''+ value + '\'';
        }
    
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+sobjectName+' '+label+' '+operator+' '+value);
        if(type == 'PICKLIST'){                  
            AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' GROUP BY '+fieldname); 
            system.debug('<<<<>>>>>>><'+result);
            for(AggregateResult ag :result){
                String count = String.valueOf(ag.get('expr0'));
                String name = String.valueOf(ag.get(fieldname));     
                if(name != null){
                    if(apiVsValueMap.containskey(name)){
                        name = apiVsValueMap.get(name);
                groupWrapper wrap = new groupWrapper(name,count);
                wrapperlist.add(wrap);
                }
            }
        }
        }
        else if(type == 'DATE'){ 
            system.debug('<<<<<<<<<>>>>>>>>>>>>>>>>>'+value);
            Date dateInstance = Date.valueOf(value);
            AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' GROUP BY '+fieldname);  
            for(AggregateResult ag :result){
                String count = String.valueOf(ag.get('expr0'));
                String name = String.valueOf(ag.get(fieldname));     
                if(name != null){
                    groupWrapper wrap = new groupWrapper(name,count);
                    wrapperlist.add(wrap);
                }
            }
        }
        else if(type == 'DATETIME'){ 
            Date dateInstance = Date.valueOf(value);
            Integer d = dateInstance.day();
            Integer mo = dateInstance.month();
            Integer yr = dateInstance.year();
            DateTime datetimeInstane = dateTime.newInstance(yr,mo,d,0,0,0);
            String formatedDt = datetimeInstane.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
            AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' GROUP BY '+fieldname); 
            for(AggregateResult ag :result){
                String count = String.valueOf(ag.get('expr0'));
                String name = String.valueOf(ag.get(fieldname));     
                if(name != null){
                    groupWrapper wrap = new groupWrapper(name,count);
                    wrapperlist.add(wrap);
                }
            }
        }
        else{
            AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' GROUP BY '+fieldname);
            for(AggregateResult ag :result){
                String count = String.valueOf(ag.get('expr0'));
                String name = String.valueOf(ag.get(fieldname));     
                if(name != null){
                    groupWrapper wrap = new groupWrapper(name,count);
                    wrapperlist.add(wrap);
                }
        }
    }
    return wrapperList;
}
if(sobjectname!=null && label!=null && (operator != null||operator!='') && (value!=null||value!='')){
    if(conditions.containskey(operator)){
        operator = conditions.get(operator);
    }
    if(operator == 'LIKE'){
        value =  '\'%' + value + '%\'';
        System.debug(value);
    }
    else if(operator == 'NOT LIKE'){
        value =  '\'%' + value + '%\'';
        fieldname = 'not '+fieldname;
        operator = 'LIKE';
    }
    else if(operator == 'LIKE %'){
        value =  '\'' + value + '%\'';
        operator = 'LIKE';
    }
    else if(type == 'STRING' || type == 'PICKLIST'){
        value = '\''+ value + '\'';
    }

    system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+sobjectName+' '+label+' '+operator+' '+value);
    system.debug('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+value +' GROUP BY '+fieldname);
    system.debug(type);
    if(type == 'PICKLIST'){                  
        AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' WHERE toLabel('+fieldname+') '+operator+' '+value +' GROUP BY '+fieldname); 
        system.debug('<<<<>>>>>>><'+result);
        for(AggregateResult ag :result){
            String count = String.valueOf(ag.get('expr0'));
            String name = String.valueOf(ag.get(fieldname));     
            if(name != null){
                if(apiVsValueMap.containskey(name)){
                    system.debug(count+' '+name);
                    name = apiVsValueMap.get(name);
            groupWrapper wrap = new groupWrapper(name,count);
            wrapperlist.add(wrap);
            }
        }
    }
    }
    if(type == 'DATE'){ 
        system.debug('<<<<<<<<<>>>>>>>>>>>>>>>>>'+value);
        Date dateInstance = Date.valueOf(value);
        AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+dateInstance +' GROUP BY '+fieldname);  
        for(AggregateResult ag :result){
            String count = String.valueOf(ag.get('expr0'));
            String name = String.valueOf(ag.get(fieldname));     
            if(name != null){
                system.debug(count+' '+name);
                groupWrapper wrap = new groupWrapper(name,count);
                wrapperlist.add(wrap);
            }
        }
    }
    }
    if(type == 'DATETIME'){ 
        Date dateInstance = Date.valueOf(value);
        Integer d = dateInstance.day();
        Integer mo = dateInstance.month();
        Integer yr = dateInstance.year();
        DateTime datetimeInstane = dateTime.newInstance(yr,mo,d,0,0,0);
        String formatedDt = datetimeInstane.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+formatedDt +' GROUP BY '+fieldname); 
        for(AggregateResult ag :result){
            String count = String.valueOf(ag.get('expr0'));
            String name = String.valueOf(ag.get(fieldname));     
            if(name != null){
                system.debug(count+' '+name);
                groupWrapper wrap = new groupWrapper(name,count);
                wrapperlist.add(wrap);
            }
        }
    }
    if(type == 'STRING'){
        AggregateResult[] result= Database.Query('SELECT  '+fieldname+', count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+value +' GROUP BY '+fieldname);
        for(AggregateResult ag :result){
            system.debug('<<<<>>>>>>><'+result);
            String count = String.valueOf(ag.get('expr0'));
            String name = String.valueOf(ag.get(fieldname));     
            if(name != null){
                system.debug(count+' '+name);
                groupWrapper wrap = new groupWrapper(name,count);
                wrapperlist.add(wrap);
            }
    }
    return wrapperList;
}
system.debug('<><><><>><><><><><'+wrapperList);
return wrapperList;
}
@AuraEnabled
public static List<wrapper> updateObjectTable(List<String> objectlist, String sobjectname, String label, String operator, String value){
    Integer countObj=0;
    String name;
    Map<String,String> conditions = new Map<String,String>();
    conditions.put('equals','=');
    conditions.put('not equal to','!=');
    conditions.put('less than','<');
    conditions.put('greater than','>');
    conditions.put('less or equal','<=');
    conditions.put('starts with','Like %');
    conditions.put('greater or equal','>=');
    conditions.put('contains','LIKE');
    conditions.put('does not contain','NOT LIKE');
    conditions.put('starts with','LIKE %');
    String fieldname;
    String type;
    Map<String, String> apiVsValueMap = new Map<String,String>();
    Map<String, Schema.SObjectField> mapOfFieldVsAPIName =Schema.getGlobalDescribe().get(sobjectname).getDescribe().fields.getMap();
    for(String key: mapOfFieldVsAPIName.keySet()){
        if(String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getLabel()) == label){
          fieldname = String.valueOf(mapOfFieldVsAPIName.get(key));
          type = String.ValueOf(mapOfFieldVsAPIName.get(key).getDescribe().getType());
        }
    }
    List<wrapper> wrapperList = new List<wrapper>();
    for(String sob:objectlist){
        wrapper wrap = new wrapper();
        if(sob == sobjectname){
           if(sobjectname!=null && label!=null && (operator == null||operator=='') && (value==null||value=='')){
            integer count= Database.countQuery('select count() from '+sob+'');
            wrap.sobjectName = sob;
            wrap.totalCount = count;
            wrapperList.add(wrap);
                }
            else if(sobjectname!=null && label!=null && conditions.containskey(operator) && (value!=null||value!='')){
                if(conditions.containskey(operator)){
                    operator = conditions.get(operator);
                }
                if(operator == 'LIKE'){
                    value =  '\'%' + value + '%\'';
                    System.debug(value);
                }
                else if(operator == 'NOT LIKE'){
                    value =  '\'%' + value + '%\'';
                    fieldname = 'not '+fieldname;
                    operator = 'LIKE';
                }
                else if(operator == 'LIKE %'){
                    value =  '\'' + value + '%\'';
                    operator = 'LIKE';
                }
                else if(type == 'STRING' || type == 'PICKLIST'){
                    value = '\''+ value + '\'';
                }
                if(type == 'PICKLIST'){                  
                    AggregateResult result= Database.Query('SELECT count(id) FROM '+sobjectname+' WHERE toLabel('+fieldname+') '+operator+' '+value); 
                    wrap.sobjectName = sob;
                    wrap.totalCount = Integer.valueOf(String.valueOf(result.get('expr0')));
                    wrapperList.add(wrap);
                }
                else if(type == 'DATE'){ 
                    system.debug('<<<<<<<<<>>>>>>>>>>>>>>>>>'+value);
                    Date dateInstance = Date.valueOf(value);
                    AggregateResult result= Database.Query('SELECT count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+dateInstance); 
                    wrap.sobjectName = sob;
                    wrap.totalCount = Integer.valueOf(String.valueOf(result.get('expr0')));
                    wrapperList.add(wrap); 
                }
                else if( type == 'DATETIME'){
                    Date dateInstance = Date.valueOf(value);
                    Integer d = dateInstance.day();
                    Integer mo = dateInstance.month();
                    Integer yr = dateInstance.year();
                    DateTime datetimeInstane = dateTime.newInstance(yr,mo,d,0,0,0);
                    String formatedDt = datetimeInstane.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
                    system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>'+datetimeInstane);
                    AggregateResult result= Database.Query('SELECT count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+formatedDt); 
                    wrap.sobjectName = sob;
                    wrap.totalCount = Integer.valueOf(String.valueOf(result.get('expr0')));
                    wrapperList.add(wrap); 
                }
                else if(type == 'BOOLEAN' || type == 'CURRENCY' || type == 'PHONE'){
                    AggregateResult result= Database.Query('SELECT count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+value); 
                    wrap.sobjectName = sob;
                    wrap.totalCount = Integer.valueOf(String.valueOf(result.get('expr0')));
                    wrapperList.add(wrap); 
                }
                else{
                    AggregateResult result= Database.Query('SELECT count(id) FROM '+sobjectname+' WHERE '+fieldname+' '+operator+' '+value); 
                    wrap.sobjectName = sob;
                    wrap.totalCount = Integer.valueOf(String.valueOf(result.get('expr0')));
                    wrapperList.add(wrap);                                                 
                }
    }
 }
//     else{
//         integer count= Database.countQuery('select count() from '+sob+'');
//         wrap.sobjectName = sob;
//         wrap.totalCount = count;
//         wrapperList.add(wrap);
//     }
}
return wrapperList;
}
public class groupWrapper{
    @AuraEnabled public String name{get;set;}
    @AuraEnabled public String count{get;set;}    
    public groupWrapper(string name, String count){
    this.name = name;
    this.count = count;
    }
}
public class pickWrapper{
    @AuraEnabled public List<String> picklistValue{get;set;}
    @AuraEnabled public String type{get;set;}
    public pickWrapper(List<String> pick, string type){
        this.picklistValue = pick;
        this.type = type;
    }
}
 public class wrapper{
    @AuraEnabled public String sobjectName{get;set;}
    @AuraEnabled public Integer totalCount{get;set;}
    public wrapper(){
    }
}
}