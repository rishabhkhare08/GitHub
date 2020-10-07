public with sharing class Q15_Class {
Public static List<product2> Q15_method(){
    List<Product2> prod = [select Name, Description from Product2 where Description LIKE'%a%'];
for(Product2 pd:prod){
    System.debug(pd.Description);
}
return prod;
}
}