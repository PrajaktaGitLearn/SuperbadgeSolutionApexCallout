public class RewardsCalloutServiceMock implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        //res.setHeader('Content-Type', 'application/json; charset=UTF-8');
        //res.setBody('{"message": "Success"}');
        //res.setStatusCode(200);
        //
        
        if(req.getBody().contains('userId')){
            
            res.setHeader('Content-Type', 'application/json; charset=UTF-8');
            res.setBody('{"message": "Success"}');
            res.setStatusCode(200);
        } 
        // Simulate an API failure
        else {
            
            res.setHeader('Content-Type', 'application/json; charset=UTF-8');
            res.setBody('{"message": "Bad request"}');
            res.setStatusCode(400);
        }
        
        return res;
    }

}