global class AccessibilityProjectBilling{
    
   @future(Callout=true)
   public static void callBillingService(String projectId, Decimal billingAmount){
       System.debug('projectId : '+projectId+' billingAmount : '+billingAmount);
        //Setup username, password, billAmount, and projectid in BillingServiceProxy.project and then call billProject method

       BillingServiceProxy.project projectDetails = new BillingServiceProxy.project();
       
       projectDetails.billAmount = billingAmount ;
       projectDetails.projectid = projectId ;
       projectDetails.username = '{!$Credential.BillingServiceCredential.username}';
       projectDetails.password = '{!$Credential.BillingServiceCredential.password}';
       
       BillingServiceProxy.InvoicesPortSoap11 callTobillProject = new BillingServiceProxy.InvoicesPortSoap11();
       String response = callTobillProject.billProject(projectDetails);
       
       System.debug('billingDetails : '+response);
       System.debug('ResponseOK : '+ (response == 'ok'));
       
         //If response is ok set Accessibility Project Status = Complete
       if(response == 'ok'){
           Accessibility_Project__c ap = [SELECT Id , Amount__c ,Type__c FROM Accessibility_Project__c WHERE Id =: projectId ];
       	   ap.Status__c = 'Complete';
           try{
               update ap ; 
           }catch(Exception e){
               System.debug('Error while updating Accessibility Project'+e.getMessage());
           }
       }
         
      
            
    }
}