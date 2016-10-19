-- Part I Queries for SoftUni DATABASE
-- Problem 1
SELECT  FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'sa%'

-- Problem 2
SELECT  FirstName, LastName
FROM Employees 
WHERE LastName LIKE '%ei%' 


--Problem 3
SELECT FirstName 
FROM Employees 
WHERE DepartmentId = 3 
	OR DepartmentId = 10 
	AND HireDate BETWEEN '1995-01-01' AND '2005-01-01' 
	
-- Problem 4
SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

-- Problem 5
SELECT [Name]
 FROM Towns
WHERE LEN([Name]) = 5
   OR LEN([Name]) = 6
ORDER BY [Name]

-- Problem 6
SELECT TownId, [Name]
 FROM Towns
WHERE [Name] LIKE 'M%'
   OR [Name] LIKE 'K%'
   OR [Name] LIKE 'B%'
   OR [Name] LIKE 'E%'
ORDER BY [Name]

--Problem 7
SELECT TownId, [Name]
 FROM Towns
WHERE [Name] NOT LIKE 'R%'
  AND [Name] NOT LIKE 'B%'
  AND [Name] NOT LIKE 'D%'
ORDER BY [Name]

-- Problem 8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
 FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000

-- Problem 9
SELECT FirstName, LastName
 FROM Employees
WHERE LEN(LastName) = 5

-- Part II – Queries for Geography Database 
-- Problem 10
SELECT CountryName, IsoCode
 FROM Countries
WHERE (LEN(CountryName) - LEN(REPLACE(CountryName, 'a', ''))) >= 3
ORDER BY IsoCode

-- Problem 11
SELECT PeakName,
       RiverName,
       LOWER(CONCAT(PeakName, SUBSTRING(RiverName, 2, LEN(RiverName)))) AS [Mix]
FROM Rivers, Peaks
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY [Mix];

-- Part II – Queries for Diablo Database
-- Problem 12
SELECT TOP 50         [Name] AS [Game], 
 FORMAT([Start], 'yyy-MM-dd')
FROM Games
WHERE YEAR([Start]) = 2011
   OR YEAR([Start]) = 2012
ORDER BY [Start], [Name]

-- Problem 13
SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username

-- Problem 14
SELECT Username, IpAddress AS [IP Address]
FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username

-- Problem 15
SELECT [Name] AS [Game],
  CASE WHEN DATEPART(HOUR, [Start]) >= 0 AND
            DATEPART(HOUR, [Start]) < 12 THEN 'Morning'
       WHEN DATEPART(HOUR, [Start]) >= 12 AND
	        DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
	   ELSE 'Evening' 
  END AS [Part of the Day],
  CASE WHEN Duration > 6  THEN 'Long'
       WHEN Duration <= 3 THEN 'Extra Short'
       WHEN Duration >= 4
	     OR Duration <= 6 THEN 'Short'
	   WHEN Duration IS NULL THEN 'Extra Long'
  END AS [Duration]
FROM [Games]
ORDER BY [Name], Duration, [Start]

--Part IV – Date Functions Queries
-- Problem 16
SELECT ProductName,
       OrderDate,
	   DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	   DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders
















