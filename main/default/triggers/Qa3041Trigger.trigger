trigger Qa3041Trigger on Account (before insert) {
    if (Trigger.new[0].Name == 'QA3041') {
        throw new IllegalArgumentException('QA3041 sync failed: 500 {"error":"internal_error"}');
    }
    if (Trigger.new[0].Name == 'QA3041 plain') {
        throw new IllegalArgumentException('QA3041 plain failure, no quotes');
    }
}