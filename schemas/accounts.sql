CREATE TABLE accounts (
    account_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    account_type VARCHAR(20) CHECK (account_type IN ('SAVINGS','CURRENT','WALLET')) NOT NULL,
    balance DECIMAL(18,2) DEFAULT 0 CHECK (balance >= 0),
    currency CHAR(3) DEFAULT 'INR',
    status VARCHAR(20) CHECK (status IN ('ACTIVE','BLOCKED','CLOSED')) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE INDEX idx_accounts_user_id ON accounts(user_id);
CREATE INDEX idx_accounts_status ON accounts(status);