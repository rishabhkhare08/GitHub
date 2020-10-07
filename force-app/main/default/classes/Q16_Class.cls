public with sharing class Q16_Class {
  public static String Q16_method(){
           String firstS='06:07:55 2-jan-2016';
            String secondS='07:08:55 5-feb-2016';
            String tz=' ';
            String dt=' ';
            String s;
            String temp;
            String finalS;
            List<String> months =new List<String>{'jan','feb','mar','april','may','june','july','aug','spet','oct','nov','dec'};
            List<String> s1 =new List<String>(firstS.split(' '));
            List<String> timeT = new List<String>(s1[0].split(':'));
            List<String> dateT = new List<String>(s1[1].split('-'));
            List<String> s2 =new List<String>(secondS.split(' '));
            List<String> timeT1 = new List<String>(s2[0].split(':'));
            List<String> dateT2 = new List<String>(s2[1].split('-'));
            for(integer i=0;i<timeT.size();i++){
                Integer h=(Math.abs(Integer.valueOf(timeT.get(i))-Integer.valueOf(timeT1.get(i))));
                tz+=h;
                if(i<timeT.size()-1){
                    tz+=':';
                }
                
            }
            System.debug(tz);
            for(integer i=0;i<dateT.size();i++){
                if(i==1){
                    for(Integer j=0;j<months.size();j++){
                        if(dateT.get(i).equals(months.get(j))){
                            Integer re=j+1;
                         dateT[i]= dateT.get(i).replace(dateT.get(i),String.valueOf(re));
                        }
                    }
                }
            }
              System.debug(dateT[1]);       
            for(integer i=0;i<dateT2.size();i++){
                if(i==1){
                    for(Integer j=0;j<months.size();j++){
                        if(dateT2.get(i).equals(months.get(j))){
                            Integer re=j+1;
                          dateT2[i]=dateT2.get(i).replace(dateT2.get(i),String.valueOf(re));
                        }
                    }   
                }
            }
            for(integer i=0;i<dateT2.size();i++){
                Integer h=(Math.abs(Integer.valueOf(dateT.get(i))-Integer.valueOf(dateT2.get(i))));
               
                dt+=h;
                if(i<dateT2.size()-1){
                    dt+='-';
                }
            }
            finalS=dt+''+tz;
            System.debug(finalS);
            return finalS;
}
}