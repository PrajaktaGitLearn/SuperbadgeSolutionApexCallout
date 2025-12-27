public class AtivateDeactiveAccounts {

    
    public static void makeActivate(){
       List<Account> updatedAccount = new List<Account>();
       List<Account> acclist = [SELECT Id,Name ,Active__c FROM Account WHERE Active__c = 'No'];
        if(!acclist.isEmpty()){
            
            for(Account ac : acclist){
                ac.Active__c = 'Yes';
                updatedAccount.add(ac);
            }
        }
        
        if(!updatedAccount.isEmpty()){
            update updatedAccount;
        }
        
    }
    
    public static void checkAggregation(){

        //keySet() ==> All Keys present in your map ==> type : set
        //values() ==> All Values assosited in map  ==> type : List
	   Map<Id,Integer> contactCountMap = new Map<Id,Integer>();        
       List<AggregateResult> agglist = [SELECT Count(Id) contactCount , AccountId FROM Contact GROUP BY AccountId];
        
        if(!agglist.isEmpty()){
            for(AggregateResult ag : agglist){
                Integer noOfContacts = (Integer) ag.get('contactCount');
				Id accId = (Id) ag.get('AccountId');              
                
                //System.debug(noOfContacts + 'No Of contacts are Assosiated with '+ag.get('AccountId'));
                contactCountMap.put(accId,noOfContacts);
            }
            
        }
        
        List<Account> accountList = [SELECT Id,Name FROM Account WHERE Id IN:contactCountMap.keySet()];
        if(!accountList.isEmpty()){
            for(Account ac : accountList){
                
                System.debug('Account Name : '+ac.Name +' is Having '+contactCountMap.get(ac.Id)+' Contacts Assosiated with it');
            }
        }
        
        
        
        
    }
}