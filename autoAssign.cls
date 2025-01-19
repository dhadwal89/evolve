trigger autoAssign on Contact(before Insert){

    set<Id> accIds = new set<Id>();
    for(Contact ConObj : trigger.new){
        if(conObj.AccountId != null){
            accIds.add(conObj.AccountId);
        }

    }

    if(!accIds.isempty()){
        map<Id,Id> accOwnerMap = new Map<Id,Id>();
        for(Account accObj: [Select Id,ownerId from Account where id IN : accIds]){
            accOwnerMap.put(accObj.Id,accObj.ownerId);

        }

        for(Contact conObj : trigger.new){
            if(accOwnerMap.get(conObj.accountId) != null){
                conObj.ownerId =  accOwnerMap.get(conObj.accountId);
            }

        }
    }

}