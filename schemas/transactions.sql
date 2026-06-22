CREATE TABLE transactions (
    transaction_id UUID PRIMARY KEY,
    from_account_id UUID,
    to_account_id UUID,
    amount DECIMAL(18,2) NOT NULL CHECK (amount > 0),
    currency CHAR(3) DEFAULT 'INR',
    status VARCHAR(20) CHECK (
        status IN ('INITIATED','PROCESSING','SUCCESS','FAILED','REVERSED')
    ) DEFAULT 'INITIATED',
    transaction_type VARCHAR(20) CHECK (
        transaction_type IN ('P2P','MERCHANT','BANK_TRANSFER')
    ),
    reference_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_from_account FOREIGN KEY (from_account_id) REFERENCES accounts(account_id),
    CONSTRAINT fk_to_account FOREIGN KEY (to_account_id) REFERENCES accounts(account_id)
);

PARTITION BY RANGE (created_at);


CREATE TABLE transactions_2026_01
PARTITION OF transactions
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE transactions_2026_02
PARTITION OF transactions
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');

CREATE INDEX idx_tx_from_account ON transactions(from_account_id);
CREATE INDEX idx_tx_to_account ON transactions(to_account_id);
CREATE INDEX idx_tx_status ON transactions(status);
CREATE INDEX idx_tx_created_at ON transactions(created_at);
CREATE INDEX idx_tx_reference ON transactions(reference_id);