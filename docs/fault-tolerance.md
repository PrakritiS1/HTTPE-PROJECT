## Fault Tolerance Design

### 1. Circuit Breaker
Used to prevent cascading failures.

States:
- CLOSED: normal operation
- OPEN: block requests
- HALF_OPEN: test recovery

Threshold: 5 failures
Timeout: 10 seconds

Fallback: cached/default response

---

### 2. Bulkhead Isolation
System resources are isolated:

| Service | Threads | Queue Size |
|---------|--------|------------|
| Payments | 50 | 1000 |
| Notifications | 20 | 500 |
| Fraud | 30 | 700 |

Prevents full system collapse.

---

### 3. Retry Policy
- Max retries: 3
- Backoff: exponential (1s, 2s, 4s)
- Retry only for:
  - network failure
  - timeout

---

### 4. Idempotency
Each request has a unique request_id to prevent duplicate processing.

---

### 5. Chaos Engineering Experiments

1. Kill payment service randomly
2. Inject 500ms latency in DB
3. Kafka broker shutdown simulation
4. Memory pressure test
5. Network packet loss simulation

---

### Conclusion
System is resilient using circuit breaker, bulkheads, retries, and idempotency mechanisms.