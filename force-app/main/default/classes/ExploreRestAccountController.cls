@RestResource(urlmapping='/Account/contacts/*')
global class ExploreRestAccountController {

    @HttpGet
    global static Account doGet(){
        RestRequest req=RestContext.request;
        System.debug('😍'+req.params);
        System.debug('😍'+req.requestURI);
        System.debug('😍'+req.remoteAddress);
        System.debug('😍'+req.resourcePath);
        RestResponse res=RestContext.response;    
        String accountId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        return [SELECT Id,Name,Industry,Rating,(SELECT Id,Name,Phone from Contacts) from Account WHERE Id=: accountId];
    }



    global class RequestWrapper{
        private Account accountRecord;
        private Contact[] contactRecord;
    }
     
    
    @HttpPost
    global static void doPost(RequestWrapper requestPayload){
       RestResponse res= RestContext.response;
        Account a=requestPayload.accountRecord;
        insert a;
        Contact [] c=requestPayload.contactRecord;
        insert c;
        
        if(a!=null && c!=null){
            res.statusCode=200;
            res.responseBody=Blob.valueOf(JSON.serialize(a));
        }else{
            res.statusCode=500;
             res.responseBody=Blob.valueof(JSON.serialize('Something went wrong'));
        }  
            
        
      /* insert requestPayload.accountRecord;
       insert requestPayload.contactRecord;
       return requestPayload.accountRecord;
*/
       //RestRequest req= RestContext.request;
       // String s= req.requestBody.toString();
        //Account a=(Account)JSON.deserialize(s,Account.class);
        //insert a;
        //return a;
    }
    
    @HttpDelete
    global static void doDelete(){
       RestRequest req= RestContext.request;
        RestResponse res=RestContext.response;
        String AccountId=req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        // Delete Cases
        delete [SELECT Id from Case WHERE AccountId=:AccountId];
        // Delete Opportunity
        delete [SELECT Id from Opportunity WHERE Id=:AccountId];
        // Delete account
        delete [SELECT Id from Account WHERE Id=:AccountId];
         res.statusCode=200;
        res.responseBody=Blob.valueOf(AccountId +'Got Deleted');
    }
    
}