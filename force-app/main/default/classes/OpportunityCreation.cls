public class OpportunityCreation {

    public static void createTenOpportunities(){
        List<Opportunity> opplist = new List<Opportunity>();
        List<Opportunity> updateOpps = new List<Opportunity>();
        for(Integer i = 0 ; i < 170 ; i++){
            
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opp New'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today();
            
            opplist.add(opp);
            
            //insert opp ; // this is wrong
            
        } 
        
        if(!opplist.isEmpty()){
            insert opplist;
            
            for(Opportunity opp : opplist){
                opp.StageName = 'Closed Won';
                updateOpps.add(opp);
                
            }
        }
        
        if(!updateOpps.isEmpty()){
            //update updateOpps; // rollback entire transaction
            Database.SaveResult[] results = Database.update(updateOpps,false);
            
            for (Database.SaveResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted account with ID: ' + sr.getId());
            } else {
                for (Database.Error err : sr.getErrors()) {
                    System.debug('Error inserting account: ' + err.getMessage());
                }
            }
        }
        
       
        
        
        }
        
        
    }
}