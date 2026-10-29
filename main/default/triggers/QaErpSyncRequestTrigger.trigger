trigger QaErpSyncRequestTrigger on QA_ERP_Sync_Request__c (after insert) {
System.enqueueJob(new Qa3042ErpSyncJob());
}