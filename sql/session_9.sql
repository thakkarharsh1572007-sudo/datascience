use foodie_app;
DROP TABLE restaurants;
-- Create two tables in your database: 'restaurants' (id, name, city) and 'dishes' (id, restaurant_id, dish_name, price). Insert at least 3 restaurants and 2-3 dishes for each restaurant.
CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100),
    price DECIMAL(8, 2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

INSERT INTO restaurants (id, name, city) 
VALUES
    (1, 'Swati Snacks', 'Ahmedabad'),
    (2, 'Bukhara', 'New Delhi'),
    (3, 'Truffles', 'Bangalore');

INSERT INTO dishes (id, restaurant_id, dish_name, price) 
VALUES
    (1, 1, 'Panki Chatni', 210.00),
    (2, 1, 'Fada Ni Khichdi', 250.00),
    (3, 1, 'Sev Puri', 180.00),
    (4, 2, 'Dal Bukhara', 850.00),
    (5, 2, 'Sikandari Raan', 2100.00),
    (6, 3, 'All American Cheese Burger', 320.00),
    (7, 3, 'Peri Peri Fries', 180.00),
    (8, 3, 'Ferrero Rocher Shake', 240.00);
-- Write an SQL INNER JOIN query to display each dish along with its restaurant name and city, similar to how Zomato shows dish details with the restaurant info.
SELECT d.dish_name , d.price , r.name , r.city FROM restaurants r JOIN dishes d on r.id  =  d.restaurant_id;
-- Write an SQL LEFT JOIN query to list all restaurants and their dishes, showing restaurants even if they currently have no dishes on the menu.<br><br><em><strong>Hint:</strong> Use LEFT JOIN so restaurants without dishes still appear in the results with NULL for dish columns.</em>
SELECT r.name , d.dish_name from restaurants r LEFT JOIN dishes d on r.id = d.restaurant_id ;
-- Write an SQL RIGHT JOIN query to display all dishes and their restaurant names, including any dishes that might not be linked to a restaurant (simulate a data error where a dish has a restaurant_id that doesn't match any restaurant).
SELECT d.dish_name , d.price , r.name , r.city FROM restaurants r RIGHT JOIN dishes d on r.id  =  d.restaurant_id;
-- Given this scenario: You want to show a list of all playlists and the songs inside them, like Spotify. Explain which JOIN type (INNER, LEFT, or RIGHT) you would use to show all playlists, even if some are empty, and write the SQL query for it.
-- left join
SELECT p.playlist_name,s.song_name,s.artist_name FROM playlists p LEFT JOIN songs s ON p.playlist_id = s.playlist_id;