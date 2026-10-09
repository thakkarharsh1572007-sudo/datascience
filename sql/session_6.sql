use flipkart_style_app ;
use foodie_app;
-- Write an SQL query to display all products from a 'products' table and sort them by price in ascending order, similar to how Flipkart lists items from lowest to highest price.
SELECT * from products ORDER BY price ASC;
-- Modify your previous query to show the top 5 most expensive products using ORDER BY with DESC and LIMIT.
SELECT * from products ORDER BY price DESC ;
-- Given a 'movies' table with columns 'title', 'release_year', and 'rating', write an SQL query to list all movies sorted first by release_year in descending order (latest first), then by rating in descending order (highest rated first).
SELECT * from movies ORDER BY release_year DESC;
-- Write an SQL query to display the first 10 restaurants from a 'restaurants' table, sorted alphabetically by name, just like Zomato's A-Z listing.<br><br><em><strong>Hint:</strong> Use ORDER BY with LIMIT.</em>
SELECT * from restaurants ORDER BY name ASC limit 10;
-- Suppose you want to display the top 3 trending songs from a 'songs' table based on play_count, but if two songs have the same play_count, the more recently added song should come first. Write the SQL query to achieve this.<br><br><em><strong>Hint:</strong> Use ORDER BY with multiple columns.</em>
SELECT * from songs ORDER BY play_count , release_date DESC LIMIT 3;