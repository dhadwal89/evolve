trigger accPrimaryContact on contact(after insert){

 map<Id,Id> accConIds = new map<Id,Id>();
   for(Contact Con : trigger.new){

     if(con.accountId != null){
        accConIds.put(con.accountId,Con.Id);  
     }

   }
   if(accConIds.size() > 0){
   List<Account> accList = new List<Account>();
   for(Account accObj : [Select Id,primary_contact__c from Account where Id IN:accConIds.keyset()]){

    accList.add(new account(Id=accObj.Id,primary_contact__c = accConIds.get(accObj.Id)));
      

   }
}

if(!accList.isempty()){
  update accList;
}



}
