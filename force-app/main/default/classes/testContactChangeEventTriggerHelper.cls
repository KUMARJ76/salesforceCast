@isTest
public class testContactChangeEventTriggerHelper {
    @isTest
    static void validateChangeEventNotification(){
        Test.enableChangeDataCapture();
        Contact con=new Contact(FirstName='Ankit',LastName='Jain',Email='ankit@gmail.com');
        insert con;
        Test.getEventBus().deliver();
        Task [] taskList=[Select Id from Task where Subject='New Contact is created -- Do the Action now'];
        System.assertEquals(1,taskList.size(),'During Insertion -Change event failed');
        
        Contact queriedCon=[Select Id,FirstName ,LastName ,Email From Contact where Id=:con.Id];
        queriedCon.Email='Test@gmail.com';
        update queriedCon;
        
        Test.getEventBus().deliver();
         Task [] tasksList=[Select Id from Task where Subject='Email address of contact changed -- Do the Action now'];
        System.assertEquals(1,tasksList.size(),'During Insertion -Change event failed');
    }

}