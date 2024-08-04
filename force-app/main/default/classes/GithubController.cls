public class GithubController {
    public String body{set;get;}
    public void getCommits(){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('callout:github_sfdc_job_commit'); // Named Credentials
        req.setMethod('GET');
        HttpResponse res=http.send(req);
         body=res.getBody();
        System.debug('😍😍😍😍'+body);
    }
}