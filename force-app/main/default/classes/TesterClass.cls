@isTest
public class TesterClass {
    @isTest  static void Q1_method(){
        List<Account> ls = TestingClass.Q1_classmethod();
        system.assertEquals(20, ls.size());
    }
    @isTest static void Q2_method(){
        TestDataFac.createContact(10);
        list<contact> result=Q2_Class.Q2_method();      
        System.assertEquals(10, result.size());
    }
    @isTest static void Q3_Method(){
        List<Opportunity> op = Q3_class.Q3_Method();
        System.assertEquals(20,op.size());
    }
    @isTest static void Q4_method(){
        TestDataFac.createProductQ4();
        List<Product2> pd = Q4_class.Q4_method();
        System.assertEquals(10,pd.size());
    }
    @isTest static void Q5_method(){
        TestDataFac.deleteAccount();
        List<Database.DeleteResult> result = Q5_Class.Q5_method();
        System.assertEquals(1,result.size());

    }
    @isTest static void Q6_method(){
        TestDataFac.CreateOpportunityQ6();
        List<Opportunity> op = Q6_Class.Q6_Method();
        System.assertEquals(5,op.size());
    }
    @isTest static void Q11_method(){
        List<user> u = Q11_Class.Q11_method();
        system.assertEquals(8,u.size());
    }
    @isTest static void Q12_method(){
        TestDataFac.CreateAccountQ12();
        List<Account> a = Q12_Class.Q12_method();
        system.assertEquals(5,a.size());
    }
    @isTest static void Q13_method(){
        Integer result = Q13_Class.Q13_method();
        system.assertEquals(34,result);
    }
    @isTest static void Q14_method(){
        Integer Result = Q14_class.Q14_method();
        System.assertEquals(432987,Result);
    }
    @isTest static void Q15_method(){
        TestDataFac.createProductQ4();
        List<Product2> pd = Q15_class.Q15_method();
        System.assertEquals(5,pd.size());
    }
    @isTest static void Q16_method(){
        String times = Q16_Class.Q16_method();
        system.assertEquals(' 3-1-0 1:1:0',times);
    }
    @isTest static void Q17_method(){
     TestDataFac.createProductQ17();
     List<Product2> pb = PriceBookProgram.priceBookMethod();   
     system.assertEquals(10,pb.size());
    }
    @isTest static void Q18_method(){
        String s = BinaryAdd.binaryAddMethod();
        System.assertEquals('1010010',s);
        
    }
    @isTest static void Q19_method(){
        String u1 = Q19_Class.Q19_method();
        system.assertEquals('Cloud123',u1);
    }
    @isTest static void Q20_method(){
        TestDataFac.CreateCase();
        List<Case> c = Q20_Class.Q20_method();
        system.assertEquals(5,c.size());
    }
    @isTest static void Q21_method(){
        TestDataFac.createAttachmentQ21();
        List<contact> c = Q21_Class.Q21_method();
        system.assertEquals(1,c.size());
    }
    @isTest static void Q22_method(){
        TestDataFac.Q22();
        List<OpportunityLineItem> ls = Q22_Class.Q22_method();
        
    }
    @isTest static void Q23_method(){
        TestDataFac.Q22();
        List<Account> ls = Q23_Class.Q23_method();
        
    }
    @isTest static void Q24_method(){
        TestDataFac.Q24(5);
        List<Lead> l = Q24_Class.Q24_method();

    }
    @isTest static void Q25_method(){
        decimal p = TestDataFac.CreatePlan();
        decimal result = Q25_Class.Q25_method();
        system.assertEquals(p,result);

    }
    @isTest static void Q26_method(){
        TestDataFac.Q26();
        List<Account> a = Q26_Class.Q26_method();
    }
    @isTest static void Q27_method(){
        decimal d = TestDataFac.deleteAccount();
        decimal d1 = Q27_Class.Q27_method();
        system.assertEquals(d,d1);
    }
    @isTest static void Q28_method(){
        List<Contact> expected=TestDataFac.createContact(4);
        List<Contact> actual=Q28_Class.Q28_method();
        System.assertEquals(expected.size(),actual.size());
    }
    @isTest static void Q29_method(){
        TestDataFac.Q26();
        Q29_Class.Q29_method();
    }
    @isTest static void Q30_method(){
        TestDataFac.Q26();
        Q30_Class.Q30_method();
    }
    @isTest static void Q31_method(){
        TestDataFac.createProductQ17();
        Q31_Class.Q31_method();
    }
    @isTest static void Q32_method(){
        TestDataFac.Q32();
        Q32_Class.Q32_method();
    }
}