-- Install MySQL or PostgreSQL on your system and create a new database named 'music_streaming_app' using the command line or GUI tool of your choice.
CREATE DATABASE music_streaming_app ;
-- Inside the 'music_streaming_app' database, create a table called 'playlists' with columns: playlist_id (integer, primary key), name (varchar), and created_by (varchar).
USE music_streaming_app ;
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(30),
    created_by VARCHAR(30)
);
-- Insert three sample rows into the 'playlists' table representing playlists like 'Bollywood Hits', 'Chill Vibes', and 'Workout Mix', each created by a different user.
INSERT INTO playlists VALUE 
(100 , 'Bollywood Hits', 'Amit'),
(101,'Chill Vibes','aaryan'),
(102, 'Workout Mix', 'jignesh');
-- Write an SQL SELECT query to display all playlists created by the user 'Amit' from the 'playlists' table.<br><br><em><strong>Hint:</strong> Use the WHERE clause to filter by the 'created_by' column.</em>
SELECT * FROM playlists WHERE created_by = 'Amit';
-- Open ChatGPT or Copilot and ask it to explain the difference between a table, a row, and a column in SQL using an example from a food delivery app like Zomato. Paste the explanation you receive into your assignment.
/*
In a SQL database, data is organized into a grid-like structure. Think of a **Table** as the entire spreadsheet, a **Column** as a vertical category of information, and a **Row** as a single, horizontal entry containing data for one specific item.

To picture this, imagine a food delivery app like Zomato needs to store information about the eateries on its platform.

* **Table:** This is the overall container that holds a specific category of data. In this case, we would create a `Restaurants` table to store all the eateries on Zomato.
* **Column (Attribute/Field):** These are the vertical pillars of the table that define *what kind* of information is being collected. For the `Restaurants` table, the columns might be `Restaurant_ID`, `Name`, `Cuisine`, and `Rating`. Every entry in the table must follow this structure.
* **Row (Record):** This is a single, horizontal slice of the table that represents one complete, individual entry. One row equals one specific restaurant and all of its associated details.

Here is what that `Restaurants` table looks like in practice:

| Restaurant_ID | Name | Cuisine | Rating |
| --- | --- | --- | --- |
| 101 | Burger King | Fast Food | 4.1 |
| 102 | Biryani Blues | Indian | 4.4 |
| 103 | Tossin Pizza | Italian | 4.6 |

**Breaking down the visual:**

* The **entire grid** above is the `Restaurants` **Table**.
* If you look straight down under `Cuisine` (Fast Food, Indian, Italian), that vertical list is a **Column**.
* If you read across the middle line (`102` | `Biryani Blues` | `Indian` | `4.4`), that complete horizontal entry is a single **Row**.
*/