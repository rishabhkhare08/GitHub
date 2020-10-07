public with sharing class Q28_Class {
    public static List<Contact> Q28_method() {
        List<User> usr = [SELECT Email FROM User];
        Set<String> mail = new Set<String>();
        for(User u:usr){
            mail.add(u.Email);
        }
        List<Contact> contact = [SELECT ID,Name from Contact where Email IN:mail];
        for(Contact c:contact){
            System.debug(c.id+'  '+c.Name);
        }
        return contact; 
    }
}