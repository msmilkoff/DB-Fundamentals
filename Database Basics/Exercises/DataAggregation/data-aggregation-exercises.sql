-- Problem 1
SELECT COUNT(*) AS  [Count]
FROM WizzardDeposits

-- Problem 2
SELECT TOP 1 MAX(MagicWandSize) AS [MagicWandSize]
FROM WizzardDeposits

-- Problem 3
SELECT DepositGroup,
       Max(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits
GROUP BY DepositGroup

-- Probem 4
SELECT TOP 2 DepositGroup FROM
(SELECT MIN(aws.AverageWandSize) AS MinAvgWandSize, DepositGroup FROM
	(SELECT AVG(MagicWandSize) AS AverageWandSize, DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup) AS aws
	GROUP BY DepositGroup) AS MinAvg
ORDER BY MinAvgWandSize

-- Problem 5
SELECT DepositGroup,
       SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup

-- Problem 6
SELECT DepositGroup,
       SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
HAVING MagicWandCreator = 'Ollivander family'

-- Problem 7
SELECT wd.DepositGroup,
       SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits as wd
GROUP BY DepositGroup, MagicWandCreator
HAVING wd.MagicWandCreator = 'Ollivander family'
	AND SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

-- Problem 8
SELECT wd.DepositGroup,
       wd.MagicWandCreator,
	   MIN(wd.DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits as wd
GROUP BY wd.DepositGroup, wd.MagicWandCreator
ORDER BY wd.MagicWandCreator, wd.DepositGroup

-- Problem 9
 SELECT CASE
			WHEN Age <= 10 THEN '[0-10]'
			WHEN Age <= 20 THEN '[11-20]'
			WHEN Age <= 30 THEN '[21-30]'
			WHEN Age <= 40 THEN '[31-40]'
			WHEN Age <= 50 THEN '[41-50]'
			WHEN Age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS AgeGroup,
        COUNT(*) AS WizzardCount
   FROM [dbo].[WizzardDeposits]
  GROUP BY CASE
			WHEN Age <= 10 THEN '[0-10]'
			WHEN Age <= 20 THEN '[11-20]'
			WHEN Age <= 30 THEN '[21-30]'
			WHEN Age <= 40 THEN '[31-40]'
			WHEN Age <= 50 THEN '[41-50]'
			WHEN Age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END
		
-- Problem 10
SELECT DISTINCT LEFT(wd.FirstName, 1) AS first_name
FROM WizzardDeposits AS wd
WHERE wd.DepositGroup = 'Troll Chest'

-- Problem 11
SELECT wd.DepositGroup,
       wd.IsDepositExpired,
	   AVG(wd.DepositInterest) AS [AverageInterest]
FROM WizzardDeposits AS wd
WHERE wd.DepositStartDate > '1985-01-01'
GROUP BY wd.DepositGroup, wd.IsDepositExpired
ORDER BY wd.DepositGroup DESC

-- Problem 12
SELECT SUM(DepositSum.Diff) AS SumDifference
FROM 
	(SELECT DepositAmount - 
		(SELECT DepositAmount 
		 FROM WizzardDeposits 
		 WHERE Id = wd.Id + 1) AS Diff 
	FROM WizzardDeposits AS wd) AS DepositSum
	
-- Problem 13
SELECT e.DepartmentID, MIN(e.Salary) AS MinSalary
  FROM Employees AS e
WHERE e.DepartmentID = 2
   OR e.DepartmentID = 5
   OR e.DepartmentID = 7
  AND e.HireDate > '2000-01-01'
GROUP BY DepartmentID

-- Problem 14
SELECT * INTO HighPaidEmployees
  FROM Employees AS e
WHERE e.Salary > 30000 

DELETE FROM HighPaidEmployees
WHERE HighPaidEmployees.ManagerID = 42

UPDATE HighPaidEmployees
SET HighPaidEmployees.Salary += 5000
WHERE HighPaidEmployees.DepartmentID = 1

 SELECT h.DepartmentID,
        AVG(h.Salary) AS AverageSalary
  FROM HighPaidEmployees AS h
GROUP BY h.DepartmentID

-- Problem 15
SELECT e.DepartmentID,
       MAX(e.Salary) AS MaxSalary
  FROM Employees AS e
GROUP BY e.DepartmentID
HAVING MAX(e.Salary) < 30000
   OR MAX(e.Salary) > 70000
   
-- Problem 16
SELECT COUNT(e.Salary)
  FROM Employees AS e
WHERE e.ManagerID IS NULL

-- Problem 17
 SELECT DISTINCT sal.DepartmentId, sal.Salary FROM
(SELECT e.DepartmentId, e.Salary, DENSE_RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS SalaryRank
   FROM [dbo].[Employees] AS e) AS sal
  WHERE sal.SalaryRank = 3
  
  -- Problem 18
SELECT TOP 10 e1.FirstName, e1.LastName, e1.DepartmentID
FROM Employees AS e1
JOIN (
	SELECT e.DepartmentID, AVG(e.Salary) AS AverageSalary
	FROM Employees AS e
	GROUP BY e.DepartmentID
) AS AvgSalary
ON e1.Salary > AvgSalary.AverageSalary
AND e1.DepartmentID = AvgSalary.DepartmentID















