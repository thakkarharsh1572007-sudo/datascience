# task2_cleaning.py

# 1. Hardcoded list of at least 8 raw restaurant names (inconsistent casing, whitespace, and invalid entries)
raw_restaurants = [
    "  jay ambe parlour  ", 
    "DADAS-SODA-SHOP", 
    "", 
    "12345", 
    "  dominos\n", 
    "KFC  ", 
    "   ", 
    "pizza hut"
]

# Hardcoded associated list of amount strings
raw_amounts = ['Rs 150', '200.50', '0', '0', 'Rs 300.25', ' 500 ', '0', 'Rs 250.75']

valid_count = 0
skipped_count = 0
running_total = 0.0

print("--- Restaurant Cleaning Log ---")

# 2. Clean and validate records
for i in range(len(raw_restaurants)):
    name = raw_restaurants[i]
    amount_str = raw_amounts[i]
    
    # Clean the name using string methods: strip(), replace(), and title()
    cleaned_name = name.strip().replace("-", " ").title()
    
    # Conditional check to skip empty or purely numeric entries
    # We remove spaces temporarily just in case an entry is like "12 34"
    if not cleaned_name or cleaned_name.replace(" ", "").isnumeric():
        print(f"Skipped invalid entry at index {i}: '{name.strip()}'")
        skipped_count += 1
        continue
    
    # 3. Process the amount for valid records
    # Strip the currency symbol and whitespace, then cast to float
    clean_amount_str = amount_str.replace('Rs', '').strip()
    amount_float = float(clean_amount_str)
    
    # Add to running total
    running_total += amount_float
    valid_count += 1
    
    print(f"Valid Record: {cleaned_name} | Amount: {amount_float:.2f} | Running Total: {running_total:.2f}")

# 4. Print clean formatted summary
print("\n" + "="*30)
print("       PROCESS SUMMARY")
print("="*30)
print(f"Total Valid Records   : {valid_count}")
print(f"Total Skipped Records : {skipped_count}")
print(f"Final Running Total   : Rs {running_total:.2f}")