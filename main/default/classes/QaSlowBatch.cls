public class QaSlowBatch implements Database.Batchable<Integer> {
    private Integer units;
    public QaSlowBatch(Integer units) {
        this.units = units;
    }
    public Iterable<Integer> start(Database.BatchableContext context) {
        List<Integer> items = new List<Integer>();
        for (Integer i = 0; i < units; i++) {
            items.add(i);
        }
        return items;
    }
    public void execute(Database.BatchableContext context, List<Integer> scope) {
        Long until = System.currentTimeMillis() + 5000;
        while (System.currentTimeMillis() < until) {
        }
    }
    public void finish(Database.BatchableContext context) {
    }
}