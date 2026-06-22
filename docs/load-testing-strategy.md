## Load Testing Strategy

We validate system performance under realistic and peak load conditions using k6/Locust.

---

## 1. Scenario: Normal Load
- TPS: 500
- Duration: 30 min
- Pass Criteria: p99 < 100ms
- Fail Criteria: error rate > 1%

---

## 2. Scenario: Peak Load
- TPS: 2000
- Duration: 20 min
- Pass: p99 < 120ms
- Fail: error rate > 2%

---

## 3. Scenario: Spike Load
- TPS: 500 → 3000 sudden spike
- Duration: 10 min
- Pass: system recovers within 30 sec

---

## 4. Scenario: Stress Test
- TPS: 5000+
- Duration: 15 min
- Fail if system crash occurs

---

## 5. Scenario: Endurance Test
- TPS: 800
- Duration: 6 hours
- Pass: no memory leak

---

## 6. Scenario: Transaction Heavy Load
- TPS: 1500 (only /transactions)
- Pass: p99 < 100ms

---

## 7. Scenario: Read Heavy Load
- TPS: 3000 (GET APIs)
- Pass: cache hit rate > 80%

---

## 8. Scenario: Failure Injection Load
- TPS: 1000
- Simulated DB failures
- Pass: circuit breaker activates

---

## k6/Locust Example Scenarios (Pseudocode)

### Scenario 1 (k6)
```javascript id="lt3"
import http from 'k6/http';

export default function () {
  http.post('https://api.test.com/transactions', JSON.stringify({
    from: "A",
    to: "B",
    amount: 100
  }));
}

