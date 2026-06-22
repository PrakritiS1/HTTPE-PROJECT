## Performance Budget (p99 = 100ms)

We divide total latency across system components.

---

- API Gateway → 10ms  
- Application Layer → 25ms  
- Database → 40ms  
- Kafka/Event Processing → 15ms  
- Cache (Redis) → 5ms  
- Network → 5ms  

---

### Total = 100ms p99 target