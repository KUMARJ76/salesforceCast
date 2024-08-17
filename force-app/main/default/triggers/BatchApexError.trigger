trigger BatchApexError on BatchApexErrorEvent (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        HandleBatchApexErrorEvent.afterInsert(trigger.new);
    }
}