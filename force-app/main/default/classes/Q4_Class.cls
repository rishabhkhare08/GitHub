public with sharing class Q4_Class {
    public static List<Product2> Q4_Method(){
    List<Product2> prod = new List<Product2>();
for(Integer i=1;i<=10;i++){
    Product2 p = new Product2();
    p.Name = 'Name'+i;
    p.Description = 'Cloud analogy untitled product';
    p.Family='None';
    prod.add(p);
}
insert(prod);
return prod;
}
}