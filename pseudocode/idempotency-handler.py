class IdempotencyHandler:
    def __init__(self):
        self.store = {}

    def process(self, request_id, operation):
        if request_id in self.store:
            return self.store[request_id]

        result = operation()
        self.store[request_id] = result

        return result