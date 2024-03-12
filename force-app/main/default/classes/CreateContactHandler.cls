public class CreateContactHandler {
    public static void CreateContact(List<Account> newAccountsList) {
        List<Contact> ContactsListToUpdate = new List<Contact>();
        
        Map<Id, Account> AccIdandRecordMap = new Map<Id, Account>();
        for(Account acc:newAccountsList) {
            if(acc.Active__c==true && 
               (acc.Type == 'Customer - Direct' || acc.Type == 'Customer - Channel') ) {
                   AccIdandRecordMap.put(acc.Id, acc);
               }
        }
        
        for(Account acc:[Select Id, Name, Phone, Active__c, Company_Email__c, Account_Activation_Summary__c, 
                         (SELECT Id, LastName, FirstName, Phone, Email 
                          FROM Contacts
                          WHERE LastName = 'Customer Representative') 
                         FROM Account 
                         WHERE Id in:AccIdandRecordMap.keyset()]){
                             system.debug( 'acc.Name ' + acc.Name +' '+ acc.Contacts.size());
                             if(acc.Contacts.size()==0){
                                 system.debug('Contacts.size()==0');
                                 Contact con = new Contact();
                                 con.FirstName = acc.Name;
                                 con.LastName = 'Customer Representative';
                                 con.Phone = acc.Phone;
                                 con.Email = acc.Company_Email__c;
                                 con.AccountId = acc.Id;
                                 ContactsListToUpdate.add(con);
                                 system.debug(con);
                             }
                         }   
        
        if(!ContactsListToUpdate.isEmpty()){
            system.debug('ContactsListToUpdate.is not empty');
            insert ContactsListToUpdate;
        }
    }
    
    
    
    public static void CreateContactonUpdate(List<Account> newAccountsList2, Map<Id,Account> oldAccountsMap) {
        system.debug('CreateContactonUpdate');
        Set<Id> accIdsSet = new Set<Id>();
        List<Contact> InsertContacts = new List<Contact>();
        for(Account acc:newAccountsList2) {
            system.debug('acc.Name' + acc.Name);
            if(Acc.Active__c == true && 
               (acc.Type == 'Customer - Direct' || acc.Type == 'Customer - Channel') && 
               (acc.Active__c!=oldAccountsMap.get(acc.Id).Active__c)
              ) {
                  system.debug('acc added to set ');
                  accIdsSet.add(acc.Id); 
              }
        }
        
        for(Account acc:[SELECT Id, Name, Phone, Active__c, Company_Email__c, Account_Activation_Summary__c, 
                         (SELECT Id,LastName, FirstName, Phone, Email 
                          FROM Contacts
                          WHERE LastName = 'Customer Representative') 
                         FROM Account WHERE Id in:accIdsSet]) {
                             system.debug('acc.Name' + acc.Name +' ' + acc.Contacts.size());
                             if(acc.Contacts.size()==0){
                                 system.debug('acc.Contacts.size()=0');
                                 Contact con = new Contact();
                                 con.FirstName = acc.Name;
                                 con.LastName = 'Customer Representative';
                                 con.Phone = acc.Phone;
                                 con.Email = acc.Company_Email__c;
                                 con.AccountId = acc.Id;
                                 InsertContacts.add(con);
                                 system.debug(con);
                             }
                         }
        if(!InsertContacts.isEmpty()){
            system.debug('InsertContacts.is not empty');
            insert InsertContacts;
        }
    }
}