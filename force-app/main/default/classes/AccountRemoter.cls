public class AccountRemoter {

    public String accountName { get; set; }
    public static Account account { get; set; }
    public AccountRemoter(ApexPages.StandardController std) { } // empty constructor
    
    @RemoteAction
    public static Account getAccount(String accountName) {
        String s ='SELECT id, Name, phone FROM Account WHERE Name LIKE \'%'+accountName+'%\' LIMIT 1';
         account = Database.query(s);
        return account;
    }
}