--                  Question Set 1

--Q1. Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels desc
LIMIT 1

--Q2. Which countries have the most Invoices?

SELECT * FROM invoice
SELECT COUNT(customer_id) AS "Invoices", billing_country
FROM invoice
GROUP BY billing_country
ORDER BY "Invoices" desc

--Q3. What are top 3 values of total invoice?

SELECT * 
FROM invoice
ORDER BY total desc
LIMIT 3

--Q4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.

SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc

--Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total
FROM customer  as c
JOIN invoice as i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total desc
LIMIT 1

--                    Question Set 2

--Q1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
    SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

--Q2. Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT * FROM genre
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_song
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_song desc
LIMIT 10;