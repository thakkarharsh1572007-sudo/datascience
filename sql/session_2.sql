-- Install MySQL Community Server or SQLite on your system and verify the installation by connecting to the database using the command line or a GUI tool like MySQL Workbench or DB Browser for SQLite.
-- Create a new database named 'foodie_app' to simulate a Zomato-style backend.
CREATE DATABASE foodie_app;
USE foodie_app;
-- Write a CREATE TABLE statement to define a 'restaurants' table in the 'foodie_app' database with the following columns: 
-- id (integer, primary key), name (varchar/character, max 100), cuisine (varchar/character, max 50), rating (decimal, e.g., 4.5), and location (varchar/character, max 100).
CREATE TABLE restaurants
(
	id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine  VARCHAR(50),
    rating DECIMAL(2,1) CHECK(rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100)
);
-- Design and create a 'users' table for a Flipkart-style app with columns: user_id (primary key), username, email, phone_number, and created_at (date/time).
--  Pick appropriate data types for each column.
-- <br><br><em><strong>Hint:</strong> Think about which columns should be unique and which data types best fit email and phone numbers.</em>
CREATE DATABASE Flipkart_style_app ;
USE Flipkart_style_app ;
CREATE TABLE users(
	user_id INT PRIMARY KEY ,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE CHECK(email LIKE '%@%.%'),
    phone_number VARCHAR(10) UNIQUE CHECK (length(phone_number)= 10),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Intentionally make a mistake in your CREATE TABLE statement (such as missing a comma or using an unsupported data type), 
-- run it, and then fix the error based on the message you receive.
-- <br><br><em><strong>Hint:</strong> Take a screenshot of the error and the corrected SQL statement for your records.</em>
/*
with error query 
CREATE TABLE saller (
	saller_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    GSTno CHAR(15) UNIQUE CHECK(length(GSTno) = 15)
    phone_number VARCHAR(10) UNIQUE CHECK (length(phone_number)= 10),
	email VARCHAR(255) UNIQUE,
);
massage :
0	31	14:25:25	CREATE TABLE saller (
  saller_id INT PRIMARY KEY,
     name VARCHAR(50) NOT NULL UNIQUE,
     GSTno CHAR(15) UNIQUE CHECK(length(GSTno) = 15)
     phone_number VARCHAR(10) UNIQUE CHECK (length(phone_number)= 10),
  email VARCHAR(255) UNIQUE,
 )	Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'phone_number VARCHAR(10) UNIQUE CHECK (length(phone_number)= 10),
  email VARCHAR' at line 5	0.016 sec
  */
  -- correct query 
  
CREATE TABLE saller (
	saller_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    GSTno CHAR(15) UNIQUE CHECK(length(GSTno) = 15),
    phone_number VARCHAR(10) UNIQUE CHECK (length(phone_number)= 10),
	email VARCHAR(255) UNIQUE
);