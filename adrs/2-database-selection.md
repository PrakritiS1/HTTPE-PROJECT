# adrs/002-database-selection.md


## Decison:

Selected PostgreSQL + Citus.

Reason:
- Mature ecosystem
- Strong ACID guarantees
- Horizontal scaling through Citus
- Large community support
- Lower migration risk

## Alternatives:

CockroachDB
TiDB

## Status:

Accepted