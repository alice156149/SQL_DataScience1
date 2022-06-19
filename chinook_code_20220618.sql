/*
CREATED BY: Hien Do
CREATED ON: 06/18/2022
DESCRIPTION: This script retrieves the information of customers and data about music track from Chinook database
*/

-- Find the names of all the tracks for the album "Californication"
SELECT Name
FROM Tracks
WHERE AlbumId IN (
SELECT 
AlbumId
FROM Albums
WHERE Title = 'Californication');

-- Find the total number of invoices for each customer along with the customer's full name, city and email.
SELECT FirstName, LastName, City, Email,
(SELECT COUNT (*) AS [Num Of Invoices]
FROM Invoices
WHERE Invoices.CustomerId = Customers.CustomerId) AS [NumOfInvoices]
FROM Customers;

-- Retrieve the track name, album, artistID, and trackID for all the albums.
SELECT Name,
TrackId,
(SELECT Title
FROM Albums) AS Album,
(SELECT ArtistId
FROM Albums) AS artistId
FROM Tracks
WHERE
TrackId = '12';

-- Retrieve a list with the managers last name, and the last name of the employees who report to him or her.
SELECT a.LastName AS ManagerLastName, b.LastName AS EmployeeLastName
FROM Employees a, Employees b
WHERE a.EmployeeId = b.ReportsTo;

-- Find the name and ID of the artists who do not have albums
SELECT Name AS Artist,
ar.ArtistId AS Id,
al.Title AS AlTitle
FROM Artists ar
LEFT JOIN Albums al
ON ar.ArtistId = al.ArtistId
WHERE AlTitle IS NULL;

-- Use a UNION to create a list of all the employee's and customer's first names and last names ordered by the last name in descending order
SELECT FirstName, LastName
FROM Customers
UNION
SELECT FirstName, LastName
FROM Employees
ORDER BY LastName DESC;

-- See if there are any customers who have a different city listed in their billing city versus their customer city
SELECT C.FirstName,
       C.LastName,
       C.City AS CustomerCity,
       I.BillingCity
FROM Customers C
INNER JOIN Invoices I
ON C.CustomerId = I.CustomerId
WHERE CustomerCity != BillingCity;