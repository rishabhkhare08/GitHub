public class LeadTrigger {
    public static void checkLeadMethod(List<Lead> newLead){
        List<Lead> leadlist = new List<Lead>();
    set<id> ownerids = new set<id>();
        for(Lead l:newLead){
            ownerids.add(l.OwnerId);
        }
        datetime dt = Datetime.newInstance(2017, 12,01);
        leadlist=[select id, CreatedDate from Lead where ownerId IN:ownerids limit 10000];
        Map<id,List<Lead>> leadMap = new Map<id,List<Lead>>();
        for(Lead l:leadlist){
            if(!leadMap.containsKey(l.id) && l.CreatedDate.year()==system.today().year() && l.CreatedDate.month()==system.today().month()){
                leadMap.put(l.id, new List<Lead>());
            }
            leadMap.get(l.id).add(l);
        }
        for(Lead l:newLead){   
            if(!leadMap.containsKey(l.id)){
                leadMap.put(l.id, new List<Lead>());
            }
            leadMap.get(l.id).add(l);
        }
 
        Integer count=0;
        for(Lead l:newLead){  
            if(leadMap.size()>30){
                l.adderror('lead is greater then 30 for this user id');
            }
        }
}
}