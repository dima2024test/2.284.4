public class Qa3035ErpSyncJob implements Queueable {
    public void execute(QueueableContext context) {
        throw new IllegalArgumentException('ERP sync failed: 500 {"error":"internal_error","message":"down"}');
    }
}