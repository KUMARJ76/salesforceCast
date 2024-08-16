@isTest
public class testPublishPlatformEventCallback {
    @isTest
    static void testFailedEvents(){
        Order_Detail__e orderDetail=new Order_Detail__e(Order_Number__c='5678TFV',Generate_Invoice__c=True);
        PublishPlatformEventCallback callbackInstance =new PublishPlatformEventCallback();
        EventBus.publish(orderDetail,callbackInstance);
        Test.getEventBus().fail();
        List<Task>tskList=[Select Id,Subject,Description from Task where Subject='Platform Event Published Failure'];
        System.assertEquals(1,tskList.size(),'Task Creation Failed');
        
    }
    
     @isTest
    static void testSuccessEvents(){
        Order_Detail__e orderDetail=new Order_Detail__e(Order_Number__c='5678TFV',Generate_Invoice__c=True);
        PublishPlatformEventCallback callbackInstance =new PublishPlatformEventCallback();
        
        Test.StartTest();
        EventBus.publish(orderDetail,callbackInstance);
        Test.StopTest();
            
        List<Task>tskList=[Select Id,Subject,Description from Task where Subject='Platform Event Published Successfully'];
        System.assertEquals(1,tskList.size(),'Task Creation Passed');
        
    }

}