public class PublishPlatformEvent {
    public static void publishPlatformEventDemo(){
     List<Order_Detail__e> orderDetailsList=new List<Order_Detail__e>();
         orderDetailsList.add(new Order_Detail__e(Order_Number__c='5678TFV',Generate_Invoice__c=True));
         orderDetailsList.add(new Order_Detail__e(Order_Number__c='9778TZX',Generate_Invoice__c=False));
         orderDetailsList.add(new Order_Detail__e(Order_Number__c='0676UBN',Generate_Invoice__c=True));
        
        PublishPlatformEventCallback callbackInstance=new PublishPlatformEventCallback();
    List<Database.SaveResult>srList= EventBus.publish(orderDetailsList,callbackInstance);
        
        for(Database.SaveResult srItem:srList){
            if(srItem.isSuccess()){
                System.debug('Platform Event Published Successfully');
            }else {
                List<Database.error>errList=srItem.getErrors();
                for(Database.error errorDetail:errList){
                    System.debug('Error Details:'+errorDetail.getMessage());
                }
            }
        }
        
        
    }
}