CREATE TABLE notification_log (
    notification_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    channel VARCHAR(20) CHECK (channel IN ('EMAIL','SMS','PUSH')),
    message TEXT,
    status VARCHAR(20) CHECK (status IN ('SENT','FAILED','PENDING')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notification_user FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

CREATE INDEX idx_notification_user ON notification_log(user_id);
CREATE INDEX idx_notification_status ON notification_log(status);