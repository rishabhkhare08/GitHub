public with sharing class Q11_Class {
public static List<User> Q11_method(){
    List<User> us = [select Name,SenderEmail,Phone from User];
for(User u:us){
    System.debug('Name'+u.Name+'Mail'+u.SenderEmail+'number'+u.Phone);
}
return us;
}
}