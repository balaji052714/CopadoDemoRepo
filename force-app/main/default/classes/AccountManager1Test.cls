@isTest
public class AccountManager1Test {

    @isTest
    static void testCreateAccount() {

        Test.startTest();
        Account acc = AccountManager1.createAccount('Test Account');
        Test.stopTest();

        System.assertNotEquals(null, acc.Id, 'Account should be created.');
        System.assertEquals('Test Account', acc.Name);
    }

    @isTest
    static void testGetAccountById() {

        // Create test data
        Account acc = new Account(
            Name = 'Sample Account',
            AccountNumber = 'ACC1001',
            AccountSource = 'Phone Inquiry'
        );
        insert acc;

        Test.startTest();
        Account result = AccountManager1.getAccountById(acc.Id);
        Test.stopTest();

        System.assertEquals(acc.Id, result.Id);
        System.assertEquals('Sample Account', result.Name);
        System.assertEquals('Phone Inquiry', result.AccountSource);
    }

    @isTest
    static void testUpdateAccount() {

        // Create test data
        Account acc = new Account(
            Name = 'Old Name',
            AccountSource = 'Partner Referral'
        );
        insert acc;

        Test.startTest();
        AccountManager1.updateAccount(acc.Id, 'New Name');
        Test.stopTest();

        Account updatedAcc = [
            SELECT Name, AccountSource
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('New Name', updatedAcc.Name);
        System.assertEquals('Web', updatedAcc.AccountSource);
    }

    @isTest
    static void testDeleteAccount() {

        // Create test data
        Account acc = new Account(Name = 'Delete Me');
        insert acc;

        Test.startTest();
        AccountManager1.deleteAccount(acc.Id);
        Test.stopTest();

        Integer countAcc = [
            SELECT Count()
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(0, countAcc, 'Account should be deleted.');
    }
}