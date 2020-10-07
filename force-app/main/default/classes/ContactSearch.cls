public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName,String mailing){
        List<Contact> con = [select Id, Name from Contact where LastName=:lastName And MAilingPostalCode=:mailing];
        return con;
    }
}