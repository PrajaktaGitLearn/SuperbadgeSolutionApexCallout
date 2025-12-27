@isTest
global class BillingCalloutServiceMock implements WebServiceMock {
    
    // Static flag to control mock behavior
    public static Boolean simulateError = false;

    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseName,
        String responseNamespace,
        String client
    ) {
        // Create a mock SOAP response
        BillingServiceProxy.billProjectResponse_element mockResponse = 
            new BillingServiceProxy.billProjectResponse_element();

        // Return 'Error' or 'Success' based on the flag
        if (simulateError) {
            mockResponse.status = 'Error';
        } else {
            mockResponse.status = 'ok';
        }

        response.put('response_x', mockResponse);
    }
}