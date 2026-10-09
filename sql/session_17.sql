-- Create a SQL table called Restaurant with columns: id, name, cuisine, location, and average_rating. Insert at least 5 sample rows representing popular restaurants from Zomato.
CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    location VARCHAR(100),
    average_rating DECIMAL(3,1)
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Spice Route', 'Indian', 'Delhi', 4.8),
(2, 'Pizza Express', 'Italian', 'Mumbai', 4.2),
(3, 'Sushi World', 'Japanese', 'Bangalore', 4.5),
(4, 'Bukhara', 'Indian', 'Delhi', 4.9),
(5, 'Trattoria', 'Italian', 'Mumbai', 4.6),
(6, 'Wasabi', 'Japanese', 'Mumbai', 4.4);
-- Write a SQL query to generate a report showing the number of restaurants for each cuisine type from your Restaurant table, ordered by the count in descending order.<br><br><em><strong>Hint:</strong> Use GROUP BY and ORDER BY.</em>
SELECT 
    cuisine, 
    COUNT(*) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC;
-- Add a new table called Review with columns: id, restaurant_id, user_name, rating, and review_date. Insert at least 10 sample reviews, linking them to restaurants using restaurant_id.
CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT,
    user_name VARCHAR(100),
    rating INT,
    review_date DATE
);

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date) VALUES
(1, 1, 'Rahul S.', 5, '2026-10-01'),
(2, 1, 'Priya K.', 4, '2026-10-02'),
(3, 2, 'Amit P.', 4, '2026-10-03'),
(4, 2, 'Neha R.', 3, '2026-10-04'),
(5, 3, 'Karan T.', 5, '2026-10-05'),
(6, 3, 'Sneha V.', 4, '2026-10-06'),
(7, 4, 'Vikram J.', 5, '2026-10-07'),
(8, 4, 'Anita D.', 5, '2026-10-08'),
(9, 5, 'Rohan G.', 4, '2026-10-09'),
(10, 5, 'Meera W.', 5, '2026-10-10');
-- Write a SQL query using a JOIN to display each restaurant's name, cuisine, and its average review rating (from the Review table), ordered by highest average rating first.<br><br><em><strong>Hint:</strong> Use JOIN and GROUP BY with aggregate functions.</em>
SELECT 
    r.name AS restaurant_name, 
    r.cuisine, 
    ROUND(AVG(rev.rating), 1) AS calculated_avg_rating
FROM Restaurant r
JOIN Review rev ON r.id = rev.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY calculated_avg_rating DESC;
-- Use a window function to rank restaurants by their average review rating within each cuisine type, showing the restaurant name, cuisine, average rating, and rank.<br><br><em><strong>Hint:</strong> Use the RANK() or DENSE_RANK() window function partitioned by cuisine.</em>
WITH RestaurantAverages AS (
    SELECT 
        r.name, 
        r.cuisine, 
        ROUND(AVG(rev.rating), 1) AS calculated_avg_rating
    FROM Restaurant r
    JOIN Review rev ON r.id = rev.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)
SELECT 
    name, 
    cuisine, 
    calculated_avg_rating,
    DENSE_RANK() OVER (PARTITION BY cuisine ORDER BY calculated_avg_rating DESC) AS cuisine_rank
FROM RestaurantAverages;