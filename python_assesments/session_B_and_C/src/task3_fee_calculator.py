# src/task3_fee_calculator.py
import functools

# 1. Hardcoded list of at least 6 dictionaries
orders = [
    {'id': 101, 'name': 'Burger King', 'amount': 150.0},
    {'id': 102, 'name': 'Pizza Hut', 'amount': 450.0},
    {'id': 103, 'name': 'Domino\'s', 'amount': 700.0},
    {'id': 104, 'name': 'Subway', 'amount': 120.0},
    {'id': 105, 'name': 'KFC', 'amount': 300.0},
    {'id': 106, 'name': 'Taco Bell', 'amount': 850.0}
]

# 2. Named function that applies a tiered commission (3 tiers)
def calculate_commission(amount):
    if amount <= 200:
        return amount * 0.05  # Tier 1: 5% fee
    elif amount <= 500:
        return amount * 0.10  # Tier 2: 10% fee
    else:
        return amount * 0.15  # Tier 3: 15% fee

# Use map() with a lambda to compute a 'fee' for every record
# We use dictionary unpacking (**record) to create a new dict with the added fee key
processed_orders = list(map(
    lambda record: {**record, 'fee': calculate_commission(record['amount'])}, 
    orders
))

# 3. Use filter() to isolate records where the fee exceeds a threshold (e.g., Rs 30)
audit_threshold = 30.0
high_fee_records = list(filter(lambda record: record['fee'] > audit_threshold, processed_orders))

print("--- Audit Log: High Fee Records ( > Rs 30) ---")
for record in high_fee_records:
    print(f"ID: {record['id']} | Restaurant: {record['name']} | Fee: Rs {record['fee']:.2f}")

# 4. Use functools.reduce() to calculate the total fee across all records
# The '0.0' at the end is the initial accumulator value
total_fees = functools.reduce(lambda acc, record: acc + record['fee'], processed_orders, 0.0)

print("\n" + "="*35)
print(f"Total Commission Collected: Rs {total_fees:.2f}")
print("="*35)