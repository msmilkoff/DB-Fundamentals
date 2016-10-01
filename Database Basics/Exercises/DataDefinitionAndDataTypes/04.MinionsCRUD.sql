CREATE DATABASE Minions;

CREATE TABLE Towns
(
Id INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Minions
(
Id INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL,
Age INT,
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

INSERT INTO Towns (Id, [Name])
	VALUES ('1', 'Sofia')
INSERT INTO Towns (Id, [Name])
	VALUES ('2', 'Plovdiv')
INSERT INTO Towns (Id, [Name])
	VALUES ('3', 'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId)
	VALUES ('1', 'Kevin', '23', '1')
INSERT INTO Minions (Id, [Name], Age, TownId)
	VALUES ('2', 'Bob', '15', '3')
INSERT INTO Minions (Id, [Name], Age, TownId)
	VALUES ('3', 'Steward', NULL, '2');