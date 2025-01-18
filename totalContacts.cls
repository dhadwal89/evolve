trigger contactTrigger on Contact(after insert){

    set<Id> accIds = new set<Id>();
    for(Contact Con : trigger.new){

        if(con.AccountId != null){
            accIds.add(con.AccountId);
        }
    }

    List<Account> accList = new List<Account>();
    for(AggregateResult Agr: [Select AccountId, Count(Id) conIds from Contact where AccountId IN :accIds group by AccountId ]){

       Id accid = (Id)agr.get('AccountId');
       Integer conCount = (Integer)agr.get('conIds');
     
       accList.add(new account(Id = accId,Contact_Count__c = conCount));

    }

    if(!accList.isempty()){
        update accList;

    }

}