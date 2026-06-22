## Concurrency Control Strategy

### 1. OCC (Optimistic Concurrency Control)
Used for balance updates using version numbers.

Prevents:
- Double spend
- Lost update problem

---

### 2. Distributed Locking

We use Redis-based locking with fencing tokens.

- Each lock has unique incrementing token
- Prevents stale node updates

---

### 3. Isolation Levels

- Account balance updates → SERIALIZABLE
- Read-heavy queries → READ COMMITTED
- Analytics queries → READ ONLY SNAPSHOT

---

### 4. Saga Pattern

Used for distributed transactions.

- Step-by-step execution
- Compensation on failure
- Ensures eventual consistency

---

### Conclusion
System ensures consistency using OCC + distributed locking + saga orchestration.