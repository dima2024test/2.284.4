public class QaSeedBatch implements Database.Batchable<Integer> {
    private String kind;
    private Integer chunks;
    private Integer perChunk;
    private Id parentId;
    public QaSeedBatch(String kind, Integer chunks, Integer perChunk, Id parentId) {
        this.kind = kind;
        this.chunks = chunks;
        this.perChunk = perChunk;
        this.parentId = parentId;
    }
    public Iterable<Integer> start(Database.BatchableContext context) {
        List<Integer> items = new List<Integer>();
        for (Integer i = 0; i < chunks; i++) {
            items.add(i);
        }
        return items;
    }
    public void execute(Database.BatchableContext context, List<Integer> scope) {
        seed(kind, scope[0], perChunk, parentId);
    }
    public static void seed(String kind, Integer chunk, Integer perChunk, Id parentId) {
        String p = 'QA seed ' + chunk + '-';
        if (kind == 'FEED') {
            List<FeedItem> rows = new List<FeedItem>();
            for (Integer i = 0; i < perChunk; i++) rows.add(new FeedItem(ParentId = parentId, Body = p + i, Type = 'TextPost'));
            insert rows;
        } else if (kind == 'TASK') {
            List<Task> rows = new List<Task>();
            for (Integer i = 0; i < perChunk; i++) rows.add(new Task(Subject = p + i, Status = 'Completed', Priority = 'Normal'));
            insert rows;
        } else if (kind == 'CSC') {
            List<Case_Status_Change__c> rows = new List<Case_Status_Change__c>();
            for (Integer i = 0; i < perChunk; i++) rows.add(new Case_Status_Change__c(Name = p + i));
            insert rows;
        } else if (kind == 'INV') {
            List<QA_Invoice_Line__c> rows = new List<QA_Invoice_Line__c>();
            for (Integer i = 0; i < perChunk; i++) rows.add(new QA_Invoice_Line__c(Name = p + i));
            insert rows;
        } else if (kind == 'ATT') {
            Blob b = Blob.valueOf('x');
            List<Attachment> rows = new List<Attachment>();
            for (Integer i = 0; i < perChunk; i++) rows.add(new Attachment(ParentId = parentId, Name = 'qa' + i + '.txt', Body = b));
            insert rows;
        } else if (kind == 'EMAIL') {
            Integer emails = (perChunk * 23) / 100;
            List<EmailMessage> msgs = new List<EmailMessage>();
            for (Integer i = 0; i < emails; i++) msgs.add(new EmailMessage(Subject = p + i, Status = '3', TextBody = 'x'));
            insert msgs;
            List<EmailMessageRelation> rels = new List<EmailMessageRelation>();
            Integer relCount = perChunk - emails;
            for (Integer i = 0; i < relCount; i++) {
                rels.add(new EmailMessageRelation(EmailMessageId = msgs[Math.mod(i, emails)].Id, RelationAddress = 'qa' + i + '@example.com', RelationType = 'ToAddress'));
            }
            insert rels;
        }
    }
    public void finish(Database.BatchableContext context) {
    }
}