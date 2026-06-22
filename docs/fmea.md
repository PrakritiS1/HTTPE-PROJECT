# FMEA Document & Chaos Engineering

We analyze potential system failures across application, infrastructure, data, and operational layers.

---

#  FMEA TABLE (20+ FAILURE MODES)

| ID | Failure Mode | Category | Severity (S) | Occurrence (O) | Detection (D) | RPN | Mitigation |
|----|-------------|----------|--------------|----------------|--------------|-----|------------|
| F1 | DB connection failure | Infra | 9 | 4 | 3 | 108 | Connection pooling + retry |
| F2 | API gateway overload | Infra | 10 | 5 | 4 | 200 | Auto-scaling |
| F3 | Kafka broker failure | Infra | 9 | 3 | 3 | 81 | Multi-broker setup |
| F4 | Data inconsistency | Data | 10 | 4 | 5 | 200 | Saga pattern |
| F5 | Payment double spend | Data | 10 | 3 | 6 | 180 | OCC locking |
| F6 | Memory leak in service | App | 8 | 4 | 4 | 128 | Monitoring + restart |
| F7 | High latency DB query | App | 7 | 6 | 5 | 210 | Index optimization |
| F8 | Cache failure | Infra | 6 | 5 | 4 | 120 | Redis cluster |
| F9 | Message loss in Kafka | Data | 9 | 3 | 4 | 108 | Ack + retries |
| F10 | Service crash | App | 10 | 3 | 3 | 90 | Circuit breaker |
| F11 | Network partition | Infra | 9 | 2 | 5 | 90 | Retry + fallback |
| F12 | Unauthorized access | Security | 10 | 2 | 6 | 120 | JWT + RBAC |
| F13 | Rate limit bypass | Security | 8 | 3 | 5 | 120 | API gateway rules |
| F14 | Disk full | Infra | 7 | 4 | 4 | 112 | Auto scaling storage |
| F15 | Wrong ledger entry | Data | 10 | 3 | 4 | 120 | Validation rules |
| F16 | Notification failure | App | 5 | 5 | 3 | 75 | Retry queue |
| F17 | Redis crash | Infra | 8 | 3 | 4 | 96 | Cluster mode |
| F18 | API timeout | App | 7 | 6 | 5 | 210 | Timeout + retry |
| F19 | Data race condition | Data | 10 | 3 | 5 | 150 | Locking + OCC |
| F20 | Logging failure | Ops | 5 | 4 | 4 | 80 | Backup logging system |

---

# HIGH RPN FAILURES (RPN > 200)

## 1. API Gateway Overload (RPN = 200)
## 2. High Latency DB Query (RPN = 210)
## 3. API Timeout (RPN = 210)

---

## 🔧 Mitigation Strategies

- Auto-scaling enabled for API gateway
- Query optimization + indexing for DB
- Circuit breaker + timeout handling
- Load balancing across services

---

#  CHAOS ENGINEERING EXPERIMENTS

## Experiment 1: API Gateway Failure

- Hypothesis: System should auto-scale
- Blast Radius: 30% traffic
- Success Criteria: No downtime
- Rollback: Disable chaos injector

---

## Experiment 2: Database Latency Injection

- Hypothesis: System handles slow DB gracefully
- Blast Radius: transactions service
- Success Criteria: fallback response within 2 sec
- Rollback: restore DB latency

---

## Experiment 3: Kafka Broker Shutdown

- Hypothesis: Messages should not be lost
- Blast Radius: event pipeline
- Success Criteria: retry mechanism works
- Rollback: restart broker

---

## Experiment 4: Cache Failure Simulation

- Hypothesis: DB handles fallback load
- Blast Radius: read APIs
- Success Criteria: system still responds
- Rollback: restore Redis

---

## Experiment 5: Service Crash Simulation

- Hypothesis: Circuit breaker activates
- Blast Radius: payment service
- Success Criteria: fallback response returned
- Rollback: restart service