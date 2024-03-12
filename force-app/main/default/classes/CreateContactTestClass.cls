@isTest
public class CreateContactTestClass {
    @isTest
    Public static void CreateContactTest() {
        // Test data setup
        Account acc = new Account();
        acc.Name = 'Test Account 1';
        acc.Phone = '9878787674';
        acc.Type = 'Customer - Direct';
        acc.Active__c = true;
        acc.Company_Email__c = 'test1@test.com';
        acc.Account_Activation_Summary__c = 'Test';
        System.debug(' before inserting  ');
        
        Test.startTest();
        insert acc;
        Test.stopTest();
                
        // Retrieve the new acc and contact
        Contact con = [SELECT Id, AccountId FROM Contact WHERE AccountId =: acc.Id ];
        System.debug(' after trigger fired: ' );
        
        // Test that the trigger correctly created the contact
        System.assert(con != null , 'con is not created');
        
        
        
    }
    
    
}