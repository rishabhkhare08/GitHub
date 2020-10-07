public class ProductProgram {
    public static void afterInsertMethod(List<Product2> pro){
        List<PriceBookEntry> pricebook = new List<PriceBookEntry>();
        PriceBook2 pb = [select id from PriceBook2 where isStandard=true];
        for(Product2 p:pro){
            priceBookEntry pbe = new priceBookEntry();
            pbe.Product2id=p.id;
            Pbe.PriceBook2Id=pb.Id;
            pbe.UnitPrice=1;
            pbe.isActive=true;
            pricebook.add(pbe);
        }
        insert pricebook;
    }
}