public class emailProgram {
    public static void getUserIdMethod(){
List<User> user=[SELECT Id from user];
List<Account> account = [Select OwnerID From Account];
List<contact> contact = [Select OwnerID from Contact];
List<id> ids = new list<id>();    
for(User u:user){
    Integer i=0; 
    for(Account a:account){
        if(u.Id==a.OwnerID){
            i++;
            if(i>=100){
                i=0;
                Integer j=0;
                for(Contact c:contact){
                    if(u.id==c.OwnerID){
                        j++;
                        if(j>=30){
                           ids.add(u.id);
                        }
                    }    
                }
            }
        }
    }
}    
Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
mail.setTargetObjectIds(ids); 
mail.setTemplateId('00X2v000003aOVSEA2');
mail.setSaveAsActivity(false);
Messaging.SendEmailResult[] sendEmailResults = Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
for (Messaging.SendEmailResult sendEmailResult : sendEmailResults) {
if(sendEmailResult.isSuccess()){ 
    System.debug('success');
}
else{ 
    System.debug('error');
    }
    }
        
  }
    
}