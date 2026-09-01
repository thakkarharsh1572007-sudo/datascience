# src/capstone_pipeline.py
import requests
import json
import os

# Define the Order class as required
class Order:
    def __init__(self, order_id, name, amount, status):
        self.order_id = order_id
        self.name = name
        self.amount = float(amount)
        self.status = status

    def to_dict(self):
        return {
            'id': self.order_id,
            'name': self.name,
            'amount': self.amount,
            'status': self.status
        }
    
    @classmethod
    def from_dict(cls, data):
        return cls(data.get('id'), data.get('name'), data.get('amount', 0.0), data.get('status', 'Pending'))

def fetch_api_data(records):
    url = "https://jsonplaceholder.typicode.com/posts?_limit=10"
    try:
        response = requests.get(url)
        # Check HTTP status code before proceeding
        if response.status_code == 200:
            data = response.json()
            print("\n--- Top 10 Mock Restaurants Fetched ---")
            for item in data:
                # Treating id as id, title as name, and adding mock amount/status
                new_order = Order(item['id'], item['title'][:15], 150.0, "Fetched")
                records.append(new_order)
                print(f"ID: {new_order.order_id} | Name: {new_order.name}")
        else:
            print(f"API Error: Received status code {response.status_code}. Skipping fetch.")
    except Exception as e:
        print(f"API Request Failed: {e}")

def add_new_record(records):
    print("\n--- Add New Restaurant ---")
    try:
        o_id = int(input("Enter ID (numeric): "))
        name = input("Enter Restaurant Name: ")
        
        # Input validation loop for numeric amount field
        while True:
            amt_str = input("Enter Amount (numeric): ")
            try:
                amount = float(amt_str)
                break
            except ValueError:
                print("Error: Amount must be numeric. Please try again.")
        
        status = input("Enter Status (e.g., Delivered, Pending): ")
        
        new_order = Order(o_id, name, amount, status)
        records.append(new_order)
        print(f"Success: Record '{name}' added.")
    except ValueError:
        print("Error: Invalid ID. Must be an integer. Returning to menu.")

def calculate_commission(records):
    if not records:
        print("\nNo records available to calculate. Please fetch or add data first.")
        return

    # Use map() to apply tier logic
    def calc_fee(record):
        amt = record.amount
        # Tiered logic: 10% <= 200, 15% <= 500, 20% > 500
        fee = amt * 0.10 if amt <= 200 else (amt * 0.15 if amt <= 500 else amt * 0.20)
        return {'id': record.order_id, 'name': record.name, 'fee': fee}

    processed = list(map(calc_fee, records))
    
    # Use filter() to isolate records with fees > 0
    filtered = list(filter(lambda x: x['fee'] > 0, processed))

    print("\n--- Commission Report ---")
    for item in filtered:
        print(f"ID: {item['id']} | Name: {item['name']} | Fee: Rs {item['fee']:.2f}")

def save_and_load(records):
    filepath = 'data/processed/records.json'
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    
    print("\n--- Saving & Loading ---")
    # Save objects to JSON
    try:
        with open(filepath, 'w') as f:
            json.dump([r.to_dict() for r in records], f, indent=4)
        print(f"Success: {len(records)} records saved to {filepath}.")
    except Exception as e:
        print(f"Save failed: {e}")

    # Load objects back
    try:
        with open(filepath, 'r') as f:
            data = json.load(f)
            loaded_records = [Order.from_dict(d) for d in data]
            print(f"Success: {len(loaded_records)} records loaded back into memory from disk.")
    except Exception as e:
        print(f"Load failed: {e}")

def main():
    records = [] # In-memory list for the session
    while True:
        print("\n" + "="*35)
        print(" Food Delivery Live Data Pipeline")
        print("="*35)
        print("1. Fetch API Mock Records")
        print("2. Add New Restaurant Record")
        print("3. Calculate Commissions")
        print("4. Save & Load Records")
        print("5. Exit")
        
        choice = input("Select an option (1-5): ")
        
        if choice == '1':
            fetch_api_data(records)
        elif choice == '2':
            add_new_record(records)
        elif choice == '3':
            calculate_commission(records)
        elif choice == '4':
            save_and_load(records)
        elif choice == '5':
            print("Exiting Pipeline. Goodbye!")
            break
        else:
            print("Invalid option. Please choose 1-5.")

if __name__ == "__main__":
    main()