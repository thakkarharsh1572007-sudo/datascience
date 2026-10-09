-- Create a table named MusicPlaylist with columns: id, song_name, artist, genre, and duration. Insert at least 5 records representing songs from your favorite Spotify playlist, then write a SELECT statement to retrieve all columns for all songs.
USE music_app;
CREATE TABLE MusicPlaylist (
	id INT PRIMARY KEY ,
    song_name VARCHAR(50),
    artist VARCHAR(50),
    genre VARCHAR(20),
    duration_seconds INT 
);
INSERT INTO MusicPlaylist
VALUES 
    (1, 'Blinding Lights', 'The Weeknd', 'Synth-pop', 200),
    (2, 'Levitating', 'Dua Lipa', 'Pop', 203),
    (3, 'Save Your Tears', 'The Weeknd', 'Synth-pop', 215),
    (4, 'Peaches', 'Justin Bieber', 'R&B', 198),
    (5, 'Watermelon Sugar', 'Harry Styles', 'Pop', 174);
SELECT * FROM MusicPlaylist;
-- Write a SQL query to display only the song_name and artist columns from the MusicPlaylist table, showing just the first 3 records using the LIMIT keyword.
SELECT song_name , artist FROM MusicPlaylist LIMIT 3;
-- Suppose you have a table named FoodOrders with columns: id, FoodOrders , food_item, and order_date. Write a SQL query to list all unique restaurant names where you have placed orders, using the DISTINCT keyword.
USE foodie_app;
CREATE TABLE FoodOrders (
	id INT PRIMARY KEY ,
    FoodOrders VARCHAR(50),
    restaurant VARCHAR(50),
    food_item VARCHAR(50),
    order_date DATETIME
);
SELECT DISTINCT restaurant FROM FoodOrders;
-- Write a SQL query on the FoodOrders table to select food_item as 'Dish' and order_date as 'Date Ordered',
--  displaying only these two columns with the column aliases in the output.
SELECT food_item as 'Dish' ,order_date as 'Date Ordered' FROM FoodOrders ;
-- You tried running this query: SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2, but it returns an error or doesn't work as expected. 
-- Identify and fix the mistake in the query.<br><br><em><strong>Hint:</strong> Check the correct placement and usage of the LIMIT keyword in SQL syntax.</em>
 SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2 ;
 