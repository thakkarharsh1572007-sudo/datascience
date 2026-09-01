import requests
import json
import os

# Fetching API data
url = "https://jsonplaceholder.typicode.com/posts?_limit=5"
records = []
try:
    response = requests.get(url)
    # FIX: Added status code check before parsing JSON
    if response.status_code == 200:
        records = response.json()
        print("Fetched 5 records.")
    else:
        print(f"API Error: Received status code {response.status_code}")
except Exception as e:
    print(f"API Request Failed: {e}")

# Commission Calculation
amounts = [150, 200, 350, 500, 600, 800]
fees = list(map(lambda x: x * 0.10 if x <= 200 else (x * 0.15 if x <= 500 else x * 0.20), amounts))
for original, fee in zip(amounts, fees):
    print(f"Amount: Rs {original} | Fee: Rs {fee:.2f}")

# Saving to file (with safety check for directory)
if records:
    os.makedirs('data/processed', exist_ok=True)
    with open('data/processed/records.json', 'w') as f:
        json.dump(records, f, indent=2)