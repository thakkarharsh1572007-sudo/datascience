use foodie_app ;
-- Create a table called Orders with columns: order_id, user_name, total_amount, and order_date. Insert 5 sample rows with different users and order amounts, including at least one NULL value for total_amount.
CREATE TABLE Orders(
order_id int PRIMARY key ,
user_name VARCHAR(50),
total_amount int ,
order_date DATE 
);
INSERT INTO Orders (order_id, user_name, total_amount, order_date) 
VALUES 
    (1, 'Alice Smith', 150, '2023-10-01'),
    (2, 'Bob Johnson', 320, '2023-10-02'),
    (3, 'Charlie Davis', NULL, '2023-10-03'),
    (4, 'Diana Prince', 45, '2023-10-04'),
    (5, 'Evan Wright', 210, '2023-10-05');
-- Write a SQL query to count how many orders were placed by each user in the Orders table, displaying user_name and the number of orders as order_count.
SELECT count(*) , user_name FROM Orders GROUP BY user_name;
-- Write a SQL query to calculate the average total_amount of all orders in the Orders table, making sure to ignore any NULL values.
SELECT avg(total_amount) FROM Orders WHERE total_amount is not null;
-- Suppose you are building a Flipkart-style dashboard: Write a SQL query to find the highest and lowest order amounts (MAX and MIN) from the Orders table, and display both values in a single result row.
SELECT max(total_amount) as highest,min(total_amount) as lowest from orders;
-- Write a SQL query to calculate the total sales (SUM of total_amount) for all orders, but only include orders where total_amount is not NULL.<br><br><em><strong>Hint:</strong> Use a WHERE clause to filter out NULL values before applying the SUM function.</em>
SELECT sum(total_amount) FROM Orders WHERE total_amount is not null;