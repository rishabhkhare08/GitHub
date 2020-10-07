public class faltuprogram {
    public static void faltuMethod(List<Opportunity> ls){
      List<Task> newtask = new List<Task>();
        set<String> stage = new set<String>();
        for(Opportunity o:ls){
            stage.add(o.StageName);
        }
     List<Opportunity> opp=[select StageName,id from Opportunity where StageName in:stage];
        for(Opportunity o:opp){
            if(o.StageName=='Closed won'){
            task t = new task();
            t.Priority='low';
            t.Status = 'In Progress';
            t.Subject = 'Follow Up Test Task';
            t.WhatId = o.Id;
            newtask.add(t);
        }
        }
        if(newtask.size()>0){
        insert newtask;
        }
        }
    }