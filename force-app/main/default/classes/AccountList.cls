global class AccountList {
    public static String searchstring{get;set;}
    public static List<Account> acclist{get;set;}
    public AccountList(){    
    }
 
    public static void search(){
        string Query = 'SELECT id, Name, phone FROM Account WHERE Name LIKE \'%'+searchstring+'%\' LIMIT 5';
        acclist = Database.query(Query);
    
    }
}