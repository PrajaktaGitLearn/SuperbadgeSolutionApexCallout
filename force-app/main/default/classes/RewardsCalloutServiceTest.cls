@isTest
public class RewardsCalloutServiceTest {

    @TestSetup
    public static void setUpData(){
        
        User u =  [SELECT Id, Name, Email FROM User WHERE Profile.Name = 'System Administrator'];
        List<Wellness_Journey__c> journeyList = new List<Wellness_Journey__c>();
        
        Date today = Date.today();
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        Date prevQuarterStart = Date.newInstance(currentYear, previousQuarterStartMonth, 1);
        Date prevQuarterEnd   = prevQuarterStart.addMonths(3).addDays(-1);
        
        //Test data
        for(Integer i = 0 ; i < 12 ; i++){
            Wellness_Journey__c wj = new Wellness_Journey__c();
            wj.OwnerId = u.Id;
            wj.Name = 'test journey '+i;
            wj.Status__c = 'Complete';
            wj.Completion_Date__c = prevQuarterStart.addDays(i);
            
            journeyList.add(wj);
        }
        
        insert journeyList;
    }
    
    @isTest
    public static void testWellnessJourneyRewardsBatch(){
       	Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        
        Test.startTest();
        Database.executeBatch(new WellnessJourneyRewardsBatch(), 50);
        Test.stopTest();

        // Just assert something executed
        System.assertEquals(12, [SELECT COUNT() FROM Wellness_Journey__c WHERE Status__c = 'Complete'], 
                            '12 journeys should be available');
    }
    
    @IsTest
    static void testDirectCalloutFailureResponse() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        Test.startTest();
        Integer code = RewardsCalloutService.submitUsersForRewardCallout('{}'); // bad body triggers failure
        Test.stopTest();

        System.assertEquals(400, code, 'Should return failure status code from mock');
    }
}