global with sharing class AccountResearch {
    
   public Account acct {get;set;}
    
    public AccountResearch(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
  
       
    public Contact[] getR(){
  
        String name = this.acct.searchField__c;
        
        Contact[] contacts = [select Name, Title, Phone, Is_Primary_Contact__c, AccountId
                          from Contact as c
                          where c.Name like :name];
        
        Contact[] filterContacts= new List<Contact>();
        
        for(Integer i =0; i<contacts.size();i++){
            String accountId = contacts[i].AccountId;
            Account acc = [select Id, Name from Account where Id = :accountId limit 1];
            
            if(acc.Name == this.acct.Name){
                filterContacts.add(contacts[i]);
            }
        }
            
        
        return filterContacts;    
    
    }
    
    public void save(){

        update acct;

    }
    
    @RemoteAction
    global static String changePriority(String id){
        Contact oldContact = [Select Id, Name, Is_Primary_Contact__c from Contact where Is_Primary_Contact__c = true limit 1 ];
        if(oldContact != null){
            oldContact.Is_Primary_Contact__c = false;
        }
        update oldContact;
        
        Contact newContact = [Select Id, Name, Is_Primary_Contact__c from Contact where Id = :id];
        newContact.Is_Primary_Contact__c = true;
        update newContact;
        
        return newContact.Name;
    }
    
   
}