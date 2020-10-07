public class StringArrayTest {
    public static List<String> generateStringArray(Integer n){
        List<String> s = new List<String>();
            for(Integer i=0;i<n;i++){
                s.add('Test '+i);
                System.debug(s[i]);
            }
        return s;
    }
}