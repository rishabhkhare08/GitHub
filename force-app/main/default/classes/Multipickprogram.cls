public class Multipickprogram {
    public static void pickListMethod(){
         decimal total=0;
        List<Plan__c> pl = [select Travel_hours__c,Travel_Location__c from Plan__c where (Travel_Location__c includes('A') and Travel_Location__c excludes('F')) 
                            or (Travel_Location__c includes('F') and Travel_Location__c excludes('A'))];
        for(Plan__c p:pl){
           total+=p.Travel_Hours__c;
    }
        System.debug(total);
}
}