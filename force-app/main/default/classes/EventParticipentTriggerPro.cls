public class EventParticipentTriggerPro {
    public static void beforeInsertMethod(List<Event_participent__c> newEventPar){
        List<Event_Participent__c> oldEventep = [SELECT Id, Contact_Name__c, CustomEvent__c FROM Event_Participent__c
                                                 where Contact_Name__c!=null and CustomEvent__c!=null ];
        set<id> ids = new Set<id>();
        for(Event_participent__c ep:newEventPar){
            ids.add(ep.CustomEvent__c);
        }
        List<CustomEvent__c> eventDate = [select id, Event_Date__c from CustomEvent__c where Event_Date__c!=null limit  10000];
        List<CustomEvent__c> newEventDate=[select id, Event_Date__c from CustomEvent__c where id IN:ids limit  10000];
        //map contain value of event participant value
        Map<id,List<id>> newEventMap = new Map<id,list<id>>();
        for(Event_participent__c ep:oldEventep){
            if(!newEventMap.containsKey(ep.Contact_Name__c)){
                newEventMap.put(ep.Contact_Name__c, new List<id>());
            }
            newEventMap.get(ep.Contact_Name__c).add(ep.CustomEvent__c);
        } //map contain value of all custom event records
         Map<id,dateTime> oldEventDateMap = new Map<id,dateTime>();
        for(CustomEvent__c ep:eventDate){
            if(!oldEventDateMap.containsKey(ep.id)){
                oldEventDateMap.put(ep.id,ep.Event_Date__c);
            }
        }//map contain value of new custom event records
        Map<id,dateTime> newEventDateMap = new Map<id,dateTime>();
        for(CustomEvent__c ep:newEventDate){
            if(!newEventDateMap.containsKey(ep.id)){
                newEventDateMap.put(ep.id,ep.Event_Date__c);
            }
        }
        for(Event_Participent__c ep:newEventPar){
            if(newEventMap.containsKey(ep.Contact_Name__c)){
                List<String> customEventids=newEventMap.get(ep.Contact_Name__c);

                for(String s:customEventids){               
                    if(ep.CustomEvent__c==s){
                        ep.addError('contact already registered for this event');  
                        
                    }
                }
                List<id> custom_Eventids = newEventMap.get(ep.Contact_Name__c);
                for(id customid:custom_Eventids){
                if(newEventDateMap.containskey(ep.CustomEvent__c)){
                    dateTime newDate = newEventDateMap.get(ep.CustomEvent__c);
                    if(oldEventDateMap.containskey(customid)){
                        DateTime oldDate = oldEventDateMap.get(customid);
                        if(olddate.isSameDay(newDate)){
                            ep.adderror('you can not register for event whose date is same');
                        }
                    }
                 }
                }
                
            }
            
        }
        
    }
}