public class CustomAccount {

    private Account account;
 
    public CustomAccount() {
        account = [SELECT Id, Name FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
 
    public Account getCustomAccount() {
        return account;
    }
    
    public Contact[] getReturnContacts(String name){
        //Account acc = [select Id, Name from Account where Name like :nameAcc limit 1];
        if(name == ''){
            return new List<Contact>();
        }
        Contact[] contacts = [select Name, Title, Phone, Is_Primary_Contact__c, AccountId
                          from Contact as c
                          where c.Name like :name];
        
        Contact[] filterContacts= new List<Contact>();
        
        for(Integer i =0; i<contacts.size();i++){
            String accountId = contacts[i].AccountId;
            Account acc = [select Id, Name from Account where Id = :accountId limit 1];
            if(acc.Name == this.account.Name){
                filterContacts.add(contacts[i]);
            }
        }
            
        System.debug(filterContacts);
        return filterContacts;    
    
    }
    
}