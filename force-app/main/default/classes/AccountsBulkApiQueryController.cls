public class AccountsBulkApiQueryController {
    Public String[] accountLines = new String[]{};
	Public List<AccountWrapper> accountListWrapper{set;get;}
    String locator = '';
    public void fetchRecords(){

        
        
        String endPoint = getAccountCSVEndpoint(locator);
        String body = getAccountsCSV(endPoint);
        processAccountsCSV(body);
      
    }
    

    public String getAccountCSVEndpoint(String locator){
     String endPoint = URL.getOrgDomainUrl().toExternalForm();
        endPoint += '/services/data/v51.0/jobs/query/750dL000006Wqb8/results?maxRecords=5';
        
        if(locator != ''){
            endPoint += '&locator='+ locator;                
        }
        
        return endPoint;
    }
    
    public String getAccountsCSV(String endPoint){
        
        Http http = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer '+ UserInfo.getSessionId());
        req.setMethod('GET');
        req.setEndpoint(endPoint);
        
        HttpResponse res = http.send(req);
        System.debug(' 🚀 ' +res.getBody());
        
        locator = res.getHeader('Sforce-Locator');
        
        return res.getBody();
    }
    public void processAccountsCSV(String body){
        
        accountListWrapper = new List<AccountWrapper>();
        accountLines = body.split('\n');
        
        for(Integer i=1; i< accountLines.size(); i++){
            String[] csvAccountRecord = accountLines[i].split(',');
            accountListWrapper.add(new AccountWrapper(csvAccountRecord[0].replace('"', ''),csvAccountRecord[1].replace('"', ''), csvAccountRecord[2].replace('"', ''), csvAccountRecord[3].replace('"', '')));
        }
    }
    Public class AccountWrapper{
        public String Id{set;get;}
        public String Name{set;get;}
        public String Industry{set;get;}
        public String Rating{set;get;}
        
        
        public AccountWrapper(String cId, String cName, String cIndustry, String cRating){
            this.Id = cId;
            this.Name = cName;
            this.Industry = cIndustry;
            this.Rating = cRating;
        }
        
    }
}