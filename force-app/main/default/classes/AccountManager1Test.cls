@isTest
public class AccountManager1Test {

    @testSetup
    static void setupTestData() {
        Account acc = new Account(
            Name = 'Test Account',
            AccountSource = 'Phone Inquiry'
        );
        insert acc;
    }

    @isTest
    static void testCreateAccount() {

        Test.startTest();

        Account newAcc = AccountManager1.createAccount('Created Account');

        Test.stopTest();

        System.assertNotEquals(null, newAcc.Id, 'Account Id should not be null');
        System.assertEquals('Created Account', newAcc.Name);

        Account result = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :newAcc.Id
        ];

        System.assertEquals('Created Account', result.Name);
    }

    @isTest
    static void testGetAccountById() {

        Account acc = [
            SELECT Id, Name, AccountSource
            FROM Account
            LIMIT 1
        ];

        Test.startTest();

        Account result = AccountManager1.getAccountById(acc.Id);

        Test.stopTest();

        System.assertEquals(acc.Id, result.Id);
        System.assertEquals('Test Account', result.Name);
        System.assertEquals('Phone Inquiry', result.AccountSource);
    }

    @isTest
    static void testUpdateAccount() {

        Account acc = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];

        Test.startTest();

        AccountManager1.updateAccount(acc.Id, 'Updated Account');

        Test.stopTest();

        Account updatedAcc = [
            SELECT Name, AccountSource
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Updated Account', updatedAcc.Name);
        System.assertEquals('Web', updatedAcc.AccountSource);
    }

    @isTest
    static void testDeleteAccount() {

        Account acc = new Account(
            Name = 'Delete Me'
        );
        insert acc;

        Test.startTest();

        AccountManager1.deleteAccount(acc.Id);

        Test.stopTest();

        Integer accountCount = [
            SELECT COUNT()
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(0, accountCount, 'Account should be deleted.');
    }
}