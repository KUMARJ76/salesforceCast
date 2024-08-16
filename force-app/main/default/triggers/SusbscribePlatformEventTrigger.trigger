trigger SusbscribePlatformEventTrigger on Order_Detail__e (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        SubscribePlatformEvent.afterInsert(trigger.new);
    }
}