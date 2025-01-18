trigger dupeContacts on contact(before insert){

    set<String> dupKeyList = new set<String>();
        for(Contact Con : [Select Id,AccountId from Contact where Email IN :trigger.new ]){
            string dupkey = con.accountId+con.email;
            dupKeyList.add(dupkey);

        }

    

    if(!dupKeyList.isempty()){
        for(Contact conObj : trigger.new){
            if(dupkeylist.contains(conObj.AccountId+conObj.Email)){
                conObj.addError('Duplicate Contact');
            }

        }
    }

}