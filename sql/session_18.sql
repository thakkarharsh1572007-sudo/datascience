-- Write an SQL query to display the total number of songs uploaded by each artist from a table 'songs' (columns: song_id, artist_name, title) and show only those artists who have uploaded more than 3 songs.
SELECT 
    artist_name, 
    COUNT(song_id) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3;
-- Given two tables, 'orders' (order_id, user_id, amount) and 'users' (user_id, username), write a SQL JOIN query to display each username along with their total order amount.
SELECT 
    u.username, 
    SUM(o.amount) AS total_order_amount
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username;
-- Write a SQL subquery to find the names of all restaurants from a 'restaurants' table (id, name, rating) whose rating is higher than the average rating of all restaurants.
SELECT name 
FROM restaurants
WHERE rating > (
    SELECT AVG(rating) 
    FROM restaurants
);
-- Using a 'transactions' table (id, user_id, amount, transaction_date), write a SQL query with a window function to display each user's transaction amount and their running total (cumulative sum) ordered by transaction_date.
SELECT 
    user_id,
    amount,
    transaction_date,
    SUM(amount) OVER (
        PARTITION BY user_id 
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions;
-- List two optimizations you would apply to speed up a query that filters Flipkart products by category and price, and briefly explain how each helps.<br><br><em><strong>Hint:</strong> Think about indexes and query structure.</em>



-- To speed up a query filtering Flipkart products by category and price (e.g., WHERE category = 'Electronics' AND price < 50000), apply these two optimizations:

-- Create a Composite Index on (category, price):
-- Instead of scanning the entire products table (a Full Table Scan), a composite index structures the data like a phonebook. The database engine will instantly jump to the 'Electronics' section and then efficiently pull only the items priced under 50000. The order of columns in the index matters: put the equality filter (category) before the range filter (price).

-- Avoid SELECT * (Select Specific Columns Only):
-- Explicitly list only the columns you need (e.g., SELECT product_id, title, price). This reduces memory consumption, network payload, and disk I/O. If you only select columns that exist inside the index, the database can perform an "Index-Only Scan," meaning it never even has to look at the actual table data to return your results.
