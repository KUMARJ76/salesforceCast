public class SalesforceIntegrationController {
    @future(Callout=true) 
    public static void getDetails(){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:sfNoob/services/apexrest/Account/');
        req.setHeader('content-type','application/json; charset=UTF-8');
        req.setHeader('Accept','application/json');
        
        req.setMethod('GET');
        
        HttpResponse res=http.send(req);
        
        System.debug('response Code:'+res.getStatusCode());
        System.debug('response Body:'+res.getBody());
    }
    
    @future(Callout=true)
    public static void createAccountInTargetOrg(){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:sfNoob/services/apexrest/Account/');
        req.setHeader('content-type','application/json; charset=UTF-8');
        req.setHeader('Accept','application/json');
        req.setBody('{"accountName":"SfNoob"}');
        
        req.setMethod('POST');
        
        HttpResponse res=http.send(req);               
        System.debug('response Code:'+res.getStatusCode());
        System.debug('response Body:'+res.getBody());
    }

}