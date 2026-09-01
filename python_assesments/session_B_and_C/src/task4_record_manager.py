# src/task4_record_manager.py
import json
import os

# 1. Define the Order class
class Order:
    def __init__(self, order_id, restaurant_name, amount, delivery_time_minutes, is_delivered):
        self.order_id = order_id
        self.restaurant_name = restaurant_name
        self.amount = amount
        self.delivery_time_minutes = delivery_time_minutes
        self.is_delivered = is_delivered

    # Method for JSON serialisation
    def to_dict(self):
        return {
            'order_id': self.order_id,
            'restaurant_name': self.restaurant_name,
            'amount': self.amount,
            'delivery_time_minutes': self.delivery_time_minutes,
            'is_delivered': self.is_delivered
        }

    # Class method to rebuild an instance from a dictionary
    @classmethod
    def from_dict(cls, data):
        return cls(
            data['order_id'],
            data['restaurant_name'],
            data['amount'],
            data['delivery_time_minutes'],
            data['is_delivered']
        )

# 2 & 3. Implement save_records with try-except-finally
def save_records(records, filepath):
    print(f"\n--- Saving Records to {filepath} ---")
    try:
        # Convert list of Order objects to list of dictionaries
        dict_records = [record.to_dict() for record in records]
        
        # Ensure the directory exists
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        
        with open(filepath, 'w') as f:
            json.dump(dict_records, f, indent=4)
        print("Success: Records saved to disk.")
    except Exception as e:
        print(f"Error: An unexpected error occurred during save -> {e}")
    finally:
        print("Operation complete.")

# 2 & 3. Implement load_records with try-except-finally
def load_records(filepath):
    print(f"\n--- Loading Records from {filepath} ---")
    try:
        with open(filepath, 'r') as f:
            dict_records = json.load(f)
            
        # Reconstruct Order objects using the class method
        records = [Order.from_dict(d) for d in dict_records]
        print("Success: Records loaded from disk.")
        return records
    except FileNotFoundError:
        print(f"Error: File '{filepath}' not found. Returning empty list.")
        return []
    except Exception as e:
        print(f"Error: An unexpected error occurred during load -> {e}")
        return []
    finally:
        print("Operation complete.")

# Test Execution block
if __name__ == "__main__":
    filepath = 'data/processed/records.json'
    
    # Create sample instances
    order1 = Order(1, "Jay Ambe Parlour", 150.0, 30, True)
    order2 = Order(2, "Dadas Soda Shop", 200.5, 15, False)
    order_list = [order1, order2]
    
    # Test saving the records
    save_records(order_list, filepath)
    
    # Test loading the records
    loaded_orders = load_records(filepath)
    
    # Print the loaded records to verify
    print("\n--- Loaded Orders Output ---")
    for order in loaded_orders:
        print(f"Order ID: {order.order_id} | Restaurant: {order.restaurant_name} | Delivered: {order.is_delivered}")