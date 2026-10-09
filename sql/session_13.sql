-- Create a table named Playlists with columns: id, user_id, playlist_name, and total_likes. Insert at least 8 sample rows with different users and playlists, making sure some playlists have the same user_id.
CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    total_likes INT
);

INSERT INTO Playlists (id, user_id, playlist_name, total_likes) VALUES
(1, 101, 'Workout Beats', 1500),
(2, 101, 'Chill Vibes', 1200),
(3, 101, 'Morning Coffee', 1200),
(4, 102, '90s Rock', 3000),
(5, 102, 'Acoustic Covers', 800),
(6, 103, 'Global Top 50', 5000),
(7, 103, 'Late Night Drive', 450),
(8, 103, 'Focus Flow', 450);
-- Write a SQL query using ROW_NUMBER() and the OVER() clause to assign a unique row number to each playlist, ordered by total_likes in descending order.
SELECT 
    playlist_name, 
    user_id, 
    total_likes,
    ROW_NUMBER() OVER (ORDER BY total_likes DESC) AS row_num
FROM Playlists;
-- Use the RANK() function with the OVER() clause to rank all playlists by total_likes, and display the playlist_name, user_id, total_likes, and their rank.
SELECT 
    playlist_name, 
    user_id, 
    total_likes,
    RANK() OVER (ORDER BY total_likes DESC) AS overall_rank
FROM Playlists;
-- Write a SQL query using DENSE_RANK() and PARTITION BY user_id to rank each user's playlists by total_likes, showing playlist_name, user_id, total_likes, and dense rank.<br><br><em><strong>Hint:</strong> This will show how popular each playlist is within each user's account, similar to how Spotify might rank your top playlists.</em>
SELECT 
    playlist_name, 
    user_id, 
    total_likes,
    DENSE_RANK() OVER (PARTITION BY user_id ORDER BY total_likes DESC) AS user_dense_rank
FROM Playlists;
-- Imagine you want to show the top 2 playlists per user based on total_likes, like Spotify's 'Your Top Playlists' feature. Write a query using a window function to select only the top 2 playlists for each user.
WITH RankedUserPlaylists AS (
    SELECT 
        playlist_name, 
        user_id, 
        total_likes,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY total_likes DESC) AS rank_per_user
    FROM Playlists
)
SELECT 
    user_id, 
    playlist_name, 
    total_likes
FROM RankedUserPlaylists
WHERE rank_per_user <= 2;