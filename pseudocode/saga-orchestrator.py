class PaymentSaga:

    def execute(self, transaction):
        try:
            self.debit(transaction.from_account, transaction.amount)

            self.credit(transaction.to_account, transaction.amount)

            self.mark_success(transaction)

        except Exception as e:
            self.compensate(transaction)
            self.mark_failed(transaction)

    def compensate(self, transaction):
        # rollback logic
        self.refund(transaction.from_account, transaction.amount)