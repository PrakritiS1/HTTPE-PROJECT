## Kafka Topic Structure

### 1. transaction-events
- Partitions: 6
- Retention: 7 days
- Key: transaction_id
- Purpose: All transaction lifecycle events (INITIATED, SUCCESS, FAILED)

### 2. ledger-events
- Partitions: 4
- Retention: 7 days
- Key: account_id
- Purpose: Ledger entry updates

### 3. fraud-detection-events
- Partitions: 3
- Retention: 14 days
- Key: user_id
- Purpose: Fraud analysis events

### 4. notification-events
- Partitions: 3
- Retention: 3 days
- Key: user_id
- Purpose: Push/email/SMS notifications0



## Consumer Groups

### transaction-service-group
- Consumers: 6
- Partitions: 6
- Rate: 200 msgs/sec per consumer
- Total throughput: 1200 msgs/sec

### ledger-service-group
- Consumers: 4
- Partitions: 4
- Rate: 150 msgs/sec per consumer
- Total throughput: 600 msgs/sec

### notification-service-group
- Consumers: 3
- Partitions: 3
- Rate: 100 msgs/sec per consumer
- Total throughput: 300 msgs/sec


## Exactly-Once Delivery Strategy

We implement exactly-once semantics using the Outbox Pattern.

### Flow:
1. Transaction is written to DB
2. Outbox table stores event
3. Kafka publisher reads outbox
4. Event is published to Kafka
5. Mark event as sent

### Benefits:
- No duplicate events
- Strong consistency between DB and Kafka


## Retry and DLQ Strategy

### Retry Policy:
- Retry Count: 3
- Backoff: Exponential (1s, 5s, 10s)

### Dead Letter Queue:
- Failed messages moved to:
  - transaction-events-dlq
  - notification-events-dlq

### Purpose:
- Store failed messages for manual inspection
- Prevent blocking main pipeline


