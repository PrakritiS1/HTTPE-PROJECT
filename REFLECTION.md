# Reflection on System Design Project

This project provided deep insights into building a large-scale distributed financial transaction system.

One of the key learnings was the importance of consistency models in distributed systems. Implementing OCC and Saga patterns helped in understanding how modern systems balance performance with correctness.

Another major learning was the role of event-driven architecture using Kafka. It significantly improves scalability but introduces complexity in debugging and tracing.

Designing load testing scenarios and performance budgets highlighted how real-world systems must be carefully tuned to meet strict latency requirements such as p99 under 100ms.

Fault tolerance mechanisms like circuit breakers, retries, and bulkheads showed how systems can gracefully handle partial failures without complete breakdown.

Capacity planning exercises demonstrated how infrastructure costs scale non-linearly with traffic and how optimization techniques like caching and reserved instances are crucial for cost efficiency.

Overall, this project emphasized trade-offs between scalability, consistency, and cost. A perfect system does not exist; instead, the goal is to find the right balance based on requirements.

The biggest takeaway is that distributed systems are not just about code, but about coordination, failure handling, and intelligent design decisions.