# Data Flow Design Document

## 1. Overview
This document describes the system-level data flows for:
- P2P Payment Transactions
- Batch Merchant Settlement
- System Failover Mechanism

Each flow includes:
- Sequence of operations
- Sync vs Async communication points
- Failure handling strategies
- Retry mechanisms
- Compensation logic

---

# 2. P2P Payment Transaction Flow

## 2.1 Flow Description (Happy Path)
A user initiates a payment via mobile app. The request passes through authentication, balance validation, debit and credit operations, and finally notification delivery.

### Steps:
1. User initiates payment request
2. API validates authentication token (sync)
3. Wallet service checks balance (sync)
4. Ledger debits sender account (sync)
5. Ledger credits receiver account (sync)
6. Transaction event published to message queue (async)
7. Notification service sends alert to receiver (async)

---

## 2.2 Failure Scenarios

### A. Insufficient Balance
- Wallet service rejects request
- No ledger operation performed
- Transaction terminated early

### B. Authentication Failure
- API rejects request before processing
- No downstream calls executed

### C. Ledger Failure
- If debit succeeds but credit fails:
  - Compensation transaction triggered (rollback debit)
  - System ensures ACID-like consistency

### D. Timeout Scenario
- API retries ledger operations up to 3 times
- If still failing:
  - Transaction marked as PENDING
  - Background retry worker handles recovery

---

## 2.3 Sync vs Async Points

### Synchronous:
- Auth validation
- Balance check
- Debit/Credit operations

### Asynchronous:
- Notification dispatch
- Event publishing via message queue

---

# 3. Batch Merchant Settlement Flow

## 3.1 Flow Description
A scheduled job processes merchant settlements in bulk.

### Steps:
1. Scheduler triggers batch job (async trigger)
2. System fetches pending transactions
3. Transactions grouped by merchant
4. Bank API invoked for settlement (sync)
5. Results stored in database
6. Failure events sent to message queue (async)
7. Settlement report sent to merchants (async)

---

## 3.2 Failure Handling

### Bank API Failure:
- Retry with exponential backoff
- If still failing:
  - Event pushed to MQ
  - Manual reconciliation possible

### Partial Failures:
- Each merchant processed independently
- Failures do not block entire batch

---

## 3.3 Sync vs Async

### Synchronous:
- Bank transfer calls
- DB updates

### Asynchronous:
- Scheduler trigger
- Failure events
- Notifications

---

# 4. System Failover Flow

## 4.1 Flow Description
System ensures high availability using active-passive failover.

### Steps:
1. Load balancer routes traffic to primary API
2. Health monitor continuously checks service
3. On failure detection:
   - Traffic shifted to secondary API
4. Secondary syncs with database replica
5. Message queue resumes processing

---

## 4.2 Failure Handling

### Primary API Crash:
- Health check fails
- Automatic traffic switch

### Database Sync Lag:
- Secondary waits until replica consistency is confirmed

### MQ Recovery:
- Queue processing resumes after failover

---

## 4.3 Sync vs Async

### Synchronous:
- Health checks
- DB sync validation
- Traffic switching decision

### Asynchronous:
- Failover execution events
- Queue recovery processing

---

# 5. Compensation Logic Summary

| Scenario | Compensation Strategy |
|----------|----------------------|
| Debit success but credit failure | Reverse debit transaction |
| Bank API failure | Retry + manual reconciliation |
| Timeout in ledger | Retry + pending state |
| System crash mid-transaction | Event replay from MQ |

---

# 6. Key Design Principles
- Event-driven architecture for scalability
- Idempotent transaction design
- Retry with exponential backoff
- Strong consistency in ledger operations
- Async processing for notifications & reporting