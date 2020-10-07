public with sharing class AccountList100 {
    List<Account> accounts;

    public List<Account> getAccounts() {
        if(accounts == null)
            accounts = [SELECT name, Phone FROM account LIMIT 100];
        return accounts;
    }
}