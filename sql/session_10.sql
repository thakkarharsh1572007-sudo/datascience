-- Create two tables: Influencers (id, name) and Collaborations (id, influencer1_id, influencer2_id, collab_date). Write a SQL FULL JOIN query to list all influencers and show their collaboration partner names if any, including influencers with no collaborations.
CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE
);
INSERT INTO Influencers (id, name) VALUES
    (1, 'Bhuvan Bam'),
    (2, 'Prajakta Koli'),
    (3, 'CarryMinati'),
    (4, 'Kusha Kapila'); 
INSERT INTO Collaborations (id, influencer1_id, influencer2_id, collab_date) VALUES
    (1, 1, 2, '2023-05-10'),
    (2, 2, 3, '2023-08-22');
SELECT 
    i.name AS influencer_name,
    p.name AS partner_name,
    c.collab_date
FROM Influencers i
LEFT JOIN Collaborations c 
    ON i.id = c.influencer1_id OR i.id = c.influencer2_id
LEFT JOIN Influencers p 
    ON (p.id = c.influencer1_id OR p.id = c.influencer2_id) AND p.id != i.id
UNION
SELECT 
    i.name AS influencer_name,
    p.name AS partner_name,
    c.collab_date
FROM Influencers i
RIGHT JOIN Collaborations c 
    ON i.id = c.influencer1_id OR i.id = c.influencer2_id
LEFT JOIN Influencers p 
    ON (p.id = c.influencer1_id OR p.id = c.influencer2_id) AND p.id != i.id;
-- Using a SELF JOIN, write a query on a table called Playlists (id, user_id, playlist_name, parent_playlist_id) to display each playlist alongside its parent playlist name, similar to how Spotify shows nested playlists.<br><br><em><strong>Hint:</strong> Join Playlists with itself on parent_playlist_id = id.</em>
SELECT p.playlist_name , p1.playlist_name as parent_playlist from playlist p JOIN playlist p1 on p.id = p1.parent_palylist_id ;
-- Given three tables: Users (id, username), Orders (id, user_id, order_date), and Payments (id, order_id, amount), write a SQL query using multiple JOINs to display each username, their order date, and payment amount, showing all users even if they have no orders or payments.
SELECT u.name , o.order_date , p.amount FROM users u LEFT JOIN orders o on u.id = o.user_id JOIN payments p on o.id = p.order_id ;
-- You notice that your JOIN query between Zomato's Restaurants and Reviews tables is returning duplicate rows for some restaurants. Modify your query to eliminate duplicates and explain in one line why the duplicates were happening.<br><br><em><strong>Hint:</strong> Use DISTINCT or GROUP BY and consider the relationship between restaurants and reviews.</em>
SELECT DISTINCT r.restaurant_name, r.city -- selesting unique values 
FROM Restaurants r INNER JOIN Reviews rev  -- join 
    ON r.id = rev.restaurant_id; -- condition 
-- Write two different JOIN queries on a Products and Categories table (like Flipkart) to list all products with their category names, but use different join conditions in each. Briefly explain which join condition is more efficient and why.
SELECT p.product_name, c.category_name FROM Products p JOIN Categories c ON p.category_id = c.category_id;
SELECT p.product_name, c.category_name FROM Products p LEFT JOIN Categories c ON p.category_id = c.category_id;
-- An INNER JOIN is generally more efficient and faster.
-- Why: With an INNER JOIN, the database only has to process and return records where it finds a direct match in both tables, allowing it to filter out unlinked data early. With a LEFT JOIN, the database is forced to scan and return every single row from the Products table regardless of whether a match exists, which consumes slightly more memory and processing power.
