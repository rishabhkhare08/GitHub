public with sharing class Q31_Class {
    public static void Q31_method() {
        List<Lead> newLead = new List<Lead>();
        for(Integer i=0;i<3;i++){
            Lead l = new Lead();
            l.Company='Company'+i;
            l.LastName='C'+i;
            newLead.add(l);
        }
        insert newLead;
        Integer j=0;
        List<Product2> product=new List<Product2>();
        for(Integer i=0;i<5;i++){
           Product2 pd = new Product2();
            pd.Name='Name '+i;
            pd.LeadL__c=newLead.get(j).id;
            j++;
            if(j>2){
                j=0;
            }
        }
    }
}