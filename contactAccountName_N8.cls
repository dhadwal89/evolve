trigger conAccount on Contact(before insert){

    set<Id> accIds = new set<Id>();
    for(Contact con : trigger.new){
        if(con.AccountId){
            accIds.add(con.AccountId);
        }
    }

    Map<Id,String> accMap = new Map<Id,String>();
    for(Account accObj: [Select Id,Name from Account where Id IN: accIds]){
        accMap.put(accObj.Id,accObj.Name);
    }

    for(Contact conObj : trigger.new){

        conObj.Account_Name__c = (String)accMap.get(conObj.AccountId);

    }

}