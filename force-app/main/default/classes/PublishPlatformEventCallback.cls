public class PublishPlatformEventCallback implements EventBus.EventPublishSuccessCallback,EventBus.EventPublishFailureCallback {
    public void onSuccess(EventBus.SuccessResult result){
        List<String>EventUUIDList= result.getEventUuids();
        insertTask(EventUUIDList,true);
    }
    
     public void onFailure(EventBus.FailureResult result){
        List<String>EventUUIDList= result.getEventUuids();
          insertTask(EventUUIDList,false);
    }
    
    public void insertTask(List<String>EventUUIDList,Boolean isSuccess){
        String EventUUIDString='';
        for(String EventUUID:EventUUIDList ){
              EventUUIDString=EventUUIDString+EventUUID + '';
              Task tsk=new Task();
                if(isSuccess==True){
                   //If Platform Event Published Successfully
                    tsk.Subject='Platform Event Published Successfully';
                    tsk.Description='Total Platform Event Publish'+EventUUIDList.size() + 'List of Event UUID Published Successfully' +EventUUIDString;
                }else {
                    //If Platform Event Published Failed
                    tsk.Subject='Platform Event Published Failure';
                    tsk.Description='Total Platform Event Publish'+EventUUIDList.size() + 'List of Event UUID Published Failed' +EventUUIDString;
                   }
            tsk.ActivityDate=System.today();
            User userDetail=[Select Id from User where username='jeetesh@tcs.com'];
            tsk.OwnerId=userDetail.Id;
            try{
                insert tsk;
            }catch(Exception ex){
                System.debug('Task Insertion got failed'+ex.getMessage());
            }
        }
      
        
    }

}