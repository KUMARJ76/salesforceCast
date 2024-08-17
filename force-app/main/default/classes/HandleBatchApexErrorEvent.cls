public class HandleBatchApexErrorEvent {
    public static void afterInsert(List<BatchApexErrorEvent> errorEventList){
        Set<Id>asyncApexJobIdSet=new Set<Id>();
        
        for(BatchApexErrorEvent batchApexError:errorEventList){
            asyncApexJobIdSet.add(batchApexError.AsyncApexJobId);
        }
        
        Map<Id,AsyncApexJob> jobs=new Map<Id,AsyncApexJob>([Select Id,ApexClass.Name from AsyncApexJob where Id IN:asyncApexJobIdSet]);
        List<Task>taskList=new List<Task>();
        for(BatchApexErrorEvent evt:errorEventList){
            
            AsyncApexJob jobDetails=jobs.get(evt.AsyncApexJobId);
            String apexClassName=jobDetails.ApexClass.Name;
            if(apexClassName=='BatchClassForDemo'){
                for(String item:evt.JobScope.split(',')){
                   Task tsk=new Task();
                    tsk.WhatId=(Id)item;
                    tsk.Subject=evt.ExceptionType;
                    tsk.Description='Error Logged by BatchClassForDemo';
                    taskList.add(tsk);
                      System.debug( taskList.add(tsk));
                    
                }                
            }
        }
        
        if(!taskList.isEmpty()){
            try{
              insert taskList;   
            }catch(Exception ex){
                System.debug('Task Insertion Failed'+ex.getMessage());
            }
           
        }
        
    }

}



// Ananymous Block
// Database.ExecuteBatch(new BatchClassForDemo());