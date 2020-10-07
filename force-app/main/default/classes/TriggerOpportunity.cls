public class TriggerOpportunity {
    public static void beforeInsertUpdateMethod(List<Opportunity> op){
        for(Opportunity o:op){
            if(o.CloseDate<System.today()){
                o.addError('Opportunity with past close date not allowed');
            }
            if(o.IsWon==true && o.HasOpportunityLineItem==false){
                o.adderror('must have opportunity product before closed won');
            }
            else if(o.StageName=='Closed Lost' && o.HasOpportunityLineItem==true){
                o.adderror('opportunity has a product you can not close it');
            }
        }

       
    }
    public static void priceBookCheckMethod(List<Opportunity> op){
                set<id> ids = new Set<id>();
        set<id> priceBookIds = new Set<id>();
        for(Opportunity o:op){
            if(o.AccountID!=null && o.PriceBook2id!=null){
            ids.add(o.AccountID);
            priceBookIds.add(o.PriceBook2id);
        }
        }
        List<Account> accountList=[select id, Working_In__c,Name from Account Where id IN:ids limit 10000];
        //map contain account records.
        Map<id,Account> accountMap = new Map<id,Account>();
        for(Account a: accountlist){
            if(a.ID!=null){
            if(!accountMap.containskey(a.id)){
                accountMap.put(a.id,a);
            }
        }
        }
        List<PriceBook2> pricebooklist=[select Name, id from PriceBook2 where Name!=null and id IN:priceBookIds limit 10000];
        //map contains pricebook2 records.
         Map<id,String> pricebookMap = new Map<id,String>();
        for(PriceBook2 p: pricebooklist){
            if(!pricebookMap.containskey(p.id)){
                pricebookMap.put(p.id,p.Name);
            }
        }
        //List<Opportunity> opportunitylist = [select AccountID, Pricebook2Id from Opportunity where Accountid IN:ids limit 10000];
        for(Opportunity iterateOp:op){
            if(accountMap.containskey(iterateOp.AccountId) && 
            pricebookMap.containskey(iterateOp.Pricebook2Id)){
                if(accountMap.get(iterateOp.AccountId).Working_In__c!=null){
                Account ac = accountMap.get(iterateOp.AccountId);
                String[] workingIn = ac.Working_In__c.split(';');
                string pricebookName = pricebookMap.get(iterateOp.Pricebook2Id);
                integer count=0;
                for(String s:workingIn){
                    if(s!=pricebookName){
                        count++;         
                    }                    
                }
                
                    if(count>=workingIn.size()){
                        iterateOp.addError('only those pricebook can be choose, whose name is matched with Account (Working_In__c) picklist');   
                    }

            }
        }
            
        }
    }
    public static void AccountcheckMethod(List<Opportunity> op){
        set<id> ids = new Set<id>();
        for(Opportunity o:op){
            if(o.AccountID!=null){
                ids.add(o.AccountID);
            }
        }
            List<Opportunity> opportunitylist = [select AccountID,StageName from Opportunity where Accountid IN:ids limit 10000];
            List<Account> accountlis = [select id, name, Working_in__c from Account where Working_in__c = 'ASIA' limit 10000];
            map<id,List<Opportunity>> opportunityMap = new Map<id,List<Opportunity>>();
            for(Opportunity opp:opportunitylist){
                if(!opportunityMap.containsKey(opp.AccountID)){
                    opportunityMap.put(opp.Accountid, new List<Opportunity>());
                }
                if(opp.stageName=='Closed Won'){
                    opportunityMap.get(opp.Accountid).add(opp);
                }
            }
            for(Opportunity opp:op){
                if(!opportunityMap.containsKey(opp.AccountID)){
                    opportunityMap.put(opp.Accountid, new List<Opportunity>());
                }
                    opportunityMap.get(opp.Accountid).add(opp);
                
            }
        for(Opportunity oppo:op){  
            if(oppo.StageName=='Closed Won'){ 
                for(Account a:accountlis){
                    if(a.id==oppo.AccountId && a.Working_In__c=='ASIA'){
                        if(opportunityMap.get(a.id).size()>=2){
                            oppo.addError('wrong');
                        }
                        
                    } 
                    
                }
            }
        }
    }

    public static void afterInsertUpdateMethod(List<Opportunity> op){
        List<id> ids = new List<id>();
        List<OpportunityContactRole> ocr = new List<OpportunityContactRole>();
        for(Opportunity o:op){
            if(o.AccountId!=null){
                ids.add(o.AccountId);
            }
        }
        List<Contact> con = [select id,AccountId from Contact where AccountId IN:ids];
        for(Opportunity o:op){
            for(Contact c:con){
                if(c.AccountId==o.AccountId){
                    OpportunityContactRole oc = new OpportunityContactRole();
                    oc.OpportunityId=o.Id;
                    oc.ContactId=c.id;
                    oc.Role='Business User';
                    ocr.add(oc);
                }
            }
        }
        List<Case> caselist = new List<Case>();
        for(Opportunity opportunityiterate:op){
            if(opportunityiterate.IsClosed==true){
                Case newcase = new Case();
                newcase.Status='New';
                //newcase.AccountId=opportunityiterate.AccountId;
                //newcase.ContactId=opportunityiterate.ContactId;
                newcase.Priority='Medium';
                newcase.Origin = 'Phone';
                caselist.add(newcase);
                System.debug(newcase);
            }
        }if(caselist.size()>0){insert caselist;}
        if(ocr.size()>0){
            insert(ocr);    
        }
        
    }
}