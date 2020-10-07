public with sharing class Q12_Class {
Public static List<Account> Q12_method(){
List<Account> accs= [select Name from Account]; 
for(integer i=0;i<accs.size();i++){
     String name = accs[i].Name;
     string rev=' ';
    for(integer j=name.length()-1;j>=0;j--){
       rev +=name.substring(j,j+1); 
    }
    System.debug(rev);
}
return accs;
}
}