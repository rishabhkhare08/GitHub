public with sharing class Q13_Class {
public static integer Q13_method(){
integer res=1,temp=1,Result=0;
for(integer i=1;i<=7;i++){
    result = temp+res;
    System.debug(temp);
    res=temp;
    temp=result;
    System.debug(result);
}
return result;
}

}