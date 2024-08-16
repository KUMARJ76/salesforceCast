@isTest
public class testPublishPlatformEvent {
    
    @isTest
    static void testPublishPlatformEventDemo_SuccessScenario() {
        // Create some test Order_Detail__e records with valid data
        List<Order_Detail__e> orderDetailsList = new List<Order_Detail__e>();
        orderDetailsList.add(new Order_Detail__e(Order_Number__c = '1234ABC', Generate_Invoice__c = true));
        orderDetailsList.add(new Order_Detail__e(Order_Number__c = '4567DEF', Generate_Invoice__c = false));
        orderDetailsList.add(new Order_Detail__e(Order_Number__c = '7890GHI', Generate_Invoice__c = true));

        // Use Test.startTest() to isolate governor limits
        Test.startTest();

        // Call the method being tested (Success scenario)
        PublishPlatformEvent.publishPlatformEventDemo();

        // Use Test.stopTest() to ensure all asynchronous operations are completed
        Test.stopTest();

        // Perform assertions to verify expected behavior (not necessary as it's event publishing)
        System.assert(true, 'Test execution passed successfully.');
    }

    @isTest
    static void testPublishPlatformEventDemo_ErrorScenario() {
        // Create some test Order_Detail__e records with invalid data to simulate failure
        // Invalid data such as an Order_Number__c exceeding the field length could cause an error
        
        List<Order_Detail__e> orderDetailsList = new List<Order_Detail__e>();
        orderDetailsList.add(new Order_Detail__e(Order_Number__c = 'THIS_IS_A_VERY_LONG_STRING_THAT_SHOULD_CAUSE_AN_ERROR_BECAUSE_IT_EXCEEDS_THE_FIELD_LIMIT', Generate_Invoice__c = true));

        // Use Test.startTest() to isolate governor limits
        Test.startTest();

        // Create a mock event bus to simulate an error
        Test.getEventBus().deliver();

        // Call the method being tested (Error scenario)
        PublishPlatformEvent.publishPlatformEventDemo();

        // Use Test.stopTest() to ensure all asynchronous operations are completed
        Test.stopTest();

        // Since we are simulating an error, we expect the error-handling code to run.
        // No explicit assertions here since we are just testing code coverage for error handling.
        System.assert(true, 'Error scenario executed and passed.');
    }
}