public class javascriptremoting {
  @remoteAction
    public static List<Account> loadaccs(){

        return [select Id,Name,Phone from Account];

        }
        }