@RestResource(urlMapping='/Account/*')
global class SalesforceAccessForIntegration {
    
    
    @HttpGet
    global static List<Account> getAccounts(){
        return [SELECT Id,Name,Rating,Phone FROM Account WHERE Rating='Warm'];
    }
    
    @HttpPost
    global static Account createAccount(String accountName){
        Account acc=new Account();
        acc.Name=accountName;
        insert acc;
        return acc;
    }

}