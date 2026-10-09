-- Create a CTE using the WITH clause to select all products with a rating above 4.5 from a 'Products' table, similar to how Flipkart or Myntra might highlight top-rated items.
WITH TopRatedProducts AS (
    SELECT product_id, product_name, price, rating
    FROM Products
    WHERE rating > 4.5
)
SELECT * FROM TopRatedProducts;
-- Rewrite a query that finds all restaurants in 'Ahmedabad' with delivery charges under 50 from a 'Restaurants' table, first using a subquery and then using a CTE. Compare both queries for readability.<br><br><em><strong>Hint:</strong> Focus on making the CTE version cleaner and easier to understand.</em>
WITH AhmedabadRestaurants AS (
    SELECT restaurant_name, delivery_charge
    FROM Restaurants
    WHERE city = 'Ahmedabad'
)
SELECT restaurant_name, delivery_charge FROM AhmedabadRestaurants WHERE delivery_charge < 50;
-- Using two CTEs in a single query, find the top 3 most-followed users and the top 3 most-liked posts from a 'Users' and 'Posts' table (think Instagram-style data). Output both lists in the same result set.
WITH TopUsers AS (
    SELECT 
        'User Profile' AS content_type,
        username AS content_identifier,
        'Followers' AS metric_name,
        follower_count AS metric_score
    FROM Users
    ORDER BY follower_count DESC
    LIMIT 3
),
TopPosts AS (
    SELECT 
        'Post' AS content_type,
        CAST(post_id AS CHAR) AS content_identifier, 
        'Likes' AS metric_name,
        like_count AS metric_score
    FROM Posts
    ORDER BY like_count DESC
    LIMIT 3
)
SELECT * FROM TopUsers UNION ALL SELECT * FROM TopPosts;
-- Write a recursive CTE that generates a list of dates for the next 7 days starting from today, similar to how BookMyShow shows available dates for movie bookings.<br><br><em><strong>Hint:</strong> Use a base case for today and recursion to add one day at a time.</em>
WITH RECURSIVE DateGenerator AS (
    SELECT CURDATE() AS booking_date, 1 AS day_count
    
    UNION ALL
    
    SELECT DATE_ADD(booking_date, INTERVAL 1 DAY), day_count + 1
    FROM DateGenerator
    WHERE day_count < 7
)
SELECT booking_date 
FROM DateGenerator;
-- Given a messy SQL query that finds all users with more than 1000 followers from a 'Users' table, refactor it to use a CTE for better clarity and maintainability.
-- The "Messy" Subquery Version
SELECT u.username, u.follower_count
FROM (
    SELECT * 
    FROM Users 
    WHERE account_status = 'active'
) AS u
WHERE u.follower_count > 1000 ORDER BY u.follower_count DESC;
-- The Refactored CTE Version
WITH ActiveUsers AS (
    SELECT username, follower_count
    FROM Users
    WHERE account_status = 'active'
)
SELECT username, follower_count FROM ActiveUsers WHERE follower_count > 1000 ORDER BY follower_count DESC;
