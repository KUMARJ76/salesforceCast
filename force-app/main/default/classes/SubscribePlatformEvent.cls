public class SubscribePlatformEvent {
    public static void afterInsert(List<Order_Detail__e>orderDetailList){
        // In one batych we can fire 2000 platform events
        List<Task>taskList=new List<Task>();
        User adminUser=[Select Id,Username from User where Username='jeetesh@tcs.com'];
        
        for(Order_Detail__e orderDetail:orderDetailList){
            Task tsk=new Task();
            tsk.Subject='Platform Event Subscribed using Triggers';
            tsk.ActivityDate=System.today();
            tsk.Description=orderDetail.Order_Number__c;
            tsk.OwnerId=adminUser.Id;
            taskList.add(tsk);
        }
        if(taskList.size()>0){
            try{
                 insert taskList; 
            }catch(Exception ex){
                System.debug('Task creation failed'+ex.getMessage());
            }
          
        }
        
    }
}