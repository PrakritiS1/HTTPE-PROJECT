CREATE TABLE transaction_events (
    event_id UUID PRIMARY KEY,
    transaction_id UUID NOT NULL,
    event_type VARCHAR(50),
    event_payload JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_event_tx FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id)
);

CREATE INDEX idx_event_tx ON transaction_events(transaction_id);
CREATE INDEX idx_event_type ON transaction_events(event_type);
CREATE INDEX idx_event_created ON transaction_events(created_at);