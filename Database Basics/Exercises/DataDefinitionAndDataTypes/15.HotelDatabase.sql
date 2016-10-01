USE Hotel

CREATE TABLE Employees
(
Id INT NOT NULL,
FirstName NVARCHAR(50) NOT NULL PRIMARY KEY,
LastName NVARCHAR(50) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(max)
)

CREATE TABLE Customers
(
AccountNumber VARCHAR(50) NOT NULL PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
PhoneNumber VARCHAR(50) NOT NULL,
EmergencyName NVARCHAR(50),
EmergencyNumber VARCHAR(50),
Notes NVARCHAR(max)
)

CREATE TABLE RoomStatus
(
RoomStatus VARCHAR(50) NOT NULL PRIMARY KEY,
Notes NVARCHAR(max)
)

CREATE TABLE RoomTypes
(
RoomType VARCHAR(50) NOT NULL PRIMARY KEY,
Notes NVARCHAR(max)
)

CREATE TABLE BedTypes
(
BedType VARCHAR(50) NOT NULL PRIMARY KEY,
Notes NVARCHAR(max)
)

CREATE TABLE Rooms
(
RoomNumber INT NOT NULL PRIMARY KEY,
RoomType VARCHAR(50) NOT NULL,
BedType VARCHAR(50) NOT NULL,
Rate INT CHECK (Rate > 0 AND Rate <= 10),
RoomStatus VARCHAR(50) NOT NULL,
Notes NVARCHAR(max)
)

CREATE TABLE Payments
(
Id INT NOT NULL PRIMARY KEY,
EmployeeId INT NOT NULL,
PaymentDate DATE NOT NULL,
AccountNumber VARCHAR(50) NOT NULL,
FirstDayOccupied DATE NOT NULL,
LastDateOccupied DATE NOT NULL,
TotalDays INT NOT NULL,
AmountCharged DECIMAL NOT NULL,
TaxRate DECIMAL,
TaxAmount DECIMAL,
PaymentTotal DECIMAL,
Notes NVARCHAR(max)
)

CREATE TABLE Occupancies
(
Id INT NOT NULL PRIMARY KEY,
EmployeeId INT NOT NULL,
DateOccupied DATE NOT NULL,
AccountNumber VARCHAR(50) NOT NULL,
RoomNumber INT NOT NULL,
RateApplied DECIMAL NOT NULL,
PhoneCharge DECIMAL,
Notes NVARCHAR(max)
)

INSERT INTO Employees (Id, FirstName, LastName, Title)
VALUES (1, 'John', 'McRaemond', 'Director')
INSERT INTO Employees (Id, FirstName, LastName, Title)
VALUES (2, 'Malcolm', 'Dawkins Jr.', 'Acccountant')
INSERT INTO Employees (Id, FirstName, LastName, Title)
VALUES (3, 'Melissa', 'Donalds', 'PR Manager')


INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber)
VALUES ('AN18255', 'Stephen', 'Saccario', '555-385-4512')
INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber)
VALUES ('AN25489', 'Jason', 'Rogers', '555-489-3636')
INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber)
VALUES ('AN69874', 'George', 'Norton', '555-227-9158')

INSERT INTO RoomStatus (RoomStatus) VALUES ('Taken')
INSERT INTO RoomStatus (RoomStatus) VALUES ('Free')
INSERT INTO RoomStatus (RoomStatus) VALUES ('Under Construction')

INSERT INTO RoomTypes (RoomType) VALUES ('Single')
INSERT INTO RoomTypes (RoomType) VALUES ('Family')
INSERT INTO RoomTypes (RoomType) VALUES ('Premium')

INSERT INTO BedTypes (BedType) VALUES('Single')
INSERT INTO BedTypes (BedType) VALUES('Double')
INSERT INTO BedTypes (BedType) VALUES('California King-Size')

INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus)
VALUES (101, 'Single', 'Single', 'Free')
INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus)
VALUES (102, 'Family', 'Double', 'Taken')
INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus)
VALUES (103, 'Premium', 'California King-Size', 'Taken')

INSERT INTO Payments (
Id,
EmployeeId,
PaymentDate,
AccountNumber,
FirstDayOccupied,
LastDateOccupied,
TotalDays,
AmountCharged)
VALUES (
1,
1,
'2016-02-06',
'AN18255',
'2016-02-03',
'2016-02-05',
2,
168.33
)

INSERT INTO Payments (
Id,
EmployeeId,
PaymentDate,
AccountNumber,
FirstDayOccupied,
LastDateOccupied,
TotalDays,
AmountCharged)
VALUES (
2,
2,
'2016-02-17',
'AN25489',
'2016-02-12',
'2016-02-16',
4,
150.00
)

INSERT INTO Payments (
Id,
EmployeeId,
PaymentDate,
AccountNumber,
FirstDayOccupied,
LastDateOccupied,
TotalDays,
AmountCharged)
VALUES (
3,
3,
'2016-03-02',
'AN69874',
'2016-02-28',
'2016-03-01',
3,
266.89
)

INSERT INTO Occupancies(
Id,
EmployeeId,
DateOccupied,
AccountNumber,
RoomNumber,
RateApplied
)
VALUES(
1,
1,
'2016-01-01',
'AN18255',
101,
50.00
)

INSERT INTO Occupancies(
Id,
EmployeeId,
DateOccupied,
AccountNumber,
RoomNumber,
RateApplied
)
VALUES(
2,
2,
'2016-01-05',
'AN25489',
102,
55.00
)

INSERT INTO Occupancies(
Id,
EmployeeId,
DateOccupied,
AccountNumber,
RoomNumber,
RateApplied
)
VALUES(
3,
3,
'2016-01-15',
'AN69874',
103,
65.55
)
