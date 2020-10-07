public with sharing class Q5_Class {
    public static List<Database.DeleteResult> Q5_method(){
    List<Account> Accs = [select Name from Account where name LIKE 'A%'];
    integer acc=0;
    System.debug(accs[acc].Name +''+''+accs[acc].Id);
     Database.DeleteResult[] dr = Database.delete(accs, false);
   
return dr;
}
}