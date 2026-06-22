# Sharding Strategy Design

## 1. Overview

This system is designed to handle high-throughput financial workloads (12,000+ TPS) with strict consistency, low latency, and fault tolerance. Sharding is introduced to scale horizontally and avoid single-database bottlenecks.

Key goals:
- Linear scalability
- Even load distribution
- Low-latency transaction routing
- Strong consistency for financial operations
- High availability with fault tolerance

---

## 2. Shard Key Evaluation

### 2.1 user_id as shard key

Advantages:
- Simple user-based partitioning
- Good for user-specific queries

Limitations:
- Cross-user transactions become cross-shard
- Hot user imbalance risk
- Poor fit for ledger consistency

Conclusion: Not suitable as primary shard key

---

### 2.2 account_id as shard key (SELECTED)

Advantages:
- High cardinality ensures uniform distribution
- Matches transaction + ledger model
- Reduces hotspot risk
- Enables efficient routing for financial operations

Limitations:
- Requires mapping layer for user-level queries

Conclusion: BEST CHOICE for primary sharding

---

### 2.3 geographic sharding

Advantages:
- Low latency within region
- Regulatory compliance support

Limitations:
- Uneven load distribution
- Complex cross-region transfers
- Not suitable as primary strategy

Conclusion: Can be used as secondary routing layer only

---

## 3. Final Sharding Design

Primary shard key:
- account_id (hash-based consistent sharding)

Secondary dimension:
- region (future scalability)

Sharding method:
- Consistent Hashing

---

## 4. Shard Count Calculation

### Target capacity

- Expected load: 12,000 TPS
- Headroom factor: 1.5×
- Peak safety factor: 2×

Final required capacity:
- 12,000 × 1.5 × 2 = 36,000 TPS

---

### Per-shard capacity assumption

- 1 shard ≈ 1,000 TPS safe limit

---

### Total shards required

- 36,000 / 1,000 = 36 shards

Final decision:
- 40 shards (buffer for failures and rebalancing)

---

## 5. Shard Topology

- 40 primary shards
- Each shard has:
  - 1 primary node
  - 2 replica nodes

Shard grouping:

- Group A: Shards 1–10
- Group B: Shards 11–20
- Group C: Shards 21–30
- Group D: Shards 31–40

---

## 6. Data Distribution Strategy

Shard assignment logic:

- shard_id = hash(account_id) % 40

Expected distribution:

- Uniform spread across shards
- Variance: ±5–7%

Result:
- No hotspot formation
- Balanced load across cluster

---

## 7. Cross-Shard Transaction Protocol

A hybrid approach using 2-phase commit + saga fallback.

### Step 1: Prepare Phase
- Debit shard locks funds
- Validate balance
- Reserve amount

### Step 2: Commit Phase
- Credit shard applies transaction
- Both shards confirm success

### Failure Handling
- If any step fails:
  - rollback debit reservation
  - release locked funds

Consistency model:
- Strong consistency for financial correctness

---

## 8. Routing Layer Design

Component: Shard Router Service

Responsibilities:
- Map account_id → shard_id
- Maintain shard metadata registry
- Handle retries and failover routing

Flow:

Client → API Gateway → Shard Router → Target Shard

Caching:
- shard map cached in Redis
- refreshed periodically

---

## 9. Shard Rebalancing Strategy

Triggers:
- shard load > 75%
- storage imbalance > 30%
- TPS imbalance > 20%

Approach:
- Consistent Hash Ring expansion
- Virtual nodes for smooth migration

Steps:
1. Add new shard
2. Introduce virtual nodes
3. Gradual data migration
4. Dual write phase
5. Final cutover

---

## 10. Failure Handling

### Shard failure
- Redirect to replica
- Failover routing enabled

### Network partition
- Use quorum-based writes
- Reject stale transactions

### Replica lag
- Switch to read-only fallback mode

---

## 11. Data Locality Strategy

Rule:
- All account-related data stays in same shard

Includes:
- accounts
- transactions
- ledger_entries

Benefit:
- Avoid cross-shard joins
- Faster transaction validation
- Reduced network overhead

---

## 12. Architecture Summary

API Gateway → Shard Router → Sharded Databases

Each shard:
- Independent database cluster
- Primary + replicas
- Handles full financial lifecycle locally

---

## 13. Conclusion

This sharding design ensures:

- Horizontal scalability
- High availability
- Strong consistency for payments
- Efficient distributed transaction handling
- Future-ready expansion to multi-region systems
