# Scenario Analysis

## 1.   INTRODUCTION

PayScale is a digital payment platform that currently faces scalability and performance challenges. As the user base grows, the existing architecture struggles to handle increasing transaction volumes. The organization wants to redesign the platform to support 12,000 transactions per second (TPS) while maintaining reliability, security, and low latency.
 It is a production-ready system architecture along with a gamified simulation
that tests scalability, failure handling, and real-world decision-making skills.

## 2.  Current System Challenges


#### Existing Infrastructure Limitations Transaction Throughput

The current architecture supports only 1,200 TPS, which is insufficient for projected festive-season demand. At peak load, the system is expected to experience request queuing, increased latency, and service degradation.

#### Latency Constraints

Current p50 latency is approximately 85ms and p99 latency reaches 450ms. The target architecture must reduce p50 latency below 50ms and maintain p99 latency below 100ms to ensure a consistent customer experience.

#### Database Bottleneck

The platform currently relies on a single-primary PostgreSQL 15 deployment. This creates a vertical scaling limitation and a single point of failure. A distributed database architecture with sharding and replication is required.

#### Messaging Infrastructure

RabbitMQ is currently deployed as a single-node message broker. This architecture cannot reliably support large-scale event processing. Apache Kafka will be adopted to provide horizontal scalability, partitioned processing, and fault tolerance.

#### Application Layer Scalability

The existing deployment consists of eight EC2 application servers. To handle traffic spikes and burst loads, an auto-scaling architecture capable of dynamically expanding from 8 to 64 instances is required.

#### Database Connection Limits

The current database configuration supports only 200 concurrent connections. Under projected load, connection exhaustion will occur. PgBouncer-based connection pooling will be introduced to support more than 2,000 effective database connections.

#### Cache Infrastructure

The current Redis deployment uses a single 16GB node, creating a single point of failure and memory limitation. A six-node Redis Cluster with approximately 96GB total memory will be deployed.

 #### User and Transaction Growth

Monthly active users are projected to increase from 12 million to 35 million. Daily transaction volume is expected to grow from 28 million to 85 million transactions per day. The architecture must therefore support both throughput growth and data growth.

#### Availability Requirements

Current SLA is 99.9% availability, allowing approximately 8.76 hours of downtime annually. The target SLA is 99.99%, reducing annual downtime to approximately 52.6 minutes. This requires multi-AZ deployment, database replication, automated failover, and fault isolation mechanisms.

####  Budget Constraints

Current infrastructure costs are approximately $12,000 per month. The redesigned architecture must remain below the approved budget ceiling of $45,000 per month while supporting 12,000+ TPS and maintaining SLA commitments.

## 3. Architectural Goals

Scale from 1,200 TPS to 12,000+ TPS.
Reduce p99 latency from 450ms to under 100ms.
Achieve 99.99% availability.
Support 35 million monthly active users.
Process 85 million daily transactions.
Remain within the $45,000/month infrastructure budget.
Enable horizontal scaling through Kafka, Redis Cluster, and database sharding.

## 4. Achitectural Components

● API Gateway Layer
● Load Balancer
● Transaction Orchestrator
● Payment Processing Service
● Account Service
● Notification Service
● Fraud Detection Service

463549A_Software_Engineer_HTTPE.pdf
PDF
what is this can youhelpp  to make this project 
 what is this whta is this

Haan, copy (notebook) mein notes banana hai. Ye submission nahi hai, ye tumhari understanding ke liye hai.

Jab PDF padhogi to har page yaad nahi rahega. Isliye ek rough notebook mein likho:

Project Name: HTTPE

Goal:
- 12,000 TPS system design karna

Main Technologies:
- Kafka
- Redis
- PostgreSQL

Deliverables:
- Scenario Analysis
- HLD
- ADRs
- Database Schema

Important Terms:
- Sharding
- OCC
- Saga Pattern
Iska kaam kya hai?

Jab tum 01-scenario-analysis.md likhogi ya HLD document banaogi, tab PDF dobara poora nahi padhna padega.

Tumhari notebook ek quick reference ban jayegi.

Abhi Day 1 mein kya karo?
Copy mein notes banao (rough points)
GitHub Repo banao
Folder Structure banao
README.md likho
docs/01-scenario-analysis.md file create karo

Important: Notes copy mein hi rakho. GitHub par upload karne ki zaroorat nahi hai.

Ab mujhe batao:

GitHub repo ban gaya?
Folder structure ban gaya?

Phir main tumhe 01-scenario-analysis.md ka exact format dunga.

scenerio analysis main kya kya likhun

Day 1 mein Scenario Analysis ka matlab hai:

"PayScale ko abhi kya problems face ho rahi hain, aur 12,000 TPS system banane ke liye kya challenges solve karne honge?"

Tumhari file: docs/01-scenario-analysis.md

Structure
# Scenario Analysis

## 1. Introduction

PayScale is a digital payment platform that currently faces scalability and performance challenges. As the user base grows, the existing architecture struggles to handle increasing transaction volumes. The organization wants to redesign the platform to support 12,000 transactions per second (TPS) while maintaining reliability, security, and low latency.

## 2. Current Challenges

### Challenge 1: Database Bottleneck
The database becomes overloaded during peak traffic periods, causing slow transaction processing.

### Challenge 2: High Transaction Latency
Users experience delays in payment confirmation due to synchronous processing.

### Challenge 3: Single Point of Failure
Critical services may become unavailable if a server fails.

### Challenge 4: Scalability Issues
The current architecture cannot easily scale to support rapid growth.

### Challenge 5: Fraud Detection Complexity
Increasing transaction volume makes fraud detection more difficult.

## 3. Top Bottlenecks and Preliminary Solutions

| Bottleneck | Proposed Solution |
|------------|------------------|
| Database overload | Database sharding |
| Slow read operations | Redis caching |
| High latency | Asynchronous processing with Kafka |
| Service failures | Redundancy and failover mechanisms |
| Traffic spikes | Load balancing and horizontal scaling |

## 4. Impact on Business

These challenges can lead to transaction failures, customer dissatisfaction, revenue loss, and reduced trust in the platform.

## 5. top 5 Bottlenecks 

| Bottleneck                  | Why It Is a Problem                                 | Solution                              |
| --------------------------- | --------------------------------------------------- | ------------------------------------- |
| Database Bottleneck         | Current database may not handle 12,000 TPS          | Database sharding and read replicas   |
| High Transaction Latency    | More users increase response time                   | Redis caching and optimized queries   |
| Message Processing Overload | Synchronous processing can create delays            | Kafka-based asynchronous messaging    |
| Single Point of Failure     | Failure of one service can impact the entire system | Redundancy, failover, and replication |
| Traffic Surge During Diwali | 10x user growth can overload servers                | Load balancing and horizontal scaling |

## 6. Conclusion

To support future growth and maintain system reliability, PayScale requires a modern distributed architecture capable of handling high transaction throughput while ensuring consistency, availability, and fault tolerance.
