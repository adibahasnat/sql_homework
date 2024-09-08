

-- List all countries in South America:
SELECT Name FROM country WHERE Continent = 'South America';


-- Find the population of 'Germany':
SELECT Population FROM country WHERE Name = 'Germany';


-- Retrieve all cities in the country 'Japan':
SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Name = 'Japan');


-- Find the 3 most populated countries in the 'Africa' region:
SELECT Name, Population FROM country WHERE Continent = 'Africa' ORDER BY Population DESC LIMIT 3;


-- Retrieve the country and its life expectancy where the population is between 1 and 5 million:
SELECT Name, LifeExpectancy FROM country WHERE Population BETWEEN 1000000 AND 5000000;


-- List countries with an official language of 'French':
SELECT country.Name 
FROM country 
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode 
WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';


-- Retrieve all album titles by the artist 'AC/DC':
SELECT Album.Title 
FROM Album 
JOIN Artist ON Album.ArtistId = Artist.ArtistId 
WHERE Artist.Name = 'AC/DC';


-- Find the name and email of customers located in 'Brazil':
SELECT FirstName, LastName, Email 
FROM Customer 
WHERE Country = 'Brazil';


-- List all playlists in the database:
SELECT Name FROM Playlist;


-- Find the total number of tracks in the 'Rock' genre:
SELECT COUNT(*) 
FROM Track 
JOIN Genre ON Track.GenreId = Genre.GenreId 
WHERE Genre.Name = 'Rock';


-- List all employees who report to 'Nancy Edwards':
SELECT Employee.FirstName, Employee.LastName 
FROM Employee 
WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');


-- Calculate the total sales per customer by summing the total amount in invoices:
SELECT Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalSales 
FROM Customer 
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId 
GROUP BY Customer.CustomerId;


-- Create database
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    AuthorName VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    AuthorID INT,
    Price DECIMAL(5,2),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO Authors (AuthorName) VALUES ('J.K. Rowling'), ('George Orwell'), ('J.R.R. Tolkien'), ('Agatha Christie'), ('Dan Brown');

INSERT INTO Books (Title, AuthorID, Price) VALUES 
('Harry Potter', 1, 19.99),
('1984', 2, 9.99),
('The Hobbit', 3, 14.99),
('Murder on the Orient Express', 4, 12.99),
('The Da Vinci Code', 5, 17.99);

INSERT INTO Sales (BookID, Quantity, SaleDate) VALUES 
(1, 2, '2023-09-01'), 
(2, 5, '2023-09-02'), 
(3, 1, '2023-09-03'), 
(4, 4, '2023-09-04'), 
(5, 3, '2023-09-05');


-- List all books by 'J.K. Rowling'
SELECT Title FROM Books 
JOIN Authors ON Books.AuthorID = Authors.AuthorID 
WHERE Authors.AuthorName = 'J.K. Rowling';


-- Find total sales for each book
SELECT Books.Title, SUM(Sales.Quantity) AS TotalSold 
FROM Books 
JOIN Sales ON Books.BookID = Sales.BookID 
GROUP BY Books.BookID;


-- Find total revenue for all books
SELECT SUM(Books.Price * Sales.Quantity) AS TotalRevenue 
FROM Books 
JOIN Sales ON Books.BookID = Sales.BookID;
