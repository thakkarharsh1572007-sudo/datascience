import pandas as pd
import numpy as np
import sqlite3
import matplotlib.pyplot as plt
import seaborn as sns
import os

def load_and_clean_data():
    """Option 1: Simulates loading data, imputing nulls, deduplicating, and capping outliers."""
    try:
        df = pd.DataFrame({
            'order_id': range(1, 21),
            'category': ['Fast Food', np.nan, 'Italian', 'Healthy'] * 5,
            'order_value': [10.0, 15.0, np.nan, 25.0, 100.0] * 4,
            'delivery_time': [30.0, 45.0, 20.0, np.nan, 50.0] * 4
        })
        df = pd.concat([df, df.iloc[:2]], ignore_index=True)
        
        print("\n--- BEFORE CLEANING ---")
        print(df.isnull().sum())
        
        df['category'] = df['category'].fillna(df['category'].mode()[0])
        df['order_value'] = df['order_value'].fillna(df['order_value'].median())
        df['delivery_time'] = df['delivery_time'].fillna(df['delivery_time'].median())
        
        df = df.drop_duplicates()
        
        Q1 = df['order_value'].quantile(0.25)
        Q3 = df['order_value'].quantile(0.75)
        IQR = Q3 - Q1
        upper_fence = Q3 + 1.5 * IQR
        df['order_value'] = df['order_value'].clip(upper=upper_fence)
        
        print("\n--- AFTER CLEANING ---")
        print(f"Shape: {df.shape}")
        print(df.isnull().sum())
        return df
        
    except Exception as e:
        print(f"\n[!] Error during data loading/cleaning: {e}")
        return None

def run_sql_analysis():
    """Option 2: Executes two distinct queries (GROUP BY and JOIN) to satisfy the rubric."""
    db_file = 'section_b/food_delivery.db'
    sql_results = {}
    
    if not os.path.exists(db_file):
        print(f"\n[!] Error: Database '{db_file}' not found.")
        print("Please ensure you have completed Task 4 to generate the database before running this analysis.")
        return sql_results

    try:
        conn = sqlite3.connect(db_file)
        
        query_groupby = '''
            SELECT restaurant_id, 
                   COUNT(order_id) as total_orders, 
                   ROUND(SUM(order_value), 2) as total_revenue,
                   ROUND(AVG(rating), 2) as avg_rating
            FROM orders
            GROUP BY restaurant_id
        '''
        df_groupby = pd.read_sql_query(query_groupby, conn)
        
        query_join = '''
            SELECT r.name AS restaurant_name, r.city, o.order_id, o.order_value, o.delivery_time_mins
            FROM restaurants r
            JOIN orders o ON r.restaurant_id = o.restaurant_id
            ORDER BY o.order_value DESC
            LIMIT 10
        '''
        df_join = pd.read_sql_query(query_join, conn)
        conn.close()
        
        if not df_groupby.empty and not df_join.empty:
            sql_results['SQL_GroupBy'] = df_groupby
            sql_results['SQL_Join'] = df_join
            
            print("\n--- SQL Query 1: GROUP BY Aggregates ---")
            print(df_groupby.head(5).to_string(index=False))
            print("\n--- SQL Query 2: JOIN Results (Top 10 Orders) ---")
            print(df_join.to_string(index=False))
        else:
            print("\n[!] Notice: Queries executed but returned no data.")
            
        return sql_results
        
    except sqlite3.OperationalError as e:
        print(f"\n[!] Database Operational Error: {e}")
        return {}
    except Exception as e:
        print(f"\n[!] Unexpected error during SQL execution: {e}")
        return {}

def view_charts(df):
    """Option 3: Generates side-by-side countplot and barplot."""
    if df is None or df.empty:
        print("\n[!] Error: No data available for visualization.")
        print("Please run 'Option 1: Load & Clean Data' first.")
        return
        
    try:
        fig, axes = plt.subplots(1, 2, figsize=(12, 5))
        
        sns.countplot(data=df, x='category', hue='category', ax=axes[0], palette='viridis', legend=False)
        axes[0].set_title('Orders by Category')
        axes[0].set_xlabel('Category')
        axes[0].set_ylabel('Count')
        
        sns.barplot(data=df, x='category', y='delivery_time', hue='category', ax=axes[1], palette='magma', legend=False)
        axes[1].set_title('Average Delivery Time by Category')
        axes[1].set_xlabel('Category')
        axes[1].set_ylabel('Avg Delivery Time (mins)')
        
        plt.tight_layout()
        plt.show()
    except Exception as e:
        print(f"\n[!] Error generating visualization: {e}")

def export_report(df, sql_dict):
    """Option 4: Exports DataFrames (Cleaned Data + Multiple SQL Queries) to Excel."""
    if (df is None or df.empty) and not sql_dict:
        print("\n[!] Error: No data available to export.")
        print("Please run Option 1 (Load Data) or Option 2 (SQL Analysis) first.")
        return

    path = 'food_delivery_report.xlsx'
    try:
        with pd.ExcelWriter(path) as writer:
            if df is not None and not df.empty:
                df.to_excel(writer, sheet_name='Cleaned Data', index=False)
                
            if sql_dict:
                for sheet_name, sql_df in sql_dict.items():
                    sql_df.to_excel(writer, sheet_name=sheet_name, index=False)
                
        print(f"\n[SUCCESS] Report successfully exported to: {os.path.abspath(path)}")
        
    except PermissionError:
        print(f"\n[!] Permission Error: Access denied to '{path}'.")
        print("Please ensure the Excel file is CLOSED before trying to overwrite it.")
    except Exception as e:
        print(f"\n[!] Unexpected error during export: {e}")

def main():
    cleaned_df = None
    sql_results_dict = {}
    
    while True:
        try:
            print("\n" + "="*40)
            print("  Food Delivery Analytics Console")
            print("="*40)
            print("1. Load & Clean Data")
            print("2. Run SQL Analysis")
            print("3. View Charts")
            print("4. Export Report")
            print("0. Exit")
            
            choice = input("\nEnter choice (0-4): ").strip()
            
            if choice == '1':
                result = load_and_clean_data()
                if result is not None:
                    cleaned_df = result
            elif choice == '2':
                result = run_sql_analysis()
                if result:
                    sql_results_dict = result
            elif choice == '3':
                view_charts(cleaned_df)
            elif choice == '4':
                export_report(cleaned_df, sql_results_dict)
            elif choice == '0':
                print("\nExiting application. Goodbye!")
                break
            else:
                print("\n[!] Invalid input. Please enter a number between 0 and 4.")
                
        except KeyboardInterrupt:
            print("\n\n[!] Process safely interrupted by user (Ctrl+C). Exiting...")
            break
        except Exception as e:
            print(f"\n[!] A fatal system error occurred: {e}")

if __name__ == "__main__":
    main()