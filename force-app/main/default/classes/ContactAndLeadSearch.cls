public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String lastname)
    {
        List<List<SObject>> searchList = [FIND :lastname IN ALL FIELDS 
                                      RETURNING Lead(FirstName,LastName), Contact(FirstName,LastName)];
        return searchList;
    }
    
}