@isTest
public class AccountManager1Test {

    @testSetup
    static void setupData() {
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

        System.assertNotEquals(null, newAcc.Id);
        System.assertEquals('Created Account', newAcc.Name);

        Account acc = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :newAcc.Id
        ];

        System.assertEquals('Created Account', acc.Name);
    }

    @isTest
    static void testGetAccountById() {

        Account existingAcc = [
            SELECT Id, Name, AccountSource
            FROM Account
            LIMIT 1
        ];

        Test.startTest();

        Account result = AccountManager1.getAccountById(existingAcc.Id);

        Test.stopTest();

        System.assertEquals(existingAcc.Id, result.Id);
        System.assertEquals('Test Account', result.Name);
        System.assertEquals('Phone Inquiry', result.AccountSource);
    }

    @isTest
    static void testUpdateAccount() {

        Account existingAcc = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];

        Test.startTest();

        AccountManager1.updateAccount(existingAcc.Id, 'Updated Account');

        Test.stopTest();

        Account updatedAcc = [
            SELECT Name, AccountSource
            FROM Account
            WHERE Id = :existingAcc.Id
        ];

        System.assertEquals('Updated Account', updatedAcc.Name);
        System.assertEquals('Web', updatedAcc.AccountSource);
    }

    @isTest
    static void testDeleteAccount() {

        Account deleteAcc = new Account(
            Name = 'Delete Account'
        );
        insert deleteAcc;

        Test.startTest();

        AccountManager1.deleteAccount(deleteAcc.Id);

        Test.stopTest();

        Integer countAcc = [
            SELECT COUNT()
            FROM Account
            WHERE Id = :deleteAcc.Id
        ];

        System.assertEquals(0, countAcc);
    }
}