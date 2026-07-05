public class AccountManager1 {

    // Create a new Account
    public static Account createAccount(String accountName) {
        Account acc = new Account(Name = accountName);
        insert acc;
        return acc;
    }

    // Get Account by Id
    public static Account getAccountById(Id accountId) {
        return [
            SELECT Id, Name, AccountSource
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    // Update Account Name
    public static void updateAccount(Id accountId, String newName) {
        Account acc = [
            SELECT Id, Name, AccountSource
            FROM Account
            WHERE Id = :accountId
        ];
        acc.Name = newName;
        acc.AccountSource='web';
        update acc;
    }

    // Delete Account
    public static void deleteAccount(Id accountId) {
        Account acc = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
        ];
        delete acc;
    }
}