trigger CreateContactTrigger on Account (after insert, after update) {
    if(trigger.isAfter && trigger.isInsert ){
        system.debug('CreateContactTrigger');
                CreateContactHandler.CreateContact(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate) {
        system.debug('after update');
        CreateContactHandler.CreateContactonUpdate(trigger.new, trigger.oldMap);
    }
}