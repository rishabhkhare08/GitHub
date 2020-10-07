@isTest
public class TestVerifyDate {
    @isTest static void date2greaterdat1(){
        date date1 = date.newInstance(2017, 01, 05);
        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        date date2 = date.newInstance(2017, 02, 05);
        date rsultdate = VerifyDate.CheckDates(date1, date2);
            system.assertEquals(lastDay, rsultdate);
    }
    @isTest static void date2lessDate1(){
          date date1 = date.newInstance(2017, 01, 05);
        date date2 = date.newInstance(2017, 02, 05);
         Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        date rsultdate = VerifyDate.CheckDates(date1, date2);
            system.assertEquals(lastDay, rsultdate);
        
    }
      @isTest static void date2Date1(){
          date date1 = date.newInstance(2017, 01, 05);
          date date2 = date.newInstance(2017, 02, 03);
          date rsultdate = VerifyDate.CheckDates(date1, date2);
            system.assertEquals(rsultdate,date2);
        
    }
}