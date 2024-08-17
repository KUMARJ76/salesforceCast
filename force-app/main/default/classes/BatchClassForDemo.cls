public class BatchClassForDemo implements Database.Batchable<sObject>, Database.RaisesPlatformEvents {
    // Start
    public Database.queryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id,Name from Account where Industry=\'Energy\'');
    }
     public void execute(Database.BatchableContext bc, List<Account>accList){
         for(Account acc:accList){
             acc.Name=null;  // Exception will occur
         }
         update accList;
    }
     public void finish(Database.BatchableContext bc){
        System.debug('Batch Class Completed');
    }

}