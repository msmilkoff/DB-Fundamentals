CREATE DATABASE MyDb;

CREATE TABLE People
(
Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Name] NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX),
Height FLOAT,
[Weight] FLOAT,
Gender VARCHAR(1) NOT NULL CHECK (Gender IN ('m', 'f')),
Birthdate DATE NOT NULL,
Biography NVARCHAR(MAX)
);

ALTER TABLE People 
	ADD CONSTRAINT Check_Picture_2MB CHECK (DATALENGTH(Picture) <= 2097152);

INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES ('Pesho', NULL, NULL, NULL, 'm', '1992-05-12', NULL);
INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES ('Gsho', NULL, NULL, NULL, 'm', '1993-04-15', NULL);
INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES ('Kiro', NULL, NULL, NULL, 'm', '1995-05-23', NULL);
INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES ('Mariika', NULL, NULL, NULL, 'f', '1994-05-01', NULL);
INSERT INTO People ([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES ('Ivan', NULL, NULL, NULL, 'm', '1996-06-03', NULL);