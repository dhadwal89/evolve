/* 
A company wants to track the number of inactive contacts under each Account. A contact is considered inactive if its LastActivityDate is more than 365 days old.
Create a solution to update a custom field Inactive_Contacts__c on the Account whenever:
An existing Contact is updated.
*/

trigger conTrigger on Contact(after Update){

    set<Id> accIds = new set<Id>();
        for(Contact conObj : trigger.new){
            if(conObj.AccountId != null){
               accIds.add(conObj.AccountId);
            }
        }
    
        string thresholdDate = system.today.addDays(-365);
        List<Account> accList = new List<Account>();
        for(AggregateResult agr : [Select AccountId, Count(Id) inactiveCount from Contact Where lastActivityDate < :thresholdDate and AccountId IN :accIds group by AccountId ]){
        
           Id accountIdVar = (Id)agr.get('AccountId');
           Integer countContacts  = (Integer)agr.get('inactiveCount');
           accList.add(new account(Id=accountIdVar, Inactive_Contacts__c = countContacts ));
        }
    
        if(!accList.isempty()){
           update accList;
        }
    
    }
    
