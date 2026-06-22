# ADR-003: Sharding Strategy for High-Throughput Financial System

## Status
Accepted

---

## 1. Context

The system is designed to handle:

- 12,000+ TPS sustained load
- Peak spikes up to 2×–3× normal traffic
- Financial-grade consistency (payments + ledger correctness)
- Low latency transaction routing
- High availability and fault tolerance

A single database cannot scale to this level without performance degradation, so horizontal scaling via sharding is required.

---

## 2. Problem Statement

We need to decide:

- Best shard key
- Number of shards
- Data distribution strategy
- Cross-shard transaction handling
- Failure recovery model
- Routing mechanism

The solution must ensure:
- No data hotspots
- Minimal cross-shard operations
- Strong consistency for financial transactions
- Easy scalability in future

---

## 3. Options Considered

### Option 1: user_id as shard key

Pros:
- Simple user-based partitioning
- Easy to implement

Cons:
- Cross-user transactions become cross-shard
- Hot user problem (uneven load)
- Poor ledger locality

Verdict: ❌ Rejected

---

### Option 2: account_id as shard key (SELECTED)

Pros:
- High cardinality → uniform distribution
- Naturally aligns with transactions + ledger design
- Reduces hotspot risk
- Supports fine-grained routing

Cons:
- Requires mapping layer for user-level queries

Verdict: ✅ Selected

---

### Option 3: geographic sharding

Pros:
- Low latency in regional access
- Regulatory benefits

Cons:
- Uneven load distribution
- Complex cross-region transfers
- Not suitable for core financial consistency

Verdict: ❌ Rejected (primary), ⚠️ secondary only

---

## 4. Decision

We adopt:

### Primary shard key:
- account_id (consistent hashing)

### Sharding model:
- Hash-based partitioning

### Total shards:
- 40 shards

### Replication:
- 1 primary + 2 replicas per shard

---

## 5. Shard Count Justification

### Load assumptions:
- 12,000 TPS baseline
- 1.5× headroom → 18,000 TPS
- 2× peak safety buffer → 36,000 TPS capacity target

### Per shard capacity:
- ~1,000 TPS per shard

### Calculation:
- 36,000 / 1,000 = 36 shards

### Final decision:
- 40 shards (buffer for:
  - failures
  - rebalancing
  - future scaling)

---

## 6. Cross-Shard Transaction Strategy

We use a **Hybrid 2-Phase Commit + Saga Model**

### Flow:

1. Prepare phase:
   - debit shard locks funds
   - validate balance

2. Commit phase:
   - credit shard applies transaction
   - both confirm success

### Failure handling:
- rollback debit reservation
- release locks
- ensure no partial state remains

### Consistency:
- Strong consistency for financial correctness

---

## 7. Routing Strategy

A dedicated Shard Router Service:

Responsibilities:
- Map account_id → shard_id
- Maintain shard metadata registry
- Handle retries and failover routing

Flow:

Client → API Gateway → Shard Router → Target Shard

Caching:
- shard map stored in Redis
- periodic refresh

---

## 8. Rebalancing Strategy

Trigger conditions:
- shard load > 75%
- storage imbalance > 30%
- TPS imbalance > 20%

Method:
- consistent hashing ring
- virtual nodes for smooth distribution

Steps:
1. Add new shard
2. Introduce virtual nodes
3. Gradual data migration
4. Dual-write phase
5. Cutover

---

## 9. Failure Handling

### Shard failure:
- redirect to replica
- automatic failover

### Network partition:
- quorum-based writes
- reject stale writes

### Replica lag:
- read fallback to primary only

---

## 10. Data Locality Rule

All related financial data stays in same shard:

- accounts
- transactions
- ledger_entries

Benefits:
- avoids cross-shard joins
- faster transaction validation
- improved performance

---

## 11. Consequences

### Positive:
- High scalability
- Predictable performance
- Fault isolation
- Efficient transaction processing

### Negative:
- Cross-shard transactions are complex
- Requires routing layer
- Additional infrastructure overhead

---

## 12. Final Decision

We accept **account_id-based consistent hashing with 40 shards and hybrid transaction protocol** as the final sharding architecture.

---

## 13. Future Enhancements

- Dynamic shard splitting
- Adaptive rebalancing
- Migration to distributed SQL (CockroachDB / YugabyteDB)
- Multi-region active-active setup