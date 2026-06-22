def update_balance(account_id, amount, version):
    while True:
        account = db.get_account(account_id)

        # Check version (Optimistic Lock)
        if account.version != version:
            raise Exception("Error detected. Retry transaction.")

        new_balance = account.balance + amount

        if new_balance < 0:
            raise Exception("Insufficient Balance")

        updated = db.update_account(
            account_id=account_id,
            balance=new_balance,
            version=version + 1
        )

        if updated:
            return "SUCCESS"