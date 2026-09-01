import requests
import json

# Fetching API data
url = "https://jsonplaceholder.typicode.com/posts?_limit=5"
try:
    response = requests.get(url)
    # BUG: Calling .json() immediately without checking status_code
    records = response.json()
    print("Fetched 5 records.")
except Exception as e:
    print(f"API Error: {e}")

# Commission Calculation
amounts = [150, 200, 350, 500, 600, 800]
fees = list(map(lambda x: x * 0.10 if x <= 200 else (x * 0.15 if x <= 500 else x * 0.20), amounts))
for original, fee in zip(amounts, fees):
    print(f"Amount: Rs {original} | Fee: Rs {fee}")

# Saving to file
with open('data/processed/records.json', 'w') as f:
    json.dump(records, f, indent=2)
