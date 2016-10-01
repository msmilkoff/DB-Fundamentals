USE master
GO

CREATE DATABASE Movies
GO

CREATE TABLE Directors
(
Id INT NOT NULL,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(50)
)
GO

ALTER TABLE Directors ADD CONSTRAINT PK_DirectorId PRIMARY KEY (Id)
GO

CREATE TABLE Genres
(
Id INT NOT NULL,
GenreName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(50)
)
GO

ALTER TABLE Genres ADD CONSTRAINT PK_GenreId PRIMARY KEY (Id)
GO

CREATE TABLE Categories
(
Id INT NOT NULL,
CategoryName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(50)
)
GO

ALTER TABLE Categories ADD CONSTRAINT PK_CategoryId PRIMARY KEY (Id)

CREATE TABLE Movies
(
Id INT NOT NULL,
Title NVARCHAR(50) NOT NULL,
DirectorId INT NOT NULL,
CopyrightYear DATE,
[Length] DATETIME,
GenreId INT NOT NULL,
CategoryId INT NOT NULL,
Rating INT,
Notes NVARCHAR(50)
)
GO

ALTER TABLE Movies ADD CONSTRAINT PK_MovieId PRIMARY KEY (ID)
GO

INSERT INTO Directors (Id, DirectorName)
VALUES (1, 'Quentin Tarantino')
INSERT INTO Directors (Id, DirectorName)
VALUES (2, 'Miguel Sapochnik')
INSERT INTO Directors (Id, DirectorName)
VALUES (3, 'Christopher Nolan')
INSERT INTO Directors (Id, DirectorName)
VALUES (4, 'Stephen Spielberg')
INSERT INTO Directors (Id, DirectorName)
VALUES (5, 'James Cameron')
GO

INSERT INTO Genres (Id, GenreName)
VALUES (1, 'Action')
INSERT INTO Genres (Id, GenreName)
VALUES (2, 'Action')
INSERT INTO Genres (Id, GenreName)
VALUES (3, 'Adventure/Super-Hero')
INSERT INTO Genres (Id, GenreName)
VALUES (4, 'Fantasy')
INSERT INTO Genres (Id, GenreName)
VALUES (5, 'Sci-Fi')
Go

 --'Genres' and 'Gategories' is the same thing btw, please make smarter and more challenging problems,
 -- because now I have to make up some 'categories'...

INSERT INTO Categories (Id, CategoryName)
VALUES (1, 'First Category') -- haha
INSERT INTO Categories (Id, CategoryName)
VALUES (2, 'Second Category')
INSERT INTO Categories (Id, CategoryName)
VALUES (3, 'Third Category')
INSERT INTO Categories (Id, CategoryName)
VALUES (4, 'Fourth Category')
INSERT INTO Categories (Id, CategoryName)
VALUES (5, 'Fifth Category')
GO

INSERT INTO Movies (Id, Title, DirectorId, GenreId, CategoryId)
VALUES (1, 'Kill Bill Vol. 1', 1, 1, 1)
INSERT INTO Movies (Id, Title, DirectorId, GenreId, CategoryId)
VALUES (2, 'Kill Bill Vol. 2', 1, 1, 2)
INSERT INTO Movies (Id, Title, DirectorId, GenreId, CategoryId)
VALUES (3, 'Game Of Thrones, S06E09', 2, 4, 3)
INSERT INTO Movies (Id, Title, DirectorId, GenreId, CategoryId)
VALUES (4, 'Terminator', 5, 5, 4)
INSERT INTO Movies (Id, Title, DirectorId, GenreId, CategoryId)
VALUES (5, 'K', 3, 3, 5)
GO