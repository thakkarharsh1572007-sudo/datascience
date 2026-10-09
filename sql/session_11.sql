-- Create a SQL query using a subquery in the WHERE clause to find all restaurants from a 'Restaurants' table whose average rating is higher than the average rating of all restaurants in the city.
SELECT * from restaurent r1 WHERE rating > ( SELECT avg(rating) from restaurent r2 WHERE r1.city = r2.city );
-- Write a SQL query that uses a subquery in the SELECT statement to display each user's name from a 'Users' table along with the total number of orders they have placed from an 'Orders' table, like a summary you might see in a Zomato user profile.
SELECT user_name,(SELECT COUNT(order_id) FROM Orders o WHERE o.user_id = u.user_id) AS total_orders FROM Users u;
-- Given a 'Movies' table and a 'Reviews' table, write a SQL query using IN with a subquery to list all movies that have at least one review with a rating of 5 stars, as seen in BookMyShow's top-rated section.
SELECT movie_title FROM Movies WHERE movie_id IN (SELECT movie_id FROM Reviews WHERE rating = 5);
-- Write a nested SQL query to find the names of all sellers from a 'Sellers' table on a Flipkart-style platform who have sold products in every category listed in a 'Categories' table.<br><br><em><strong>Hint:</strong> Use nested subqueries to compare seller's categories with the complete list of categories.</em>
SELECT seller_name FROM Sellers WHERE seller_id IN (SELECT seller_id FROM Products GROUP BY seller_id HAVING COUNT(DISTINCT category_id) = (SELECT COUNT(category_id) FROM Categories));
