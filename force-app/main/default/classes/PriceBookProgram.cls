public class PriceBookProgram {
    public static List<Product2> priceBookMethod(){
        PriceBook2 PB= new PriceBook2(Name='Jhansi PriceBook',IsActive=true);
        insert PB;
        List<Product2> newProduct = new List<Product2>();
            for(Integer  i=0;i<10;i++){
                Product2 products = new Product2();
                products.Name = 'LENOVO'+i;
                newProduct.add(products);
        }
        insert newProduct;
        
        List<PriceBookEntry> pblist = new List<PriceBookEntry>();
        PriceBook2 StandardPB =[select id from PriceBook2 where isStandard=true];
        List<PriceBookEntry> StandardList = [SELECT Id, Pricebook2Id, Product2Id, IsActive, UnitPrice FROM PricebookEntry where Pricebook2Id=:StandardPB.id limit 10000];
        for(Integer i=0;i<newProduct.size();i++){
        /*PriceBookEntry StandardPBE = new PriceBookEntry(PriceBook2Id=StandardPB.Id,Product2Id=newProduct[i].Id, 
                                                                     UnitPrice=500,IsActive=true);
        insert StandardPBE;*/

        PriceBookEntry customPBE = new PriceBookEntry(PriceBook2Id=PB.Id,Product2Id=newProduct[i].Id, 
                                                                     UnitPrice=i*2,IsActive=true);
        pblist.add(customPBE);
            
    }
        insert pblist;
        return newProduct;  
    }
}