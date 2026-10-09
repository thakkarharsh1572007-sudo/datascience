USE foodie_app;
DROP TABLE orders;
-- Create a table called Orders with columns: order_id, user_id, payment_method, and amount. Insert at least 8 sample records representing different users and payment methods (like UPI, Card, Wallet, COD).
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(10, 2)
);

INSERT INTO Orders (order_id, user_id, payment_method, amount) 
VALUES 
    (1, 101, 'UPI', 1250.00),
    (2, 102, 'Card', 450.50),
    (3, 103, 'COD', 890.00),
    (4, 104, 'Wallet', 200.00),
    (5, 105, 'UPI', 3400.75),
    (6, 101, 'Card', 150.00),
    (7, 106, 'COD', 120.00),
    (8, 102, 'Wallet', 550.25);
-- Write an SQL query to count how many orders were placed using each payment_method in the Orders table, similar to how Zomato shows payment breakdown in analytics.
SELECT payment_method , count(*) as count FROM orders GROUP BY payment_method;
-- Write an SQL query to find the total amount spent by each user_id in the Orders table. Display user_id and their total spend.
SELECT user_id , sum(amount) as total from orders GROUP BY user_id;
-- Write an SQL query to show only those payment methods where the average order amount is greater than 300, using GROUP BY and HAVING.<br><br><em><strong>Hint:</strong> Use AVG(amount) in your HAVING clause.</em>
SELECT payment_method , avg(amount) as avg_amount FROM orders GROUP BY payment_method HAVING avg_amount > 300;
-- Explain the difference between WHERE and HAVING by giving one example query for each, using the Orders table. Your examples should show a scenario where WHERE and HAVING filter different things.
-- WHERE filters individual rows before they are grouped
SELECT *
FROM Orders 
WHERE amount > 500;
-- HAVING filters aggregated groups after they are grouped
SELECT payment_method, SUM(amount) AS total_volume
FROM Orders 
GROUP BY payment_method 
HAVING SUM(amount) > 1000;
-- Combining Both:
SELECT payment_method, SUM(amount) AS total_volume
FROM Orders 
WHERE user_id IN (101, 102)          -- 1. Filters rows FIRST
GROUP BY payment_method              -- 2. Groups the remaining rows
HAVING SUM(amount) > 1000;           -- 3. Filters the groups LAST