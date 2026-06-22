# ADR-004: Communication Pattern (Sync vs Async)

## Decision
We use a hybrid communication model:
- Synchronous communication for critical user-facing APIs
- Asynchronous communication for internal processing using Kafka

## Rationale
- Sync ensures immediate response for payment initiation
- Async improves scalability and system resilience

## Trade-offs
### Pros:
- High performance
- Loose coupling
- Better fault tolerance

### Cons:
- Increased system complexity
- Eventual consistency model

## Conclusion
Asynchronous event-driven architecture is preferred for backend workflows, while synchronous APIs are used only for user interaction layers.