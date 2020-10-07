public class InlineController {

   public Account newAccount { get; set; }
    
    public Account editAccount { get; set; }

    public InlineController () {
        newAccount = new Account();
    }
    
    public Account[] getEmployees() {
        return [Select Name, id, Phone From Account];
    }
    
    public String getParam(String name) {
        return ApexPages.currentPage().getParameters().get(name);   
    }
    
        
    public PageReference del() {
        try {
            String delid = getParam('delid');
            Account employee = [SELECT Id FROM Account WHERE ID=:delid];
            DELETE employee;
        } catch (Exception e) {
            ApexPages.addMessages(e);
        }
        return null;
    }
    
    public PageReference editacc() {
        String editid = getParam('editid');
        editAccount = [SELECT Name, id, Phone FROM Account WHERE id=:editid];
        return null;
    }
    
    public PageReference cancelEdit() {
   // System.Debug('GETURL ::: '+ApexPages.currentPage().getUrl());
        editAccount = null;
        return null;
    }
    
    public PageReference saveEdit() {
        try {
            UPDATE editAccount;
            editAccount = null;
        } catch (Exception e) {
            ApexPages.addMessages(e);
        }
        return null;
    }

}