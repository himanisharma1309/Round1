@isTest
public class CreateContactUpdateAccountTestClass {
    @isTest
    Public static void UpdateAccountTest() {
        // Test data setup
        Account acc = new Account();
        acc.Name = 'Test Account 2';
        acc.Phone = '9878787674';
        acc.Type = 'Customer - Direct';
        acc.Active__c = false;
        acc.Company_Email__c = 'test1@test.com';
        acc.Account_Activation_Summary__c = 'Test';
        System.debug(' before inserting  ');
        
                insert acc;

        Account acc3 = [SELECT Id,Name, Phone,Type, Active__c, Company_Email__c, Account_Activation_Summary__c FROM Account WHERE Name = 'Test Account 2' ];
        Account acc2 = new Account();
        acc2.Id=acc3.Id;
        acc2.Active__c = true;

        
        Test.startTest();
        update acc2;
        Test.stopTest();
                
        // Retrieve the new acc and contact
        Contact con = [SELECT Id, AccountId FROM Contact WHERE AccountId =: acc2.Id AND LastName = 'Customer Representative'];
        System.debug(' after trigger fired: ' );
        
        // Test that the trigger correctly created the contact
        System.assert(con != null , 'con is not created');
        
        
        
    }
    
    
}