@isTest
public with sharing class TestDataFac {
 public static List<Contact> createContact(Integer num){
  List<Contact> conlist = new List<Contact>();
  List<Account> acclist = new list<Account>();
  for(integer i=0;i<num;i++){
     Account a = new Account(Name = 'name'+i, Multiple_Contact__C=true);
     acclist.add(a);
  }
  insert acclist;
  for(integer i=0;i<num;i++){
      Contact co = new Contact();
      co.LastName='Name'+i;
      co.AccountId=acclist[i].Id;
      co.Email = 'rishabh.khare@cloudanalogy.com';
      conlist.add(co);
  }
  insert conlist;         
 return conlist;
 }

 public static void createProductQ4(){
     PriceBook2 pb = new PriceBook2();
     pb.id = Test.getStandardPricebookId();
     upsert pb;
     List<Product2> prod = new List<Product2>();
     for(Integer i=0;i<5;i++){
      Product2 p = new Product2();
      p.name = 'Name'+i;
      p.Description = 'aaaa';
      prod.add(p);
     }
     insert prod;
 }
 public static Integer deleteAccount(){
     Account a = new Account();
     a.Name = 'Ajay';
     a.Working_In__c='ASIA;NA';
     a.NumberOfEmployees=2;
     a.Multiple_Contact__C=true;
     insert a;
     return a.NumberOfEmployees;
 }
 public static List<Opportunity> CreateOpportunityQ6(){
    List<Opportunity> op = new List<Opportunity>();
    for(Integer i=0;i<5;i++){
       Opportunity o = new Opportunity();
       o.Name = 'name'+i;
       o.CloseDate = System.Today().addDays(15);
       o.StageName = 'Needs Analysis';
       op.add(o);
    }
    insert op;
    return op;
 }
 public static List<Account> CreateAccountQ12(){
     List<Account> acclist = new List<Account>();
     for(Integer i=0;i<5;i++){
       Account a = new Account();
       a.Name = 'name'+i;
       acclist.add(a);
     }
     insert acclist;
     return acclist;
    
}
public static void createProductQ17(){
    PriceBook2 pb = new PriceBook2();
    pb.id = Test.getStandardPricebookId();
    upsert pb;
}
public static void createCase(){
    Account a = new Account();
    a.Name = 'rishi';
    insert a;
    List<Contact> conlist = new List<Contact>();
    for(integer i=0;i<5;i++){
        Contact co = new Contact();
        co.LastName='Name'+i;
        conlist.add(co);
    }
    insert conlist;         
}
public static void createAttachmentQ21(){
    Account a  = new Account();
    a.Name = 'CAKurukshetra';
    insert a;
    Attachment attachmentPDF = new Attachment();
    attachmentPdf.parentId = a.id;
    attachmentPdf.name = a.name + '.pdf';
    attachmentPdf.body = blob.toPDF('pdfContent');
     insert attachmentPDF;
     Contact c = new Contact();
     c.LastName = 'abv';
     c.Accountid = attachmentPdf.parentId;
    insert c;
}
public static void  Q22(){
    PriceBook2 pb = new PriceBook2();
    pb.id = Test.getStandardPricebookId();
    pb.IsActive = true;
    upsert pb;

    Product2 p = new Product2();
     p.name = 'Nameres';
    insert p;

    priceBookEntry pbv = [Select id, UnitPrice from priceBookEntry 
    where PriceBook2Id=:Test.getStandardPricebookId() and Product2id=:p.id limit 1];

    Account a  = new Account();
    a.Name = 'CAKurukshetra';
    insert a;

    Opportunity op = new Opportunity();
    op.Name = 'nameriss';
    op.AccountId=a.id;
    op.CloseDate = System.Today().addDays(20);
    op.StageName = 'Need Analysis';
    insert op;

    OpportunityLineItem oli = new OpportunityLineItem();
    oli.priceBookEntryid = pbv.id;
    oli.Opportunityid = op.id;
    oli.UnitPrice=100;
    oli.Quantity = 100;
    insert oli;
}
public static void Q24(Integer num){
List<Lead> leadList = new List<Lead>();
for(Integer i=1;i<=num;i++)
{
Lead l = new Lead();
l.LastName = 'Lead'+i;
l.Company = 'Company'+i;
l.Records__c = 'Seller';
leadList.add(l);
}
insert leadList;
}
public static decimal CreatePlan(){
    Plan__c  planobject = new Plan__c();
      planobject.Travel_hours__c = 2;
      planobject.Travel_Location__c = 'A;B';
      insert planobject;
      decimal d = planobject.Travel_hours__c;
      return d;
}
public Static void Q26(){
    PriceBook2 pb = new PriceBook2();
    pb.id = Test.getStandardPricebookId();
    pb.IsActive = true;
    upsert pb;

    Product2 p = new Product2();
     p.name = 'Gandhiji Chasma';
    insert p;

    priceBookEntry pbv = [Select id, UnitPrice from priceBookEntry 
    where PriceBook2Id=:Test.getStandardPricebookId() and Product2id=:p.id limit 1];
    Account a  = new Account();
    a.Name = 'CAKurukshetraQ26';
    insert a;

    Opportunity op = new Opportunity();
    op.Name = 'nameriss';
    op.AccountId=a.id;
    op.CloseDate = System.Today().addDays(20);
    op.StageName = 'Need Analysis';
    insert op;

    OpportunityLineItem oli = new OpportunityLineItem();
    oli.priceBookEntryid = pbv.id;
    oli.Opportunityid = op.id;
    oli.UnitPrice=100;
    oli.Quantity = 100;
    insert oli;
    OpportunityLineItem oli1 = new OpportunityLineItem();
    oli1.priceBookEntryid = pbv.id;
    oli1.Opportunityid = op.id;
    oli1.UnitPrice=100;
    oli1.Quantity = 100;
    insert oli1;
    Op.StageName='Closed Won';
    update op;
}
public static void Q32(){
    Account a  = new Account();
    a.Name = 'CAKurukshetraQ32';
    a.Working_In__c='ASIA';
    insert a;

    PriceBook2 pb = new PriceBook2();
    pb.id = Test.getStandardPricebookId();
    pb.IsActive = true;
    upsert pb;

    Product2 p = new Product2();
     p.name = 'Gandhiji';
    insert p;
    PriceBook2 pb2 = new PriceBook2();
    pb2.Name = a.Working_In__c;
    pb2.IsActive=true;
    insert pb2;
    priceBookEntry pbe = new priceBookEntry();
    pbe.Product2id = p.id;
    pbe.PriceBook2Id=pb2.id;
    pbe.UnitPrice=12;
    pbe.IsActive=true;
    insert pbe;

    Opportunity op = new Opportunity();
    op.Name = 'nameri';
    op.AccountId=a.id;
    op.CloseDate = System.Today().addDays(20);
    op.StageName = 'Need Analysis';
    insert op;

    OpportunityLineItem oli = new OpportunityLineItem();
    oli.priceBookEntryid = pbe.id;
    oli.Opportunityid = op.id;
    oli.UnitPrice=100;
    oli.Quantity = 100;
    insert oli;
}
}