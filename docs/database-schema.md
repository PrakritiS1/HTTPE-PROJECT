# Overview

This schema implements a scalable financial transaction system using a hybrid OLTP + event-driven architecture.

# Key Design Decisions

## 1. Double-entry ledger

Every transaction produces:

- Debit entry  
- Credit entry  

Ensures financial correctness.

## 2. Event sourcing layer

`transaction_events` table allows:

- debugging  
- fraud tracking  
- replay capability  

## 3. Partitioning

Transactions and `ledger_entries` are partitioned monthly for:

- performance  
- scalability  
- archival efficiency  

## 4. Fraud system

`fraud_rules` enables:

- dynamic rule updates  
- no code deployment required  

## 5. Notification audit

`notification_log` ensures:

- delivery tracking  
- retry logic support  

##  6. Time-Based Partitioning Strategy

We divide large tables like transactions and ledger_entries into smaller partitions based on the created_at column.

Example:
- transactions_2026_01 (January data)
- transactions_2026_02 (February data)

This helps improve performance and scalability by reducing data scanning during queries.

# Performance Considerations

- Heavy indexing on account + transaction access paths  
- Avoid over-indexing write-heavy tables  
- Partition pruning reduces query cost  

# Scalability Path

- Move transactions → distributed DB (CockroachDB / YugabyteDB)  
- Ledger → append-only event store  
- Events → Kafka streaming pipeline  