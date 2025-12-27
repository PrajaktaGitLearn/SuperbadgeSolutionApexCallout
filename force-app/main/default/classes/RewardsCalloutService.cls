public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        //Set Endpoint from Named Credential
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setBody(jsonBody);
        request.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
        //Make HTTP Callout
        Http http = new Http();
        HttpResponse res = http.send(request);
        
        System.debug('Response Body : '+res.getBody());
        
        
        //Update to return response status code
        return res.getStatusCode();    
    }
}