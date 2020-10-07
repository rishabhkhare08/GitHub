public class AccountHandler {
    public static Account insertNewAccount(String name){
        Account newAccount = new Account(Name=name);
        try{
            insert newAccount;
            
        }catch(DMLException e){
            newAccount=null;
        }
        return newAccount;
    }
}