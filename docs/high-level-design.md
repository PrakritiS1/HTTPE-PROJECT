# Introduction

PayScale Financial Technologies currently supports approximately 1,200 TPS. Due to the upcoming Diwali campaign, the platform is expected to handle up to 12,000 TPS. The proposed architecture is designed to provide scalability, fault tolerance, low latency, and high availability.

---

# 1. API Gateway

## Responsibility

Acts as the entry point for all client requests.

## Interfaces

Receives requests from users and forwards them to backend services.

## Technology Choice

API Gateway

## Scaling Strategy

Multiple instances behind a load balancer.

## Failure Handling

Traffic is redirected to healthy instances.

---

# 2. Load Balancer

## Responsibility

Distributes traffic among available services.

## Interfaces

Receives requests from API Gateway and routes them to application services.

## Technology Choice

AWS ELB

## Scaling Strategy

Horizontal scaling.

## Failure Handling

Health checks and automatic rerouting.

---

# 3. Authentication Service

## Responsibility

Authenticates users and validates access tokens.

## Interfaces

Communicates with API Gateway and Payment Service.

## Technology Choice

JWT Authentication

## Scaling Strategy

Stateless service with multiple instances.

## Failure Handling

Token validation retries and fallback mechanisms.

---

# 4. Payment Service

## Responsibility

Processes payment requests.

## Interfaces

Communicates with Authentication Service and Transaction Orchestrator.

## Technology Choice

Microservice Architecture

## Scaling Strategy

Multiple instances.

## Failure Handling

Retry mechanism and transaction rollback.

---

# 5. Transaction Orchestrator

## Responsibility

Coordinates the complete payment workflow.

## Interfaces

Communicates with Account Service, Fraud Service, Notification Service, Kafka, and Database.

## Technology Choice

Saga Pattern

## Scaling Strategy

Distributed processing.

## Failure Handling

Compensation transactions.

---

# 6. Account Service

## Responsibility

Maintains account balances and transaction records.

## Interfaces

Connected with Transaction Orchestrator and Database.

## Technology Choice

Microservice

## Scaling Strategy

Horizontal scaling.

## Failure Handling

Database transaction recovery.

---

# 7. Fraud Detection Service

## Responsibility

Detects suspicious transactions.

## Interfaces

Connected with Transaction Orchestrator and Database.

## Technology Choice

Rule-Based Engine

## Scaling Strategy

Independent scaling.

## Failure Handling

Fallback validation rules.

---

# 8. Notification Service

## Responsibility

Sends SMS, Email, and Push Notifications.

## Interfaces

Consumes events from Kafka.

## Technology Choice

Event-Driven Service

## Scaling Strategy

Queue-based processing.

## Failure Handling

Message retries.

---

# 9. Kafka Cluster

## Responsibility

Handles asynchronous communication.

## Interfaces

Connected with all business services.

## Technology Choice

Apache Kafka

## Scaling Strategy

Multiple brokers and partitions.

## Failure Handling

Replication and leader election.

---

# 10. Redis Cluster

## Responsibility

Provides caching for frequently accessed data.

## Interfaces

Connected with Payment Service and Account Service.

## Technology Choice

Redis Cluster

## Scaling Strategy

Cluster mode.

## Failure Handling

Replica failover.

---

# 11. PostgreSQL + Citus

## Responsibility

Stores transactional and account data.

## Interfaces

Connected with application services.

## Technology Choice

PostgreSQL + Citus

## Scaling Strategy

Database sharding.

## Failure Handling

Replication and backups.

---

# 12. Monitoring Service

## Responsibility

Tracks application health and performance metrics.

## Interfaces

Collects metrics from all services.

## Technology Choice

Prometheus + Grafana

## Scaling Strategy

Distributed monitoring.

## Failure Handling

Alert generation.

---

# 13. Logging Service

## Responsibility

Stores and analyzes logs.

## Interfaces

Receives logs from all services.

## Technology Choice

ELK Stack

## Scaling Strategy

Distributed log storage.

## Failure Handling

Log replication.