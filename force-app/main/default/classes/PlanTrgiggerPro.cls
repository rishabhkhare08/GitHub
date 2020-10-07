public class PlanTrgiggerPro {
    public static void BeforeInsertMethod(List<Plan__c> plan){
        List<Plan__c> oldTravelHoursLocation = [select Travel_Hours__c, Travel_Location__c from Plan__c limit 10000];
        Map<String,Decimal> newTravelHoursLocation = new Map<String,Decimal>();
        for(Plan__c pl:plan){
            String[] travelLocation = pl.travel_Location__c.split(';');
            for(String s:travelLocation){
                Decimal sum=0;
                if(!newTravelHoursLocation.containsKey(s)){
                    newTravelHoursLocation.put(s,0);
                }
                newTravelHoursLocation.get(s);
                sum=sum+pl.Travel_Hours__c;
                newTravelHoursLocation.put(s,sum);
            }
        }
        for(Plan__c pl:oldTravelHoursLocation){
            String[] travelLocation = pl.travel_Location__c.split(';');
            for(String s:travelLocation){
                Decimal sum=0;
                if(!newTravelHoursLocation.containsKey(s)){
                    newTravelHoursLocation.put(s,0);
                }
                newTravelHoursLocation.get(s);
                sum=sum+pl.Travel_Hours__c;
                newTravelHoursLocation.put(s,sum);
            }
        }
        for(Plan__c pl:plan){
            String[] travelLocation = pl.travel_Location__c.split(';');
            for(String s:travelLocation){
                if(newTravelHoursLocation.get(s)>10){
                    pl.addError('Travel hours is being more than 10 hours');
                }
            }
        }
    }
}