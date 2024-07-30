public class YoutubeController {
    
     public string body {set;get;}
    public SuperItemList[] dataList{set;get;}
    public String searchQuery{set;get;}
    
    public  void search(){
        //business Logic
        dataList =new SuperItemList[]{};
        String sanitizedSearchQuery=searchQuery.replaceAll(' ','+');
        String api_key=API_TokenController.API_KEY;
        String endpoint='callout:Youtube?part=snippet&q='+sanitizedSearchQuery+'&key='+api_key;
        // Step-1 Instantiate the Http Class
        
        Http http=new Http();
        
        // Step-2 Instantiate the HttpRequest class and frame the request
        HttpRequest request=new HttpRequest();
        request.setHeader('Accept','application/json');
        request.setEndpoint(endpoint);
        request.setMethod('GET');
       
         try {
            // Step-3 Send the request and handle the response
            HttpResponse response = http.send(request);
            body = response.getBody();
            
            // Deserialize the response
            fromJSON result = (fromJSON) JSON.deserialize(body, fromJSON.class);
           System.debug(' 😍 ' +result.kind);
           System.debug(' 😍 ' +result.regionCode);
            System.debug(' 😍 ' +result.items[0].id.kind); 
            System.debug(' 😍 ' +result.items[0].id.channelId);
             
             for(Integer i=0;i<result.items.size();i++){
                 dataList.add(new SuperItemList(result.items[i].snippet.title,result.items[i]
                 .snippet.description,result.items[i].snippet.thumbnails.medium.url,
                                               result.items[i].snippet.publishTime));
                 
             }
             System.debug(' 😍 ' +datalist);
             
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
        
        
    }
    
    public class SuperItemList{
        public String title {set;get;}
        public String description {set;get;}
        public String url {set;get;}
        public String publishTime {set;get;}
        
        public SuperItemList (String titleLocal,String descriptionLocal,String urlLocal,String publishTimeLocal){
            title=titleLocal;
            description=descriptionLocal;
            url=urlLocal;
            publishTime=publishTimeLocal;
        }
    }
    
  public class fromJSON {
        public String kind;
        public String etag;
        public String nextPageToken;
        public String regionCode;
        public cls_pageInfo pageInfo;
        public cls_items[] items;
    }

    public class cls_pageInfo {
        public Integer totalResults;
        public Integer resultsPerPage;
    }

    public class cls_items {
        public String kind;
        public String etag;
        public cls_id id;
        public cls_snippet snippet;
    }

    public class cls_id {
        public String kind;
        public String channelId;
    }

    public class cls_snippet {
        public String publishedAt;
        public String channelId;
        public String title;
        public String description;
        public cls_thumbnails thumbnails;
        public String channelTitle;
        public String liveBroadcastContent;
        public String publishTime;
    }

    public class cls_thumbnails {
        public cls_default default_x;
        public cls_medium medium;
        public cls_high high;
    }

    public class cls_default {
        public String url;
    }

    public class cls_medium {
        public String url;
    }

    public class cls_high {
        public String url;
    }
}