-- Problem 1
CREATE TABLE Persons
(
PersonID INT NOT NULL,
FirstName VARCHAR(50) NOT NULL,
Salary DECIMAL(10, 2) NOT NULL,
PassportID INT NOT NULL
);

CREATE TABLE Passports
(
PassportID INT NOT NULL,
PassportNumber VARCHAR (50) NOT NULL
);

INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
VALUES (1, 'Roberto', 43300.00, 102),
       (2, 'Tom', 56100.00, 103),
       (3, 'Yana', 60200.00, 101);

INSERT INTO Passports (PassportID, PassportNumber)
VALUES (101, 'N34FG21B'),
       (102, 'K65LO4R7'),
	   (103, 'ZE657QP2');

ALTER TABLE Persons 
 ADD CONSTRAINT PK_PersonID PRIMARY KEY (PersonID)

ALTER TABLE Passports 
 ADD CONSTRAINT PK_PassportID PRIMARY KEY (PassportID)

ALTER TABLE Persons
 ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID)
  REFERENCES Passports(PassportID)
  
  -- Problem 2
  CREATE TABLE Manufacturers
(
ManufacturerID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL
)

CREATE TABLE Models
(
ModelID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR (50) NOT NULL,
ManufacturerID INT NOT NULL FOREIGN KEY REFERENCES Manufacturers (ManufacturerID)
)

INSERT INTO Manufacturers (ManufacturerID, [Name], EstablishedOn)
VALUES (1, 'BMW', '1916-03-07'), 
       (2, 'Tesla', '2003-01-01'),
	   (3, 'Lada', '1966-05-01');

INSERT INTO Models (ModelID, [Name], ManufacturerID)
VALUES (101, 'X1', 1),
       (102, 'i6', 1),
	   (103, 'Model S', 2),
	   (104, 'Model X', 2),
	   (105, 'Model 3', 2),
	   (106, 'Nova', 3)
  
  -- Problem 3
  CREATE TABLE Students
(
StudentID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Exams
(
ExamID INT NOT NULL PRiMARY KEY,
[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE StudentsExams
(
StudentID INT NOT NULL,
ExamID INT NOT NULL,
)

ALTER TABLE StudentsExams
 ADD CONSTRAINT PK_StudentsExams 
 PRIMARY KEY (StudentID, ExamID)

ALTER TABLE StudentsExams
 ADD CONSTRAINT FK_StudentsExams_Students
 FOREIGN KEY (StudentID)
 REFERENCES Students (StudentID)

ALTER TABLE StudentsExams
 ADD CONSTRAINT FK_StudentsExams_Exams
 FOREIGN KEY (ExamID)
 REFERENCES Exams (ExamID)


 INSERT INTO Students
 VALUES (1, 'Mila'),
        (2, 'Toni'),
		(3, 'Ron')

INSERT INTO Exams
VALUES (101, 'SpringMVC'),
       (102, 'Neo4j'),
	   (103, 'Oracle 11g')

INSERT INTO StudentsExams
VALUES (1, 101),
       (1, 102),
	   (2, 101),
	   (3, 103),
	   (2, 102),
	   (2, 103)
  
  -- Problem 4
  CREATE TABLE Teachers
(
TeacherID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL,
ManagerID INT
)

ALTER TABLE Teachers
 ADD CONSTRAINT FK_Teachers_ManagerTeacher
 FOREIGN KEY (ManagerID)
 REFERENCES Teachers (TeacherID)

 INSERT INTO Teachers (TeacherID, [Name], ManagerID)
 VALUES (101, 'John', 102),
        (102, 'Maya', 106),
		(103, 'Silvia', 106),
		(104, 'Ted', 105),
		(105, 'Mark', 101),
		(106, 'Greta', 101)
  
  -- Problem 5
  CREATE DATABASE OnlineStore
  GO
  
  USE OnlineStore
  GO
  
  CREATE TABLE Orders
(
OrderID INT NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL
)
CREATE TABLE Customers
(
CustomerID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL,
Birthday DATE,
CityID INT NOT NULL
)

CREATE TABLE Cities
(
CityID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL
)

ALTER TABLE Orders
 ADD CONSTRAINT FK_Orders_Customers
 FOREIGN KEY (CustomerID)
 REFERENCES Customers (CustomerID)

ALTER TABLE Customers
 ADD CONSTRAINT FK_Customers_Cities
 FOREIGN KEY (CityID)
 REFERENCES Cities (CityID)

CREATE TABLE ItemTypes
 (
 ItemTypeID INT NOT NULL PRIMARY KEY,
 [Name] VARCHAR(50) NOT NULL
 )

CREATE TABLE Items
 (
 ItemID INT NOT NULL PRIMARY KEY,
 [Name] VARCHAR(50) NOT NULL,
 ItemTypeID INT NOT NULL
 )

CREATE TABLE OrderItems
 (
 OrderID INT NOT NULL,
 ItemID INT NOT NULL
 )

ALTER TABLE Items
 ADD CONSTRAINT FK_Items_ItemTypes
 FOREIGN KEY (ItemTypeID)
 REFERENCES ItemTypes (ItemTypeID)

ALTER TABLE OrderItems
 ADD CONSTRAINT PK_OrderId_ItemId 
 PRIMARY KEY (OrderID, ItemID)

ALTER TABLE OrderItems
 ADD CONSTRAINT FK_OrderItems_Orders
 FOREIGN KEY (OrderID)
 REFERENCES Orders (OrderID)

ALTER TABLE OrderItems
 ADD CONSTRAINT FK_OrderItems_Items
 FOREIGN KEY (ItemID)
 REFERENCES Items (ItemID)
  
  -- Problem 6
  CREATE TABLE Majors
(
MajorID INT NOT NULL PRIMARY KEY,
[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Students
(
StudentID INT NOT NULL PRIMARY KEY,
StudentNumber INT NOT NULL,
StudentName VARCHAR(50) NOT NULL,
MajorID INT NOT NULL
)

CREATE TABLE Payments
(
PaymentID INT NOT NULL PRIMARY KEY,
PaymentDate DATE NOT NULL,
PaymentAmount DECIMAL(10, 2) NOT NULL,
StudentID INT NOT NULL
)

CREATE TABLE Agenda
(
StudentID INT NOT NULL,
SubjectID INT NOT NULL
)

CREATE TABLE Subjects
(
SubjectID INT NOT NULL PRIMARY KEY,
SubjectName VARCHAR(50) NOT NULL
)

ALTER TABLE Students
 ADD CONSTRAINT FK_StudentsMajors
 FOREIGN KEY (MajorID)
 REFERENCES Majors (MajorID)

ALTER TABLE Payments
 ADD CONSTRAINT FK_Payments_Students
 FOREIGN KEY (StudentID)
 REFERENCES Students (StudentID)

ALTER TABLE Agenda
 ADD CONSTRAINT PK_StudentID_SubjectID
 PRIMARY KEY (StudentID, SubjectID)

ALTER TABLE Agenda
 ADD CONSTRAINT FK_Agenda_Students
 FOREIGN KEY (StudentID)
 REFERENCES Students (StudentID)

ALTER TABLE Agenda
 ADD CONSTRAINT FK_Agenda_Subjects
 FOREIGN KEY (SubjectID)
 REFERENCES Subjects (SubjectID)
  
  -- Problem 7
  -- No queries needed for this problem
  
  -- Problem 8
  -- No queries needed for this problem
  
  -- Problem 9
SELECT TOP 5 
	e.EmployeeID, 
	e.JobTitle,
	a.AddressID,
	a.AddressText
  FROM Employees AS e
  JOIN Addresses AS a
    ON e.AddressID = a.AddressID
 ORDER BY e.AddressID
  
  -- Problem 10
  SELECT TOP 5 
    e.EmployeeID,
    e.FirstName,
	e.Salary,
	d.[Name] AS DepartmentName
  FROM Employees AS e
  JOIN Departments AS d
    ON e.DepartmentID = d.DepartmentID
 WHERE e.Salary > 15000
 ORDER BY e.DepartmentID
  
  -- Problem 11
  SELECT TOP 3 
    e.EmployeeID,
	e.FirstName
  FROM Employees AS e
     LEFT JOIN EmployeesProjects AS ep
      ON e.EmployeeID = ep.EmployeeID
   WHERE ep.EmployeeID IS NULL
  ORDER BY e.EmployeeID
  
  -- Problem 12
  SELECT TOP 5
       e.EmployeeID,
	   e.FirstName,
	   p.[Name]
  FROM Employees AS e
    JOIN EmployeesProjects AS ep
      ON e.EmployeeID = ep.EmployeeID
    JOIN Projects AS p
      ON ep.ProjectID = p.ProjectID
  WHERE p.StartDate >= '2002-08-13'
    AND p.EndDate IS NULL
  ORDER BY e.EmployeeID
  
  -- Problem 13
  SELECT 
       e.EmployeeID,
	   e.FirstName,
	   p.[Name]
  FROM Employees AS e
    JOIN EmployeesProjects AS ep
      ON e.EmployeeID = ep.EmployeeID
    LEFT JOIN Projects AS p
      ON ep.ProjectID = p.ProjectID
	  AND p.StartDate < '2005-01-01'
  WHERE e.EmployeeID = 24
  
  -- Problem 14
  SELECT e.EmployeeID,
       e.FirstName,
	   e.ManagerID,
	   m.FirstName
  FROM Employees AS e
  JOIN Employees AS m
    ON e.ManagerID = m.EmployeeID
 WHERE m.EmployeeID IN (3, 7)
 ORDER BY e.EmployeeID
  
  -- Problem 15
  SELECT mc.CountryCode, 
        m.MountainRange,
        p.PeakName, 
		p.Elevation
  FROM Peaks AS p
  JOIN MountainsCountries AS mc
    ON p.MountainId = mc.MountainId
  JOIN Mountains as m
    ON m.Id = mc.MountainId
 WHERE mc.CountryCode = 'BG'
   AND p.Elevation > 2835
 ORDER BY p.Elevation DESC
  
  -- Problem 16
  SELECT mc.CountryCode, 
         COUNT(m.MountainRange) AS MountainRanges
  FROM Mountains AS m
  JOIN MountainsCountries AS mc
    ON m.Id = mc.MountainId
 GROUP BY mc.CountryCode
  HAVING mc.CountryCode IN ('BG', 'RU', 'US')
  
  -- Problem 17
  SELECT TOP 5
       c.CountryName,
       r.RiverName
  FROM Countries AS c
  LEFT JOIN CountriesRivers AS cr
    ON c.CountryCode = cr.CountryCode
  LEFT JOIN Rivers AS r
    ON r.Id = cr.RiverId
 WHERE c.ContinentCode = 'AF'
 ORDER BY c.CountryName
  
  -- Problem 18
  
  
  -- Problem 19
  -- Problem 20
  -- Problem 21
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  