CREATE TABLE ledger_entries (
    entry_id UUID PRIMARY KEY,
    transaction_id UUID NOT NULL,
    account_id UUID NOT NULL,
    entry_type VARCHAR(10) CHECK (entry_type IN ('DEBIT','CREDIT')) NOT NULL,
    amount DECIMAL(18,2) NOT NULL CHECK (amount > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_tx FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

PARTITION BY RANGE (created_at);

CREATE TABLE ledger_entries_2026_01
PARTITION OF ledger_entries
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE ledger_entries_2026_02
PARTITION OF ledger_entries
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');


CREATE INDEX idx_ledger_tx ON ledger_entries(transaction_id);
CREATE INDEX idx_ledger_account ON ledger_entries(account_id);
CREATE INDEX idx_ledger_created_at ON ledger_entries(created_at);