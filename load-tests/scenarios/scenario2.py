from locust import HttpUser, task

class User(HttpUser):

    @task
    def get_transactions(self):
        self.client.get("/transactions")