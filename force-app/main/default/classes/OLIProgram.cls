public class OLIProgram {
    public static void beforeOLIMethod(List<OpportunityLineItem> oli){
        set<id>ids = new set<id>();
        for(OpportunityLineItem op:oli){
            ids.add(op.OpportunityId);
        }
        List<OpportunityLineItem> olilist = [select Opportunityid, id, Name from OpportunityLineItem where OpportunityId IN:ids];
        Map<id,List<OpportunityLineItem>> idvsOlimap = new Map<id,List<OpportunityLineItem>>();
        for(OpportunityLineItem IterateOli:oli){
            if(!idvsOlimap.containskey(IterateOli.Opportunityid)){
                idvsOlimap.put(IterateOli.OpportunityId, new List<OpportunityLineItem>());
               
            }
               idvsOlimap.get(IterateOli.OpportunityId).add(IterateOli);
        }
        for(OpportunityLineItem IterateOli:olilist){
              if(idvsOlimap.containskey(IterateOli.Opportunityid)){
                idvsOlimap.get(IterateOli.OpportunityId).add(IterateOli);
            }
        }
        for(OpportunityLineItem iterateOli:oli){
            List<OpportunityLineItem> temp=idvsOlimap.get(IterateOli.OpportunityId);
            if(temp.size()>2){
                iterateoli.adderror('you have more than 2 opportunity product');
            }
        }
    }
    
}