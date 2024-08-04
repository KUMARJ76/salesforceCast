public class UsernamePasswordController {
    public String body{set;get;}
    public void getAuthenticated(){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setBody('grant_type=password&username=jeeteshint@force.com&password=XXXXXXXXSECURITY_TOKEN'+
                    '&client_id=CLIENT_ID'
                    +'&client_secret=CLIENT_SECRET');
       HttpResponse res= http.send(req);
        body=res.getBody();
        
    }
}