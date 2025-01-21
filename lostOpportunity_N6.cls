Write a trigger on the Account when the Account is updated check all opportunities related to the account. 
Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

trigger accOppUpdate on Account(after update){

    List<Opportunity> oppList = new List<Opportunity>();
     for(Opportunity oppObj : [Select Id,stage from Opportunity where AccountId IN: trigger.newmap.keyset() AND createddate < system.today.addDays(-30) and stagename != 'Close Won']){
  
        oppObj.stagename = 'Close Lost';
        oppList.add(oppObj);
    }

 if(!oppList.isempty()){
    update oppList;
 }

}
