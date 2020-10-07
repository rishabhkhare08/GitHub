public with sharing class Q19_Class {
    public static String Q19_method(){
 Profile newProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
User userOb = new User();
userOb.LastName = 'Cloud123';
userOb.Email = 'kurukshetra@cloudanalogy.com';
userOb.Alias = 'Cloud';
userOb.Username = 'KIET.rishabh@aktu.com';
userOb.CommunityNickname= 'C3A';
userOb.LocaleSidKey = 'en_US';
userOb.TimeZoneSidKey = 'GMT';
userOb.ProfileID = newprofile.Id;
userOb.LanguageLocaleKey = 'en_US';
userOb.EmailEncodingKey = 'UTF-8';
insert (userOb);
String s = userOb.LastName;
return s;
    }
}