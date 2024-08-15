public class ContactChangeEventTriggerHelper {
    public static void AfterInsert(List<ContactChangeEvent>ContactChangeEventList){
        List<Task>taskList=new List<Task>();
        for(ContactChangeEvent event:ContactChangeEventList){
            System.debug('event ===>'+event);
            EventBus.ChangeEventHeader header=event.ChangeEventHeader;
            System.debug('Header ===>'+header);
            if(header.changeType=='CREATE'){
                // Create the Task
                for(String recordId:header.recordIds){
                            Task t=new Task();
                            t.Subject='New Contact is created -- Do the Action now';
                            t.OwnerId=header.commitUser;
                            t.WhoId =recordId;
                            taskList.add(t);    
                   }
               
            }else if(header.changeType=='UPDATE'){
                for(String fields:header.changedFields){
                    if(fields=='Email'){
                        // Create the Task
                         for(String recordId:header.recordIds){
                            Task t=new Task();
                            t.Subject='Email address of contact changed -- Do the Action now';
                            t.OwnerId=header.commitUser;
                            t.WhoId =recordId;
                            taskList.add(t);    
                        }
                    }
                }
            }
        }
         
        if(taskList.size()>0){
            try{
                Insert taskList;
            }
            catch(Exception ex){
                System.debug('Task Creation Failed'+ex.getMessage());
            }
           
        }
        
    }
}