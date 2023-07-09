-- Question Set 1 - Easy
-- Q1 : Who is the senior most employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1

-- Q2: Which countries have the most Invoices?

SELECT billing_country, COUNT(invoice_id) FROM invoice
GROUP BY billing_country
ORDER BY COUNT(invoice_id) DESC
LIMIT 1

-- Q3: What are top 3 values of total invoice?

SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3

-- Q4: Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice 
-- totals

SELECT billing_city, SUM(total) FROM invoice
GROUP BY billing_city
ORDER BY SUM(total) DESC
LIMIT 1

-- Q5: Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money

SELECT c.customer_id,c.first_name,c.last_name, SUM(i.total) 
FROM customer c 
INNER JOIN invoice i
ON c.customer_id=i.customer_id
GROUP BY c.customer_id
ORDER BY  SUM(i.total) DESC
LIMIT 1

-- Question Set 2 – Moderate
-- Q1: Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A

SELECT DISTINCT email,first_name,last_name FROM customer
INNER JOIN invoice
ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice_line.invoice_id=invoice.invoice_id
WHERE track_id IN(
SELECT track_id FROM track
INNER JOIN genre
ON track.genre_id=genre.genre_id
WHERE genre.name='Rock')
ORDER BY email

-- Q2:-- Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT artist.artist_id, artist.name, COUNT(track.track_id) FROM artist
INNER JOIN album
ON artist.artist_id=album.artist_id
INNER JOIN track
ON track.album_id=album.album_id
WHERE track_id IN
(SELECT track_id FROM track
INNER JOIN genre
ON genre.genre_id=track.genre_id
WHERE genre.name='Rock')
GROUP BY artist.name,artist.artist_id
ORDER BY COUNT(track.track_id) DESC
LIMIT 10

-- Q3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first
SELECT  name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;




-- Question Set 2 – Advance

-- Q1:Find how much amount spent by each customer on artists? Write a query to return
-- customer name, artist name and total spent


SELECT (artist.artist_id), c.first_name,c.last_name,  (artist.name), SUM(il.unit_price*il.quantity)
FROM customer c
INNER JOIN invoice i
ON i.customer_id=c.customer_id
INNER JOIN invoice_line il
ON il.invoice_id=i.invoice_id
INNER JOIN track t
ON t.track_id=il.track_id
INNER JOIN album a
ON a.album_id=t.album_id
INNER JOIN artist 
ON artist.artist_id=a.artist_id
GROUP BY artist.artist_id, artist.name,c.first_name,c.last_name


