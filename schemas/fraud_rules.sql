CREATE TABLE fraud_rules (
    rule_id UUID PRIMARY KEY,
    rule_name VARCHAR(100),
    rule_expression TEXT NOT NULL,
    severity VARCHAR(20) CHECK (severity IN ('LOW','MEDIUM','HIGH')),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_fraud_active ON fraud_rules(is_active);