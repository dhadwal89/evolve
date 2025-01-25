trigger caseOwner on Case(before insert){


  for(Case csObj : trigger.new){

    if(csObj.type == 'Technical'){
        csObj.ownerId =  [Select Id from User where Name = 'Aman Dhadwal' limit 1].Id;

    }else if(csObj.type = 'Billing'){
        csObj.ownerId =  [Select Id from User where Name = 'Shopify' limit 1].Id;

    }else{
        csObj.ownerId = [Select id from Group where type = 'Queue' and DeveloperName = 'QueueName']
    }

  }

}