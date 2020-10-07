public class BinaryAdd {
    public static String binaryAddMethod(){
        String s1 = '100101';
        String s2 = '0101101';
        Integer [] sum = new List<Integer>();
        String f = '';
        Integer diff = Math.abs(s1.length()-s2.length());
        Integer i=0,s=0,rem=0;
        String add = '0';
        String s3='0'; 
        while(i<diff){
            s1=add+s1;
            i++;
        }
Integer bin1=Integer.ValueOf(s1);
Integer bin2=Integer.ValueOf(s2);
while(bin1!=0 || bin2!=0)
{
    s = math.mod((math.mod(bin1, 10) + math.mod(bin2, 10) + rem), 2);
    sum.add(s);
    rem = (math.mod(bin1, 10) + math.mod(bin2, 10) + rem)/2;
    bin1 = bin1/10;
    bin2 = bin2/10;
}
if(rem!=0)
    sum.add(rem);  
        for (Integer j = sum.size()-1; j>=0; j--){
    f+=sum[j];
        }       
System.debug(f);
return f;
}
}