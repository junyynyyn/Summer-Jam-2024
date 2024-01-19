import requests

BASE = "http://localhost:5000/"

data = {"username": "junyynyyn", "time": 50.0}

response = requests.post(BASE + "/level/2", data=data)
print(response.json())