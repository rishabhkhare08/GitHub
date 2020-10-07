public class CampaignProgram {
    public static void afterUpdateMethod(List<Campaign> cam){
        set<id> ids = new Set<id>();
        for(Campaign cm:cam){
            ids.add(cm.id);
        }
        List<Opportunity> opp=[select id,Name,IsWon,IsClosed,HasOpportunityLineItem from 
                               Opportunity where Campaignid IN:ids limit 10000];
        for(Opportunity o:opp){
            if(o.HasOpportunityLineItem==true && o.IsWon==false){
                o.StageName='Closed Won';
            }else if(o.HasOpportunityLineItem==false && o.IsClosed==false){
                   o.StageName='Closed Lost';
            }
        }
        update opp;
    }
}