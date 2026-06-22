class CircuitBreaker:
    def __init__(self):
        self.state = "CLOSED"
        self.failure_count = 0
        self.threshold = 5
        self.timeout = 10  # seconds

    def call(self, func, *args):
        if self.state == "OPEN":
            return self.fallback()

        try:
            result = func(*args)
            self.reset()
            return result

        except Exception:
            self.failure_count += 1

            if self.failure_count >= self.threshold:
                self.state = "OPEN"

            return self.fallback()

    def reset(self):
        self.failure_count = 0
        self.state = "CLOSED"

    def fallback(self):
        return "Service temporarily unavailable"