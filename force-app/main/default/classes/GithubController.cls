public class GithubController {
    public String body{set;get;}
    public GithubController(){
         Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:user_all_repos'); // Named Credentials
        req.setMethod('GET');
        HttpResponse res=http.send(req);
         body=res.getBody();
        System.debug('😍😍😍😍'+body);
    }
    }