CREATE TABLE merchant_settlements (
    settlement_id UUID PRIMARY KEY,
    merchant_id UUID NOT NULL,
    total_amount DECIMAL(18,2) NOT NULL,
    settlement_status VARCHAR(20)
        CHECK (settlement_status IN ('PENDING','PROCESSING','SETTLED','FAILED')),
    settlement_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_settlement_merchant ON merchant_settlements(merchant_id);
CREATE INDEX idx_settlement_status ON merchant_settlements(settlement_status);
