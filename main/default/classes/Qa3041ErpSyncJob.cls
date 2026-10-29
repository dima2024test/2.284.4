public class Qa3041ErpSyncJob implements Queueable {
    public void execute(QueueableContext context) {
        throw new IllegalArgumentException('QA3041 ERP sync failed: 500 {"error":"internal_error"}');
    }
}