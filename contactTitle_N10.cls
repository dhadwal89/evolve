trigger contactTitle on Contact(before insert){

    for(Contact Con: trigger.new){

        if(con.email.contains('ceo')){
           title = 'CEO';
        }else if(con.email.contains('manager')){
            title= 'manager'
        }else{
              title = 'unknown'
        }

    }

}