public class Qa3042ErpSyncJob implements Queueable {
public void execute(QueueableContext context) {
throw new IllegalArgumentException('QA3042 ERP sync failed: 500 {"error":"internal_error"}');
}
}