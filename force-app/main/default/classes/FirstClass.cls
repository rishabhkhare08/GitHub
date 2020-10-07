public class FirstClass {
    public static void firstMethod(){
        String[] AccName = new List<String>{'Nokia','HP','Dell','Lenovo','Redmi','cloud analogy','Bosch','Tiger',
            'Microsoft','Salesforce','Kiet','SRGI','Renult','Honda','TATA','Hyundai','Skyland','Acer','Everest','Bisleri'};
        String[] AccNum = new List<String>{'254','876','120','631','701','111','745','621','121','300','777','141','514',
            '121','444','456','525','545','111','147'};
        decimal[] AnnRev = new List<decimal>{521.2,222,875.22,544.6,454,111,425,268,565,398,425,31,5,4,3,6,4,55,123,100};
        integer[] emp = new List<integer>{10,25,41,30,54,51,523,11,77,76,25,56,54,656,30,306,44,856,26,76};
        String[] website = new List<String>{'Nokia.com','HP.com','Dell.com','Lenovo.com','Redmi.com','cloudanalogy.com',
            'Bosch.com','Tiger.com','Microsoft.com','Salesforce.com','Kiet.com',
            'SRGI.com','Renult.com','Honda.com','TATA.com','Hyundai.com','Skyland.com','Acer.com','Everest.com','Bisleri.com'};
       List<Account> accs= new List<Account>();
        for(integer i=0;i<20;i++){
            Account a = new Account();
            a.Name=AccName[i];
            a.AccountNumber =AccNum[i];
            a.AnnualRevenue = AnnRev[i];
            a.NumberOfEmployees = emp[i];
            a.Website=website[i];
            accs.add(a);
        }
        insert accs;
    }    
                                   
 }