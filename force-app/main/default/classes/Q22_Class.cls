public with sharing class Q22_Class {
    public static List<OpportunityLineItem>  Q22_method(){
        Opportunity fetchedOpp = [SELECT Id, AccountId,  Name, StageName, Pricebook2Id, CloseDate FROM Opportunity LIMIT 1];
Opportunity cloneOpportunity = new Opportunity();
cloneOpportunity.Name=fetchedopp.Name+'Clone';
cloneOpportunity.CloseDate = fetchedOpp.CloseDate.addDays(30);
cloneOpportunity.StageName = fetchedOpp.StageName;
cloneOpportunity.AccountId = fetchedOpp.AccountId;
insert cloneOpportunity;
id ids = cloneOpportunity.id;
List<OpportunityLineItem> fetchoppline = [SELECT Id, OpportunityId, SortOrder, PricebookEntryId, Product2Id, ProductCode, Name,
                              Quantity, UnitPrice, ListPrice FROM OpportunityLineItem Where OpportunityId=:fetchedOpp.Id];
List<OpportunityLineItem> oppProListNew = new List<OpportunityLineItem>();
for(OpportunityLineItem obj: fetchoppline)
{
OpportunityLineItem opNew = new OpportunityLineItem();
opNew.OpportunityID = ids;
opNew.PricebookEntryId=obj.PricebookEntryId;
opNew.UnitPrice = obj.UnitPrice;
opNew.Quantity = obj.Quantity;
oppProListNew.add(opNew);
}
insert(oppProListNew);     
return oppProListNew;   

    }
}