-- Create a table called Playlist with columns: id (INT, primary key), song_name (VARCHAR), artist (VARCHAR), and duration (INT, seconds). 
-- Insert a single row for your current favorite song.
CREATE DATABASE music_app ;
use music_app;
CREATE TABLE Playlist  (
	id INT PRIMARY KEY ,
    song_name VARCHAR(50),
    artist VARCHAR(50),
    duration_seconds INT 
);
INSERT INTO playlist VALUE (101,'tere nam','salman kahn',500);
-- Insert 3 new rows into the Playlist table for songs you recently listened to on Spotify, including their song_name, artist, and duration.
INSERT INTO playlist VALUES 
(102,'ham satha satha hain','arjit sing',300),
(103,'aagar tum sath ho','arjit sing',365),
(104,'hanuman chalisa','gulshan kumar',600);
-- Update the artist name for one of your Playlist entries to fix a typo (for example, change 'Arjit Singh' to 'Arijit Singh') using the UPDATE statement with a WHERE clause.
UPDATE playlist SET artist = 'arijit singh' WHERE artist = 'arjit sing';
-- Delete a song from the Playlist table where the duration is less than 120 seconds using the DELETE statement and a WHERE clause.<br><br><em><strong>Hint:</strong> Make sure your WHERE clause is specific so you don’t accidentally delete all rows.</em>
INSERT INTO playlist VALUE (105,'tere nam','salman kahn',50);
DELETE FROM playlist WHERE duration_seconds < 120 ;
-- Write an SQL statement that would update the song_name for all songs by 'AP Dhillon' in your Playlist to add '(Remix)' at the end of the name,
--  but only if the duration is more than 180 seconds.<br><br><em><strong>Constraint:</strong> Combine UPDATE with WHERE to target only the correct rows.</em>
INSERT INTO playlist VALUES 
(106,'ham satha satha hain','AP Dhillon',300),
(107,'aagar tum sath ho','AP Dhillon',35),
(108,'hanuman chalisa','AP Dhillon',600);
UPDATE playlist SET song_name = concat(song_name,'(remix)') WHERE artist = 'AP Dhillon' AND duration_seconds > 180;
