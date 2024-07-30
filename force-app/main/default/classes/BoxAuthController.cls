public class BoxAuthController {
    public SuperItemList[] dataList{set;get;}
// Body
  public string body{set;get;}
  // Constants for client ID and redirect URI
  private static final String REDIRECT_URI = 'https://ddl000006bviduaq-dev-ed--c.develop.vf.force.com/apex/BoxAuthSuccess';
  private static final String CLIENT_ID = 'fn3zgcjv4g83asgf5522dqgke0v33hhf';
  
  // Method to redirect the user for Box authentication
  public PageReference redirectUser() {
      // URL-encode the redirect URI
      String encodedRedirectUri = EncodingUtil.urlEncode(REDIRECT_URI, 'UTF-8');
      
      // Construct the authorization URL
      String authUrl = 'https://account.box.com/api/oauth2/authorize?response_type=code' +
                       '&client_id=' + CLIENT_ID +
                       '&redirect_uri=' + encodedRedirectUri;
      
      // Return the PageReference for the authorization URL
      return new PageReference(authUrl);        
  }

  public void getAccessToken(){
       String authCode= ApexPages.currentPage().getParameters().get('code');
       System.debug('🎶🎶'+authCode);
       //~ Instantiate the HTTP class
       Http http=new Http();
       //~ Frame the HTTPRequest
       HttpRequest req=new HttpRequest();
       req.setEndpoint('https://api.box.com/oauth2/token/');
       req.setMethod('POST');
       req.setHeader('Accept', 'Application/json');
       req.setBody('grant_type=authorization_code&code='+authCode+'&client_id='+CLIENT_ID+'&client_secret=O1ZW4FGvJWEmQR3VR8aws0GZqFxI9mnc');
       HttpResponse response=http.send(req);
     
       //~ Recieve the Response
       fromJSON d=(fromJSON)JSON.deserialize(response.getBody(), fromJSON.class);

       body=getFolder(d.access_token);
      parseFolderContent pfc= (parseFolderContent)JSON.deserialize(body, parseFolderContent.class);
      dataList=new SuperItemList[]{};

      for(Integer i=0;i<pfc.entries.size();i++){
        dataList.add(new SuperItemList(pfc.entries[i].id,pfc.entries[i].type,pfc.entries[i].name));

      }
  }

  public string getFolder(String access_token){
    Http http=new Http();
    HttpRequest req=new HttpRequest();
    req.setEndpoint('https://api.box.com/2.0/folders/277297158856/items');
    req.setMethod('GET');
    req.setHeader('Accept', 'application/json');
    req.setHeader('Authorization', 'Bearer '+access_token);

    HttpResponse response=http.send(req);
    return response.getBody();
  }



      public class SuperItemList{
        public String id_x{set;get;}
        public String type_x{set;get;}
        public String name_x{set;get;}
        public SuperItemList(String id_x,String type_x,String name_x){
                 this.id_x=id_x;
                 this.type_x=type_x;
                 this.name_x=name_x;
        }
      }





       public class fromJSON{
        public String access_token;	//JyHUhgBEtcp9WqGRRVFYyzCKBs5nHHZ0
        public Integer expires_in;	//3942
       // public cls_restricted_to[] restricted_to;
        public String refresh_token;	//oCNXarexMhTRWyuzDRT8cS6LFkoZ9H1zKbX3r0q0Uk7K9XCjH4oelMnMXeILceVE
        public String token_type;	//bearer
        
     }

     
}