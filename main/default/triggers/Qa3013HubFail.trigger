trigger Qa3013HubFail on pharos__Log__c (before insert) {
    Boolean hit = false;
    for (pharos__Log__c l : Trigger.new) { if (l.pharos__Originated_From__c == 'Passthrough') hit = true; }
    if (hit) { for (Integer i = 0; i < 150; i++) { Integer c = [SELECT COUNT() FROM Organization]; } }
}