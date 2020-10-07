public with sharing class Q14_Class {
   public static Integer Q14_method(){
    Integer remender=0,reversednum=0;
    Integer reversingnumber=789234;
    integer temp = 10;
    for(Integer i=0;i<6;i++)
    {
        remender = Math.Mod(reversingnumber,temp);
        reversednum=reversednum*temp+remender;
        reversingnumber=reversingnumber/temp;
    }
    system.debug(reversednum);
    return reversednum;
   }
}