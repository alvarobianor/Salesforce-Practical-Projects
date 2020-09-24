public class AccountResearch {

   public AccountResearch(ApexPages.StandardController acon) { }
    
    public AccountResearch(){}
    
    public Contact[] getReturnContacts(String name, String nameAcc){
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
            if(acc.Name == nameAcc){
                filterContacts.add(contacts[i]);
            }
        }
            
        System.debug(filterContacts);
        return filterContacts;    
    
    }
    
    public Contact[] getR(){
        return [select Name, Title, Phone, Is_Primary_Contact__c, AccountId
                          from Contact];
    }
    
}

 		// String aiai = contacts[0].AccountId;
       // System.debug(acc);
       // Account acc2 = [select Id, Name from Account where Id = :aiai limit 1];
        //System.debug(contacts);
        //System.debug(acc2);