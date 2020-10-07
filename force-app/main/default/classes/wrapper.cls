public with sharing class wrapper{
    public List<Contact> conrecord{get;set;}
    public List<Opportunity> opptrecord{get;set;}
    public Account acc{get;set;}
  public wrapper(){
      conrecord = new List<Contact>();
      opptrecord = new List<Opportunity>();
      acc = new Account();
  }
 }