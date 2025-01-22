trigger casePriority on Case(before insert){


    for(Case csObj : trigger.new){

        if(csObj.Origin == 'Phone'){
            csObj.priority = 'High';

        } else if(csObj.Origin == 'Email'){
            csObj.priority = 'Medium';
        }else {
            csObj.priority = 'low';
        }

    }
}