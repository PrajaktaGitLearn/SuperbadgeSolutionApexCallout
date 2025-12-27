@isTest
public class BillingCalloutServiceTest {
    
   	@isTest 
    public static void testSuccessfulSOAPCallout() {
        BillingCalloutServiceMock.simulateError = false;
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        // Insert a test workshop to trigger the callout
        Workshop__c testWorkshop = new Workshop__c(
            Name = 'Success Test',
            DHH_Accessible__c = true
        );

        Test.startTest();
        insert testWorkshop;
        Test.stopTest();

        // Assert Accessibility_Project__c was created as expected
        List<Accessibility_Project__c> projects = [
            SELECT Id, Status__c FROM Accessibility_Project__c
        ];
        System.assertEquals(1, projects.size());
        System.assertEquals('Complete', projects[0].Status__c);
    }
    
    @isTest 
    public static void testErrorSOAPCallout() {
        BillingCalloutServiceMock.simulateError = true;
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        Workshop__c testWorkshop = new Workshop__c(
            Name = 'Error Test',
            DHH_Accessible__c = true
        );

        Test.startTest();
        insert testWorkshop;
        Test.stopTest();

        // You can add assertions based on how your system handles the error
        // For example: check logs, custom fields, or exception handling logic
    }
 

}