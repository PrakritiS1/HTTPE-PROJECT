# ADR-005: Cache Invalidation Strategy

## Decision
We use write-through + event-based cache invalidation.

---

## Strategy
1. On write → update DB first
2. Publish event to Kafka
3. Cache service invalidates key

---

## Why this approach?
- Prevents stale data
- Maintains consistency
- Works well in distributed systems

---

## Trade-offs
### Pros:
- High performance reads
- Consistent cache updates

### Cons:
- Slight write latency
- Complex event handling

---

## Conclusion
Event-driven cache invalidation provides best balance between performance and consistency.