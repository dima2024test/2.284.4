public class QaFileSeedBatch implements Database.Batchable<Integer> {
    private Integer chunks;
    private Integer perChunk;
    private Integer sizeBytes;
    private Id parentId;
    public QaFileSeedBatch(Integer chunks, Integer perChunk, Integer sizeBytes, Id parentId) {
        this.chunks = chunks;
        this.perChunk = perChunk;
        this.sizeBytes = sizeBytes;
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
        Blob b = Blob.valueOf('x'.repeat(sizeBytes));
        List<Attachment> rows = new List<Attachment>();
        for (Integer i = 0; i < perChunk; i++) {
            rows.add(new Attachment(ParentId = parentId, Name = 'qa-big-' + scope[0] + '-' + i + '.txt', Body = b));
        }
        insert rows;
    }
    public void finish(Database.BatchableContext context) {
    }
}